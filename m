Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82AB3DDED0
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Jun 2007 22:08:40 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: Marvell mv64x60 drivers for ppc platforms fix
Date: Sun, 24 Jun 2007 15:52:31 +0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200706241552.31483.yur@emcraft.com>
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 This patch fixes the issue of erroneously involving the 
arch/powerpc/sysdev/mv64x60*.c files into the compilation 
process for ppc- (not powerpc-) based platforms (e.g., 
P3M750).

 Signed-off-by: Yuri Tikhonov <yur@emcraft.com>

--

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index c3ce0bd..25eaa14 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -17,7 +17,9 @@ obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
+ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
+endif
 
 # contains only the suspend handler for time
 obj-$(CONFIG_PM)		+= timer.o
