Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB341B744F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:33 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/13] powerpc: Kconfig updates for FSL BookE HUGETLB 64-bit
Date: Mon, 10 Oct 2011 15:50:44 -0500
Message-Id: <1318279885811-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1318279883564-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
 <13182798731357-git-send-email-beckyb@kernel.crashing.org>
 <13182798761457-git-send-email-beckyb@kernel.crashing.org>
 <13182798791090-git-send-email-beckyb@kernel.crashing.org>
 <1318279883564-git-send-email-beckyb@kernel.crashing.org>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

Allow hugetlb to be enabled on 64b FSL_BOOK3E.  No platforms enable
it by default yet.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/platforms/Kconfig.cputype |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a85990c..7e47fd4 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -174,7 +174,6 @@ config BOOKE
 config FSL_BOOKE
 	bool
 	depends on (E200 || E500) && PPC32
-	select SYS_SUPPORTS_HUGETLBFS if PHYS_64BIT
 	default y
 
 # this is for common code between PPC32 & PPC64 FSL BOOKE
@@ -182,6 +181,7 @@ config PPC_FSL_BOOK3E
 	bool
 	select FSL_EMB_PERFMON
 	select PPC_SMP_MUXED_IPI
+	select SYS_SUPPORTS_HUGETLBFS if PHYS_64BIT || PPC64
 	default y if FSL_BOOKE
 
 config PTE_64BIT
@@ -298,7 +298,7 @@ config PPC_BOOK3E_MMU
 
 config PPC_MM_SLICES
 	bool
-	default y if (PPC64 && HUGETLB_PAGE) || (PPC_STD_MMU_64 && PPC_64K_PAGES)
+	default y if (!PPC_FSL_BOOK3E && PPC64 && HUGETLB_PAGE) || (PPC_STD_MMU_64 && PPC_64K_PAGES)
 	default n
 
 config VIRT_CPU_ACCOUNTING
-- 
1.5.6.5
