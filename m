Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71D131A06DE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:54:56 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Mar 2015 19:54:54 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7DD943E40047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:51 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2V1spCe47317200
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 18:54:51 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2V1sof3003149
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:51 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH v2 07/10] powerpc/hv-24x7: Define add_event_to_24x7_request()
Date: Mon, 30 Mar 2015 18:53:44 -0700
Message-Id: <1427766828-771-8-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1427766828-771-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1427766828-771-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move code that maps a perf_event to a 24x7 request buffer into a
separate function, add_event_to_24x7_request().

Changelog[v2]
	[Michael Ellerman]: Move white-space changes to separate patch.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 59 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index e78b127..fe74221 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1000,15 +1000,52 @@ static void log_24x7_hcall(struct hv_24x7_request_buffer *request_buffer,
 			result_buffer->failing_request_ix);
 }
 
-static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
+/*
+ * Add the given @event to the next slot in the 24x7 request_buffer.
+ *
+ * Note that H_GET_24X7_DATA hcall allows reading several counters'
+ * values in a single HCALL. We expect the caller to add events to the
+ * request buffer one by one, make the HCALL and process the results.
+ */
+static int add_event_to_24x7_request(struct perf_event *event,
+				struct hv_24x7_request_buffer *request_buffer)
 {
 	u16 idx;
+	int i;
+	struct hv_24x7_request *req;
+
+	if (request_buffer->num_requests > 254) {
+		pr_devel("Too many requests for 24x7 HCALL %d\n",
+				request_buffer->num_requests);
+		return -EINVAL;
+	}
+
+	if (is_physical_domain(event_get_domain(event)))
+		idx = event_get_core(event);
+	else
+		idx = event_get_vcpu(event);
+
+	i = request_buffer->num_requests++;
+	req = &request_buffer->requests[i];
+
+	req->performance_domain = event_get_domain(event);
+	req->data_size = cpu_to_be16(8);
+	req->data_offset = cpu_to_be32(event_get_offset(event));
+	req->starting_lpar_ix = cpu_to_be16(event_get_lpar(event)),
+	req->max_num_lpars = cpu_to_be16(1);
+	req->starting_ix = cpu_to_be16(idx);
+	req->max_ix = cpu_to_be16(1);
+
+	return 0;
+}
+
+static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
+{
 	unsigned long ret;
 
 	struct hv_24x7_request_buffer *request_buffer;
 	struct hv_24x7_data_result_buffer *result_buffer;
 	struct hv_24x7_result *resb;
-	struct hv_24x7_request *req;
 
 	BUILD_BUG_ON(sizeof(*request_buffer) > 4096);
 	BUILD_BUG_ON(sizeof(*result_buffer) > 4096);
@@ -1019,23 +1056,11 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 	memset(request_buffer, 0, 4096);
 	memset(result_buffer, 0, 4096);
 
-	if (is_physical_domain(event_get_domain(event)))
-		idx = event_get_core(event);
-	else
-		idx = event_get_vcpu(event);
-
 	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
-	request_buffer->num_requests = 1;
-
-	req = &request_buffer->requests[0];
 
-	req->performance_domain = event_get_domain(event);
-	req->data_size = cpu_to_be16(8);
-	req->data_offset = cpu_to_be32(event_get_offset(event));
-	req->starting_lpar_ix = cpu_to_be16(event_get_lpar(event)),
-	req->max_num_lpars = cpu_to_be16(1);
-	req->starting_ix = cpu_to_be16(idx);
-	req->max_ix = cpu_to_be16(1);
+	ret = add_event_to_24x7_request(event, request_buffer);
+	if (ret)
+		return ret;
 
 	/*
 	 * NOTE: Due to variable number of array elements in request and
-- 
1.8.3.1
