Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B5811A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 22:09:45 +1100 (AEDT)
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/5] Cleaning printk stuff in NMI context
Date: Fri, 27 Nov 2015 12:09:27 +0100
Message-Id: <1448622572-16900-1-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set generalizes the already existing solution for
printing NMI messages. The main idea comes from Peter Zijlstra.

This second version has only few changes in compare with v1, see
below. Peter Zijlstra suggested to improve also handling of
the serial console. I looked into tit and it seems to be
a rather huge task. It might need to review all console
implementations and avoid a deadlock in the locally used locks.
It would be nice but I would move this to another season.

I think that this patchset makes sense as is. It definitely
improves the situation. It allows to put all messages into
the ring buffer so that they are available in the crashdump.
We have had a similar solution in SLE for years and customers
stopped complaining about the deadlock.

Changes against v1:

  + rebased on top of 4.4-rc2; there the old implementation was
    moved to lib/nmi_backtrace.c and used also on arm; I hope that
    I got the arm side correctly; I was not able to test on arm :-(

  + defined HAVE_NMI on arm for !CPU_V7M instead of !CPU_V7;
    handle_fiq_as_nmi() is called from entry-armv.S that
    is compiled when !CPU_V7M

  + defined HAVE_NMI also on mips; it calls nmi_enter() and
    seems to have real NMIs (or am I wrong?)

  + serialized backtraces when printing directly
    (oops_in_progress)

Petr Mladek (5):
  printk/nmi: Generic solution for safe printk in NMI
  printk/nmi: Use IRQ work only when ready
  printk/nmi: Try hard to print Oops message in NMI context
  printk/nmi: Warn when some message has been lost in NMI context
  printk/nmi: Increase the size of the temporary buffer

 arch/Kconfig                  |   7 ++
 arch/arm/Kconfig              |   2 +
 arch/arm/kernel/smp.c         |   2 +
 arch/avr32/Kconfig            |   1 +
 arch/blackfin/Kconfig         |   1 +
 arch/cris/Kconfig             |   1 +
 arch/mips/Kconfig             |   1 +
 arch/powerpc/Kconfig          |   1 +
 arch/s390/Kconfig             |   1 +
 arch/s390/mm/fault.c          |   1 +
 arch/sh/Kconfig               |   1 +
 arch/sparc/Kconfig            |   1 +
 arch/tile/Kconfig             |   1 +
 arch/x86/Kconfig              |   1 +
 arch/x86/kernel/apic/hw_nmi.c |   1 -
 include/linux/hardirq.h       |   2 +
 include/linux/percpu.h        |   3 -
 include/linux/printk.h        |  12 ++-
 init/Kconfig                  |   5 +
 init/main.c                   |   1 +
 kernel/printk/Makefile        |   1 +
 kernel/printk/nmi.c           | 218 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c        |  36 +++----
 kernel/printk/printk.h        |  55 +++++++++++
 lib/bust_spinlocks.c          |   1 +
 lib/nmi_backtrace.c           |  93 +++---------------
 26 files changed, 345 insertions(+), 105 deletions(-)
 create mode 100644 kernel/printk/nmi.c
 create mode 100644 kernel/printk/printk.h

-- 
1.8.5.6
