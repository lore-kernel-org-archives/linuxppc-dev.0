Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6E80267A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 12:04:01 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fd5eb84defe2c51141e872390eefc9a1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 3 Mar 2005 19:03:51 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: ppcembed Linux list <linuxppc-embedded@ozlabs.org>
Subject: Allowing i-side updates of TLB on 4xx/book-e
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Paul,

I know its been forever since you looked at ppc32 and even longer for 
4xx/booke :)  I did have a question regarding some code on the i-side 
TLB faults in do_page_fault:

                 /* Since 4xx/Book-E supports per-page execute 
permission,
                  * we lazily flush dcache to icache. */
                 ptep = NULL;
                 if (get_pteptr(mm, address, &ptep) && 
pte_present(*ptep)) {
                         struct page *page = pte_page(*ptep);

                         if (! test_bit(PG_arch_1, &page->flags)) {
                                 flush_dcache_icache_page(page);
                                 set_bit(PG_arch_1, &page->flags);
                         }
                         pte_update(ptep, 0, _PAGE_HWEXEC);
                         _tlbie(address);
                         pte_unmap(ptep);
                         up_read(&mm->mmap_sem);
                         return 0;
                 }

Is there a reason we don't allow preloading of the I-side TLB entry 
that we just updated, rather than doing the _tlbie?  We have to figure 
that we are about to take another I-TLB miss to reload the entry we 
just got this InstructionStorage fault for.  Is there something I'm 
missing?

thanks

- kumar
