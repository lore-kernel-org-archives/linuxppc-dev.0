Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 151FAB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 10:11:10 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Gang.Liu@freescale.com
Subject: [PATCH/RFC] rapidio: temporarily exclude FSL_RIO from 64 bit builds
Date: Tue, 21 Feb 2012 18:10:53 -0500
Message-Id: <1329865853-17277-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following are seen while using the corenet64_smp_defconfig:

arch/powerpc/sysdev/fsl_rmu.c:315: error: cast from pointer to integer of different size
arch/powerpc/sysdev/fsl_rmu.c:320: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:320: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:320: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:330: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:332: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:339: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:340: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:341: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:348: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:348: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:348: error: cast to pointer from integer of different size
arch/powerpc/sysdev/fsl_rmu.c:659: error: cast from pointer to integer of different size
arch/powerpc/sysdev/fsl_rmu.c:659: error: format '%8.8x' expects type 'unsigned int', but argument 5 has type 'size_t'
arch/powerpc/sysdev/fsl_rmu.c:985: error: cast from pointer to integer of different size
arch/powerpc/sysdev/fsl_rmu.c:997: error: cast to pointer from integer of different size

A quick inspection of the code leaves one with the impression
that it was not explicitly written with 64 bit support in mind,
so just block that as a possible config selection for now.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

---

[This is seen in linux-next -- not sure if this is the right way to go
 but at least it will give the issue some visibility to the right ppl.]

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 75f061e..5ad8013 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -773,7 +773,7 @@ config RAPIDIO
 
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
-	depends on RAPIDIO && HAS_RAPIDIO
+	depends on RAPIDIO && HAS_RAPIDIO && (BROKEN || !PPC64)
 	default "n"
 	---help---
 	  Include support for RapidIO controller on Freescale embedded
-- 
1.7.9.1
