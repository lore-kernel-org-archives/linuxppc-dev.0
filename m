Return-Path: <gknispel@proformatique.com>
Date: Tue, 4 May 2010 02:19:41 +0200
From: Guillaume Knispel <gknispel@proformatique.com>
To: linux-kernel@vger.kernel.org, Linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 0/2] genirq: reliably replay pending edge-triggered irq
	(plus doc)
Message-Id: <20100504021941.ff7579c1.gknispel@proformatique.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Russell King <linux@arm.linux.org.uk>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Guillaume Knispel <gknispel@proformatique.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
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
correct behavior. So the patch unconditionally builds the
resend_irqs() tasklet and its scheduling
(CONFIG_HARDIRQS_SW_RESEND is not used anymore).

I only tested an equivalent patch for linux-2.6.22.18 on powerpc
for a board with an MPC8555E (using a portC line on the CPM2 PIC),
and build-tested this one for x86.


[2/2] updates Documentation/DocBook/genericirq.tmpl, taking
into account 1/2 other previous undocumented changes to genirq.


History:
[v2]	- Don't touch archs Kconfig and defconfigs
	  (CONFIG_HARDIRQS_SW_RESEND is left unused)
	- Don't make unrelated change to a comment in
	  arch/x86/kernel/apic/io_apic.c
	- (hopefully) Better commit message for [1/2]
	- Correct spelling errors in [2/2]

[v1]	- initial patch


Guillaume Knispel (2):
  genirq: reliably replay pending edge-triggered irq
  genirq: update doc

 Documentation/DocBook/genericirq.tmpl |   73 ++++++++++++++++++--------------
 kernel/irq/resend.c                   |    6 ---
 2 files changed, 41 insertions(+), 38 deletions(-)
