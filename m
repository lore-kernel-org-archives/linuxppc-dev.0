Subject: Re: Proposed changes to io.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Whitney <johnw@sands-edge.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain
Message-Id: <1080787943.1434.47.camel@gaston>
Mime-Version: 1.0
Date: Thu, 01 Apr 2004 12:52:23 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-04-01 at 01:44, John Whitney wrote:
> I've made few changes to include/asm-ppc/io.h that might want to be
> incorporated into the mainline tree.  These changes include:
>
> 1. Modifications to virt_to_bus, bus_to_virt, virt_to_phys, and
> phys_to_virt.  With the use of fully virtual addresses for
> cache-coherent allocations (consistent_alloc(), etc.), just subracting
> KERNELBASE from the virtual address is no longer sufficient.  Because
> of this, I have modified virt_to_phys and phys_to_virt to look like:

Those functions are deprecated actually (the _bus_ ones at least,
the _phys_ one can still be used by some internal arch code, though
it's well known that they will only work with the linear mapping,
thus a simple substraction is enough).

> This simplifies the "bus" routines, and makes sure that they use the
> standard virtual/physical translations.

The proper simplification is to kill them
>
> 2. I'd like to add 64-bit __raw_readll and __raw_writell routines to
> io.h, done using floating-point registers.  Currently, modules such as
> MTD (when writing to 64-bit buses) perform two 32-bit, non-atomic
> writes, which can cause problems.  Using a floating-point register to
> guarantee a 64-bit write is ugly, but it works.  Code for these inlined
> routines is as follows:

First, the proper name is readq/writeq ;) Then, most machines may
not have a 64 bits IO bus anyway, I don't think we need to provide
those functions for ppc32 and the MSR munging will cost you more
than the benefit of doing a 64 bits access.

So unless you have a specific need for those, I don't think we
need that in the kernel. Note about your implementation: you could
probably clear MSR:EE at the same time as you set MSR:FP instead
of using local_irq_save outside of the asm block ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
