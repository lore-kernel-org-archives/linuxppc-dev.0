Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwPM57RGzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:37:59 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3Y92m123383
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:48 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vpaj1e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:48 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:37:47 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 07/17] powerpc/mm/hash: Move kernel context to the starting
 of context range
Date: Wed, 22 Mar 2017 09:06:53 +0530
In-Reply-To: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490153823-29241-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With current kernel, we use the top 4 context for the kernel. Kernel VSIDs are built
using these top context values and effective segemnt ID. In the following patches,
we want to increase the max effective address to 512TB. We achieve that by
increasing the effective segments IDs there by increasing virtual address range.

We will be switching to a 68bit virtual address in the following patch. But for
platforms like  p4 and p5, which only support a 65 bit va, we want to limit the
virtual addrress to a 65 bit value. We do that by limiting the context bits to 16
instead of 19. That means we will have different max context values on different
platforms.

To make this simpler. we move the kernel context to the starting of the range.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 39 ++++++------
 arch/powerpc/include/asm/mmu_context.h        |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c         |  2 +-
 arch/powerpc/mm/hash_utils_64.c               |  5 --
 arch/powerpc/mm/mmu_context_book3s64.c        | 88 ++++++++++++++++++---------
 arch/powerpc/mm/slb_low.S                     | 20 ++----
 6 files changed, 84 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 52d8d1e4b772..37dbc9becaba 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -494,10 +494,10 @@ extern void slb_set_size(u16 size);
  * For user processes max context id is limited to ((1ul << 19) - 5)
  * for kernel space, we use the top 4 context ids to map address as below
  * NOTE: each context only support 64TB now.
- * 0x7fffc -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
- * 0x7fffd -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
- * 0x7fffe -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
- * 0x7ffff -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
+ * 0x00000 -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
+ * 0x00001 -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
+ * 0x00002 -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
+ * 0x00003 -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
  *
  * The proto-VSIDs are then scrambled into real VSIDs with the
  * multiplicative hash:
@@ -511,15 +511,9 @@ extern void slb_set_size(u16 size);
  * robust scattering in the hash table (at least based on some initial
  * results).
  *
- * We also consider VSID 0 special. We use VSID 0 for slb entries mapping
- * bad address. This enables us to consolidate bad address handling in
- * hash_page.
- *
  * We also need to avoid the last segment of the last context, because that
  * would give a protovsid of 0x1fffffffff. That will result in a VSID 0
