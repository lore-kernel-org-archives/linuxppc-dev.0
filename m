Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2D2D1A06B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:54:55 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Mar 2015 19:54:54 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 81D7A1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:46:01 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2V1r43225362506
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 18:53:04 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2V1snxE003074
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:50 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH v2 05/10] powerpc/hv24x7: Move debug prints to separate
 function
Date: Mon, 30 Mar 2015 18:53:42 -0700
Message-Id: <1427766828-771-6-git-send-email-sukadev@linux.vnet.ibm.com>
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

To simplify/cleanup code, move the rather long printk() to a separate
function.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Conflicts:
	arch/powerpc/perf/hv-24x7.c
---
 arch/powerpc/perf/hv-24x7.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index f509f3b..a58a1df 100644
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
@@ -1032,12 +1047,7 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 			virt_to_phys(result_buffer),  H24x7_DATA_BUFFER_SIZE);
 
 	if (ret) {
-		pr_devel_ratelimited("hcall failed: %d %#x %#x %d => "
-				"0x%lx (%ld) detail=0x%x failing ix=%x\n",
-				req->performance_domain, req->data_offset,
-				idx, req->starting_lpar_ix, ret, ret,
-				result_buffer->detailed_rc,
-				result_buffer->failing_request_ix);
+		log_24x7_hcall(request_buffer, result_buffer, ret);
 		goto out;
 	}
 
-- 
1.8.3.1
