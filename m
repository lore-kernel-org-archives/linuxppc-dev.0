Return-Path: <gknispel@proformatique.com>
From: Guillaume Knispel <gknispel@proformatique.com>
To: linux-kernel@vger.kernel.org,
	Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] genirq: reliably replay pending edge-triggered irq (plus
	doc)
Date: Thu, 22 Apr 2010 15:09:56 +0200
Message-Id: <1271941798-9659-1-git-send-email-gknispel@proformatique.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Guillaume Knispel <gknispel@proformatique.com>,
	Michael Buesch <mb@bu3sch.de>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the following series:


[1/2] implements the proposal I made at the end of the thread
http://lkml.org/lkml/2010/4/19/129 to reliably support replay
of edge-triggered interrupts on all architectures when using
disable_irq() / enable_irq().

Proper replays of pending edge-triggered interrupts was
depending on CONFIG_HARDIRQS_SW_RESEND which only seems to have
been noticed for plateforms of ARM and AVR32 architecture while
it should also have been used on other architectures to get the
correct behavior. So the patch removes CONFIG_HARDIRQS_SW_RESEND
and unconditionally builds the resend_irqs() tasklet and its
scheduling.

I only tested an equivalent patch for linux-2.6.22.18 on powerpc
for a board with an MPC8555E (using a portC line on the CPM2 PIC),
and build-tested this one for x86.


[2/2] updates Documentation/DocBook/genericirq.tmpl, taking
into account 1/2 other previous undocumented changes to genirq.


--
Guillaume Knispel
