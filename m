Return-Path: <xcarandiru@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 7DF91DDFA3
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 12:57:57 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so2680260ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 19:57:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d970ff420905281057kefbf339y29257154c142186a@mail.gmail.com>
References: <d970ff420905281057kefbf339y29257154c142186a@mail.gmail.com>
Date: Thu, 28 May 2009 23:57:55 -0300
Message-ID: <d970ff420905281957p69fba993ue7426f8413ec958f@mail.gmail.com>
Subject: Fwd: serial8250: too much work
From: Alemao <xcarandiru@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Im facing some problems with serial, getting flooded with this
message:

---
serial8250: too much work for irq16
---

Something I notice, in my .dts I have the following lines:

serial0: serial@4500, interrupts =3D <9 =A00x8>
serial1: serial@4600, interrupts =3D <10 0x8>
spi: =A0 =A0   spi@7000, =A0 =A0  interrupts =3D <16 0x8>

But when kernel starts:

---
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 16) is a 16550A
---

Why IRQ 16? Shouldn't it be IRQ 9?

I traced functions calls in 8250.c driver:

---
serial8250_interrup() -> serial8250_handle_port() -> transmit_chars()
---

"too much work" is for transmiting, but there's nothing to transmit.

In my MPC8343 board I have only serial0 connected to a MAX3232, serial1
is floating. Maybe some electromagnetic interference in the bus?

I found this comments in linux/drivers/serial/8250.h, and tried to use
same defines that they used, but no success:

/*
=A0* Digital did something really horribly wrong with the OUT1 and OUT2
=A0* lines on at least some ALPHA's. =A0The failure mode is that if either
=A0* is cleared, the machine locks up with endless interrupts.
=A0*/

/*
=A0* WindRiver did something similarly broken on their SBC8560 board. The
=A0* UART tristates its IRQ output while OUT2 is clear, but they pulled
=A0* the interrupt line _up_ instead of down, so if we register the IRQ
=A0* while the UART is in that state, we die in an IRQ storm.
=A0*/


I also tried removing serial1 and spi from .dts, but didn't work.

Any sugestions?

Cheers,

--
Alemao
