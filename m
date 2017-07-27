Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJ8RK46YXzDrH5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 21:10:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, joserz@linux.vnet.ibm.com,
 Paul Mackerras <paulus@ozlabs.org>
Cc: oohall@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: KVM guests freeze under upstream kernel
In-Reply-To: <1501138604.14223.1.camel@gmail.com>
References: <20170719194634.GA1222@pacoca>
 <1500507770.3350.41.camel@kernel.crashing.org>
 <20170720030222.GA21034@pacoca> <20170720052159.GB8602@fergus.ozlabs.ibm.com>
 <20170721011818.GC13187@pacoca> <20170726131848.GA13783@pacoca>
 <87d18mfu56.fsf@concordia.ellerman.id.au>
 <1501138604.14223.1.camel@gmail.com>
Date: Thu, 27 Jul 2017 21:10:51 +1000
Message-ID: <877eyuf83o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
>
...
> kernel BUG at /scratch/surajjs/linux/arch/powerpc/include/asm/book3s/64/radix.h:260!

Next thing to try would be something like below.

cheers

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d1da415e283c..c749a757738e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1016,6 +1016,7 @@ static inline unsigned long
 pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
 		    unsigned long clr, unsigned long set)
 {
+	BUG_ON(set & PAGE_DEVMAP);
 	if (radix_enabled())
 		return radix__pmd_hugepage_update(mm, addr, pmdp, clr, set);
 	return hash__pmd_hugepage_update(mm, addr, pmdp, clr, set);
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 31eed8fa8e99..55c443a3dd5b 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -31,6 +31,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 			  pmd_t *pmdp, pmd_t entry, int dirty)
 {
 	int changed;
+	BUG_ON(pmd & PAGE_DEVMAP);
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
 	assert_spin_locked(&vma->vm_mm->page_table_lock);
@@ -56,6 +57,7 @@ int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
+	BUG_ON(pmd & PAGE_DEVMAP);
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
 	assert_spin_locked(&mm->page_table_lock);
