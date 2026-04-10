Return-Path: <linuxppc-dev+bounces-19570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C96CF4484F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:18:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbSC6XTZz2yZ6;
	Fri, 10 Apr 2026 22:18:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823515;
	cv=none; b=Na+lBMAdZjmxP0XsZELYRPbXK7NJNPeBFtY27d1sXJmWGZFLjX8LB4H3rhowZCMphIRl9SR1S56Skh2aAKPtc6RhfSskb0qZAT/fxmNxJ9nt6H15rSMus8XTMbJxnWf4cl2w+tZ63gitJQiAVNYUlHrT3YNYq72UACkjPiWXuOnewjAmQr19oNP6P6VUVPEK/gE9FQK4jRVItwK93J5MCWjybHG8PnSuaN2zFRCrvTHM+gxh3rrm0XDrPWW7sBVcAOYuu497BD1HlJQaZaY3VkEb0oHD9UO3T95PUIYXvcuZriLZDF+FYih+U0hRINMNa7D/s9FaeNO1TZ4evRRBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823515; c=relaxed/relaxed;
	bh=RGZWkdQ4vdhJ/zmTXBMfmAASwOBRdYWIY356UL1Iu/0=;
	h=Date:Message-ID:From:To:Subject:cc; b=gN4a4QXSUWGGSiG6MLZeG0gqrhQ0a4IYvLXfqjL33KN5gAMHmp9fXG/eriFGLaEiR3EBEnhOY3VxS2/2cabEqyZhr3/NfVMcaMpltHS/mNJFsEckjSSnIofshiREcEnAoJay0Pimby9tgXHH0pcLr2G5L8/T8YWm2IZ9huxr5PSlnmeq9UST9gAER23M6Rue/HaLJw21TJjLMhPThLQ2MIxTAsyHwuMGs+IwPUc1vjpaHXp8ylG7GLk4YvVVoBQ5g0sNNwXa9h1fsjdvWQQl94DGItwLOJCRfeLmshqKmmICrRXNrw7QmXUOOE3n2F9QxfhoJH8IroA/Ty3dVEAjoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X6IRMdbN; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X6IRMdbN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbSB4fjKz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:18:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6FD0B6024D;
	Fri, 10 Apr 2026 12:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF16C19421;
	Fri, 10 Apr 2026 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823511;
	bh=xG6Zhe4Reh8n1CuuXKHsxMx4yyA7cv5SRNW/ce+u7MA=;
	h=Date:From:To:Subject:cc:From;
	b=X6IRMdbNwD/1TPVTuuT38dax3aETJdTvvykNWi23GiBjWbaPnFiS31YP2+3+rHYnr
	 +yBiYqSiaFZumAFwSR+NEqA6PxsCix9KHXp0BGVkWu/kFUlz/YIdIICieWTokegmLh
	 Yr8j8VsIfTTYuyizZOa5fjt2rtqvhW2e+npoz/WBNOWVCp5m8FdgfGaOB54VOYpbJT
	 yU3PgzyY9/f2Y08BZe1qPEkZ4DBScL99CvOU6Da3YpVoCSH2byw56W+6qCVZbtJoMm
	 0joIfHOTvLdlWQN0yWziORYb41f8Ajm7GcTfuGZTXlFCF7Y90aZDQyz+rgc1XQsGrv
	 br4n1yhF6vGQA==
Date: Fri, 10 Apr 2026 14:18:27 +0200
Message-ID: <20260410120044.031381086@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 00/38] treewide: Cleanup LATCH,
 CLOCK_TICK_RATE and get_cycles() [ab]use
cc: Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

First of all sorry for the insanely big Cc list, but people can't make
their mind up whether they want to be Cc'ed on everything or not. So I'm
opting for the worst case to cater to the people who want to be Cc'ed on
everything and assume that the rest of you got used to it by now. I really
wanted this to be more confined but a treewide cleanup does not give a lot
of options.

