Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id E58BC67A64
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Feb 2005 02:37:23 +1100 (EST)
Message-ID: <41FFA21C.8060203@nortelnetworks.com>
Date: Tue, 01 Feb 2005 09:37:00 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
References: <41FECA18.50609@nortelnetworks.com>
	<1107243398.4208.47.camel@laptopd505.fenrus.org>
In-Reply-To: <1107243398.4208.47.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on symbol exports
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arjan van de Ven wrote:
> On Mon, 2005-01-31 at 18:15 -0600, Chris Friesen wrote:

>>Is there any particular reason why modules should not be allowed to 
>>flush the tlb, or is this an oversight?
> 
> can you point at the url to your module source? I suspect modules doing
> tlb flushes is the wrong thing, but without seeing the source it's hard
> to tell.

I've included the relevent code at the bottom.  The module will be 
released under the GPL.

I've got a module that I'm porting forward from 2.4.  The basic idea is 
that we want to be able to track pages dirtied by an application.  The 
system has no swap, so we use the dirty bit to get this information.  On 
demand we walk the page tables belonging to the process, store the 
addresses of any dirty ones, flush the tlb, and mark them clean.

I (obviously) don't have a good understanding of how the tlb interacts 
with the software page tables.  If we don't need to flush the tlb I'd 
love to hear it.  If there's an easier way than walking the tables 
manually please let me know.

If it matters, some of the dirty pages may be code (it's used by an 
emulator for a system that can handle on-the-fly binary patching).

Thanks,

Chris







Note: this code is run while holding &mm->mmap_sem and &mm->page_table_lock.

	/* scan through the entire address space given */
	dirty_count = 0;
	for(addr=start&PAGE_MASK; addr<=end; addr+=PAGE_SIZE) {
		pgd_t *pgd;
		pmd_t *pmd;
		pte_t *ptep, pte;
		
		/* Page table walking code stolen from follow_page() except
		 * that this version does not support huge tlbs.
		 */
		pgd = pgd_offset(mm, addr);
		if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
			continue;

		pmd = pmd_offset(pgd, addr);
		if (pmd_none(*pmd))
			continue;
		if (unlikely(pmd_bad(*pmd)))
			continue;

		ptep = pte_offset_map(pmd, addr);
		if (!ptep)
			continue;

		pte = *ptep;
		pte_unmap(ptep);
		if (!pte_present(pte))
			continue;

		if (!pte_dirty(pte))
			continue;

		if (!pte_read(pte))
			continue;

		/* We have a user readable dirty page.  Count it.*/
		dirty_count++;

		if (dirty_count > entries) {
			continue;
		} else {
			__put_user(addr, buf);
			buf++;
		}

		flush_tlb_page(find_vma(mm,addr), addr);
		pte = pte_mkclean(pte);
	}
