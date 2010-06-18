Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9CC7CB7D84
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 15:38:30 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5I5cBd2015223 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 22:38:21 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o5I5cFcj026493
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 00:38:16 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] fsl_rio: fix compile errors
Date: Fri, 18 Jun 2010 13:29:16 +0800
Message-Id: <1276838958-28947-1-git-send-email-leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes the following compile problem on E500 platforms:
arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared (first use in this function)

Also fixes the compile problem on non-E500 platforms.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 30e1626..f908ba6 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -240,12 +240,13 @@ struct rio_priv {
 
 static void __iomem *rio_regs_win;
 
+#ifdef CONFIG_E500
 static int (*saved_mcheck_exception)(struct pt_regs *regs);
 
 static int fsl_rio_mcheck_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *entry = NULL;
-	unsigned long reason = (mfspr(SPRN_MCSR) & MCSR_MASK);
+	unsigned long reason = mfspr(SPRN_MCSR);
 
 	if (reason & MCSR_BUS_RBERR) {
 		reason = in_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR));
@@ -269,6 +270,7 @@ static int fsl_rio_mcheck_exception(struct pt_regs *regs)
 	else
 		return cur_cpu_spec->machine_check(regs);
 }
+#endif
 
 /**
  * fsl_rio_doorbell_send - Send a MPC85xx doorbell message
@@ -1517,8 +1519,10 @@ int fsl_rio_setup(struct of_device *dev)
 	fsl_rio_doorbell_init(port);
 	fsl_rio_port_write_init(port);
 
+#ifdef CONFIG_E500
 	saved_mcheck_exception = ppc_md.machine_check_exception;
 	ppc_md.machine_check_exception = fsl_rio_mcheck_exception;
+#endif
 	/* Ensure that RFXE is set */
 	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | 0x20000));
 
-- 
1.6.4
