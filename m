Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 160AEB7D84
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 15:38:31 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5I5cEAZ015240 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 22:38:24 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o5I5cFcn026493
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 00:38:19 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] fsl_rio: fix non-standard HID1 register access
Date: Fri, 18 Jun 2010 13:29:18 +0800
Message-Id: <1276838958-28947-3-git-send-email-leoli@freescale.com>
In-Reply-To: <1276838958-28947-2-git-send-email-leoli@freescale.com>
References: <1276838958-28947-1-git-send-email-leoli@freescale.com>
	<1276838958-28947-2-git-send-email-leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The access to HID1 register is only legitimate for e500 v1/v2 cores.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 954a754..785a882 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1523,9 +1523,12 @@ int fsl_rio_setup(struct of_device *dev)
 #ifdef CONFIG_E500
 	saved_mcheck_exception = ppc_md.machine_check_exception;
 	ppc_md.machine_check_exception = fsl_rio_mcheck_exception;
-#endif
-	/* Ensure that RFXE is set */
+	
+#ifndef CONFIG_E500MC
+	/* Ensure that RFXE is set on e500 v1/v2 */
 	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | 0x20000));
+#endif /* !E500MC */
+#endif /* E500 */
 
 	return 0;
 err:
-- 
1.6.4
