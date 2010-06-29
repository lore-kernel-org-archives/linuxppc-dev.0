Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4DA8B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 18:50:20 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5T8oHCs005680 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 01:50:17 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5T90V0r015315
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 04:00:32 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: disable SPARSE_IRQ by default
Date: Tue, 29 Jun 2010 17:32:57 +0800
Message-Id: <1277803977-3376-1-git-send-email-leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SPARSE_IRQ considerably adds overhead to critical path of IRQ
handling.  However it doesn't benefit much in space for most systems with
limited IRQ_NR.  Should be disabled unless really necessary.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 328774b..6506bf4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -400,7 +400,7 @@ config IRQ_ALL_CPUS
 
 config SPARSE_IRQ
 	bool "Support sparse irq numbering"
-	default y
+	default n
 	help
 	  This enables support for sparse irqs. This is useful for distro
 	  kernels that want to define a high CONFIG_NR_CPUS value but still
@@ -409,7 +409,7 @@ config SPARSE_IRQ
 	  ( Sparse IRQs can also be beneficial on NUMA boxes, as they spread
 	    out the irq_desc[] array in a more NUMA-friendly way. )
 
-	  If you don't know what to do here, say Y.
+	  If you don't know what to do here, say N.
 
 config NUMA
 	bool "NUMA support"
-- 
1.6.6-rc1.GIT