That said, let me explain what this is about.

  1) LATCH

     The LATCH define goes back to Linux version 0.1 and has survived until
     today for the very wrong reasons.

     Initially it was based on the x86 PIT frequency and also steered the
     timekeeping conversions.

     With the arrival of non x86 architectures it got changed to be based
     on CLOCK_TICK_RATE in order not to change core code which depended on
     LATCH.

     That all got meaningless when timers, timekeeping and scheduling
     infrastructure got rewritten more than two decades ago.

     But there is still a lonely survivor in arch/x86/kernel/apm_32.c
     which dates back to Linux 1.3.46 (Dec. 1995)

     Which causes the next historical gem

  2) CLOCK_TICK_RATE

     When Linux got expanded beyond i386 LATCH was made "flexible" by
     basing it on CLOCK_TICK_RATE to adjust for other frequencies than the
     i386 PIT frequency.

     As LATCH this got meaningless long ago and for amusement value it got
     copied into new architectures arriving way after it got obsolete for
     no reason but with comments to the effect that it's meaningless

     And of course it had a lonely survivor in arch/x86/kernel/setup.c
     despite it being only an alias for PIT_TICK_RATE for a very long time.

  3) get_cycles()

     That was introduced in 2.1.133pre4 (Dec. 1998) to utilize the back
     then brand new TSC. The introduction broke everything except i386 SMP
     with a CPU having a TSC and got then fixed up within a couple of days
     with empty stubs returning 0 and #ifdeffery for CONFIG_TSC before the
     2.2.0 release.

     It's amusing that the naming deliberately ignored that TSC is the
     acronym for Time Stamp Counter and not Cycle Counter and rather went
     for the underlying coincidence that the TSC was running at the same
     fixed frequency as the CPU core.

     That turned out to be interesting when CPUs started to have frequency
     scaling as the TSC then turned into a variable frequency random number
     generator.

     A decade later CPU designers came to senses and made the TSC invariant
     usually running at the nominal CPU frequency, which allowed to use it
     for reliable timekeeping purposes.

     Non x86 architectures implemented get_cycles() based on whatever
     continuously running counter they had available in their CPUs. Some of
     them actual CPU cycle counters, but many of them running at a fixed
     frequency which was completely unrelated to CPU cycles.

     Around 2004/5 the timekeeping subsystem was completely rewritten and
     made generic along with the scheduling clock and other related
     infrastructure. With that rewrite get_cycles() got mostly obsolete,
     but despite it being on the todo list of quite some people it never
     ceased to exist and it was just a conveniance vehicle to base other
     things like the recent addition of random_get_entropy() on top with a
     hideous #ifdef/#define macro maze.

     The other remaining use cases are mostly debugging and testing
     code. Especially the usage in performance test code is hillarious at
     best. While the name get_cycles() suggests that it provides access to
     CPU cycles the reality is that it provides a unspecified counter for
     most systems, where a lot of architectures simply return 0 because
     they either do not have such a counter or did not bother to implement
     it at all.

     So in fact get_cycles() should have been renamed to get_bogo_cycles()
     long ago matching the BogoMIPS "impress your friends" printk which
     still exists for historical amusement value.

     But the real solution is to remove it all together instead of
     proliferating the bogosity.


This is what this series does with the following steps:

   1) Cleanup some header dependency hell which got unearthed by the
      restructuring and went unnoticed so far. It's amazing how the kernel
      build system magically "works". This affects not only x86, but the
      main fallout was observed and fixed there. ARM64 and MIPS are at
      least as bad as they silently rely on the accidental asm/timex.h
      include through a variety of generic headers to make their
      architecture code compile. See the changelog and patches specific to
      those two.

   2) Removal of LATCH

   3) Removal of CLOCK_TICK_RATE

   4) Consolidation of cycles_t which was a typedef in asm/timex.h

   5) Cleanup of read_current_timer() which is only used for delay
      calibration and has nothing to do with get_cycles()

   6) Cleanup of get_cycles() usage in debug and test code

   7) Decoupling of random_get_entropy() from get_cycles()

   8) Removal of asm/timex.h includes except for architecture internal
      usage where necessary.

At the end get_cycles() survives in a couple of architectures as a purely
architecture internal implementation detail.

This survives compile testing on all architectures except hexagon and nios2
because the current cross tools based on gcc15 do not offer a compiler for
them anymore. Boot tested on x86 and some qemu instances covering only a
few architectures.

The series applies on v7.0-rc7 and with very minor conflicts on -next. It
is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git getcycles-v1

Thanks,

	tglx
