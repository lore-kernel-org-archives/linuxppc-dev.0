Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 116171A030A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 21:23:38 +1100 (AEDT)
Message-Id: <9d25d9f3a8c0f39d0236c82eacda5917abd90c79.1454932181.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454932181.git.christophe.leroy@c-s.fr>
References: <cover.1454932181.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 16/23] powerpc/8xx: rewrite set_context() in C
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  9 Feb 2016 11:23:36 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no real need to have set_context() in assembly.
Now that we have mtspr() handling CPU6 ERRATA directly, we
can rewrite set_context() in C language for easier maintenance.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: no change
v4: no change
v5: no change
v6: no change
v7: no change

 arch/powerpc/kernel/head_8xx.S | 44 ------------------------------------------
 arch/powerpc/mm/8xx_mmu.c      | 34 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 637f8e9..bb2b657 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -968,50 +968,6 @@ initial_mmu:
 
 
 /*
- * Set up to use a given MMU context.
- * r3 is context number, r4 is PGD pointer.
- *
- * We place the physical address of the new task page directory loaded
- * into the MMU base register, and set the ASID compare register with
- * the new "context."
- */
-_GLOBAL(set_context)
-
-#ifdef CONFIG_BDI_SWITCH
-	/* Context switch the PTE pointer for the Abatron BDI2000.
-	 * The PGDIR is passed as second argument.
-	 */
-	lis	r5, KERNELBASE@h
-	lwz	r5, 0xf0(r5)
-	stw	r4, 0x4(r5)
-#endif
-
-	/* Register M_TW will contain base address of level 1 table minus the
-	 * lower part of the kernel PGDIR base address, so that all accesses to
-	 * level 1 table are done relative to lower part of kernel PGDIR base
-	 * address.
-	 */
-	li	r5, (swapper_pg_dir-PAGE_OFFSET)@l
-	sub	r4, r4, r5
-	tophys	(r4, r4)
-#ifdef CONFIG_8xx_CPU6
-	lis	r6, cpu6_errata_word@h
-	ori	r6, r6, cpu6_errata_word@l
-	li	r7, 0x3f80
-	stw	r7, 12(r6)
-	lwz	r7, 12(r6)
-#endif
-	mtspr	SPRN_M_TW, r4		/* Update pointeur to level 1 table */
-#ifdef CONFIG_8xx_CPU6
-	li	r7, 0x3380
-	stw	r7, 12(r6)
-	lwz	r7, 12(r6)
-#endif
-	mtspr	SPRN_M_CASID, r3	/* Update context */
-	SYNC
-	blr
-
-/*
  * We put a few things here that have to be page-aligned.
  * This stuff goes at the beginning of the data segment,
  * which is page-aligned.
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 50f17d2..b75c461 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -147,3 +147,37 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	memblock_set_current_limit(min_t(u64, first_memblock_size,
 					 initial_memory_size));
 }
+
+/*
+ * Set up to use a given MMU context.
+ * id is context number, pgd is PGD pointer.
+ *
+ * We place the physical address of the new task page directory loaded
+ * into the MMU base register, and set the ASID compare register with
+ * the new "context."
+ */
+void set_context(unsigned long id, pgd_t *pgd)
+{
+	s16 offset = (s16)(__pa(swapper_pg_dir));
+
+#ifdef CONFIG_BDI_SWITCH
+	pgd_t	**ptr = *(pgd_t ***)(KERNELBASE + 0xf0);
+
+	/* Context switch the PTE pointer for the Abatron BDI2000.
+	 * The PGDIR is passed as second argument.
+	 */
+	*(ptr + 1) = pgd;
+#endif
+
+	/* Register M_TW will contain base address of level 1 table minus the
+	 * lower part of the kernel PGDIR base address, so that all accesses to
+	 * level 1 table are done relative to lower part of kernel PGDIR base
+	 * address.
+	 */
+	mtspr(SPRN_M_TW, __pa(pgd) - offset);
+
+	/* Update context */
+	mtspr(SPRN_M_CASID, id);
+	/* sync */
+	mb();
+}
-- 
2.1.0
