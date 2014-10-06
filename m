Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E31A1A0053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Oct 2014 20:34:32 +1100 (EST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CDB2D1400EA
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Oct 2014 20:34:30 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 6 Oct 2014 15:04:23 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 065D23940048
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Oct 2014 15:04:22 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s969Yn5R37552290
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Oct 2014 15:04:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s969YKAd024269
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Oct 2014 15:04:20 +0530
Subject: [PATCH] powerpc/powernv: Fallback to old HMI handling behavior for
 old firmware
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 06 Oct 2014 15:04:19 +0530
Message-ID: <20141006093358.1828.36741.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Recently we moved HMI handling into Linux kernel instead of taking
HMI directly in OPAL. This new change is dependent on new OPAL call
for HMI recovery which was introduced in newer firmware. While this new
change works fine with latest OPAL firmware, we broke the HMI handling
if we run newer kernel on old OPAL firmware that results in system hang.

This patch fixes this issue by falling back to old HMI behavior on older
OPAL firmware.

This patch introduces a check for opal token OPAL_HANDLE_HMI to see
if we are running on newer firmware or old firmware. On newer firmware
this check would return OPAL_TOKEN_PRESENT, otherwise we are running on
old firmware and fallback to old HMI behavior.

This patch depends on opal check token patch posted at ppc-devel
https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120224.html

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index b44eec3..2768cd3 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -194,6 +194,24 @@ static int __init opal_register_exception_handlers(void)
 	 * fwnmi area at 0x7000 to provide the glue space to OPAL
 	 */
 	glue = 0x7000;
+
+	/* Check if we are running on newer firmware that exports
+	 * OPAL_HANDLE_HMI token. If yes, then don't ask opal to patch
+	 * HMI interrupt and we catch it directly in Linux kernel.
+	 *
+	 * For older firmware we will fallback to old behavior and
+	 * let OPAL patch the HMI vector and handle it inside OPAL
+	 * firmware.
+	 */
+	if (opal_check_token(OPAL_HANDLE_HMI) != OPAL_TOKEN_PRESENT) {
+		/* We are on old firmware. fallback to old behavior. */
+		pr_info("%s: Falling back to old HMI handling behavior.\n",
+			__func__);
+		opal_register_exception_handler(
+				OPAL_HYPERVISOR_MAINTENANCE_HANDLER,
+				0, glue);
+		glue += 128;
+	}
 	opal_register_exception_handler(OPAL_SOFTPATCH_HANDLER, 0, glue);
 #endif
 
