Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <4A16BAAE.3070401@grandegger.com>
References: <4A16BAAE.3070401@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 22 May 2009 09:08:27 -0600
Message-ID: <fa686aa40905220808kecd06cdqb570b78ca97f0ca6@mail.gmail.com>
Subject: Re: [net-next-2.6 PATCH v2] can: SJA1000: generic OF platform bus
	driver
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux Netdev List <netdev@vger.kernel.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfgang, thanks for the quick response.  Comments below...

On Fri, May 22, 2009 at 8:46 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> +++ net-next-2.6/Documentation/powerpc/dts-bindings/can/sja1000.txt
> @@ -0,0 +1,37 @@
> +Memory mapped SJA1000 CAN controller from NXP (formerly Philips)
> +
> +Required properties:
> +
> +- compatible : should be "nxp,sja1000".
> +- reg : should specify the chip select, address offset and size used
> + =A0 =A0 =A0 for the chip depending on the bus it is connected to.
> +- interrupts: property with a value describing the interrupt source
> + =A0 =A0 =A0 (number and sensitivity) for that device. The encoding depe=
nds
> + =A0 =A0 =A0 on the type of interrupt controller used.

Hmmm, "reg", "interrupts", and "interrupt-parent" are well understood
properties.  I don't think we need to keep boilerplate defining the
meaning every time a new binding is added.  (general musing; not an
ack or nack of this patch)

However, what should be defined is *what* the register range is (ie.
one tuple; location of device registers), and what the interrupts are
(ie. single tuple for device's irq line).  Granted this is a trivial
case, but in the case of devices with more than one address range or
irq line, the meaning of each tuple is critical information.  I think
it would be a good pattern to establish.

> +Optional properties:
> +
> +- interrupt-parent : the phandle for the interrupt controller that
> + =A0 =A0 =A0 services interrupts for that device.

Thinking further; I wouldn't even mention "interrupt-parent" here.
Anyone working with this stuff must already understand irq routing.

> +- clock-frequency : CAN system clock frequency in Hz, which is normally
> + =A0 =A0 =A0 half of the oscillator clock frequency. If not specified, a
> + =A0 =A0 =A0 default value of 8000000 (8 MHz) is used.

A clock-frequency property typically refers to the bus clock
frequency.  Something like can-frequency would be better.

> +- cdr-reg : value of the SJA1000 clock divider register according to
> + =A0 =A0 =A0 the SJA1000 data sheet. If not specified, a default value o=
f
> + =A0 =A0 =A0 0x48 is used.

Ewh.  The driver should be clueful enough to derive the clock divider
value given both the bus and can frequencies.  I don't like this
property.

> +- ocr-reg : value of the SJA1000 output control register according to
> + =A0 =A0 =A0 the SJA1000 data sheet. If not specified, a default value o=
f
> + =A0 =A0 =A0 0x0a is used.

Ditto here; the binding should describe the usage mode; not the
register settings to get the usage mode.  What sort of settings will
the .dts author be writing here?

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
