Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFxZ81lcKzDr6f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 18:53:04 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7J8nG3w135844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 04:53:02 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wuv9ebt2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 04:53:02 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 04:53:01 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 4/5] powerpc/64/kexec: Copy image with MMU off when possible
Date: Fri, 19 Aug 2016 14:22:38 +0530
In-Reply-To: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1471596759-3396-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Currently we turn the MMU off after copying the image, and we make
sure there is no overlap between the hash table and the target pages
in that case.

That doesn't work for Radix however. In that case, the page tables
are scattered and we can't really enforce that the target of the
image isn't overlapping one of them.

So instead, let's turn the MMU off before copying the image in radix
mode. Thankfully, in radix mode, even under a hypervisor, we know we
don't have the same kind of RMA limitations that hash mode has.

While at it, also turn the MMU off early when using hash in non-LPAR
mode, that way we can get rid of the collision check completely.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec_64.c | 47 +++++++++++++++-------------------
 arch/powerpc/kernel/misc_64.S          | 18 ++++++++++---
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 8cbd870dd557..98058d13d115 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -65,31 +65,6 @@ int default_machine_kexec_prepare(struct kimage *image)
 		if (image->segment[i].mem < __pa(_end))
 			return -ETXTBSY;
 
-	/*
-	 * For non-LPAR, we absolutely can not overwrite the mmu hash
-	 * table, since we are still using the bolted entries in it to
-	 * do the copy.  Check that here.
-	 *
-	 * It is safe if the end is below the start of the blocked
-	 * region (end <= low), or if the beginning is after the
-	 * end of the blocked region (begin >= high).  Use the
-	 * boolean identity !(a || b)  === (!a && !b).
-	 */
-#ifdef CONFIG_PPC_STD_MMU_64
-	if (htab_address) {
-		low = __pa(htab_address);
-		high = low + htab_size_bytes;
-
-		for (i = 0; i < image->nr_segments; i++) {
-			begin = image->segment[i].mem;
-			end = begin + image->segment[i].memsz;
-
-			if ((begin < high) && (end > low))
-				return -ETXTBSY;
-		}
-	}
-#endif /* CONFIG_PPC_STD_MMU_64 */
-
 	/* We also should not overwrite the tce tables */
 	for_each_node_by_type(node, "pci") {
 		basep = of_get_property(node, "linux,tce-base", NULL);
@@ -330,11 +305,14 @@ struct paca_struct kexec_paca;
 /* Our assembly helper, in misc_64.S */
 extern void kexec_sequence(void *newstack, unsigned long start,
 			   void *image, void *control,
-			   void (*clear_all)(void)) __noreturn;
+			   void (*clear_all)(void),
+			   bool copy_with_mmu_off) __noreturn;
 
 /* too late to fail here */
 void default_machine_kexec(struct kimage *image)
 {
+	bool copy_with_mmu_off;
+
 	/* prepare control code if any */
 
 	/*
@@ -372,13 +350,28 @@ void default_machine_kexec(struct kimage *image)
 	/* XXX: If anyone does 'dynamic lppacas' this will also need to be
 	 * switched to a static version!
 	 */
+	/* On Book3S, the copy must happen with the MMU off if we are either
+	 * using Radix page tables or we are not in an LPAR since we can
+	 * overwrite the page tables while copying.
+	 *
+	 * In an LPAR, we keep the MMU on otherwise we can't access beyond
+	 * the RMA. On BookE there is no real MMU off mode, so we have to
+	 * keep it enabled as well (but then we have bolted TLB entries).
+	 */
+#ifdef CONFIG_PPC_BOOK3E
+	copy_with_mmu_off = false;
+#else
+	copy_with_mmu_off = radix_enabled() ||
+		!(firmware_has_feature(FW_FEATURE_LPAR) ||
+		  firmware_has_feature(FW_FEATURE_PS3_LV1));
+#endif
 
 	/* Some things are best done in assembly.  Finding globals with
 	 * a toc is easier in C, so pass in what we can.
 	 */
 	kexec_sequence(&kexec_stack, image->start, image,
 		       page_address(image->control_code_page),
-		       mmu_cleanup_all);
+		       mmu_cleanup_all, copy_with_mmu_off);
 	/* NOTREACHED */
 }
 
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 7902f4b12d3f..23b746228d20 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -591,7 +591,8 @@ real_mode:	/* assume normal blr return */
 #endif
 
 /*
- * kexec_sequence(newstack, start, image, control, clear_all())
+ * kexec_sequence(newstack, start, image, control, clear_all(),
+	          copy_with_mmu_off)
  *
  * does the grungy work with stack switching and real mode switches
  * also does simple calls to other code
@@ -627,7 +628,7 @@ _GLOBAL(kexec_sequence)
 	mr	r29,r5			/* image (virt) */
 	mr	r28,r6			/* control, unused */
 	mr	r27,r7			/* clear_all() fn desc */
-	mr	r26,r8			/* spare */
+	mr	r26,r8			/* copy_with_mmu_off */
 	lhz	r25,PACAHWCPUID(r13)	/* get our phys cpu from paca */
 
 	/* disable interrupts, we are overwriting kernel data next */
@@ -639,15 +640,24 @@ _GLOBAL(kexec_sequence)
 	mtmsrd	r3,1
 #endif
 
+	/* We need to turn the MMU off unless we are in hash mode
+	 * under a hypervisor
+	 */
+	cmpdi	r26,0
+	beq	1f
+	bl	real_mode
+1:
 	/* copy dest pages, flush whole dest image */
 	mr	r3,r29
 	bl	kexec_copy_flush	/* (image) */
 
-	/* turn off mmu */
+	/* turn off mmu now if not done earlier */
+	cmpdi	r26,0
+	bne	1f
 	bl	real_mode
 
 	/* copy  0x100 bytes starting at start to 0 */
-	li	r3,0
+1:	li	r3,0
 	mr	r4,r30		/* start, aka phys mem offset */
 	li	r5,0x100
 	li	r6,0
-- 
2.7.4
