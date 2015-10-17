Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9A091A023F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 21:09:02 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 17 Oct 2015 15:39:00 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1C6E73940066
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:57 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9HA8vZM655774
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:57 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9HA8uXE017411
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:56 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 26/31] powerpc/mm: Remove the dependency on pte bit
 position in asm code
Date: Sat, 17 Oct 2015 15:38:37 +0530
Message-Id: <1445076522-20527-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should not expect pte bit position in asm code. Simply
by moving part of that to C

Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 16 +++-------------
 arch/powerpc/mm/hash_utils_64.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0a0399c2af11..34920f11dbdd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1556,28 +1556,18 @@ do_hash_page:
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
 	bne	77f			/* then don't call hash_page now */
-	/*
-	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
-	 * accessing a userspace segment (even from the kernel). We assume
-	 * kernel addresses always have the high bit set.
-	 */
-	rlwinm	r4,r4,32-25+9,31-9,31-9	/* DSISR_STORE -> _PAGE_RW */
-	rotldi	r0,r3,15		/* Move high bit into MSR_PR posn */
-	orc	r0,r12,r0		/* MSR_PR | ~high_bit */
-	rlwimi	r4,r0,32-13,30,30	/* becomes _PAGE_USER access bit */
-	ori	r4,r4,1			/* add _PAGE_PRESENT */
-	rlwimi	r4,r5,22+2,31-2,31-2	/* Set _PAGE_EXEC if trap is 0x400 */
 
 	/*
 	 * r3 contains the faulting address
-	 * r4 contains the required access permissions
+	 * r4 msr
 	 * r5 contains the trap number
 	 * r6 contains dsisr
 	 *
 	 * at return r3 = 0 for success, 1 for page fault, negative for error
 	 */
+        mr 	r4,r12
 	ld      r6,_DSISR(r1)
-	bl	hash_page		/* build HPTE if possible */
+	bl	__hash_page		/* build HPTE if possible */
 	cmpdi	r3,0			/* see if hash_page succeeded */
 
 	/* Success */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index db35e7d83088..04d549527eaa 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1162,6 +1162,35 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
 }
 EXPORT_SYMBOL_GPL(hash_page);
 
+int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
+		unsigned long dsisr)
+{
+	unsigned long access = _PAGE_PRESENT;
+	unsigned long flags = 0;
+	struct mm_struct *mm = current->mm;
+
+	if (REGION_ID(ea) == VMALLOC_REGION_ID)
+		mm = &init_mm;
+
+	if (dsisr & DSISR_NOHPTE)
+		flags |= HPTE_NOHPTE_UPDATE;
+
+	if (dsisr & DSISR_ISSTORE)
+		access |= _PAGE_RW;
+	/*
+	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
+	 * accessing a userspace segment (even from the kernel). We assume
+	 * kernel addresses always have the high bit set.
+	 */
+	if ((msr & MSR_PR) || (REGION_ID(ea) == USER_REGION_ID))
+		access |= _PAGE_USER;
+
+	if (trap == 0x400)
+		access |= _PAGE_EXEC;
+
+	return hash_page_mm(mm, ea, access, trap, flags);
+}
+
 void hash_preload(struct mm_struct *mm, unsigned long ea,
 		  unsigned long access, unsigned long trap)
 {
-- 
2.5.0
