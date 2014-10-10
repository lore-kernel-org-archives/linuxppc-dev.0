Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 309A61A0986
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Oct 2014 02:58:37 +1100 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 82A851400AB
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2014 02:58:36 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 10 Oct 2014 21:28:32 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A4A6AE0045
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2014 21:31:23 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9AFwwM663504430
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2014 21:28:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9AFwRJG030605
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2014 21:28:27 +0530
Subject: [PATCH v2] powerpc/powernv: Fallback to old HMI handling behavior
 for old firmware
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Oct 2014 21:28:26 +0530
Message-ID: <20141010155743.3855.36732.stgit@mars>
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

Old firmware: POWER8 System Firmware Release as of today <= SV810_087
Action: Let OPAL handle HMIs

Newer firmware: in development/yet to be released.
Action: Let Linux host handle HMIs.

This patch depends on opal check token patch posted at ppc-devel
https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120224.html

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index b44eec3..f172c15 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -194,6 +194,29 @@ static int __init opal_register_exception_handlers(void)
 	 * fwnmi area at 0x7000 to provide the glue space to OPAL
 	 */
 	glue = 0x7000;
+
+	/*
+	 * Check if we are running on newer firmware that exports
+	 * OPAL_HANDLE_HMI token. If yes, then don't ask opal to patch
+	 * HMI interrupt and we catch it directly in Linux kernel.
+	 *
+	 * For older firmware (i.e currently released POWER8 System Firmware
+	 * as of today <= SV810_087), we fallback to old behavior and let OPAL
+	 * to patch the HMI vector and handle it inside OPAL firmware.
+	 *
+	 * For newer firmware (in development/yet to be released) we will
+	 * start catching/handling HMI directly in Linux kernel.
+	 */
+	if (!opal_check_token(OPAL_HANDLE_HMI)) {
+		/* We are on old firmware. fallback to old behavior. */
+		pr_info("%s: Old firmware detected, let OPAL handle HMIs.\n",
+			"opal");
+		opal_register_exception_handler(
+				OPAL_HYPERVISOR_MAINTENANCE_HANDLER,
+				0, glue);
+		glue += 128;
+	}
+
 	opal_register_exception_handler(OPAL_SOFTPATCH_HANDLER, 0, glue);
 #endif
 
