Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5744CDE0CB
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 14:23:29 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2A3NO25014466
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 20:23:24 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n2A3NMoK008826
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 22:23:23 -0500 (CDT)
From: Liu Yu <yu.liu@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] efp: Fix efp dependence
Date: Tue, 10 Mar 2009 11:09:49 +0800
Message-Id: <1236654589-6624-1-git-send-email-yu.liu@freescale.com>
Cc: Liu Yu <yu.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is no dependece between efp and math-emu.
But when disalbe math-emu, the efp code cannot be built.
This patch fixes it.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
It would be nice to see this patch go along with 2.6.29

 arch/powerpc/Makefile          |    4 ++--
 arch/powerpc/math-emu/Makefile |    5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 72d17f5..551fc58 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -147,8 +147,8 @@ core-y				+= arch/powerpc/kernel/ \
 				   arch/powerpc/mm/ \
 				   arch/powerpc/lib/ \
 				   arch/powerpc/sysdev/ \
-				   arch/powerpc/platforms/
-core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/
+				   arch/powerpc/platforms/ \
+				   arch/powerpc/math-emu/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
 
diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index f9e506a..0c16ab9 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -1,6 +1,4 @@
 
-obj-y				:= math.o fmr.o lfd.o stfd.o
-
 obj-$(CONFIG_MATH_EMULATION)	+= fabs.o fadd.o fadds.o fcmpo.o fcmpu.o \
 					fctiw.o fctiwz.o fdiv.o fdivs.o \
 					fmadd.o fmadds.o fmsub.o fmsubs.o \
@@ -9,7 +7,8 @@ obj-$(CONFIG_MATH_EMULATION)	+= fabs.o fadd.o fadds.o fcmpo.o fcmpu.o \
 					fres.o frsp.o frsqrte.o fsel.o lfs.o \
 					fsqrt.o	fsqrts.o fsub.o fsubs.o \
 					mcrfs.o mffs.o mtfsb0.o mtfsb1.o \
-					mtfsf.o mtfsfi.o stfiwx.o stfs.o
+					mtfsf.o mtfsfi.o stfiwx.o stfs.o \
+					math.o fmr.o lfd.o stfd.o
 
 obj-$(CONFIG_SPE)		+= math_efp.o
 
-- 
1.5.4
