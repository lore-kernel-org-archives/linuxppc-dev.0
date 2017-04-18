Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6k4V4sGdzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 21:51:38 +1000 (AEST)
In-Reply-To: <1492491886-29233-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mahesh@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: powerpc/64: Fix HMI exception on LE with CONFIG_RELOCATABLE=y
Message-Id: <3w6k4V44Ydz9s7h@ozlabs.org>
Date: Tue, 18 Apr 2017 21:51:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-18 at 05:04:46 UTC, Michael Ellerman wrote:
> Prior to commit 2337d207288f ("powerpc/64: CONFIG_RELOCATABLE support for hmi
> interrupts"), the branch from hmi_exception_early() to hmi_exception_realmode()
> was just a bl hmi_exception_realmode, which the linker would turn into a bl to
> the local entry point of hmi_exception_realmode. This was broken when
> CONFIG_RELOCATABLE=y because hmi_exception_realmode() is not in the low part of
> the kernel text that is copied down to 0x0.
> 
> But in fixing that, we added a new bug on little endian kernels. Because the
> branch is now a bctrl when CONFIG_RELOCATABLE=y, we branch to the global entry
> point of hmi_exception_realmode(). The global entry point must be called with
> r12 containing the address of hmi_exception_realmode(), because it uses that
> value to calculate the TOC value (r2).
> 
> This may manifest as a checkstop, because we take a junk value from r12 which
> came from HSRR1, add a small constant to it and then use that as the TOC
> pointer. The HSRR1 value will have 0x9 as the top nibble, which puts it above
> RAM and somewhere in MMIO space.
> 
> Fix it by changing the BRANCH_LINK_TO_FAR() macro to always use r12 to load the
> label we're branching to. This means r12 will be setup correctly on LE, fixing
> this bug, and r12 is also volatile across function calls on BE so it's a good
> choice anyway.
> 
> Fixes: 2337d207288f ("powerpc/64: CONFIG_RELOCATABLE support for hmi interrupts")
> Reported-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/be5c5e843c4afa1c8397cb740b6032

cheers
