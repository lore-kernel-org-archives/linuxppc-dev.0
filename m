Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98531DDED5
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 09:46:53 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1CMknKR018839
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 16:46:50 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/book-3e: Introduce concept of Book-3e MMU
Date: Thu, 12 Feb 2009 16:46:48 -0600
Message-Id: <1234478808-31883-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1234478808-31883-1-git-send-email-galak@kernel.crashing.org>
References: <1234478808-31883-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Power ISA 2.06 spec introduces a standard MMU programming model that
is based on the Freescale Book-E MMU programing model.  The Freescale
version is pretty backwards compatiable with the ISA 2.06 definition so
we are starting to refactor some of the Freescale code so it can be
easily shared.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 .../include/asm/{mmu-fsl-booke.h => mmu-book3e.h}  |    0 
 arch/powerpc/include/asm/mmu.h                     |    6 +++---
 arch/powerpc/platforms/Kconfig.cputype             |    4 ++++
 3 files changed, 7 insertions(+), 3 deletions(-)
 rename arch/powerpc/include/asm/{mmu-fsl-booke.h => mmu-book3e.h} (100%)

diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h b/arch/powerpc/include/asm/mmu-book3e.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-fsl-booke.h
rename to arch/powerpc/include/asm/mmu-book3e.h
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 6e76399..5c78079 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -71,9 +71,9 @@ extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 #elif defined(CONFIG_44x)
 /* 44x-style software loaded TLB */
 #  include <asm/mmu-44x.h>
-#elif defined(CONFIG_FSL_BOOKE)
-/* Freescale Book-E software loaded TLB */
-#  include <asm/mmu-fsl-booke.h>
+#elif defined(CONFIG_PPC_BOOK3E_MMU)
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#  include <asm/mmu-book3e.h>
 #elif defined (CONFIG_PPC_8xx)
 /* Motorola/Freescale 8xx software loaded TLB */
 #  include <asm/mmu-8xx.h>
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e868b5c..9428c0e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -210,6 +210,10 @@ config PPC_MMU_NOHASH
 	def_bool y
 	depends on !PPC_STD_MMU
 
+config PPC_BOOK3E_MMU
+	def_bool y
+	depends on FSL_BOOKE
+
 config PPC_MM_SLICES
 	bool
 	default y if HUGETLB_PAGE || (PPC_STD_MMU_64 && PPC_64K_PAGES)
-- 
1.5.6.6
