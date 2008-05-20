Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id 20E2ADDF41
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 10:45:27 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC] GPIO-based flow control in the cpm_uart driver
Date: Mon, 19 May 2008 17:25:16 -0700
References: <200804151522.36884.laurentp@cse-semaphore.com>
In-Reply-To: <200804151522.36884.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805191725.16768.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 April 2008, Laurent Pinchart wrote:
> I'm implementing flow control and modem control lines support in the
> cpm_uart driver.
>
> The implementation is based on the GPIO lib. Modem control lines are
> described in the device tree as GPIO resources and accessed through the OF
> GPIO bindings. The I/O ports have to be initialized as GPIOs in the
> platform-specific code.

I don't follow the "have to be" ... why couldn't the platform
setup code know that if a given UART is being used with hardware
handshaking, that means a particular pin mux config should be used?

Are there maybe some on-chip routing options, so that for example
RTS2 could come out on any of three different balls?  (In which
case that setup code could just be told *which* config to use...)

In this case I'm asking specifically about the normal all-works-ok
situation ... no errata or similar complications I mention below.


>  An option would be to export gpio_to_chip from drivers/gpio/gpiolib.c
>  and use cpm1/2_set_pin in the cpm_uart driver.

Help me to understand this a bit.  UARTs are a fair example of places
where I've seen such pin reconfiguration be useful, but it's never
seemed to be generalizable except possibly as callbacks to SOC-specific
code (which don't imply updating generic programming interfaces).


I've seen examples where the hardware flow control normally works, so
that board setup sets up those pins in "hardware flow control" mode
when it's told the board has them wired up that way ... but then, some
chip revisions have errata forcing the driver to use a particular
port's handshake pins as GPIOs in some cases.  (Obviously troublesome
except at low data rates, so one hopes the board designers just avoid
using those UARTs in that mode.)

I've also seen examples where the UART clock needs to be disabled in
deeper sleep states, but the system still wants the UART to be a wake
event source ... by having either the START bit, or maybe BREAK (it
gives a longer latch period), kick in a gpio-based pin change IRQ on
the UARTn.RX line.


Now in *both* of those examples I've seen before, the solution could
not be generic.  When the pin was used as GPIO, a particular pinmux
configuration was needed.  (Bitfield X of register Y has value Z ...
or maybe a couple registers needed to change.)  And when used as a
UART signal, a different one was used.  (Same setup.  Maybe value Z
became value W.  Or again, maybe a few registers needed changing.)

And for different chips in the family, sometimes even different
revisions of one chip, the W/X/Y/Z/etc values differed even for UART1.
For other UARTs, the same was true.


So given that ... how would knowing the GPIO chip help, when I'd
still need to find out the W/X/Y/Z/etc values?  And if I've got a
way to convey W/X/Y/Z/etc -- canonical example being a callback to
the relevant SOC-specific code --  why shouldn't that obviate the
need for any scheme to look up the gpio chip?

- Dave
