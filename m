Message-ID: <3D810824.9020004@mvista.com>
Date: Thu, 12 Sep 2002 14:33:24 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consistent_free re-revisited
References: <3D7FB97B.9060301@mvista.com> <20020912032640.GA32156@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Gibson wrote:

>>Furthermore, consistent_alloc does not fill out vm_struct fields for the
>>VM area that map it to the struct pages, so consistent_free can't use
>>those to derive the physical pages.  And neither can vfree(), which is
>>what consistent_free() calls to do its work.  And so consistent_free()
>>does not free the physical pages allocated by consistent_alloc()...
>
> Erm... vfree() walks the page tables to find the pages to free, which
> should work fine.

Been curious about this... vfree() walks the page tables to find PTE
entries to unmap (modifying the PTE entry).  But its code to call
__free_page() on the physical pages for the area (the deallocate_pages
condition in __vunmap()) is not being executed (because area->nr_pages
== 0), and it seems likely this is needed.

After modifying consistent_alloc() to fill out the area->pages array and
set area->nr_pages, __vunmap() will then call __free_page() on those
pages.  Whereupon:

   vaddr = consistent_alloc(gfp, size, &physaddr);
   consistent_free(vaddr);
   vaddr = consistent_alloc(gfp, size, &physaddr);

then allocates the same physaddr both times, which is not currently the
case.  There is also an overall difference in memory usage in the
neighborhood of the allocated buffer size between the 2 schemes (per
free(1) at a shell prompt), but I wouldn't swear to it...


--
Todd


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
