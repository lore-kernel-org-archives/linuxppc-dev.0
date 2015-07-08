Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C99A1A1992
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 08:36:44 +1000 (AEST)
Message-ID: <1436394990.3948.113.camel@kernel.crashing.org>
Subject: Re: PASEMI: PA6T board doesn't boot with the RC1 of kernel 4.2 anymore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 09 Jul 2015 08:36:30 +1000
In-Reply-To: <559D653F.2060307@xenosoft.de>
References: <559BB716.6040001@xenosoft.de> <559BC99D.20608@xenosoft.de>
 <559D653F.2060307@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-08 at 20:00 +0200, Christian Zigotzky wrote:
> Dear Linuxppc-dev mailing list,
> 
> I used git bisect and found out that the following commit is the problem.
> 
> commit 3ceaccdf92073d193f0bfbe24280dd736e3fed86
> Author: Dave Hansen <dave.hansen@linux.intel.com>

There is no way that commit affects anything on that platform, it only
changes a file in arch/x86 that isn't compiled on a powerpc build. You
must have made a mistake in your bisection, possibly the one "sometimes
boots" should be considered good, but I can't say for sure.

Michael has a PA6T board at work, so I assume he will see if he can
reproduce.

Ben.

> 
> Log:
> 
> git clone 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-git
> 
> git bisect start b953c0d234bc72e8489d3bf51a276c5c4ec85345 (Linux 4.1)
> 
> git bisect bad d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754 (Linux 4.2-rc1)
> 
> Output:
> 
> Bisecting: 6261 revisions left to test after this (roughly 13 steps)
> [4570a37169d4b44d316f40b2ccc681dc93fedc7b] Merge tag 'sound-4.2-rc1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> 
> ----
> 
> git bisect bad
> 
> Output:
> 
> Bisecting: 3295 revisions left to test after this (roughly 12 steps)
> [4e241557fc1cb560bd9e77ca1b4a9352732a5427] Merge tag 'for-linus' of 
> git://git.kernel.org/pub/scm/virt/kvm/kvm
> 
> ----
> 
> git bisect bad
> 
> Output:
> 
> Bisecting: 1625 revisions left to test after this (roughly 11 steps)
> [44d21c3f3a2ef2f58b18bda64c52c99e723f3f4a] Merge 
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> 
> ----
> 
> git bisect bad
> 
> Output:
> 
> Bisecting: 712 revisions left to test after this (roughly 10 steps)
> [e75c73ad64478c12b3a44b86a3e7f62a4f65b93e] Merge branch 
> 'x86-fpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> ----
> 
> git bisect bad (sometimes the kernel boots but the mouse doesn't work)
> 
> Output:
> 
> Bisecting: 371 revisions left to test after this (roughly 9 steps)
> [c58267e9fa7b0345dd9006939254701e3622ca6a] Merge branch 
> 'perf-core-for-linus' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> ----
> 
> git bisect good
> 
> Output:
> 
> Bisecting: 185 revisions left to test after this (roughly 8 steps)
> [59a36d16be8f9f68410f1bd396577fb7f31ae877] x86/fpu: Factor out 
> fpu/regset.h from fpu/internal.h
> 
> ----
> 
> git bisect good
> 
> Output:
> 
> Bisecting: 93 revisions left to test after this (roughly 7 steps)
> [23b7776290b10297fe2cae0fb5f166a4f2c68121] Merge branch 
> 'sched-core-for-linus' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> ----
> 
> git bisect good
> 
> Output:
> 
> Bisecting: 46 revisions left to test after this (roughly 6 steps)
> [0c4109bec0a6cde471bef3a21cd6f8384a614469] x86/fpu/xstate: Fix up bad 
> get_xsave_addr() assumptions
> 
> ----
> 
> git bisect good
> 
> Output:
> 
> Bisecting: 19 revisions left to test after this (roughly 5 steps)
> [cfe3eceb7a2eb91284d5605c5315249bb165e9d3] Merge branch 
> 'x86-efi-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> ----
> 
> git bisect good
> 
> Output:
> 
> Bisecting: 9 revisions left to test after this (roughly 3 steps)
> [cd4996dce18b619bd7b3acf75c91f49c77f05a97] x86/mpx: Trace allocation of 
> new bounds tables
> 
> ----
> 
> git bisect good
> 
> Output:
> 
> Bisecting: 4 revisions left to test after this (roughly 2 steps)
> [613fcb7d3c79ec25b5913a6aa974c9047c31e68c] x86/mpx: Support 32-bit 
> binaries on 64-bit kernels
> 
> ----
> 
> git bisect good
> 
> Output:
> 
> Bisecting: 2 revisions left to test after this (roughly 1 step)
> [bea03c50b871a2fa922f31ad7c9993bb4fc7b192] x86/mpx: Do not count MPX 
> VMAs as neighbors when unmapping
> 
> ----
> 
> git bisect bad (sometimes the kernel boots but the mouse doesn't work)
> 
> Output:
> 
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [3ceaccdf92073d193f0bfbe24280dd736e3fed86] x86/mpx: Rewrite the unmap code
> 
> ----
> 
> git bisect bad (sometimes the kernel boots but the mouse doesn't work)
> 
> Output:
> 
> 3ceaccdf92073d193f0bfbe24280dd736e3fed86 is the first bad commit
> commit 3ceaccdf92073d193f0bfbe24280dd736e3fed86
> Author: Dave Hansen <dave.hansen@linux.intel.com>
> Date:   Sun Jun 7 11:37:06 2015 -0700
> 
>      x86/mpx: Rewrite the unmap code
> 
>      The MPX code needs to clear out bounds tables for memory which
>      is no longer in use.  We do this when a userspace mapping is
>      torn down (unmapped).
> 
>      There are two modes:
> 
>        1. An entire bounds table becomes unused, and can be freed
>           and its pointer removed from the bounds directory.  This
>           happens either when a large mapping is torn down, or when
>           a small mapping is torn down and it is the last mapping
>           "covered" by a bounds table.
> 
>        2. Only part of a bounds table becomes unused, in which case
>           we free the backing memory as if MADV_DONTNEED was called.
> 
>      The old code was a spaghetti mess of "edge" bounds tables
>      where the edges were handled specially, even if we were
>      unmapping an entire one.  Non-edge bounds tables are always
>      fully unmapped, but share a different code path from the edge
>      ones.  The old code had a bug where it was unmapping too much
>      memory.  I worked on fixing it for two days and gave up.
> 
>      I didn't write the original code.  I didn't particularly like
>      it, but it worked, so I left it.  After my debug session, I
>      realized it was undebuggagle *and* buggy, so out it went.
> 
>      I also wrote a new unmapping test program which uncovers bugs
>      pretty nicely.
> 
>      Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>      Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>      Cc: Andrew Morton <akpm@linux-foundation.org>
>      Cc: Dave Hansen <dave@sr71.net>
>      Cc: H. Peter Anvin <hpa@zytor.com>
>      Cc: Linus Torvalds <torvalds@linux-foundation.org>
>      Cc: Peter Zijlstra <peterz@infradead.org>
>      Link: 
> http://lkml.kernel.org/r/20150607183706.DCAEC67D@viggo.jf.intel.com
>      Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> :040000 040000 d6809ce6030ff42a5813da4a94971888d8ad67c9 
> a0514265bbf313aba996e5606c00881acc62b220 M    arch
> 
> ----
> 
> Cheers,
> 
> Christian
> 
> 
> On 07 July 2015 2:44 PM, Christian Zigotzky wrote:
> >
> >
> > Error messages images:
> >
> > http://forum.hyperion-entertainment.biz/download/file.php?id=1772&mode=view 
> >
> > http://forum.hyperion-entertainment.biz/download/file.php?id=1774&mode=view 
> >
> >
> > -- Christian
> >
> > On 07 July 2015 12:50 PM Christian Zigotzky wrote:
> >> Dear Linuxppc-dev mailing list,
> >>
> >> I compiled a kernel from the git on Tuesday 23rd of June 2015. It
> >> didn't boot with my PASEMI PA6T board.
> >>
> >> Error messages:
> >>
> >> Oops: Kernel access of bad area, sig: 11 [#1]
> >>
> >> .sb600_8259_cascade+0x4c/0xac (unreliable)
> >> .schedule+0x74/0x9c (unreliable)
> >>
> >> Kernel panic - not syncing: Fatal exception in interrupt
> >>
> >> I compiled the RC1 of kernel 4.2 last Sunday. Unfortunately it didn't
> >> boot either. The kernel 4.1 and 4.1.1 boot without any problems.
> >>
> >> Could someone please explain me why it doesn't boot anymore?
> >>
> >> I would like to thank you very much in advance for helping me.
> >>
> >> If you have any questions, please don't hesitate to ask. I'm looking
> >> forward to getting your reply.
> >>
> >>
> >> Kind regards,
> >>
> >> Christian Zigotzky
> >>
> >>
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@lists.ozlabs.org
> >> https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
