Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id A73CEDDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 03:32:19 +1100 (EST)
Received: by gxk1 with SMTP id 1so7623291gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 09:32:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9A8B45DD4DE17F4783430D784DA0B68811C41F9D9F@HEXMBVS12.hostedmsx.local>
References: <9A8B45DD4DE17F4783430D784DA0B68811C41F9D9F@HEXMBVS12.hostedmsx.local>
Date: Mon, 30 Mar 2009 10:32:17 -0600
Message-ID: <fa686aa40903300932p2c92110g2907bb7bf80d44d@mail.gmail.com>
Subject: Re: Interrupts on GPIO
From: Grant Likely <grant.likely@secretlab.ca>
To: Yann Pelletier <ypelletier@haivision.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 30, 2009 at 9:57 AM, Yann Pelletier
<ypelletier@haivision.com> wrote:
>
> Hi,
> I'd like to add supports for interrupts handling from GPIO controller. =
=A0Some of these interrupts are from I2C devices and some others are from S=
PI devices.
>
> What is the best approach to enable interrupts handling for those devices=
 through GPIO.

Modify the GPIO driver to also be a cascaded IRQ driver (see
http://patchwork.ozlabs.org/patch/21914/ for an example).

> Also,
>
> # cat /proc/interrupts
> =A0 =A0 =A0 =A0 =A0 CPU0
> =A016: =A0 =A0 =A0 =A0 60 =A0 IPIC =A0 Level =A0 =A0 serial
> =A017: =A0 =A0 =A0 =A0 =A00 =A0 IPIC =A0 Level =A0 =A0 fpga
> =A018: =A0 =A0 =A0 =A0 =A04 =A0 IPIC =A0 Level =A0 =A0 mpc83xx_spi
> =A021: =A0 =A0 =A0 =A0 =A00 =A0 IPIC =A0 Level =A0 =A0 i2c-mpc
> =A022: =A0 =A0 =A0 =A0 =A07 =A0 IPIC =A0 Level =A0 =A0 i2c-mpc
>
> According to my platform device tree, serial irq should be on int9, SPI o=
n int16 and i2c on int14,15. =A0This causes me some problems as I need int1=
8 to map to external IRQ2.

These numbers are *Linux internal* virtual irq numbers.  They have no
relation to the physical IRQ number for each interrupt controller.
Just make sure your Device Tree maps the IRQs correctly and you'll be
okay.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
