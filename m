Date: Fri, 14 Feb 2003 11:32:44 -0600 (CST)
From: vinai <vroopcha@mcw.edu>
To: Matt Porter <porter@cox.net>
Cc: "LinuxPPC Developers' List" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: vmalloc limits in PPC kernels ?
Message-ID: <Pine.LNX.4.44.0302141128590.273-100000@kaiso.biophysics.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt,

Thanks much for the information you provided below.  Are there any
pointers/references as to why these changes were actually implemented,
or is it really a case of "the source being the guide" ?  As I said,
this issue is really troubling for us, and I want to see if there is
a "clean" way to circumvent that limit without screwing up the MM
subsystem (at least not too badly :) ...

cheers
vinai

On Thu, 13 Feb 2003, Matt Porter wrote:

> All architectures have a limit.  Its size is defined by
> VMALLOC_END-VMALLOC_START and further limited by the size of each
> preceding allocation (+ a PAGE_SIZE pad) before the allocation in
> question.  Allocations also include ioremaps and on some architectures
> consistent memory allocations absorb vmalloc space.
>
> You can see the constraints in asm-ppc/pgtable.h.  On PPC, it is possible
> to change the default parameters in order to expand the amount of vmalloc
> space available.  This is accomplished via config options under the
> advanced kernel options menu.  With PAGE_OFFSET at 0x40000000 and highmem,
> I've run a system with nearly 3GB of vmalloc space.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
