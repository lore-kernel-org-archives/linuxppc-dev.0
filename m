Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 067931A0634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:54:54 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Mar 2015 19:54:53 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1EE5A1FF0023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:46:01 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2V1saXr35192952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 18:54:36 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2V1snQd003061
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:49 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH v2 04/10] powerpc/hv-24x7: Drop event_24x7_request()
Date: Mon, 30 Mar 2015 18:53:41 -0700
Message-Id: <1427766828-771-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

The function event_24x7_request() is essentially a wrapper to the
function single_24x7_request() and can be dropped to simplify code.

Changelog [v2]:
	- Michael Ellerman: Use fields from the request structure rather
		than re-extracting from event structure.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 87c9905..f509f3b 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -985,9 +985,9 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
-static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
-					 u16 lpar, u64 *count)
+static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 {
+	u16 idx;
 	unsigned long ret;
 
 	struct hv_24x7_request_buffer *request_buffer;
@@ -1004,17 +1004,22 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 	memset(request_buffer, 0, 4096);
 	memset(result_buffer, 0, 4096);
 
+	if (is_physical_domain(event_get_domain(event)))
+		idx = event_get_core(event);
+	else
+		idx = event_get_vcpu(event);
+
 	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
 	request_buffer->num_requests = 1;
 
 	req = &request_buffer->requests[0];
 
-	req->performance_domain = domain;
+	req->performance_domain = event_get_domain(event);
 	req->data_size = cpu_to_be16(8);
-	req->data_offset = cpu_to_be32(offset);
-	req->starting_lpar_ix = cpu_to_be16(lpar),
+	req->data_offset = cpu_to_be32(event_get_offset(event));
+	req->starting_lpar_ix = cpu_to_be16(event_get_lpar(event)),
 	req->max_num_lpars = cpu_to_be16(1);
-	req->starting_ix = cpu_to_be16(ix);
+	req->starting_ix = cpu_to_be16(idx);
 	req->max_ix = cpu_to_be16(1);
 
 	/*
@@ -1029,7 +1034,8 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 	if (ret) {
 		pr_devel_ratelimited("hcall failed: %d %#x %#x %d => "
 				"0x%lx (%ld) detail=0x%x failing ix=%x\n",
-				domain, offset, ix, lpar, ret, ret,
+				req->performance_domain, req->data_offset,
+				idx, req->starting_lpar_ix, ret, ret,
 				result_buffer->detailed_rc,
 				result_buffer->failing_request_ix);
 		goto out;
@@ -1042,22 +1048,6 @@ out:
 	return ret;
 }
 
-static unsigned long event_24x7_request(struct perf_event *event, u64 *res)
-{
-	u16 idx;
-	unsigned domain = event_get_domain(event);
-
-	if (is_physical_domain(domain))
-		idx = event_get_core(event);
-	else
-		idx = event_get_vcpu(event);
-
-	return single_24x7_request(event_get_domain(event),
-				event_get_offset(event),
-				idx,
-				event_get_lpar(event),
-				res);
-}
 
 static int h_24x7_event_init(struct perf_event *event)
 {
@@ -1126,7 +1116,7 @@ static int h_24x7_event_init(struct perf_event *event)
 	}
 
 	/* see if the event complains */
-	if (event_24x7_request(event, &ct)) {
+	if (single_24x7_request(event, &ct)) {
 		pr_devel("test hcall failed\n");
 		return -EIO;
 	}
@@ -1138,7 +1128,7 @@ static u64 h_24x7_get_value(struct perf_event *event)
 {
 	unsigned long ret;
 	u64 ct;
-	ret = event_24x7_request(event, &ct);
+	ret = single_24x7_request(event, &ct);
 	if (ret)
 		/* We checked this in event init, shouldn't fail here... */
 		return 0;
-- 
1.8.3.1
