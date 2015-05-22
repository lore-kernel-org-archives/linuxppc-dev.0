Return-Path: <Pengbo.Li@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 586471A0BE8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 15:11:23 +1000 (AEST)
From: Pengbo Li <Pengbo.Li@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: Xie Xiaobo <X.Xie@freescale.com>, Li Pengbo <Pengbo.Li@freescale.com>
Subject: [PATCH v2] powerpc/85xx: p1025twr: add module conditional to fix
 QE-uart issue
Date: Fri, 22 May 2015 13:07:19 +0800
Message-ID: <1432271239-37337-1-git-send-email-Pengbo.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xie Xiaobo <X.Xie@freescale.com>

A ioport setting was needed when used the QE uart function on TWR-P1025.
Added a conditional definition to avoid missing this setting when the
QE-uart driver was bulit to a module.

Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
Signed-off-by: Li Pengbo <Pengbo.Li@freescale.com>
---
 arch/powerpc/platforms/85xx/twr_p102x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 1eadb6d..30e002f 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -79,7 +79,7 @@ static void __init twr_p1025_setup_arch(void)
 	mpc85xx_qe_init();
 	mpc85xx_qe_par_io_init();
 
-#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
+#if IS_ENABLED(CONFIG_UCC_GETH) || IS_ENABLED(CONFIG_SERIAL_QE)
 	if (machine_is(twr_p1025)) {
 		struct ccsr_guts __iomem *guts;
 
@@ -101,7 +101,7 @@ static void __init twr_p1025_setup_arch(void)
 					MPC85xx_PMUXCR_QE(12));
 			iounmap(guts);
 
-#if defined(CONFIG_SERIAL_QE)
+#if IS_ENABLED(CONFIG_SERIAL_QE)
 			/* On P1025TWR board, the UCC7 acted as UART port.
 			 * However, The UCC7's CTS pin is low level in default,
 			 * it will impact the transmission in full duplex
-- 
2.1.0.27.g96db324
