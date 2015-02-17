Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 157F11A0A2F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:01:19 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:01:17 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3294038C8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 16:57:30 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HM1F2327787346
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 22:01:15 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HM1Dso032263
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 17:01:13 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/9] powerpc/hv-24x7: Drop event_24x7_request()
Date: Tue, 17 Feb 2015 14:00:28 -0800
Message-Id: <1424210434-28070-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1424210434-28070-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1424210434-28070-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 7856e38..c189e75 100644
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
@@ -1029,7 +1034,9 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 	if (ret) {
 		pr_notice_ratelimited("hcall failed: %d %#x %#x %d => "
 				"0x%lx (%ld) detail=0x%x failing ix=%x\n",
-				domain, offset, ix, lpar, ret, ret,
+				(int)event_get_domain(event),
+				(unsigned int)event_get_offset(event),
+				idx, (int)event_get_lpar(event), ret, ret,
 				result_buffer->detailed_rc,
 				result_buffer->failing_request_ix);
 		goto out;
@@ -1042,22 +1049,6 @@ out:
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
@@ -1126,7 +1117,7 @@ static int h_24x7_event_init(struct perf_event *event)
 	}
 
 	/* see if the event complains */
-	if (event_24x7_request(event, &ct)) {
+	if (single_24x7_request(event, &ct)) {
 		pr_devel("test hcall failed\n");
 		return -EIO;
 	}
@@ -1138,7 +1129,7 @@ static u64 h_24x7_get_value(struct perf_event *event)
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