- * because of the modulo operation in vsid scramble. But the vmemmap
- * (which is what uses region 0xf) will never be close to 64TB in size
- * (it's 56 bytes per page of system memory).
+ * because of the modulo operation in vsid scramble.
  */
 
 #define CONTEXT_BITS		19
@@ -532,12 +526,15 @@ extern void slb_set_size(u16 size);
 /*
  * 256MB segment
  * The proto-VSID space has 2^(CONTEX_BITS + ESID_BITS) - 1 segments
- * available for user + kernel mapping. The top 4 contexts are used for
+ * available for user + kernel mapping. The bottom 4 contexts are used for
  * kernel mapping. Each segment contains 2^28 bytes. Each
- * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
- * (19 == 37 + 28 - 46).
+ * context maps 2^46 bytes (64TB).
+ *
+ * We also need to avoid the last segment of the last context, because that
+ * would give a protovsid of 0x1fffffffff. That will result in a VSID 0
+ * because of the modulo operation in vsid scramble.
  */
-#define MAX_USER_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 5)
+#define MAX_USER_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 2)
 
 /*
  * This should be computed such that protovosid * vsid_mulitplier
@@ -673,19 +670,19 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
  * This is only valid for addresses >= PAGE_OFFSET
  *
  * For kernel space, we use the top 4 context ids to map address as below
- * 0x7fffc -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
- * 0x7fffd -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
- * 0x7fffe -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
- * 0x7ffff -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
+ * 0x00000 -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
+ * 0x00001 -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
+ * 0x00002 -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
+ * 0x00003 -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
  */
 static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 {
 	unsigned long context;
 
 	/*
-	 * kernel take the top 4 context from the available range
+	 * kernel take the first 4 context from the available range
 	 */
-	context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1;
+	context = (ea >> 60) - 0xc;
 	return get_vsid(context, ea, ssize);
 }
 
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b9e3f0aca261..8fe1ba1808d3 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -51,7 +51,7 @@ static inline void switch_mmu_context(struct mm_struct *prev,
 	return switch_slb(tsk, next);
 }
 
-extern int __init_new_context(void);
+extern int hash__get_new_context(void);
 extern void __destroy_context(int context_id);
 static inline void mmu_context_init(void) { }
 #else
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index a587e8f4fd26..d6041101a5e2 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -390,7 +390,7 @@ int kvmppc_mmu_init(struct kvm_vcpu *vcpu)
 	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	int err;
 
-	err = __init_new_context();
+	err = hash__get_new_context();
 	if (err < 0)
 		return -1;
 	vcpu3s->context_id[0] = err;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 1bbf572243f7..6922a8d267cc 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -257,11 +257,6 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 		unsigned long vpn  = hpt_vpn(vaddr, vsid, ssize);
 		unsigned long tprot = prot;
 
-		/*
-		 * If we hit a bad address return error.
-		 */
-		if (!vsid)
-			return -1;
 		/* Make kernel text executable */
 		if (overlaps_kernel_text(vaddr, vaddr + step))
 			tprot &= ~HPTE_R_N;
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 73bf6e14c3aa..a6450c7f9cf3 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -30,17 +30,19 @@
 static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
-int __init_new_context(void)
+int hash__get_new_context(void)
 {
-	int index;
-	int err;
+	int index, err;
 
 again:
 	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
 		return -ENOMEM;
 
 	spin_lock(&mmu_context_lock);
-	err = ida_get_new_above(&mmu_context_ida, 1, &index);
+	/*
+	 * 0 - 3 context is taken by kernel.
+	 */
+	err = ida_get_new_above(&mmu_context_ida, 4, &index);
 	spin_unlock(&mmu_context_lock);
 
 	if (err == -EAGAIN)
@@ -54,51 +56,79 @@ int __init_new_context(void)
 		spin_unlock(&mmu_context_lock);
 		return -ENOMEM;
 	}
+	return index;
+}
+EXPORT_SYMBOL_GPL(hash__get_new_context);
+
+static int hash__init_new_context(struct mm_struct *mm)
+{
+	int index;
 
+	index = hash__get_new_context();
+	if (index < 0)
+		return index;
+	/* The old code would re-promote on fork, we don't do that
+	 * when using slices as it could cause problem promoting slices
+	 * that have been forced down to 4K
+	 *
+	 * For book3s we have MMU_NO_CONTEXT set to be ~0. Hence check
+	 * explicitly against context.id == 0. This ensures that we
+	 * properly initialize context slice details for newly allocated
+	 * mm's (which will have id == 0) and don't alter context slice
+	 * inherited via fork (which will have id != 0).
+	 *
+	 * We should not be calling init_new_context() on init_mm. Hence a
+	 * check against 0 is ok.
+	 */
+	if (mm->context.id == 0)
+		slice_set_user_psize(mm, mmu_virtual_psize);
+	subpage_prot_init_new_context(mm);
 	return index;
 }
-EXPORT_SYMBOL_GPL(__init_new_context);
-static int radix__init_new_context(struct mm_struct *mm, int index)
+
+static int radix__init_new_context(struct mm_struct *mm)
 {
+	int index, err;
 	unsigned long rts_field;
 
+again:
+	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
+		return -ENOMEM;
+
+	spin_lock(&mmu_context_lock);
+	err = ida_get_new_above(&mmu_context_ida, 1, &index);
+	spin_unlock(&mmu_context_lock);
+
+	if (err == -EAGAIN)
+		goto again;
+	else if (err)
+		return err;
+
+	if (index > ((1UL << PRTB_SIZE_SHIFT) - 1)) {
+		spin_lock(&mmu_context_lock);
+		ida_remove(&mmu_context_ida, index);
+		spin_unlock(&mmu_context_lock);
+		return -ENOMEM;
+	}
 	/*
 	 * set the process table entry,
 	 */
 	rts_field = radix__get_tree_size();
 	process_tb[index].prtb0 = cpu_to_be64(rts_field | __pa(mm->pgd) | RADIX_PGD_INDEX_SIZE);
-	return 0;
+	return index;
 }
 
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	int index;
 
