Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36B77DDF54
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 07:35:57 +1000 (EST)
Subject: Re: Level IRQ handling on Xilinx INTC with ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
In-Reply-To: <16359.1217340857@redhat.com>
References: <360961217332693@webmail22.yandex.ru> <16359.1217340857@redhat.com>
Content-Type: text/plain
Date: Wed, 30 Jul 2008 07:35:23 +1000
Message-Id: <1217367323.11188.263.camel@pasglop>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-29 at 15:14 +0100, David Howells wrote:
> Sergey Temerkhanov <temerkhanov@yandex.ru> wrote:
> 
> > And handle_level_irq() which is currently used as high-level IRQ handler for
> > Xilinx INTC only tries to acknowledge IRQ before ISR call. So that the IRQ
> > remains asserted in INTC and after the call to desc->chip->unmask() causes
> > spurious attempt to process the same IRQ again. However, call to
> > desc->chip->ack() this time finishes the required procedure of IRQ
> > acknowledge.
> 
> I think I'm seeing the same on the MN10300 arch with its builtin PIC.  My
> soultion was to make unmask() also clear the IRQ latch in the PIC for that
> channel.  We perhaps want an unmask_ack() op.

I've heard about similar issues on other setups... I dislike having a
separate op though, not sure what's the best approach. Another one is to
write a different level handler for such PICs, though that somewhat
sucks too. CC'ing Ingo and Thomas who may have a better idea.

Ben.
