Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14F951A0B53
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:01:21 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:01:19 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CF99F6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 16:53:08 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HM1HuE26280176
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 22:01:17 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HM1EDk032610
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 17:01:15 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/9] powerpc/hv24x7: Move debug prints to separate function
Date: Tue, 17 Feb 2015 14:00:29 -0800
Message-Id: <1424210434-28070-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

To simplify/cleanup code, move the rather long printk() to a separate
function.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index c189e75..a58a1df 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -985,6 +985,21 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
+static void log_24x7_hcall(struct hv_24x7_request_buffer *request_buffer,
+			struct hv_24x7_data_result_buffer *result_buffer,
+			unsigned long ret)
+{
+	struct hv_24x7_request *req;
+
+	req = &request_buffer->requests[0];
+	pr_notice_ratelimited("hcall failed: [%d %#x %#x %d] => "
+			"ret 0x%lx (%ld) detail=0x%x failing ix=%x\n",
+			req->performance_domain, req->data_offset,
+			req->starting_ix, req->starting_lpar_ix, ret, ret,
+			result_buffer->detailed_rc,
+			result_buffer->failing_request_ix);
+}
+
 static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 {
 	u16 idx;
@@ -1032,13 +1047,7 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 			virt_to_phys(result_buffer),  H24x7_DATA_BUFFER_SIZE);
 
 	if (ret) {
-		pr_notice_ratelimited("hcall failed: %d %#x %#x %d => "
-				"0x%lx (%ld) detail=0x%x failing ix=%x\n",
-				(int)event_get_domain(event),
-				(unsigned int)event_get_offset(event),
-				idx, (int)event_get_lpar(event), ret, ret,
-				result_buffer->detailed_rc,
-				result_buffer->failing_request_ix);
+		log_24x7_hcall(request_buffer, result_buffer, ret);
 		goto out;
 	}
 
-- 
1.8.3.1
