Message-ID: <3B72E40D.3080600@chinook.com>
Date: Thu, 09 Aug 2001 15:27:09 -0400
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: Daris A Nevil <dnevil@snmc.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Non-cacheable memory
References: <Pine.LNX.4.33.0108091838380.11077-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Justin (Gus) Hurwitz wrote:

> On Tue, 7 Aug 2001, Daris A Nevil wrote:
>>
>>Here is the procedure I used to allocate pages and mark them as non-cached in
>>the 2.2.5 kernel (SNMC's QSLinux):
>>
>>    mem_addr = __get_free_page(GFP_KERNEL);
>>    pte = va_to_pe(&init_task, mem_addr);
>>    pte_val(*pte) |= _PAGE_NO_CACHE;
>>    flush_tlb_page(current->mm_mmap, mem_addr);
>>
>>I used these pages for SCC buffer descriptors, so they were never returned to
>>the system. I'm not sure if this is the preferred way, but it certainly works.
>>I have not tried this in the 2.4 kernel yet.  The functions __get_free_page()
>>and flush_tlb_page() do exist in 2.4.4, but I could not locate va_to_pe()  (I
>>think that was a macro in 2.2.5).


In 2.4 you can use consistent_alloc() - this allocates memory and makes
it non-cachable.  (well, it makes it consistent w.r.t. PCI DMA, but for
860s it's the same thing.)  It returns a virtual address plus a DMA
address in an arg ptr - throw away the DMA address, as that's
PCI-specific, and run the virtual address through virt_to_phys().

--
.....................................................................
  Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
  Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
  100 Hayden Ave, Lexington MA 02421


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
