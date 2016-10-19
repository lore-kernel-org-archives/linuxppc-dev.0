Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szFvh2MgXzDt1m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 13:17:36 +1100 (AEDT)
In-Reply-To: <20161011184756.5f09aa81@roar.ozlabs.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Guenter Roeck <linux@roeck-us.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: ppc64 qemu test failure since commit f9aa67142 ("powerpc/64s:
 Consolidate Alignment 0x600 interrupt")
Message-Id: <3szFvh1c1Xz9s9x@ozlabs.org>
Date: Wed, 19 Oct 2016 13:17:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-10 at 07:47:56 UTC, Nicholas Piggin wrote:
> On Mon, 10 Oct 2016 07:15:11 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 10/09/2016 10:49 PM, Nicholas Piggin wrote:
> > > On Sun, 9 Oct 2016 08:21:21 -0700
> > > Guenter Roeck <linux@roeck-us.net> wrote:
> > >  
> > >> Nicholas,
> > >>
> > >> some of my qemu tests for ppc64 started failing on mainline (and -next).
> > >> You can find a test log at
> > >> http://kerneltests.org/builders/qemu-ppc64-master/builds/580/steps/qemubuildcommand/logs/stdio
> > >>
> > >> The scripts to run the test are available at
> > >> https://github.com/groeck/linux-build-test/tree/master/rootfs/ppc64
> > >>
> > >> Bisect points to commit f9aa67142ef26 ("powerpc/64s: Consolidate Alignment 0x600
> > >> interrupt"). Bisect log is attached.
> > >>
> > >> Since I don't have the means to run the code on a real system, I have no idea
> > >> if the problem is caused by qemu or by the code. It is interesting, though, that
> > >> only the 'mac99' tests are affected.
> > >>
> > >> Please let me know if there is anything I can do to help tracking down the
> > >> problem.  
> > >
> > > Thanks for this. That patch just moves a small amount of code, so it's likely
> > > that it's caused something to get placed out of range of its caller, or the
> > > linker started generating a stub for some reason. I can't immediately see the
> > > problem, but it could be specific to your exact toolchain.
> > >
> > > Something that might help, would you be able to put the compiled vmlinux binaries
> > > from before/after the bad patch somewhere I can grab them?
> > >  
> > 
> > http://server.roeck-us.net/qemu/ppc64/mac99/
> > 
> > 'bad' is at f9aa67142ef26, 'good' is one commit earlier, 'tot' is from top of tree
> > (b66484cd7470, more specifically).
> > 
> > Key difference in System.map, from the bad case:
> > 
> > c000000000005c00 T __end_interrupts
> > c000000000007000 t end_virt_trampolines
> > c000000000008000 t 00000010.long_branch.power4_fixup_nap+0
> > c000000000008100 t fs_label
> > c000000000008100 t start_text
> > 
> > 00000010.long_branch.power4_fixup_nap+0 does not exist in the good case,
> > and fs_label/start_text are at c000000000008000.
> > 
> > Toolchain is from poky 1.5.1, which uses gcc 4.8.1 and binutils 2.23.2.
> > I also tried with the toolchain from poky 1.6, using gcc 4.8.2 and binutils 2.24,
> > with the same result.
> 
> Thank you for the quick response, this points to the exact problem.
> I've attached a patch which should fix the bug. There are some checks
> I've got planned that will catch this type of thing at build time and
> be much easier to track down.
> 
> Thanks,
> Nick
> 
> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Tue, 11 Oct 2016 18:33:26 +1100
> Subject: [PATCH] powerpc/64s: fix power4_fixup_nap placement
> 
> power4_fixup_nap is called from the "common" handlers, not the virt/real
> handlers, therefore it should itself be a common handler. Placing it
> down in the trampoline space caused it to go out of reach of its
> callers, requiring a trampoline inserted at the start of the text
> section, which breaks the fixed section address calculations.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7c8cb4b50f3cc6f4a8f7bfddad6fb5

cheers
