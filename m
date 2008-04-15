Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73ED9DE8A6
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 05:56:28 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 07/13] [POWERPC] Rename __initial_memory_limit to
	__initial_memory_limit_addr
Date: Tue, 15 Apr 2008 14:52:25 -0500
Message-Id: <1208289151-2925-8-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1208289151-2925-7-git-send-email-galak@kernel.crashing.org>
References: <1208289151-2925-1-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-2-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-3-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-4-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-5-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-6-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-7-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We always use __initial_memory_limit as an address so rename it
to be clear.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/fsl_booke_mmu.c |    2 +-
 arch/powerpc/mm/init_32.c       |   10 +++++-----
 arch/powerpc/mm/mmu_decl.h      |    2 +-
 arch/powerpc/mm/ppc_mmu_32.c    |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 59f6649..ada249b 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -227,5 +227,5 @@ adjust_total_lowmem(void)
 			__cam0 >> 20, __cam1 >> 20, __cam2 >> 20,
 			(total_lowmem - __cam0 - __cam1 - __cam2) >> 20);
 	__max_low_memory = __cam0 + __cam1 + __cam2;
-	__initial_memory_limit = memstart_addr + __max_low_memory;
+	__initial_memory_limit_addr = memstart_addr + __max_low_memory;
 }
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index ba61d08..9a0ea2c 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -95,10 +95,10 @@ int __map_without_ltlbs;
 unsigned long __max_low_memory = MAX_LOW_MEM;
 
 /*
- * limit of what is accessible with initial MMU setup -
+ * address of the limit of what is accessible with initial MMU setup -
  * 256MB usually, but only 16MB on 601.
  */
-unsigned long __initial_memory_limit = 0x10000000;
+phys_addr_t __initial_memory_limit_addr = (phys_addr_t)0x10000000;
 
 /*
  * Check for command-line options that affect what MMU_init will do.
@@ -131,10 +131,10 @@ void __init MMU_init(void)
 
 	/* 601 can only access 16MB at the moment */
 	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
-		__initial_memory_limit = 0x01000000;
+		__initial_memory_limit_addr = 0x01000000;
 	/* 8xx can only access 8MB at the moment */
 	if (PVR_VER(mfspr(SPRN_PVR)) == 0x50)
-		__initial_memory_limit = 0x00800000;
+		__initial_memory_limit_addr = 0x00800000;
 
 	/* parse args from command line */
 	MMU_setup();
@@ -209,7 +209,7 @@ void __init *early_get_page(void)
 		p = alloc_bootmem_pages(PAGE_SIZE);
 	} else {
 		p = __va(lmb_alloc_base(PAGE_SIZE, PAGE_SIZE,
-					__initial_memory_limit));
+					__initial_memory_limit_addr));
 	}
 	return p;
 }
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 67477e7..0480225 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -48,7 +48,7 @@ extern unsigned int num_tlbcam_entries;
 
 extern unsigned long ioremap_bot;
 extern unsigned long __max_low_memory;
-extern unsigned long __initial_memory_limit;
+extern phys_addr_t __initial_memory_limit_addr;
 extern unsigned long total_memory;
 extern unsigned long total_lowmem;
 extern phys_addr_t memstart_addr;
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 65f915c..cef9f15 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -233,7 +233,7 @@ void __init MMU_init_hw(void)
 	 */
 	if ( ppc_md.progress ) ppc_md.progress("hash:find piece", 0x322);
 	Hash = __va(lmb_alloc_base(Hash_size, Hash_size,
-				   __initial_memory_limit));
+				   __initial_memory_limit_addr));
 	cacheable_memzero(Hash, Hash_size);
 	_SDR1 = __pa(Hash) | SDR1_LOW_BITS;
 
-- 
1.5.4.1
