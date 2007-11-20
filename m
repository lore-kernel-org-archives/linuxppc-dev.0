Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA053DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 18:32:17 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix 8xx build breakage due to _tlbie changes
Date: Tue, 20 Nov 2007 10:32:12 +0300
Message-ID: <20071120073212.5717.51938.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


My changes to _tlbie to fix 4xx unfortunately broke 8xx build in a
couple of places. This fixes it.

Spotted by Olof Johansson

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/mm/mem.c      |    2 +-
 arch/powerpc/mm/mmu_decl.h |    2 +-
 arch/ppc/mm/init.c         |    2 +-
 arch/ppc/mm/mmu_decl.h     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 81eb96e..5402fb6 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -464,7 +464,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		 * we invalidate the TLB here, thus avoiding dcbst
 		 * misbehaviour.
 		 */
-		_tlbie(address);
+		_tlbie(address, 0 /* 8xx doesn't care about PID */);
 #endif
 		if (!PageReserved(page)
 		    && !test_bit(PG_arch_1, &page->flags)) {
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index eb3a732..ebfd13d 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -56,7 +56,7 @@ extern unsigned long total_lowmem;
  * architectures.  -- Dan
  */
 #if defined(CONFIG_8xx)
-#define flush_HPTE(X, va, pg)	_tlbie(va)
+#define flush_HPTE(X, va, pg)	_tlbie(va, 0 /* 8xx doesn't care about PID */)
 #define MMU_init_hw()		do { } while(0)
 #define mmu_mapin_ram()		(0UL)
 
diff --git a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
index 390dd19..dd898d3 100644
--- a/arch/ppc/mm/init.c
+++ b/arch/ppc/mm/init.c
@@ -561,7 +561,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		 * That means the zeroed TLB has to be invalidated
 		 * whenever a page miss occurs.
 		 */
-		_tlbie(address);
+		_tlbie(address, 0 /* 8xx doesn't care about PID */);
 #endif
 		if (!PageReserved(page)
 		    && !test_bit(PG_arch_1, &page->flags)) {
diff --git a/arch/ppc/mm/mmu_decl.h b/arch/ppc/mm/mmu_decl.h
index f1d4f21..b298b60 100644
--- a/arch/ppc/mm/mmu_decl.h
+++ b/arch/ppc/mm/mmu_decl.h
@@ -49,7 +49,7 @@ extern unsigned int num_tlbcam_entries;
  * architectures.  -- Dan
  */
 #if defined(CONFIG_8xx)
-#define flush_HPTE(X, va, pg)	_tlbie(va)
+#define flush_HPTE(X, va, pg)	_tlbie(va, 0 /* 8xx doesn't care about PID */)
 #define MMU_init_hw()		do { } while(0)
 #define mmu_mapin_ram()		(0UL)
 
