Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B78BB1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 04:59:02 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Oct 2014 03:59:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E14142BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 04:58:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9RHwo9425886848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 04:58:50 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9RHwqta012392
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 04:58:53 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrea Arcangeli <aarcange@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V2 1/2] mm: Update generic gup implementation to handle
 hugepage directory
In-Reply-To: <20141027001842.GU6911@redhat.com>
References: <1413520687-31729-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
 <20141023.184035.388557314666522484.davem@davemloft.net>
 <1414107635.364.91.camel@pasglop> <1414167761.19984.17.camel@jarvis.lan>
 <1414356641.364.142.camel@pasglop> <20141027001842.GU6911@redhat.com>
Date: Mon, 27 Oct 2014 23:28:41 +0530
Message-ID: <87fve9xulq.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-arch@vger.kernel.org, steve.capper@linaro.org,
 linux-kernel@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrea Arcangeli <aarcange@redhat.com> writes:

> Hello,
>
> On Mon, Oct 27, 2014 at 07:50:41AM +1100, Benjamin Herrenschmidt wrote:
>> On Fri, 2014-10-24 at 09:22 -0700, James Bottomley wrote:
>> 
>> > Parisc does this.  As soon as one CPU issues a TLB purge, it's broadcast
>> > to all the CPUs on the inter-CPU bus.  The next instruction isn't
>> > executed until they respond.
>> > 
>> > But this is only for our CPU TLB.  There's no other external
>> > consequence, so removal from the page tables isn't effected by this TLB
>> > flush, therefore the theory on which Dave bases the change to
>> > atomic_add() should work for us (of course, atomic_add is lock add
>> > unlock on our CPU, so it's not going to be of much benefit).
>> 
>> I'm not sure I follow you here.
>> 
>> Do you or do you now perform an IPI to do TLB flushes ? If you don't
>> (for example because you have HW broadcast), then you need the
>> speculative get_page(). If you do (and can read a PTE atomically), you
>> can get away with atomic_add().
>> 
>> The reason is that if you remember how zap_pte_range works, we perform
>> the flush before we get rid of the page.
>> 
>> So if your using IPIs for the flush, the fact that gup_fast has
>> interrupts disabled will delay the IPI response and thus effectively
>> prevent the pages from being actually freed, allowing us to simply do
>> the atomic_add() on x86.
>> 
>> But if we don't use IPIs because we have HW broadcast of TLB
>> invalidations, then we don't have that synchronization. atomic_add won't
>> work, we need get_page_speculative() because the page could be
>> concurrently being freed.
>
> I looked at how this works more closely and I agree
> get_page_unless_zero is always necessary if the TLB flush doesn't
> always wait for IPIs to all CPUs where a gup_fast may be running onto.
>
> To summarize, the pagetables are freed with RCU (arch sets
> HAVE_RCU_TABLE_FREE) and that allows to walk them lockless with RCU.
>
> After we can walk the pagetables lockless with RCU, we get to the page
> lockless, but the pages themself can still be freed at any time from
> under us (hence the need for get_page_unless_zero).
>
> The additional trick gup_fast RCU does is to recheck the pte after
> elevating the page count with get_page_unless_zero. Rechecking the
> pte/hugepmd to be sure it didn't change from under us is critical to
> be sure get_page_unless_zero didn't run after the page was freed and
> reallocated which would otherwise lead to a security problem too
> (i.e. it protects against get_page_unless_zero false positives).
>
> The last bit required is to still disable irqs like on x86 to
> serialize against THP splits combined with pmdp_splitting_flush always
> delivering IPIs (pmdp_splitting_flush must wait all gup_fast to
> complete before proceeding in mangling the page struct of the compound
> page).
>
> Preventing the irq disable while taking a gup_fast pin using
> compound_lock isn't as "easy" as it is to do for put_page. put_page
> (non-compound) fastest path remains THP agnostic because
> collapse_huge_page is inhibited by any existing gup pin, but here
> we're exactly taking it, so we can't depend on it to already exist to
> avoid the race with collapse_huge_page. It's not just split_huge_page
> we need to protect against.
>
> So while thinking the above summary, I noticed this patch misses a IPI
> in mm/huge_memory.c that must be delivered after pmdp_clear_flush
> below to be safe against collapse_huge_page for the same reasons it
> sends it within pmdp_splitting_flush. Without this IPI what can happen
> is that the GUP pin protection in __collapse_huge_page_isolate races
> against gup_fast-RCU.
>
> If gup_fast reads the pte on one CPU before pmdp_clear_flush, and on
> the other CPU __collapse_huge_page_isolate succeeds, then gup_fast
> could recheck the pte that hasn't been zapped yet by
> __collapse_huge_page_copy. gup_fast would succeed because the pte
> wasn't zapped yet, but then __collapse_huge_page_copy would run
> replacing the pte with a transhuge pmd, making gup_fast return the old
> page, while the process got the copy as part of the collapsed hugepage.
>
> 	/*
> 	 * After this gup_fast can't run anymore. This also removes
> 	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ -> invariant broken by gup_fast-RCU
> 	 * any huge TLB entry from the CPU so we won't allow
> 	 * huge and small TLB entries for the same virtual address
> 	 * to avoid the risk of CPU bugs in that area.
> 	 */
> 	_pmd = pmdp_clear_flush(vma, address, pmd);
> 	spin_unlock(pmd_ptl);
> 	mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
>
> 	spin_lock(pte_ptl);
> 	isolated = __collapse_huge_page_isolate(vma, address, pte);
> 	spin_unlock(pte_ptl);


That is the transition from pmd pointing to a PTE page to a hugepage
right ? On ppc64 we do the below. Though not for the same reason
mentioned above (we did that to handle the hash insertion case) that
should take care of the gup case too right ?


pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
		       pmd_t *pmdp)
{
	pmd_t pmd;

	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
	if (pmd_trans_huge(*pmdp)) {
		pmd = pmdp_get_and_clear(vma->vm_mm, address, pmdp);
	} else {
		/*
		 * khugepaged calls this for normal pmd
		 */
		pmd = *pmdp;
		pmd_clear(pmdp);
		/*
		 * Wait for all pending hash_page to finish. This is needed
		 * in case of subpage collapse. When we collapse normal pages
		 * to hugepage, we first clear the pmd, then invalidate all
		 * the PTE entries. The assumption here is that any low level
		 * page fault will see a none pmd and take the slow path that
		 * will wait on mmap_sem. But we could very well be in a
		 * hash_page with local ptep pointer value. Such a hash page
		 * can result in adding new HPTE entries for normal subpages.
		 * That means we could be modifying the page content as we
		 * copy them to a huge page. So wait for parallel hash_page
		 * to finish before invalidating HPTE entries. We can do this
		 * by sending an IPI to all the cpus and executing a dummy
		 * function there.
		 */
		kick_all_cpus_sync();
                ...
                .....           
                }

>
> CPU0					CPU1
> ---------				-------------
> gup_fast-RCU
> local_irq_disable()
> pte = pte_offset_map(pmd, address)
>
> 					pmdp_clear_flush (not sending IPI -> bug)
>
> 					__collapse_huge_page_isolate -> succeeds
>
> 					(page_count != 1 gup-pin check of
> 					__collapse_huge_page_isolate
> 					didn't fire)
>
> page = vm_normal_page(pte)
> get_page_unless_zero() -> succeeds
> recheck pte -> succeeds
> local_irq_enable()
> return page
>
> 					collapse_huge_page thought
> 					no gup_fast could run after
> 					pmdp_clear_flush returned
>
> 					__collapse_huge_page_copy (zap
> 					pte too late, gup_fast already
> 					returned on the other CPU)
>
> 					set_pmd_at(mm, address, pmd, _pmd);
>
> 					virtual memory backed by THP
>
> gup_fast went out of sync with virtual memory
>
> It could be solved also without IPI, for example by adding a failure
> path to __collapse_huge_page_copy and by adding a second gup-pin check
> (page_count != 1) after pte_clear(vma->vm_mm, address, _pte) (with a
> smp_mb() in between) and returning a failure if the check
> triggers. However then we need to store the 512 pte pointers in a
> temporary page to roll all of them back if we raced.
>
> Comments what is preferable between IPI and a gup-pin check after
> zapping the pte in __collapse_huge_page_copy welcome. If a
> modification to __collapse_huge_page_copy is preferable the temporary
> pte allocation (for rollback in the gup-pin check trigger case) should
> still be skipped on x86.

We already do an IPI for ppc64.

-aneesh
