Return-Path: <arnd@arndb.de>
Message-Id: <20071218175106.932751000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:09 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 17/18] cell: handle SPE kernel mappings that cross segment
	boundaries
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, we have a possibilty that the SLBs setup during context
switch don't cover the entirety of the necessary lscsa and code
regions, if these regions cross a segment boundary.

This change checks the start and end of each region, and inserts a SLB
entry for each, if unique. We also remove the assumption that the
spu_save_code and spu_restore_code reside in the same segment, by using
the specific code array for save and restore.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spu_base.c     |   50 ++++++++++++++++++++++++----
 arch/powerpc/platforms/cell/spufs/switch.c |   11 ++++--
 include/asm-powerpc/spu.h                  |    4 +-
 3 files changed, 52 insertions(+), 13 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
@@ -275,19 +275,55 @@ static void __spu_kernel_slb(void *addr,
 }
 
 /**
+ * Given an array of @nr_slbs SLB entries, @slbs, return non-zero if the
+ * address @new_addr is present.
+ */
+static inline int __slb_present(struct spu_slb *slbs, int nr_slbs,
+		void *new_addr)
+{
+	unsigned long ea = (unsigned long)new_addr;
+	int i;
+
+	for (i = 0; i < nr_slbs; i++)
+		if (!((slbs[i].esid ^ ea) & ESID_MASK))
+			return 1;
+
+	return 0;
+}
+
+/**
  * Setup the SPU kernel SLBs, in preparation for a context save/restore. We
  * need to map both the context save area, and the save/restore code.
+ *
+ * Because the lscsa and code may cross segment boundaires, we check to see
+ * if mappings are required for the start and end of each range. We currently
+ * assume that the mappings are smaller that one segment - if not, something
+ * is seriously wrong.
  */
-void spu_setup_kernel_slbs(struct spu *spu, struct spu_lscsa *lscsa, void *code)
+void spu_setup_kernel_slbs(struct spu *spu, struct spu_lscsa *lscsa,
+		void *code, int code_size)
 {
-	struct spu_slb code_slb, lscsa_slb;
+	struct spu_slb slbs[4];
+	int i, nr_slbs = 0;
+	/* start and end addresses of both mappings */
+	void *addrs[] = {
+		lscsa, (void *)lscsa + sizeof(*lscsa) - 1,
+		code, code + code_size - 1
+	};
 
-	__spu_kernel_slb(lscsa, &lscsa_slb);
-	__spu_kernel_slb(code, &code_slb);
+	/* check the set of addresses, and create a new entry in the slbs array
+	 * if there isn't already a SLB for that address */
+	for (i = 0; i < ARRAY_SIZE(addrs); i++) {
+		if (__slb_present(slbs, nr_slbs, addrs[i]))
+			continue;
+
+		__spu_kernel_slb(addrs[i], &slbs[nr_slbs]);
+		nr_slbs++;
+	}
 
-	spu_load_slb(spu, 0, &lscsa_slb);
-	if (lscsa_slb.esid != code_slb.esid)
-		spu_load_slb(spu, 1, &code_slb);
+	/* Add the set of SLBs */
+	for (i = 0; i < nr_slbs; i++)
+		spu_load_slb(spu, i, &slbs[i]);
 }
 EXPORT_SYMBOL_GPL(spu_setup_kernel_slbs);
 
Index: linux-2.6-new/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spufs/switch.c
@@ -691,7 +691,8 @@ static inline void resume_mfc_queue(stru
 	out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESUME_DMA_QUEUE);
 }
 
-static inline void setup_mfc_slbs(struct spu_state *csa, struct spu *spu)
+static inline void setup_mfc_slbs(struct spu_state *csa, struct spu *spu,
+		unsigned int *code, int code_size)
 {
 	/* Save, Step 47:
 	 * Restore, Step 30.
@@ -708,7 +709,7 @@ static inline void setup_mfc_slbs(struct
 	 *     translation is desired by OS environment).
 	 */
 	spu_invalidate_slbs(spu);
-	spu_setup_kernel_slbs(spu, csa->lscsa, &spu_save_code);
+	spu_setup_kernel_slbs(spu, csa->lscsa, code, code_size);
 }
 
 static inline void set_switch_active(struct spu_state *csa, struct spu *spu)
@@ -1835,7 +1836,8 @@ static void save_lscsa(struct spu_state 
 	 */
 
 	resume_mfc_queue(prev, spu);	/* Step 46. */
-	setup_mfc_slbs(prev, spu);	/* Step 47. */
+	/* Step 47. */
+	setup_mfc_slbs(prev, spu, spu_save_code, sizeof(spu_save_code));
 	set_switch_active(prev, spu);	/* Step 48. */
 	enable_interrupts(prev, spu);	/* Step 49. */
 	save_ls_16kb(prev, spu);	/* Step 50. */
@@ -1940,7 +1942,8 @@ static void restore_lscsa(struct spu_sta
 	setup_spu_status_part1(next, spu);	/* Step 27. */
 	setup_spu_status_part2(next, spu);	/* Step 28. */
 	restore_mfc_rag(next, spu);	        /* Step 29. */
-	setup_mfc_slbs(next, spu);	        /* Step 30. */
+	/* Step 30. */
+	setup_mfc_slbs(next, spu, spu_restore_code, sizeof(spu_restore_code));
 	set_spu_npc(next, spu);	                /* Step 31. */
 	set_signot1(next, spu);	                /* Step 32. */
 	set_signot2(next, spu);	                /* Step 33. */
Index: linux-2.6-new/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6-new.orig/include/asm-powerpc/spu.h
+++ linux-2.6-new/include/asm-powerpc/spu.h
@@ -201,8 +201,8 @@ int spu_irq_class_0_bottom(struct spu *s
 int spu_irq_class_1_bottom(struct spu *spu);
 void spu_irq_setaffinity(struct spu *spu, int cpu);
 
-void spu_setup_kernel_slbs(struct spu *spu,
-		struct spu_lscsa *lscsa, void *code);
+void spu_setup_kernel_slbs(struct spu *spu, struct spu_lscsa *lscsa,
+		void *code, int code_size);
 
 #ifdef CONFIG_KEXEC
 void crash_register_spus(struct list_head *list);

-- 
