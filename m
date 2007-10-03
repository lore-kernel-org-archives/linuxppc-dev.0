Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26A4DDDF0E
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 06:10:06 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l93K9w6i024075
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 13:09:58 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l93K9vG0017852
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 15:09:58 -0500 (CDT)
Subject: [PATCH 4/5] Add initial MPC8610 HPCD Kconfig and Makefiles.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1191442197.21463.84.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 03 Oct 2007 15:09:57 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Xianghua Xiao <x.xiao@freescale.com>

Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Jason Jin <Jason.jin@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/Kconfig  |   13 +++++++++++++
 arch/powerpc/platforms/86xx/Makefile |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 685b2fb..21d1135 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -11,6 +11,12 @@ config MPC8641_HPCN
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
+config MPC8610_HPCD
+	bool "Freescale MPC8610 HPCD"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the MPC8610 HPCD board.
+
 endchoice
 
 config MPC8641
@@ -19,3 +25,10 @@ config MPC8641
 	select PPC_UDBG_16550
 	select MPIC
 	default y if MPC8641_HPCN
+
+config MPC8610
+	bool
+	select FSL_PCI if PCI
+	select PPC_UDBG_16550
+	select MPIC
+	default y if MPC8610_HPCD
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 3376c77..c967063 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
+obj-$(CONFIG_MPC8610_HPCD)	+= mpc8610_hpcd.o
-- 
1.5.3
