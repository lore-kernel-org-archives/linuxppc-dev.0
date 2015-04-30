Return-Path: <Pengbo.Li@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0119.outbound.protection.outlook.com [207.46.100.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1AD41A0415
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 14:35:22 +1000 (AEST)
From: Pengbo Li <Pengbo.Li@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH] powerpc/85xx: p1025twr: add module conditional to fix QE-uart
 issue
Date: Thu, 30 Apr 2015 10:56:50 +0800
Message-ID: <1430362610-35564-1-git-send-email-Pengbo.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xie Xiaobo <X.Xie@freescale.com>
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
Change-Id: I95b40c760335ce5fa7a27a94287dbef28219b5fa
Reviewed-on: http://git.am.freescale.net:8181/6643
Tested-by: Review Code-CDREVIEW <CDREVIEW@freescale.com>
Reviewed-by: Yang Li <LeoLi@freescale.com>
Reviewed-by: Thomas Trefny <Tom.Trefny@freescale.com>
Reviewed-on: http://git.am.freescale.net:8181/12045
Reviewed-by: Jose Rivera <German.Rivera@freescale.com>
---
 arch/powerpc/platforms/85xx/twr_p102x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 1eadb6d..069e19b 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -101,7 +101,7 @@ static void __init twr_p1025_setup_arch(void)
 					MPC85xx_PMUXCR_QE(12));
 			iounmap(guts);
 
-#if defined(CONFIG_SERIAL_QE)
+#if defined(CONFIG_SERIAL_QE) || defined(CONFIG_SERIAL_QE_MODULE)
 			/* On P1025TWR board, the UCC7 acted as UART port.
 			 * However, The UCC7's CTS pin is low level in default,
 			 * it will impact the transmission in full duplex
-- 
2.1.0.27.g96db324
