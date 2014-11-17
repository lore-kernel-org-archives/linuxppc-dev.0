Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D5361A025B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 19:26:34 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 13:56:29 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C83D1394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 13:56:22 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAH8QsAV11206814
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 13:56:55 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAH8QKbO011407
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 13:56:20 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/7] Replace _PAGE_NUMA with PAGE_NONE protections
In-Reply-To: <1415971986-16143-1-git-send-email-mgorman@suse.de>
References: <1415971986-16143-1-git-send-email-mgorman@suse.de>
Date: Mon, 17 Nov 2014 13:56:19 +0530
Message-ID: <877fyugrmc.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, Sasha Levin <sasha.levin@oracle.com>,
 Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mel Gorman <mgorman@suse.de> writes:

> This is follow up from the "pipe/page fault oddness" thread.
>
> Automatic NUMA balancing depends on being able to protect PTEs to trap a
> fault and gather reference locality information. Very broadly speaking it
> would mark PTEs as not present and use another bit to distinguish between
> NUMA hinting faults and other types of faults. It was universally loved
> by everybody and caused no problems whatsoever. That last sentence might
> be a lie.
>
> This series is very heavily based on patches from Linus and Aneesh to
> replace the existing PTE/PMD NUMA helper functions with normal change
> protections. I did alter and add parts of it but I consider them relatively
> minor contributions. Note that the signed-offs here need addressing. I
> couldn't use "From" or Signed-off-by from the original authors as the
> patches had to be broken up and they were never signed off. I expect the
> two people involved will just stick their signed-off-by on it.


How about the additional change listed below for ppc64 ? One part of the
patch is to make sure that we don't hit the WARN_ON in set_pte and set_pmd
because we find the _PAGE_PRESENT bit set in case of numa fault. I
ended up relaxing the check there.

Second part of the change is to add a WARN_ON to make sure we are
not depending on DSISR_PROTFAULT for anything else. We ideally should not
get a DSISR_PROTFAULT for PROT_NONE or NUMA fault. hash_page_mm do check
whether the access is allowed by pte before inserting a pte into hash
page table. Hence we will never find a PROT_NONE or PROT_NONE_NUMA ptes
in hash page table. But it is good to run with VM_WARN_ON ?

I also added a similar change to handle CAPI. 

This will also need an ack from Ben and Paul . (added them to Cc:) 

With the below patch you can add

Acked-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

for the respective patches.

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 5a236f082c78..2e208afb7f4c 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -64,10 +64,14 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
 		if (!(vma->vm_flags & VM_WRITE))
 			goto out_unlock;
 	} else {
-		if (dsisr & DSISR_PROTFAULT)
-			goto out_unlock;
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto out_unlock;
+		/*
+		 * protfault should only happen due to us
+		 * mapping a region readonly temporarily. PROT_NONE
+		 * is also covered by the VMA check above.
+		 */
+		VM_WARN_ON(dsisr & DSISR_PROTFAULT);
 	}
 
 	ret = 0;
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 50074972d555..6df9483e316f 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -396,17 +396,6 @@ good_area:
 #endif /* CONFIG_8xx */
 
 	if (is_exec) {
-#ifdef CONFIG_PPC_STD_MMU
-		/* Protection fault on exec go straight to failure on
-		 * Hash based MMUs as they either don't support per-page
-		 * execute permission, or if they do, it's handled already
-		 * at the hash level. This test would probably have to
-		 * be removed if we change the way this works to make hash
-		 * processors use the same I/D cache coherency mechanism
-		 * as embedded.
-		 */
-#endif /* CONFIG_PPC_STD_MMU */
-
 		/*
 		 * Allow execution from readable areas if the MMU does not
 		 * provide separate controls over reading and executing.
@@ -421,6 +410,14 @@ good_area:
 		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
 		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
 			goto bad_area;
+#ifdef CONFIG_PPC_STD_MMU
+		/*
+		 * protfault should only happen due to us
+		 * mapping a region readonly temporarily. PROT_NONE
+		 * is also covered by the VMA check above.
+		 */
+		VM_WARN_ON(error_code & DSISR_PROTFAULT);
+#endif /* CONFIG_PPC_STD_MMU */
 	/* a write */
 	} else if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -430,6 +427,7 @@ good_area:
 	} else {
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
+		VM_WARN_ON(error_code & DSISR_PROTFAULT);
 	}
 
 	/*
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index c90e602677c9..75b08098fcf5 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -172,9 +172,13 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		pte_t pte)
 {
-#ifdef CONFIG_DEBUG_VM
-	WARN_ON(pte_val(*ptep) & _PAGE_PRESENT);
-#endif
+	/*
+	 * When handling numa faults, we already have the pte marked
+	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
+	 * Hence we can use set_pte_at for them.
+	 */
+	VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
+		   (_PAGE_PRESENT | _PAGE_USER));
 	/* Note: mm->context.id might not yet have been assigned as
 	 * this context might not have been activated yet when this
 	 * is called.
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c8d709ab489d..c721c5efb4df 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -710,7 +710,8 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(pmd_val(*pmdp) & _PAGE_PRESENT);
+	WARN_ON((pmd_val(*pmdp) & (_PAGE_PRESENT | _PAGE_USER)) ==
+		(_PAGE_PRESENT | _PAGE_USER));
 	assert_spin_locked(&mm->page_table_lock);
 	WARN_ON(!pmd_trans_huge(pmd));
 #endif
