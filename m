Return-Path: <B21989@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06C071007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 13:32:05 +1100 (EST)
Received: from mail52-tx2 (localhost.localdomain [127.0.0.1])	by
	mail52-tx2-R.bigfish.com (Postfix) with ESMTP id A442F5E81EF	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 02:31:59 +0000 (UTC)
Received: from TX2EHSMHS005.bigfish.com (unknown [10.9.14.251])	by
	mail52-tx2.bigfish.com (Postfix) with ESMTP id 4FF78518056	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 02:31:59 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9E2Vu4e003892	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 19:31:57 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9E2l5lr024837	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 21:47:06 -0500 (CDT)
From: Shaohui Xie <b21989@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3] fsl_rio: fix non-standard HID1 register access
Date: Thu, 14 Oct 2010 10:04:26 +0800
Message-ID: <1287021866-22095-1-git-send-email-b21989@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alexandre.bounine@idt.com, b21989@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>

The access to HID1 register is only legitimate for e500 v1/v2 cores.
Also fixes magic number.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Shaohui Xie <b21989@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 4127636..dfff3b7 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1537,9 +1537,12 @@ int fsl_rio_setup(struct platform_device *dev)
 #ifdef CONFIG_E500
 	saved_mcheck_exception = ppc_md.machine_check_exception;
 	ppc_md.machine_check_exception = fsl_rio_mcheck_exception;
-#endif
-	/* Ensure that RFXE is set */
-	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | 0x20000));
+
+#ifndef CONFIG_PPC_E500MC
+	/* Ensure that RFXE is set on e500 v1/v2 */
+	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | HID1_RFXE));
+#endif /* !PPC_E500MC */
+#endif /* E500 */
 
 	return 0;
 err:
-- 
1.6.4
