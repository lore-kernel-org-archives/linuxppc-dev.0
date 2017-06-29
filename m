Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzD4l4xDXzDr6H
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 07:56:07 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TLs0UI016404
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:56:05 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd1dtqkaw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:56:04 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 18:56:02 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TLphkv31981818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:51:43 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TLtx6b030191
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:55:59 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v3 3/8] powerpc/perf/hv-24x7: Properly iterate through results
Date: Thu, 29 Jun 2017 18:55:33 -0300
In-Reply-To: <20170629215538.1645-1-bauerman@linux.vnet.ibm.com>
References: <20170629215538.1645-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20170629215538.1645-4-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hv-24x7.h has a comment mentioning that result_buffer->results can't be
indexed as a normal array because it may contain results of variable sizes,
so fix the loop in h_24x7_event_commit_txn to take the variation into
account when iterating through results.

Another problem in that loop is that it sets h24x7hw->events[i] to NULL.
This assumes that only the i'th result maps to the i'th request, but that
is not guaranteed to be true. We need to leave the event in the array so
that we don't dereference a NULL pointer in case more than one result maps
to one request.

We still assume that each result has only one result element, so warn if
that assumption is violated.

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 141de0f708f7..8b1a3e849d23 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1144,7 +1144,9 @@ static int add_event_to_24x7_request(struct perf_event *event,
 
 static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 {
+	u16 num_elements;
 	unsigned long ret;
+	struct hv_24x7_result *result;
 	struct hv_24x7_request_buffer *request_buffer;
 	struct hv_24x7_data_result_buffer *result_buffer;
 
@@ -1166,8 +1168,14 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 		goto out;
 	}
 
+	result = result_buffer->results;
+
+	/* This code assumes that a result has only one element. */
+	num_elements = be16_to_cpu(result->num_elements_returned);
+	WARN_ON_ONCE(num_elements != 1);
+
 	/* process result from hcall */
-	*count = be64_to_cpu(result_buffer->results[0].elements[0].element_data[0]);
+	*count = be64_to_cpu(result->elements[0].element_data[0]);
 
 out:
 	put_cpu_var(hv_24x7_reqb);
@@ -1400,8 +1408,7 @@ static int h_24x7_event_commit_txn(struct pmu *pmu)
 {
 	struct hv_24x7_request_buffer *request_buffer;
 	struct hv_24x7_data_result_buffer *result_buffer;
-	struct hv_24x7_result *resb;
-	struct perf_event *event;
+	struct hv_24x7_result *res, *next_res;
 	u64 count;
 	int i, ret, txn_flags;
 	struct hv_24x7_hw *h24x7hw;
@@ -1428,13 +1435,20 @@ static int h_24x7_event_commit_txn(struct pmu *pmu)
 
 	h24x7hw = &get_cpu_var(hv_24x7_hw);
 
-	/* Update event counts from hcall */
-	for (i = 0; i < request_buffer->num_requests; i++) {
-		resb = &result_buffer->results[i];
-		count = be64_to_cpu(resb->elements[0].element_data[0]);
-		event = h24x7hw->events[i];
-		h24x7hw->events[i] = NULL;
+	/* Go through results in the result buffer to update event counts. */
+	for (i = 0, res = result_buffer->results;
+	     i < result_buffer->num_results; i++, res = next_res) {
+		struct perf_event *event = h24x7hw->events[res->result_ix];
+		u16 num_elements = be16_to_cpu(res->num_elements_returned);
+		u16 data_size = be16_to_cpu(res->result_element_data_size);
+
+		/* This code assumes that a result has only one element. */
+		WARN_ON_ONCE(num_elements != 1);
+
+		count = be64_to_cpu(res->elements[0].element_data[0]);
 		update_event_count(event, count);
+
+		next_res = (void *) res->elements[0].element_data + data_size;
 	}
 
 	put_cpu_var(hv_24x7_hw);
-- 
2.13.0