-	index = __init_new_context();
+	if (radix_enabled())
+		index = radix__init_new_context(mm);
+	else
+		index = hash__init_new_context(mm);
 	if (index < 0)
 		return index;
 
-	if (radix_enabled()) {
-		radix__init_new_context(mm, index);
-	} else {
-
-		/* The old code would re-promote on fork, we don't do that
-		 * when using slices as it could cause problem promoting slices
-		 * that have been forced down to 4K
-		 *
-		 * For book3s we have MMU_NO_CONTEXT set to be ~0. Hence check
-		 * explicitly against context.id == 0. This ensures that we
-		 * properly initialize context slice details for newly allocated
-		 * mm's (which will have id == 0) and don't alter context slice
-		 * inherited via fork (which will have id != 0).
-		 *
-		 * We should not be calling init_new_context() on init_mm. Hence a
-		 * check against 0 is ok.
-		 */
-		if (mm->context.id == 0)
-			slice_set_user_psize(mm, mmu_virtual_psize);
-		subpage_prot_init_new_context(mm);
-	}
 	mm->context.id = index;
 #ifdef CONFIG_PPC_ICSWX
 	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index a85e06ea6c20..90154a4e5b9a 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -45,13 +45,6 @@ _GLOBAL(slb_allocate_realmode)
 	/* r3 = address, r10 = esid, cr7 = <> PAGE_OFFSET */
 	blt	cr7,0f			/* user or kernel? */
 
-	/* kernel address: proto-VSID = ESID */
-	/* WARNING - MAGIC: we don't use the VSID 0xfffffffff, but
-	 * this code will generate the protoVSID 0xfffffffff for the
-	 * top segment.  That's ok, the scramble below will translate
-	 * it to VSID 0, which is reserved as a bad VSID - one which
-	 * will never have any pages in it.  */
-
 	/* Check if hitting the linear mapping or some other kernel space
 	*/
 	bne	cr7,1f
@@ -63,12 +56,10 @@ _GLOBAL(slb_allocate_realmode)
 slb_miss_kernel_load_linear:
 	li	r11,0
 	/*
-	 * context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
+	 * context = (ea >> 60) - 0xc
 	 * r9 = region id.
 	 */
-	addis	r9,r9,(MAX_USER_CONTEXT - 0xc + 1)@ha
-	addi	r9,r9,(MAX_USER_CONTEXT - 0xc + 1)@l
-
+	subi	r9,r9,0xc
 
 BEGIN_FTR_SECTION
 	b	.Lslb_finish_load
@@ -77,9 +68,9 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 
 1:
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-	/* Check virtual memmap region. To be patches at kernel boot */
 	cmpldi	cr0,r9,0xf
 	bne	1f
+/* Check virtual memmap region. To be patched at kernel boot */
 .globl slb_miss_kernel_load_vmemmap
 slb_miss_kernel_load_vmemmap:
 	li	r11,0
@@ -102,11 +93,10 @@ slb_miss_kernel_load_io:
 	li	r11,0
 6:
 	/*
-	 * context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
+	 * context = (ea >> 60) - 0xc
 	 * r9 = region id.
 	 */
-	addis	r9,r9,(MAX_USER_CONTEXT - 0xc + 1)@ha
-	addi	r9,r9,(MAX_USER_CONTEXT - 0xc + 1)@l
+	subi	r9,r9,0xc
 
 BEGIN_FTR_SECTION
 	b	.Lslb_finish_load
-- 
2.7.4
