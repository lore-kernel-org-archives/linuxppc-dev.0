Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF350DDE38
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 04:36:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: IRQ questions & puzzles
Date: Thu, 26 Apr 2007 11:36:09 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1EB@MERCURY.inside.istor.com>
In-Reply-To: <30f6090e0704260910y383ace08g30a7b6899d86ed7e@mail.gmail.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a linux-2.6.17.11 source tree that has configs for two boards.
One has an 8241 and the other has an 8541. The kernel code works fine on
the 8241, but appears to lock up in my custom driver in the 8541 when
interrupts are enabled.

What I see happening, based on using a BDI to go/halt after the apparent
lockup is that the kernel is spinning around in routines like
kernel/irq/handle.c:__do_IRQ and an associated
arch/powerpc/kernel/irq.c.

It looks like the interrupt, which should be level triggered and at this
point, is probably continuously asserted is causing the kernel to spin
in a tight loop and be incapable of doing printk's out the serial port
at 115200.

This leads to a few questions:

1. I can see most everything comes from arch/ppc, but do_IRQ comes from
arch/powerpc. Is that OK?

2. What is the most straightforward way to slow down a tight loop like
this slow enough so I can printk what is happening.

3. What might be the likely scenarios leading to such a despicable
state.

Charles Krinke
