Return-Path: <cfriesen@nortel.com>
Message-ID: <42077EE0.2060505@nortel.com>
Date: Mon, 07 Feb 2005 08:44:48 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <41FECA18.50609@nortelnetworks.com>	
	<1107243398.4208.47.camel@laptopd505.fenrus.org>	
	<41FFA21C.8060203@nortelnetworks.com>	
	<1107273017.4208.132.camel@laptopd505.fenrus.org>	
	<20050204203050.GA5889@dmt.cnet> <4203D793.1040604@nortel.com>
	<1107595148.30302.5.camel@gaston>
In-Reply-To: <1107595148.30302.5.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: question on symbol exports
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>It turns out that to call ptep_clear_flush_dirty() on ppc64 from a 
>>module I needed to export the following symbols:
>>
>>__flush_tlb_pending
>>ppc64_tlb_batch
>>hpte_update
> 
> 
> Any reason why you need to call that from a module ? Is the module
> GPL'd ?

I explained this at the beginning of the thread, but I'll do so again. 
The module will be released under the GPL.

The basic idea is that we want to be able to track pages dirtied by a 
userspace process.  The system has no swap, so we use the dirty bit for 
this.  On demand we look up the page tables for an address range 
specified by the caller, store the addresses of any dirty pages, then 
mark them clean so that the next write causes them to get marked dirty 
again.  It is this act of marking them clean that requires the 
additional exports.

I've included the current code below.  If there is any way to accomplish 
this without the additional exports, I'd love to hear about it.

Chris








Note: this code is run while holding &mm->mmap_sem and &mm->page_table_lock.


for(addr=start&PAGE_MASK; addr<=end; addr+=PAGE_SIZE) {
	pte_t *ptep=0;

	ptep = va_to_ptep_map(mm, addr);
	if (!ptep)
		goto unmap_continue;

	if (!pte_dirty(*ptep))
		goto unmap_continue;

	/* We have a user readable dirty page.  Count it.*/
	dirty_count++;

	if (dirty_count <= entries) {
		__put_user(addr, buf);
		buf++;
		ptep_clear_flush_dirty(find_vma(mm, addr), addr, ptep);

		/* Handle option to stop early. */
		if ((dirty_count == entries) &&
			(options & STOP_WHEN_BUF_FULL))
			addr=end+1;
	}

unmap_continue:
	if (ptep)
		pte_unmap(ptep);		
}
