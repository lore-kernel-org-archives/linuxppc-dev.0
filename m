Date: Wed, 31 Mar 2004 10:01:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: John Whitney <johnw@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
Message-ID: <20040331100159.A17284@home.com>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com>; from johnw@sands-edge.com on Wed, Mar 31, 2004 at 10:44:25AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 31, 2004 at 10:44:25AM -0500, John Whitney wrote:
> I've made few changes to include/asm-ppc/io.h that might want to be
> incorporated into the mainline tree.  These changes include:
>
> 1. Modifications to virt_to_bus, bus_to_virt, virt_to_phys, and
> phys_to_virt.  With the use of fully virtual addresses for
> cache-coherent allocations (consistent_alloc(), etc.), just subracting
> KERNELBASE from the virtual address is no longer sufficient.  Because
> of this, I have modified virt_to_phys and phys_to_virt to look like:

This group of calls is defined to only work on statically mapped
kernel virtual addresses. That is, the system memory mapped at
PAGE_OFFSET/KERNELBASE.  Adding any additional functionality to these
calls will just make ppc32 different from other arches. Yes, I know
the names are misleading but I didn't make them. :-P

If you want to drive a uniform address translation API into the
kernel then the place to start is on lkml.  This has been hashed
out on linuxppc-embedded before, please check the archives.

> 2. I'd like to add 64-bit __raw_readll and __raw_writell routines to
> io.h, done using floating-point registers.  Currently, modules such as
> MTD (when writing to 64-bit buses) perform two 32-bit, non-atomic
> writes, which can cause problems.  Using a floating-point register to
> guarantee a 64-bit write is ugly, but it works.  Code for these inlined
> routines is as follows:
>
> /*
>   * For reading and writing 64-bit values, we need to use the floating
> point
>   * registers.  The code will enable MSR_FP in the MSR register, use
> FPR1 to
>   * read from and write to memory, and then restore everything to the
>   * previous values.
>   */

I think this is useful...I've had to recommend this method for
local hacks on various people's platforms.  The most typical case
seems to be MTD but a lot of folks have custom data acquisition devices
that run into this problem. Yes, it's ugly, but hardware folks keep
configuring devices for a 64-bit bus width.

Why not create a patch against linux-2.5/linux-2.4 so that it is
easily reviewed?  Paul/Ben/others might then be compelled to comment
on it.

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