---
 arch/alpha/include/asm/timex.h                 |   33 --------
 arch/arc/include/asm/timex.h                   |   15 ---
 arch/arm/include/asm/timex.h                   |   16 ---
 arch/arm64/include/asm/timex.h                 |   18 ----
 arch/hexagon/include/asm/timex.h               |   23 -----
 arch/m68k/include/asm/timex.h                  |   42 ----------
 arch/microblaze/include/asm/timex.h            |   13 ---
 arch/mips/include/asm/timex.h                  |  102 -------------------------
 arch/sh/include/asm/timex.h                    |   24 -----
 arch/sparc/include/asm/timex.h                 |    9 --
 arch/sparc/include/asm/timex_32.h              |   14 ---
 arch/um/include/asm/timex.h                    |    9 --
 b/Documentation/fb/udlfb.rst                   |    4 
 b/arch/Kconfig                                 |   10 ++
 b/arch/alpha/Kconfig                           |    1 
 b/arch/alpha/include/asm/random.h              |   14 +++
 b/arch/arm/Kconfig                             |    2 
 b/arch/arm/include/asm/delay.h                 |    1 
 b/arch/arm/include/asm/random.h                |   14 +++
 b/arch/arm/lib/delay.c                         |   14 +--
 b/arch/arm/mach-omap1/Kconfig                  |    2 
 b/arch/arm64/Kconfig                           |    2 
 b/arch/arm64/include/asm/io.h                  |    5 -
 b/arch/arm64/include/asm/ptp_vmclock.h         |   12 ++
 b/arch/arm64/include/asm/random.h              |   11 ++
 b/arch/arm64/include/asm/rqspinlock.h          |    1 
 b/arch/arm64/kernel/time.c                     |    6 +
 b/arch/arm64/kernel/topology.c                 |    1 
 b/arch/arm64/kernel/traps.c                    |    1 
 b/arch/arm64/kvm/emulate-nested.c              |    1 
 b/arch/arm64/kvm/hyp/include/hyp/switch.h      |    1 
 b/arch/arm64/lib/delay.c                       |    1 
 b/arch/hexagon/Kconfig                         |    1 
 b/arch/hexagon/kernel/time.c                   |    8 +
 b/arch/loongarch/Kconfig                       |    1 
 b/arch/loongarch/include/asm/random.h          |   15 +++
 b/arch/loongarch/include/asm/timex.h           |    2 
 b/arch/loongarch/kernel/relocate.c             |    1 
 b/arch/loongarch/kernel/syscall.c              |    1 
 b/arch/loongarch/lib/delay.c                   |    2 
 b/arch/m68k/Kconfig                            |    1 
 b/arch/m68k/amiga/config.c                     |    1 
 b/arch/m68k/include/asm/random.h               |   14 +++
 b/arch/m68k/kernel/time.c                      |    2 
 b/arch/mips/Kconfig                            |    1 
 b/arch/mips/generic/init.c                     |    1 
 b/arch/mips/include/asm/random.h               |    7 +
 b/arch/mips/kernel/pm-cps.c                    |    1 
 b/arch/mips/kernel/proc.c                      |    1 
 b/arch/mips/kernel/relocate.c                  |    2 
 b/arch/mips/kernel/time.c                      |   53 ++++++++++++
 b/arch/mips/lib/dump_tlb.c                     |    1 
 b/arch/mips/mm/cache.c                         |    1 
 b/arch/nios2/Kconfig                           |    1 
 b/arch/nios2/include/asm/random.h              |   14 +++
 b/arch/nios2/include/asm/timex.h               |    7 -
 b/arch/nios2/kernel/time.c                     |    4 
 b/arch/openrisc/Kconfig                        |    2 
 b/arch/openrisc/include/asm/random.h           |   12 ++
 b/arch/openrisc/include/asm/timex.h            |   10 --
 b/arch/openrisc/lib/delay.c                    |    8 -
 b/arch/parisc/Kconfig                          |    1 
 b/arch/parisc/include/asm/random.h             |   12 ++
 b/arch/parisc/include/asm/timex.h              |   10 --
 b/arch/parisc/kernel/processor.c               |    1 
 b/arch/parisc/kernel/time.c                    |    1 
 b/arch/powerpc/Kconfig                         |    1 
 b/arch/powerpc/include/asm/random.h            |   13 +++
 b/arch/powerpc/include/asm/timex.h             |   25 ------
 b/arch/powerpc/platforms/cell/spufs/switch.c   |    5 -
 b/arch/riscv/Kconfig                           |    2 
 b/arch/riscv/include/asm/random.h              |   25 ++++++
 b/arch/riscv/include/asm/timex.h               |   23 -----
 b/arch/riscv/kernel/unaligned_access_speed.c   |    1 
 b/arch/riscv/kvm/vcpu_timer.c                  |    1 
 b/arch/riscv/lib/delay.c                       |    8 +
 b/arch/s390/Kconfig                            |    1 
 b/arch/s390/include/asm/random.h               |   12 ++
 b/arch/s390/include/asm/timex.h                |   10 --
 b/arch/s390/kernel/time.c                      |    1 
 b/arch/s390/kernel/vtime.c                     |    1 
 b/arch/sparc/Kconfig                           |    2 
 b/arch/sparc/include/asm/random.h              |   15 +++
 b/arch/sparc/include/asm/timex_64.h            |   20 ----
 b/arch/sparc/kernel/pcic.c                     |    1 
 b/arch/sparc/kernel/time_32.c                  |    1 
 b/arch/sparc/kernel/time_64.c                  |    4 
 b/arch/sparc/vdso/vclock_gettime.c             |    1 
 b/arch/x86/Kconfig                             |    4 
 b/arch/x86/include/asm/iommu.h                 |    3 
 b/arch/x86/include/asm/msr.h                   |    5 -
 b/arch/x86/include/asm/percpu.h                |    5 -
 b/arch/x86/include/asm/percpu_types.h          |   17 ++++
 b/arch/x86/include/asm/ptp_vmclock.h           |   12 ++
 b/arch/x86/include/asm/pvclock.h               |    1 
 b/arch/x86/include/asm/random.h                |   12 --
 b/arch/x86/include/asm/smp.h                   |    2 
 b/arch/x86/include/asm/tsc.h                   |   11 --
 b/arch/x86/include/asm/vdso/gettimeofday.h     |    5 -
 b/arch/x86/kernel/apm_32.c                     |    4 
 b/arch/x86/kernel/cpu/mce/core.c               |    1 
 b/arch/x86/kernel/nmi.c                        |    1 
 b/arch/x86/kernel/setup.c                      |    2 
 b/arch/x86/kernel/smpboot.c                    |    1 
 b/arch/x86/kernel/tsc.c                        |   12 +-
 b/arch/x86/lib/delay.c                         |    8 -
 b/crypto/jitterentropy-kcapi.c                 |    1 
 b/crypto/tcrypt.c                              |   84 ++++++++++----------
 b/drivers/iommu/intel/dmar.c                   |    4 
 b/drivers/iommu/intel/iommu.h                  |    8 +
 b/drivers/irqchip/irq-apple-aic.c              |    1 
 b/drivers/misc/sgi-gru/gruhandles.c            |   20 +---
 b/drivers/misc/sgi-gru/grukservices.c          |    3 
 b/drivers/misc/sgi-gru/grutlbpurge.c           |    5 -
 b/drivers/net/arcnet/arc-rimi.c                |    4 
 b/drivers/net/arcnet/arcdevice.h               |   20 ----
 b/drivers/net/arcnet/com20020.c                |    6 -
 b/drivers/net/arcnet/com90io.c                 |    6 -
 b/drivers/net/arcnet/com90xx.c                 |    4 
 b/drivers/net/hamradio/baycom_epp.c            |   51 ------------
 b/drivers/net/wireless/ath/wil6210/debugfs.c   |    2 
 b/drivers/net/wireless/ath/wil6210/txrx.c      |    6 -
 b/drivers/net/wireless/ath/wil6210/txrx_edma.c |    4 
 b/drivers/net/wireless/ath/wil6210/wil6210.h   |    3 
 b/drivers/ptp/Kconfig                          |    6 -
 b/drivers/ptp/ptp_vmclock.c                    |    6 -
 b/drivers/video/fbdev/udlfb.c                  |   24 ++---
 b/fs/ext4/mballoc.c                            |    4 
 b/include/asm-generic/Kbuild                   |    2 
 b/include/asm-generic/percpu_types.h           |   20 ++++
 b/include/linux/compiler_types.h               |    1 
 b/include/linux/delay.h                        |    2 
 b/include/linux/jiffies.h                      |    3 
 b/include/linux/random.h                       |   18 ++++
 b/include/linux/timex.h                        |   26 ------
 b/include/linux/types.h                        |    6 +
 b/init/calibrate.c                             |   19 ++--
 b/kernel/kcsan/core.c                          |    3 
 b/kernel/kcsan/debugfs.c                       |    8 -
 b/kernel/time/timer.c                          |    1 
 b/lib/interval_tree_test.c                     |   17 +---
 b/lib/rbtree_test.c                            |   47 +++++------
 b/lib/test_vmalloc.c                           |   10 +-
 b/mm/kasan/sw_tags.c                           |    2 
 b/mm/slub.c                                    |   37 +++++----
 include/asm-generic/timex.h                    |   23 -----
 146 files changed, 622 insertions(+), 796 deletions(-)



