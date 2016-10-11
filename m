Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stTcp5jfTzDrSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 18:48:10 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id qn10so1115568pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 00:48:10 -0700 (PDT)
Date: Tue, 11 Oct 2016 18:47:56 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc64 qemu test failure since commit f9aa67142 ("powerpc/64s:
 Consolidate Alignment 0x600 interrupt")
Message-ID: <20161011184756.5f09aa81@roar.ozlabs.ibm.com>
In-Reply-To: <d55b4014-1265-da65-1698-2860d3acd603@roeck-us.net>
References: <20161009152121.GA13188@roeck-us.net>
 <20161010164953.5f37e6e4@roar.ozlabs.ibm.com>
 <d55b4014-1265-da65-1698-2860d3acd603@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 10 Oct 2016 07:15:11 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 10/09/2016 10:49 PM, Nicholas Piggin wrote:
> > On Sun, 9 Oct 2016 08:21:21 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >  
> >> Nicholas,
> >>
> >> some of my qemu tests for ppc64 started failing on mainline (and -next).
> >> You can find a test log at
> >> http://kerneltests.org/builders/qemu-ppc64-master/builds/580/steps/qemubuildcommand/logs/stdio
> >>
> >> The scripts to run the test are available at
> >> https://github.com/groeck/linux-build-test/tree/master/rootfs/ppc64
> >>
> >> Bisect points to commit f9aa67142ef26 ("powerpc/64s: Consolidate Alignment 0x600
> >> interrupt"). Bisect log is attached.
> >>
> >> Since I don't have the means to run the code on a real system, I have no idea
> >> if the problem is caused by qemu or by the code. It is interesting, though, that
> >> only the 'mac99' tests are affected.
> >>
> >> Please let me know if there is anything I can do to help tracking down the
> >> problem.  
> >
> > Thanks for this. That patch just moves a small amount of code, so it's likely
> > that it's caused something to get placed out of range of its caller, or the
> > linker started generating a stub for some reason. I can't immediately see the
> > problem, but it could be specific to your exact toolchain.
> >
> > Something that might help, would you be able to put the compiled vmlinux binaries
> > from before/after the bad patch somewhere I can grab them?
> >  
> 
> http://server.roeck-us.net/qemu/ppc64/mac99/
> 
> 'bad' is at f9aa67142ef26, 'good' is one commit earlier, 'tot' is from top of tree
> (b66484cd7470, more specifically).
> 
> Key difference in System.map, from the bad case:
> 
> c000000000005c00 T __end_interrupts
> c000000000007000 t end_virt_trampolines
> c000000000008000 t 00000010.long_branch.power4_fixup_nap+0
> c000000000008100 t fs_label
> c000000000008100 t start_text
> 
> 00000010.long_branch.power4_fixup_nap+0 does not exist in the good case,
> and fs_label/start_text are at c000000000008000.
> 
> Toolchain is from poky 1.5.1, which uses gcc 4.8.1 and binutils 2.23.2.
> I also tried with the toolchain from poky 1.6, using gcc 4.8.2 and binutils 2.24,
> with the same result.

Thank you for the quick response, this points to the exact problem.
I've attached a patch which should fix the bug. There are some checks
I've got planned that will catch this type of thing at build time and
be much easier to track down.

Thanks,
Nick

From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 11 Oct 2016 18:33:26 +1100
Subject: [PATCH] powerpc/64s: fix power4_fixup_nap placement

power4_fixup_nap is called from the "common" handlers, not the virt/real
handlers, therefore it should itself be a common handler. Placing it
down in the trampoline space caused it to go out of reach of its
callers, requiring a trampoline inserted at the start of the text
section, which breaks the fixed section address calculations.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 08992f8..f129408 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1377,7 +1377,7 @@ __end_interrupts:
 DEFINE_FIXED_SYMBOL(__end_interrupts)
 
 #ifdef CONFIG_PPC_970_NAP
-TRAMP_REAL_BEGIN(power4_fixup_nap)
+EXC_COMMON_BEGIN(power4_fixup_nap)
 	andc	r9,r9,r10
 	std	r9,TI_LOCAL_FLAGS(r11)
 	ld	r10,_LINK(r1)		/* make idle task do the */
-- 
2.9.3
