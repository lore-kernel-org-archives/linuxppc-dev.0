From: Michel Lanners <mlan@mcp.cpu.lu>
Message-Id: <200001281552.QAA02394@mcp.cpu.lu>
Subject: Re: PREP memory layout and PCI transactions
To: lizzi@csti.fr
Date: Fri, 28 Jan 2000 16:52:20 MET
Cc: linuxppc-dev@lists.linuxppc.org
Reply-To: mlan@cpu.lu
In-Reply-To: <200001280947.KAA09960@devl58>; from "Christophe Lizzi" at Jan 28, 100 10:47 am
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello there,

> The driver requests the device to fill some memory locations in kernel
> space via DMA. This works just fine when such memory locations come
> from pages allocated by get_free_page() or kmalloc().
>
> However, this fails when these locations come from the *static* data
> of the module, or from pages allocated by vmalloc().

This is expected behaviour, since the way the MM code allocates memory is
different between kmalloc()'ed and vmalloc()'ed memory.

kmalloc() returns a memory object consiting of a number of consecutive pages
of RAM, adressed through the existing memory translation from (all RAM) to
(kernel virtual memory). The full physical RAM is mapped starting at 0xc0000000,
and kmalloc will return an address within that range.

However, vmalloc() returns a memory object consisting of pages that are only
consecutive in kernel virtual address space, but which is composed of individual
pages retreived through get_free_pages(). Therefore, these pages are not
necessarily consecutive in physical RAM, and the full object is mapped by
a new translation to virtual addresses _above_ physical RAM. As a result,
the simple offset calculation between kernel virtual address and physical
address doesn't work here.

> Specifically, the pages returned by get_free_page() or kmalloc() are located
> around kernel virtual addresses C1xxxxxx (bus addresses 81xxxxxx), while the
> static data in question and the pages returned by vmalloc() are located
> behind virtual addresses C4xxxxxx (bus addresses 84xxxxxx).

But bus address 0x84xxxxxx doesn't correspond to any existing RAM.

For DMA, you need to use kmalloc(), or assemble your buffer the dirty way
through successive calls to get_free_pages() and other wizardry.

Michel

____________________________________________________________________
.sig home alone

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
