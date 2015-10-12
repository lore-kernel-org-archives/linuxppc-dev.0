Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E95FA1A081F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 05:40:35 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 00:10:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2E465125801C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:15 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CIeUc357999462
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CIeTI4013627
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:30 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 19/31] powerpc/mm: Convert 4k hash insert to C
Date: Tue, 13 Oct 2015 00:10:03 +0530
Message-Id: <1444675215-19484-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/Makefile        |   3 +
 arch/powerpc/mm/hash64_64k.c    | 202 +++++++++++++++++++++
 arch/powerpc/mm/hash_low_64.S   | 380 ----------------------------------------
 arch/powerpc/mm/hash_utils_64.c |   4 +-
 4 files changed, 208 insertions(+), 381 deletions(-)
 create mode 100644 arch/powerpc/mm/hash64_64k.c

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3eb73a38220d..f80ad1a76cc8 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -18,6 +18,9 @@ obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= hash_low_$(CONFIG_WORD_SIZE).o \
 				   tlb_hash$(CONFIG_WORD_SIZE).o \
 				   mmu_context_hash$(CONFIG_WORD_SIZE).o
+ifeq ($(CONFIG_PPC_STD_MMU_64),y)
+obj-$(CONFIG_PPC_64K_PAGES)	+= hash64_64k.o
+endif
 obj-$(CONFIG_PPC_ICSWX)		+= icswx.o
 obj-$(CONFIG_PPC_ICSWX_PID)	+= icswx_pid.o
 obj-$(CONFIG_40x)		+= 40x_mmu.o
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
new file mode 100644
index 000000000000..da133f2a51a7
--- /dev/null
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -0,0 +1,202 @@
+/*
+ * Copyright IBM Corporation, 2015
+ * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#include <linux/mm.h>
+#include <asm/machdep.h>
+#include <asm/mmu.h>
+
+int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
+		   pte_t *ptep, unsigned long trap, unsigned long flags,
+		   int ssize, int subpg_prot)
+{
+	real_pte_t rpte;
+	unsigned long *hidxp;
+	unsigned long hpte_group;
+	unsigned int subpg_index;
+	unsigned long shift = 12; /* 4K */
+	unsigned long rflags, pa, hidx;
+	unsigned long old_pte, new_pte, subpg_pte;
+	unsigned long vpn, hash, slot;
+
+	/*
+	 * atomically mark the linux large page PTE busy and dirty
+	 */
+	do {
+		pte_t pte = READ_ONCE(*ptep);
+
+		old_pte = pte_val(pte);
+		/* If PTE busy, retry the access */
+		if (unlikely(old_pte & _PAGE_BUSY))
+			return 0;
+		/* If PTE permissions don't match, take page fault */
+		if (unlikely(access & ~old_pte))
+			return 1;
+		/*
+		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
+		 * a write access. Since this is 4K insert of 64K page size
+		 * also add _PAGE_COMBO
+		 */
+		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
+		if (access & _PAGE_RW)
+			new_pte |= _PAGE_DIRTY;
+	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
+					  old_pte, new_pte));
+	/*
+	 * Handle the subpage protection bits
+	 */
+	subpg_pte = new_pte & ~subpg_prot;
+	/*
+	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
+	 * need to add in 0x1 if it's a read-only user page
+	 */
+	rflags = subpg_pte & _PAGE_USER;
+	if ((subpg_pte & _PAGE_USER) && !((subpg_pte & _PAGE_RW) &&
+					(subpg_pte & _PAGE_DIRTY)))
+		rflags |= 0x1;
+	/*
+	 * _PAGE_EXEC -> HW_NO_EXEC since it's inverted
+	 */
+	rflags |= ((subpg_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
+	/*
+	 * Always add C and Memory coherence bit
+	 */
+	rflags |= HPTE_R_C | HPTE_R_M;
+	/*
+	 * Add in WIMG bits
+	 */
+	rflags |= (subpg_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
+				_PAGE_COHERENT | _PAGE_GUARDED));
+
+	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
+	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
+
+		/*
+		 * No CPU has hugepages but lacks no execute, so we
+		 * don't need to worry about that case
+		 */
+		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
+	}
+
+	subpg_index = (ea & (PAGE_SIZE - 1)) >> shift;
+	vpn  = hpt_vpn(ea, vsid, ssize);
+	rpte = __real_pte(__pte(old_pte), ptep);
+	/*
+	 *None of the sub 4k page is hashed
+	 */
+	if (!(old_pte & _PAGE_HASHPTE))
+		goto htab_insert_hpte;
+	/*
+	 * Check if the pte was already inserted into the hash table
+	 * as a 64k HW page, and invalidate the 64k HPTE if so.
+	 */
+	if (!(old_pte & _PAGE_COMBO)) {
+		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
+		old_pte &= ~_PAGE_HPTE_SUB;
+		goto htab_insert_hpte;
+	}
+	/*
+	 * Check for sub page valid and update
+	 */
+	if (__rpte_sub_valid(rpte, subpg_index)) {
+		int ret;
+
+		hash = hpt_hash(vpn, shift, ssize);
+		hidx = __rpte_to_hidx(rpte, subpg_index);
+		if (hidx & _PTEIDX_SECONDARY)
+			hash = ~hash;
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		slot += hidx & _PTEIDX_GROUP_IX;
+
+		ret = ppc_md.hpte_updatepp(slot, rflags, vpn,
+					   MMU_PAGE_4K, MMU_PAGE_4K,
+					   ssize, flags);
+		/*
+		 *if we failed because typically the HPTE wasn't really here
+		 * we try an insertion.
+		 */
+		if (ret == -1)
+			goto htab_insert_hpte;
+
+		*ptep = __pte(new_pte & ~_PAGE_BUSY);
+		return 0;
+	}
+
+htab_insert_hpte:
+	/*
+	 * handle _PAGE_4K_PFN case
+	 */
+	if (old_pte & _PAGE_4K_PFN) {
+		/*
+		 * All the sub 4k page have the same
+		 * physical address.
+		 */
+		pa = pte_pfn(__pte(old_pte)) << HW_PAGE_SHIFT;
+	} else {
+		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
+		pa += (subpg_index << shift);
+	}
+	hash = hpt_hash(vpn, shift, ssize);
+repeat:
+	hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+
+	/* Insert into the hash table, primary slot */
+	slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
+				  MMU_PAGE_4K, MMU_PAGE_4K, ssize);
+	/*
+	 * Primary is full, try the secondary
+	 */
+	if (unlikely(slot == -1)) {
+		hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+		slot = ppc_md.hpte_insert(hpte_group, vpn, pa,
+					  rflags, HPTE_V_SECONDARY,
+					  MMU_PAGE_4K, MMU_PAGE_4K, ssize);
+		if (slot == -1) {
+			if (mftb() & 0x1)
+				hpte_group = ((hash & htab_hash_mask) *
+					      HPTES_PER_GROUP) & ~0x7UL;
+			ppc_md.hpte_remove(hpte_group);
+			/*
+			 * FIXME!! Should be try the group from which we removed ?
+			 */
+			goto repeat;
+		}
+	}
+	/*
+	 * Hypervisor failure. Restore old pmd and return -1
+	 * similar to __hash_page_*
+	 */
+	if (unlikely(slot == -2)) {
+		*ptep = __pte(old_pte);
+		hash_failure_debug(ea, access, vsid, trap, ssize,
+				   MMU_PAGE_4K, MMU_PAGE_4K, old_pte);
+		return -1;
+	}
+	/*
+	 * Insert slot number & secondary bit in PTE second half,
+	 * clear _PAGE_BUSY and set appropriate HPTE slot bit
+	 * Since we have _PAGE_BUSY set on ptep, we can be sure
+	 * nobody is undating hidx.
+	 */
+	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
+	/* __real_pte use pte_val() any idea why ? FIXME!! */
+	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
+	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
+	new_pte |= (_PAGE_HPTE_SUB0 >> subpg_index);
+	/*
+	 * check __real_pte for details on matching smp_rmb()
+	 */
+	smp_wmb();
+	*ptep = __pte(new_pte & ~_PAGE_BUSY);
+	return 0;
+}
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 3b49e3295901..6b4d4c1d0628 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -328,381 +328,8 @@ htab_pte_insert_failure:
 	li	r3,-1
 	b	htab_bail
 
