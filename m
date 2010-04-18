Return-Path: <gknispel@proformatique.com>
Date: Sun, 18 Apr 2010 05:34:39 +0200
From: Guillaume Knispel <gknispel@proformatique.com>
To: linux-kernel@vger.kernel.org, Linuxppc-dev@lists.ozlabs.org
Subject: Pending interrupts not always replayed
Message-ID: <20100418053439.4d2ffe11@xilun.lan.proformatique.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
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

Hi,

=46rom reading the code (kernel/irq stuffs), it seems that at least some
handle_edge_irq based interrupts are not replayed when enabling if
desc->chip->retrigger =3D=3D NULL and on a platform where
CONFIG_HARDIRQS_SW_RESEND is not set (which for now is only defined for
(some?) arm and avr32). Depending on the pic this problem might
be masked if multiple interrupts are received between disable_irq and
enable_irq (maybe other conditions exist with controllers i don't know).

I happen to program a PPC SoC (MPC8555E to be precise), using some edge
interrupts on the PortC of the CPM2 pic (arch/powerpc/sysdev/cpm2_pic.c)
in a driver that does some enable_irq/disable_irq while various
patterns of interrupts are received and i think i've hit the problem.

Is the behavior intended (not always replaying edge triggered interrupts)
or is it just a bug to fix?

Anybody knows if it's safe to activate CONFIG_HARDIRQS_SW_RESEND for a
powerpc or are there some known dangerous interactions?
(I'll give it a try on my side in the meantime anyway)

Cheers!
--=20
Guillaume Knispel
