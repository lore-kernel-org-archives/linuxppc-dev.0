Return-Path: <xcarandiru@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id D2DE9DDF91
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 06:07:08 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2832508yxb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 13:07:06 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 29 May 2009 17:07:06 -0300
Message-ID: <d970ff420905291307p62e9c6eck772e7ee3757ee44a@mail.gmail.com>
Subject: MPC8343 - serial8250: too much work
From: Alemao <xcarandiru@gmail.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Im facing some problems with serial, linux-2.6.23, getting flooded
with this message in logs:

---
serial8250: too much work for irq16
---

Something I notice, in my .dts I have the following lines:

serial0: serial@4500,  interrupts   =  <9  0x8>
serial1: serial@4600,  interrupts   =  <10 0x8>
spi:       spi@7000,     interrupts   =  <16 0x8>


But when kernel starts:

---
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
---

Why IRQ 16? Shouldn't it be IRQ 9?

I traced functions calls in 8250.c driver:

---
serial8250_interrup() -> serial8250_handle_port() -> transmit_chars()
---

"too much work" is for transmiting, but there's nothing to transmit.

In my MPC8343 board I have only serial0 connected to a MAX3232, serial1
is floating.

I found this comments in linux/drivers/serial/8250.h, and tried to use
same defines that they used, but no success:

/*
 * Digital did something really horribly wrong with the OUT1 and OUT2
 * lines on at least some ALPHA's.  The failure mode is that if either
 * is cleared, the machine locks up with endless interrupts.
 */

/*
 * WindRiver did something similarly broken on their SBC8560 board. The
 * UART tristates its IRQ output while OUT2 is clear, but they pulled
 * the interrupt line _up_ instead of down, so if we register the IRQ
 * while the UART is in that state, we die in an IRQ storm.
 */


I also tried removing serial1 and spi from .dts, but didn't work.

Any sugestions?

Cheers,

--
Alemao
