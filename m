Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE1F41A1A3E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2015 03:26:22 +1100 (AEDT)
Date: Fri, 18 Dec 2015 17:18:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Cris <linux-cris-kernel@axis.com>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
Message-ID: <20151218161836.GL3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <20151211153054.48da5d4139b93dd4ed438f4c@linux-foundation.org>
 <20151215142621.GE3729@pathway.suse.cz>
 <20151217143858.447b5fe79aaa5ed7b2328d67@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151217143858.447b5fe79aaa5ed7b2328d67@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 2015-12-17 14:38:58, Andrew Morton wrote:
> On Tue, 15 Dec 2015 15:26:21 +0100 Petr Mladek <pmladek@suse.com> wrote:
> 
> > > OK, thanks.  So "not needed at present, might be needed in the future,
> > > useful for out-of-tree debug code"?
> > 
> > It is possible that I got it a wrong way on arm. The NMI buffer is
> > usable there on two locations.
> > 
> > First, the temporary is currently used to handle IPI_CPU_BACKTRACE.
> > It seems that it is not a real NMI. But it seems to be available
> > (compiled) on all arm system. This is why I introduced NEED_PRINTK_NMI
> > Kconfig flag to avoid confusion with a real NMI.
> > 
> > Second, there is the FIQ "NMI" handler that is called from
> > /arch/arm/kernel/entry-armv.S. It is compiled only if _not_
> > defined $(CONFIG_CPU_V7M). It calls nmi_enter() and nmi_stop().
> > It looks like a real NMI handler. This is why I defined HAVE_NMI
> > if (!CPU_V7M).
> > 
> > A solution would be to define HAVE_NMI on all Arm systems and get rid
> > of NEED_PRINTK_NMI. If you think that it would cause less confusion...
> 
> So does this mean that the patch will be updated?

Please, find the follow up patch below. I guess that you will want to
squash it into the [1/n] one.


>From 144d90ada2e34b8807efcc01922c48d7c09797e7 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Fri, 18 Dec 2015 16:04:35 +0100
Subject: [PATCH] printk/nmi: Remove the questionable CONFIG_NEED_PRINTK_NMI

The flag NEED_PRINTK_NMI was added because of Arm. It used the NMI safe
backtrace implementation on all Arm systems. But it did not have a real
NMI handling on CPU_V7M.

It seems that it causes more confusion than good. Let's use HAVE_NMI
on all arm systems and get rid of the problematic flag.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/Kconfig     | 3 ---
 arch/arm/Kconfig | 3 +--
 init/Kconfig     | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 7ce5101c2472..d1a18b313624 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -190,9 +190,6 @@ config HAVE_KPROBES_ON_FTRACE
 config HAVE_NMI
 	bool
 
-config NEED_PRINTK_NMI
-	bool
-
 config HAVE_NMI_WATCHDOG
 	depends on HAVE_NMI
 	bool
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 96d2c275f0f7..01dc56d8f31b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -63,8 +63,7 @@ config ARM
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC
-	select HAVE_NMI if (!CPU_V7M)
-	select NEED_PRINTK_NMI if (CPU_V7M)
+	select HAVE_NMI
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
 	select HAVE_PERF_EVENTS
diff --git a/init/Kconfig b/init/Kconfig
index 61cfd96a3c96..abf79f3b1a55 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1481,7 +1481,7 @@ config PRINTK
 config PRINTK_NMI
 	def_bool y
 	depends on PRINTK
-	depends on HAVE_NMI || NEED_PRINTK_NMI
+	depends on HAVE_NMI
 
 config BUG
 	bool "BUG() support" if EXPERT
-- 
1.8.5.6
