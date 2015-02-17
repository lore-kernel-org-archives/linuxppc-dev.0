Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D3531A087E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:01:16 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:01:14 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9516E38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 16:57:26 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HM1BEJ31719536
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 22:01:11 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HM19fK031919
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 17:01:10 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/9] powerpc/hv24x7: Remove unnecessary parameter
Date: Tue, 17 Feb 2015 14:00:27 -0800
Message-Id: <1424210434-28070-3-git-send-email-sukadev@linux.vnet.ibm.com>
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

Use pr_notice_ratelimited() to log error messages and remove
the 'success_expected' parameter.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 408e6e9..7856e38 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -986,8 +986,7 @@ static const struct attribute_group *attr_groups[] = {
 };
 
 static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
-					 u16 lpar, u64 *count,
-					 bool success_expected)
+					 u16 lpar, u64 *count)
 {
 	unsigned long ret;
 
@@ -1028,8 +1027,7 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 			virt_to_phys(result_buffer),  H24x7_DATA_BUFFER_SIZE);
 
 	if (ret) {
-		if (success_expected)
-			pr_err_ratelimited("hcall failed: %d %#x %#x %d => "
+		pr_notice_ratelimited("hcall failed: %d %#x %#x %d => "
 				"0x%lx (%ld) detail=0x%x failing ix=%x\n",
 				domain, offset, ix, lpar, ret, ret,
 				result_buffer->detailed_rc,
@@ -1044,8 +1042,7 @@ out:
 	return ret;
 }
 
-static unsigned long event_24x7_request(struct perf_event *event, u64 *res,
-		bool success_expected)
+static unsigned long event_24x7_request(struct perf_event *event, u64 *res)
 {
 	u16 idx;
 	unsigned domain = event_get_domain(event);
@@ -1059,8 +1056,7 @@ static unsigned long event_24x7_request(struct perf_event *event, u64 *res,
 				event_get_offset(event),
 				idx,
 				event_get_lpar(event),
-				res,
-				success_expected);
+				res);
 }
 
 static int h_24x7_event_init(struct perf_event *event)
@@ -1130,7 +1126,7 @@ static int h_24x7_event_init(struct perf_event *event)
 	}
 
 	/* see if the event complains */
-	if (event_24x7_request(event, &ct, false)) {
+	if (event_24x7_request(event, &ct)) {
 		pr_devel("test hcall failed\n");
 		return -EIO;
 	}
@@ -1142,7 +1138,7 @@ static u64 h_24x7_get_value(struct perf_event *event)
 {
 	unsigned long ret;
 	u64 ct;
-	ret = event_24x7_request(event, &ct, true);
+	ret = event_24x7_request(event, &ct);
 	if (ret)
 		/* We checked this in event init, shouldn't fail here... */
 		return 0;
-- 
1.8.3.1
