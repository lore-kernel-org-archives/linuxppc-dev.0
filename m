Date: Wed, 15 Mar 2000 22:06:59 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
In-Reply-To: <20000315123150.025617@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10003151244460.3396-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 15 Mar 2000, Benjamin Herrenschmidt wrote:

> Well, we need a fix _now_ (that I will backport to 2.2.x as soon as
> possible too), at least for PowerMacs. The problem of ISA drivers with
> legacy hard-coded addresses is indeed a real one, but it can be
> temporarily worked around by having the kernel maintaing a separate
> mapping of the "old" IO base to the legacy ISA bus if one exist.

- Mapping address 0 does not help in catching null pointer accesses and
has the slight defect of overlapping  user space :-),

-  conditionally adding _IO_BASE if address is too low will bloat code

- systematically oring with _IO_BASE instead of adding it might prove
reasonable (oring with 0 has little side effects for PMacs, and on all
other boards I know it should work properly given that the alignement
of I/O space is larger than its size), although it does not solve the code
bloat issue.

But you have to consider that, AFAIK, on all architectures, the I/O space
is accessed using the start field in the resource struct. So these have to
be kernel virtual addresses, which are hard to distinguish from physical
addresses with 1:1 mappings as we have now. But that's exactly this
confusion of physical addresses with kernel virtual addresses which
prohibits increasing user space to 3Gb since on PreP I/O is mapped at 2
Gb...

MMIO is not a problem since what is in the resource field is first
translated by ioremap() so that you can put physical addresses. But for
I/O space some form of cookie is used which can be used as a parameter
for in and out instructions and is wildly varying depending on
architectures:

- on PPC, add _IO_BASE and use the result as kernel _virtual_ address.

- on SPARC64, I don't know what the address space identifiers exactly are,
but it seems to use only physical addresses. SPARC32 on the other hand
uses kernel virtual addresses but they don't have any ISA legacy it seems.

- on ALPHA, seems a mess (just spotted in core_tsunami.h):
        /* ??? I wish I could get rid of this.  But there's no ioremap
           equivalent for I/O space.  PCI I/O can be forced into the
           correct hose's I/O region, but that doesn't take care of
           legacy ISA crap.  */
        addr += TSUNAMI_IO_BIAS;
        return __kernel_ldbu(*(vucp)addr);

and it's much worse with generic kernels or older machines which did not
support byte and 16 bit transfers. Ok, they acknowledge that something has
to be done for legacy I/O, perhaps functions prefixed with isa_ IIRC what
Richard Henderson said at some point.

- on ix86: fairly straightforward for obvious reasons, after all it's the
machine that we inherit the marvellously broken concept of separate spaces
from, and it's inherited from the 8008...

- on IA64, extremely baroque, using 4kB of virtual address space for every
4 bytes of I/O space and still limited to 64kB. Some things never
change...

I can't think of any simple solution right now, using physical addresses
does not seem to be an option because it forces 1:1 mappings and it's
definitely not what we want. How does cat /proc/ioports (which now
actually lists the contents of pci devices resource fields) look like on
architectures other than x86 and PPC with a recent 2.3 ?

> We have, I think, no legacy code using /proc/bus/pci, do we ? If I'm
> right, then we can chance it to return physical addresses without
> breaking anyone so at least we have a temporary fix for XFree. We must
> get the kernel<->userland interface right asap so that we don't need to
> change XFree again and again.

I suspect you mean /proc/bus/pci/devices not /proc/bus/pci/xx/xx.x which
directly access configuration space and can't be fixed up.

I agree to put physical addresses for MMIO (actually I do it by fixing up
addresses in resource srtuctures when the bridge is in PreP mode), but it
requires more thought for I/O space, we want a definitive solution not one
which will break in another 6 months.

BTW: is it possible to add specific ioctls to /proc code, this might be a
solution, ugly but given the current state it might be the only solution.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
