Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id A1B19DE0A5
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 00:14:21 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <360961217332693@webmail22.yandex.ru>
References: <360961217332693@webmail22.yandex.ru>
To: Sergey Temerkhanov <temerkhanov@yandex.ru>
Subject: Re: Level IRQ handling on Xilinx INTC with ARCH=powerpc
Date: Tue, 29 Jul 2008 15:14:17 +0100
Message-ID: <16359.1217340857@redhat.com>
Sender: dhowells@redhat.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergey Temerkhanov <temerkhanov@yandex.ru> wrote:

> And handle_level_irq() which is currently used as high-level IRQ handler for
> Xilinx INTC only tries to acknowledge IRQ before ISR call. So that the IRQ
> remains asserted in INTC and after the call to desc->chip->unmask() causes
> spurious attempt to process the same IRQ again. However, call to
> desc->chip->ack() this time finishes the required procedure of IRQ
> acknowledge.

I think I'm seeing the same on the MN10300 arch with its builtin PIC.  My
soultion was to make unmask() also clear the IRQ latch in the PIC for that
channel.  We perhaps want an unmask_ack() op.

David
