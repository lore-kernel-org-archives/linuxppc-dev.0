Message-Id: <200209171824.g8HIOaS17677@flyingfox.snowshore.com>
From: Waqar Ahmad <wahmad@snowshore.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: problem with pci_alloc_consistent (it does work)
Date: Tue, 17 Sep 2002 14:24:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Found the problem I was using phys_to_virt(..) to convert the physical address to virtual. Once I fixed that everything seems to be working now. so



Waqar

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of wahmad
> Sent: Monday, September 16, 2002 6:38 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: problem with pci_alloc_consistent
>
>
>
> I am using pci_alloc_consistent() for obtaining contiguous
> memory that is
> cache safe. Here is how I am calling the routine
>
> pci_alloc_consistent(NULL,size,&dummy).
> Note I am throwing away the bus address.
>
> The memory that I get does not seem to be cache safe. My
> device doesn't see
> the data  untill I add flush_dcache_range(..). It is very
> undesirable for me
> to add flushes and invalidates. I will appreciate any help in
> this matter.
>
> I am using kernel version 2.4.20-pre5 for IBM PPC405GP and
> using version
> 2.95.3 for gcc on an x86 as a cross compiler.
>
> I also have CONFIG_NOT_COHERENT_CACHE defined.
>
> Thanks
>
> Waqar
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