-
 #else /* CONFIG_PPC_64K_PAGES */
 
-
-/*****************************************************************************
- *                                                                           *
- *           64K SW & 4K or 64K HW in a 4K segment pages implementation      *
- *                                                                           *
- *****************************************************************************/
-
-/* _hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
- *		 pte_t *ptep, unsigned long trap, unsigned local flags,
- *		 int ssize, int subpg_prot)
- */
-
-/*
- * For now, we do NOT implement Admixed pages
- */
-_GLOBAL(__hash_page_4K)
-	mflr	r0
-	std	r0,16(r1)
-	stdu	r1,-STACKFRAMESIZE(r1)
-	/* Save all params that we need after a function call */
-	std	r6,STK_PARAM(R6)(r1)
-	std	r8,STK_PARAM(R8)(r1)
-	std	r9,STK_PARAM(R9)(r1)
-
-	/* Save non-volatile registers.
-	 * r31 will hold "old PTE"
-	 * r30 is "new PTE"
-	 * r29 is vpn
-	 * r28 is a hash value
-	 * r27 is hashtab mask (maybe dynamic patched instead ?)
-	 * r26 is the hidx mask
-	 * r25 is the index in combo page
-	 */
-	std	r25,STK_REG(R25)(r1)
-	std	r26,STK_REG(R26)(r1)
-	std	r27,STK_REG(R27)(r1)
-	std	r28,STK_REG(R28)(r1)
-	std	r29,STK_REG(R29)(r1)
-	std	r30,STK_REG(R30)(r1)
-	std	r31,STK_REG(R31)(r1)
-
-	/* Step 1:
-	 *
-	 * Check permissions, atomically mark the linux PTE busy
-	 * and hashed.
-	 */
-1:
-	ldarx	r31,0,r6
-	/* Check access rights (access & ~(pte_val(*ptep))) */
-	andc.	r0,r4,r31
-	bne-	htab_wrong_access
-	/* Check if PTE is busy */
-	andi.	r0,r31,_PAGE_BUSY
-	/* If so, just bail out and refault if needed. Someone else
-	 * is changing this PTE anyway and might hash it.
-	 */
-	bne-	htab_bail_ok
-	/* Prepare new PTE value (turn access RW into DIRTY, then
-	 * add BUSY and ACCESSED)
-	 */
-	rlwinm	r30,r4,32-9+7,31-7,31-7	/* _PAGE_RW -> _PAGE_DIRTY */
-	or	r30,r30,r31
-	ori	r30,r30,_PAGE_BUSY | _PAGE_ACCESSED
-	oris	r30,r30,_PAGE_COMBO@h
-	/* Write the linux PTE atomically (setting busy) */
-	stdcx.	r30,0,r6
-	bne-	1b
-	isync
-
-	/* Step 2:
-	 *
-	 * Insert/Update the HPTE in the hash table. At this point,
-	 * r4 (access) is re-useable, we use it for the new HPTE flags
-	 */
-
-	/* Load the hidx index */
-	rldicl	r25,r3,64-12,60
-
-BEGIN_FTR_SECTION
-	cmpdi	r9,0			/* check segment size */
-	bne	3f
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	/* Calc vpn and put it in r29 */
-	sldi	r29,r5,SID_SHIFT - VPN_SHIFT
-	/*
-	 * clrldi r3,r3,64 - SID_SHIFT -->  ea & 0xfffffff
-	 * srdi	 r28,r3,VPN_SHIFT
-	 */
-	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT - VPN_SHIFT)
-	or	r29,r28,r29
-	/*
-	 * Calculate hash value for primary slot and store it in r28
-	 * r3 = va, r5 = vsid
-	 * r0 = (va >> 12) & ((1ul << (28 - 12)) -1)
-	 */
-	rldicl	r0,r3,64-12,48
-	xor	r28,r5,r0		/* hash */
-	b	4f
-
-3:	/* Calc vpn and put it in r29 */
-	sldi	r29,r5,SID_SHIFT_1T - VPN_SHIFT
-	/*
-	 * clrldi r3,r3,64 - SID_SHIFT_1T -->  ea & 0xffffffffff
-	 * srdi	r28,r3,VPN_SHIFT
-	 */
-	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT_1T - VPN_SHIFT)
-	or	r29,r28,r29
-
-	/*
-	 * Calculate hash value for primary slot and
-	 * store it in r28  for 1T segment
-	 * r3 = va, r5 = vsid
-	 */
-	sldi	r28,r5,25		/* vsid << 25 */
-	/* r0 = (va >> 12) & ((1ul << (40 - 12)) -1) */
-	rldicl	r0,r3,64-12,36
-	xor	r28,r28,r5		/* vsid ^ ( vsid << 25) */
-	xor	r28,r28,r0		/* hash */
-
-	/* Convert linux PTE bits into HW equivalents */
-4:
-#ifdef CONFIG_PPC_SUBPAGE_PROT
-	andc	r10,r30,r10
-	andi.	r3,r10,0x1fe		/* Get basic set of flags */
-	rlwinm	r0,r10,32-9+1,30,30	/* _PAGE_RW -> _PAGE_USER (r0) */
-#else
-	andi.	r3,r30,0x1fe		/* Get basic set of flags */
-	rlwinm	r0,r30,32-9+1,30,30	/* _PAGE_RW -> _PAGE_USER (r0) */
-#endif
-	xori	r3,r3,HPTE_R_N		/* _PAGE_EXEC -> NOEXEC */
-	rlwinm	r4,r30,32-7+1,30,30	/* _PAGE_DIRTY -> _PAGE_USER (r4) */
-	and	r0,r0,r4		/* _PAGE_RW & _PAGE_DIRTY ->r0 bit 30*/
-	andc	r0,r3,r0		/* r0 = pte & ~r0 */
-	rlwimi	r3,r0,32-1,31,31	/* Insert result into PP lsb */
-	/*
-	 * Always add "C" bit for perf. Memory coherence is always enabled
-	 */
-	ori	r3,r3,HPTE_R_C | HPTE_R_M
-
-	/* We eventually do the icache sync here (maybe inline that
-	 * code rather than call a C function...)
-	 */
-BEGIN_FTR_SECTION
-	mr	r4,r30
-	mr	r5,r7
-	bl	hash_page_do_lazy_icache
-END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
-
-	/* At this point, r3 contains new PP bits, save them in
-	 * place of "access" in the param area (sic)
-	 */
-	std	r3,STK_PARAM(R4)(r1)
-
-	/* Get htab_hash_mask */
-	ld	r4,htab_hash_mask@got(2)
-	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
-
-	/* Check if we may already be in the hashtable, in this case, we
-	 * go to out-of-line code to try to modify the HPTE. We look for
-	 * the bit at (1 >> (index + 32))
-	 */
-	rldicl.	r0,r31,64-12,48
-	li	r26,0			/* Default hidx */
-	beq	htab_insert_pte
-
-	/*
-	 * Check if the pte was already inserted into the hash table
-	 * as a 64k HW page, and invalidate the 64k HPTE if so.
-	 */
-	andis.	r0,r31,_PAGE_COMBO@h
-	beq	htab_inval_old_hpte
-
-	ld	r6,STK_PARAM(R6)(r1)
-	ori	r26,r6,PTE_PAGE_HIDX_OFFSET /* Load the hidx mask. */
-	ld	r26,0(r26)
-	addi	r5,r25,36		/* Check actual HPTE_SUB bit, this */
-	rldcr.	r0,r31,r5,0		/* must match pgtable.h definition */
-	bne	htab_modify_pte
-
-htab_insert_pte:
-	/* real page number in r5, PTE RPN value + index */
-	andis.	r0,r31,_PAGE_4K_PFN@h
-	srdi	r5,r31,PTE_RPN_SHIFT
-	bne-	htab_special_pfn
-	sldi	r5,r5,PAGE_FACTOR
-	add	r5,r5,r25
-htab_special_pfn:
-	sldi	r5,r5,HW_PAGE_SHIFT
-
-	/* Calculate primary group hash */
-	and	r0,r28,r27
-	rldicr	r3,r0,3,63-3		/* r0 = (hash & mask) << 3 */
-
-	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARAM(R4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve vpn */
-	li	r7,0			/* !bolted, !secondary */
-	li	r8,MMU_PAGE_4K		/* page size */
-	li	r9,MMU_PAGE_4K		/* actual page size */
-	ld	r10,STK_PARAM(R9)(r1)	/* segment size */
-.globl htab_call_hpte_insert1
-htab_call_hpte_insert1:
-	bl	.			/* patched by htab_finish_init() */
-	cmpdi	0,r3,0
-	bge	htab_pte_insert_ok	/* Insertion successful */
-	cmpdi	0,r3,-2			/* Critical failure */
-	beq-	htab_pte_insert_failure
-
-	/* Now try secondary slot */
-
-	/* real page number in r5, PTE RPN value + index */
-	andis.	r0,r31,_PAGE_4K_PFN@h
-	srdi	r5,r31,PTE_RPN_SHIFT
-	bne-	3f
-	sldi	r5,r5,PAGE_FACTOR
-	add	r5,r5,r25
-3:	sldi	r5,r5,HW_PAGE_SHIFT
-
-	/* Calculate secondary group hash */
-	andc	r0,r27,r28
-	rldicr	r3,r0,3,63-3		/* r0 = (~hash & mask) << 3 */
-
-	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARAM(R4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve vpn */
-	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
-	li	r8,MMU_PAGE_4K		/* page size */
-	li	r9,MMU_PAGE_4K		/* actual page size */
-	ld	r10,STK_PARAM(R9)(r1)	/* segment size */
-.globl htab_call_hpte_insert2
-htab_call_hpte_insert2:
-	bl	.			/* patched by htab_finish_init() */
-	cmpdi	0,r3,0
-	bge+	htab_pte_insert_ok	/* Insertion successful */
-	cmpdi	0,r3,-2			/* Critical failure */
-	beq-	htab_pte_insert_failure
-
-	/* Both are full, we need to evict something */
-	mftb	r0
-	/* Pick a random group based on TB */
-	andi.	r0,r0,1
-	mr	r5,r28
-	bne	2f
-	not	r5,r5
-2:	and	r0,r5,r27
-	rldicr	r3,r0,3,63-3		/* r0 = (hash & mask) << 3 */
-	/* Call ppc_md.hpte_remove */
-.globl htab_call_hpte_remove
-htab_call_hpte_remove:
-	bl	.			/* patched by htab_finish_init() */
-
-	/* Try all again */
-	b	htab_insert_pte
-
-	/*
-	 * Call out to C code to invalidate an 64k HW HPTE that is
-	 * useless now that the segment has been switched to 4k pages.
-	 */
-htab_inval_old_hpte:
-	mr	r3,r29			/* vpn */
-	mr	r4,r31			/* PTE.pte */
-	li	r5,0			/* PTE.hidx */
-	li	r6,MMU_PAGE_64K		/* psize */
-	ld	r7,STK_PARAM(R9)(r1)	/* ssize */
-	ld	r8,STK_PARAM(R8)(r1)	/* flags */
-	bl	flush_hash_page
-	/* Clear out _PAGE_HPTE_SUB bits in the new linux PTE */
-	lis	r0,_PAGE_HPTE_SUB@h
-	ori	r0,r0,_PAGE_HPTE_SUB@l
-	andc	r30,r30,r0
-	b	htab_insert_pte
-	
-htab_bail_ok:
-	li	r3,0
-	b	htab_bail
-
-htab_pte_insert_ok:
-	/* Insert slot number & secondary bit in PTE second half,
-	 * clear _PAGE_BUSY and set approriate HPTE slot bit
-	 */
-	ld	r6,STK_PARAM(R6)(r1)
-	li	r0,_PAGE_BUSY
-	andc	r30,r30,r0
-	/* HPTE SUB bit */
-	li	r0,1
-	subfic	r5,r25,27		/* Must match bit position in */
-	sld	r0,r0,r5		/* pgtable.h */
-	or	r30,r30,r0
-	/* hindx */
-	sldi	r5,r25,2
-	sld	r3,r3,r5
-	li	r4,0xf
-	sld	r4,r4,r5
-	andc	r26,r26,r4
-	or	r26,r26,r3
-	ori	r5,r6,PTE_PAGE_HIDX_OFFSET
-	std	r26,0(r5)
-	lwsync
-	std	r30,0(r6)
-	li	r3, 0
-htab_bail:
-	ld	r25,STK_REG(R25)(r1)
-	ld	r26,STK_REG(R26)(r1)
-	ld	r27,STK_REG(R27)(r1)
-	ld	r28,STK_REG(R28)(r1)
-	ld	r29,STK_REG(R29)(r1)
-	ld      r30,STK_REG(R30)(r1)
-	ld      r31,STK_REG(R31)(r1)
-	addi    r1,r1,STACKFRAMESIZE
-	ld      r0,16(r1)
-	mtlr    r0
-	blr
-
-htab_modify_pte:
-	/* Keep PP bits in r4 and slot idx from the PTE around in r3 */
-	mr	r4,r3
-	sldi	r5,r25,2
-	srd	r3,r26,r5
-
-	/* Secondary group ? if yes, get a inverted hash value */
-	mr	r5,r28
-	andi.	r0,r3,0x8 /* page secondary ? */
-	beq	1f
-	not	r5,r5
-1:	andi.	r3,r3,0x7 /* extract idx alone */
-
-	/* Calculate proper slot value for ppc_md.hpte_updatepp */
-	and	r0,r5,r27
-	rldicr	r0,r0,3,63-3	/* r0 = (hash & mask) << 3 */
-	add	r3,r0,r3	/* add slot idx */
-
-	/* Call ppc_md.hpte_updatepp */
-	mr	r5,r29			/* vpn */
-	li	r6,MMU_PAGE_4K		/* base page size */
-	li	r7,MMU_PAGE_4K		/* actual page size */
-	ld	r8,STK_PARAM(R9)(r1)	/* segment size */
-	ld	r9,STK_PARAM(R8)(r1)	/* get "flags" param */
-.globl htab_call_hpte_updatepp
-htab_call_hpte_updatepp:
-	bl	.			/* patched by htab_finish_init() */
-
-	/* if we failed because typically the HPTE wasn't really here
-	 * we try an insertion.
-	 */
-	cmpdi	0,r3,-1
-	beq-	htab_insert_pte
-
-	/* Clear the BUSY bit and Write out the PTE */
-	li	r0,_PAGE_BUSY
-	andc	r30,r30,r0
-	ld	r6,STK_PARAM(R6)(r1)
-	std	r30,0(r6)
-	li	r3,0
-	b	htab_bail
-
-htab_wrong_access:
-	/* Bail out clearing reservation */
-	stdcx.	r31,0,r6
-	li	r3,1
-	b	htab_bail
-
-htab_pte_insert_failure:
-	/* Bail out restoring old PTE */
-	ld	r6,STK_PARAM(R6)(r1)
-	std	r31,0(r6)
-	li	r3,-1
-	b	htab_bail
-
-#endif /* CONFIG_PPC_64K_PAGES */
-
-#ifdef CONFIG_PPC_64K_PAGES
-
 /*****************************************************************************
  *                                                                           *
  *           64K SW & 64K HW in a 64K segment pages implementation           *
@@ -994,10 +621,3 @@ ht64_pte_insert_failure:
 
 
 #endif /* CONFIG_PPC_64K_PAGES */
-
-
-/*****************************************************************************
- *                                                                           *
- *           Huge pages implementation is in hugetlbpage.c                   *
- *                                                                           *
- *****************************************************************************/
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7f9616f7c479..9fcad40c16e9 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -653,7 +653,7 @@ static void __init htab_finish_init(void)
 	patch_branch(ht64_call_hpte_updatepp,
 		ppc_function_entry(ppc_md.hpte_updatepp),
 		BRANCH_SET_LINK);
-#endif /* CONFIG_PPC_64K_PAGES */
+#else /* !CONFIG_PPC_64K_PAGES */
 
 	patch_branch(htab_call_hpte_insert1,
 		ppc_function_entry(ppc_md.hpte_insert),
@@ -667,6 +667,8 @@ static void __init htab_finish_init(void)
 	patch_branch(htab_call_hpte_updatepp,
 		ppc_function_entry(ppc_md.hpte_updatepp),
 		BRANCH_SET_LINK);
+#endif
+
 }
 
 static void __init htab_initialize(void)
-- 
2.5.0
