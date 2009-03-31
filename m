Return-Path: <ypelletier@haivision.com>
Received: from mx11.exchange.telus.com (mx11.exchange.telus.com
	[216.123.224.145]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "mx11.exchange.telus.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA407DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 07:59:37 +1100 (EST)
From: Yann Pelletier <ypelletier@haivision.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Tue, 31 Mar 2009 14:59:33 -0600
Subject: RE:  Interrupts on GPIO
Message-ID: <9A8B45DD4DE17F4783430D784DA0B68811C429F9B7@HEXMBVS12.hostedmsx.local>
In-Reply-To: <mailman.3884.1238431353.26545.linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Message: 7
> Date: Mon, 30 Mar 2009 10:32:17 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> Subject: > To: Yann Pelletier <ypelletier@haivision.com>
> Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
> Message-ID:
> 	<fa686aa40903300932p2c92110g2907bb7bf80d44d@mail.gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1
>=20
> On Mon, Mar 30, 2009 at 9:57 AM, Yann Pelletier
> <ypelletier@haivision.com> wrote:
> >
> > Hi,
> > I'd like to add supports for interrupts handling from GPIO controller.
> ?Some of these interrupts are from I2C devices and some others are from
> SPI devices.
> >
> > What is the best approach to enable interrupts handling for those
> devices through GPIO.
>=20
> Modify the GPIO driver to also be a cascaded IRQ driver (see
> http://patchwork.ozlabs.org/patch/21914/ for an example).
>=20

I've looked at the patch but I wonder if this would be applicable to the MP=
C8313.  If my understanding is good, in the MPC52xx you have 8 gpio only in=
terrupts and 8 gpio/gpt.  With the MPC8313, each GPIO can act as an interru=
pt but they are all muxed to only 1 interrupt in the IPIC.  So I'm concern =
about making the GPIO controller act as an interrupt controller.



> > Also,
> >
> > # cat /proc/interrupts
> > ? ? ? ? ? CPU0
> > ?16: ? ? ? ? 60 ? IPIC ? Level ? ? serial
> > ?17: ? ? ? ? ?0 ? IPIC ? Level ? ? fpga
> > ?18: ? ? ? ? ?4 ? IPIC ? Level ? ? mpc83xx_spi
> > ?21: ? ? ? ? ?0 ? IPIC ? Level ? ? i2c-mpc
> > ?22: ? ? ? ? ?7 ? IPIC ? Level ? ? i2c-mpc
> >
> > According to my platform device tree, serial irq should be on int9, SPI
> on int16 and i2c on int14,15. ?This causes me some problems as I need
> int18 to map to external IRQ2.
>=20
> These numbers are *Linux internal* virtual irq numbers.  They have no
> relation to the physical IRQ number for each interrupt controller.
> Just make sure your Device Tree maps the IRQs correctly and you'll be
> okay.
>=20

This is good now, thanks

> g.
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>=20
>=20
