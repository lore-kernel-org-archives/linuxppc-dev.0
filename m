Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 1F80FDDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 03:42:31 +1100 (EST)
Received: by gxk1 with SMTP id 1so7639760gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 09:42:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49d0d82a.09038e0a.585d.348b@mx.google.com>
References: <49d0d82a.09038e0a.585d.348b@mx.google.com>
Date: Mon, 30 Mar 2009 10:42:30 -0600
Message-ID: <fa686aa40903300942l585cdbebt2546bb09738e6e32@mail.gmail.com>
Subject: Re: using IRQ1 in mpc5121ads
From: Grant Likely <grant.likely@secretlab.ca>
To: sylvain.louchez@g4apps.com
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 30, 2009 at 8:33 AM, sylvain louchez
<sylvain.louchez@gmail.com> wrote:
> Hello, I=92m a newbie looking for where the documentation and implementat=
ion
> model can be found=85
>
> My custom driver is looking for an interrupt notification from the kernel=
 -
> and it registers in the /proc/interrupts file as expected when installed,
> i.e.
>
> $insmod custom_driver.ko gps_irq=3D<n>

You don't want to do this with PowerPC.  There is no reliable way to
know what the IRQ number is at module load time.  Note that the IRQ
numbers listed in /proc/interrupts are *not* the same as the hardware
interrupt number.  /proc/interrupts on powerpc shows 'virtual IRQ'
numbers which are assigned dynamically as needed.  This is so that the
kernel can handle multiple cascaded IRQ controllers, each with
different hardware IRQ numbering schemes.

> 1. create an entry in the dts file; I think we've got this understood
> through advice already received - for example the new interrupt entry can=
 be
> created in the dts file - something like:
>
>
>
> gps@0 {=A0=A0=A0=A0=A0 // there is no address so just make it 0

There is no address so just make it "gps {", unless you have more than
one of them.

>
> =A0=A0=A0 compatible =3D "gps_interrupt";

Change this to: compatible =3D "<vendor>,<name-of-gps-device>";

Note that this node should describe the whole GPS device, not just IRQ
line for the GPS device.  Is this device addressable in any way?  Does
it have any memory mapped registers?  SPI?  I2C?

>
> =A0=A0=A0 interrupts =3D <17 0x8>;=A0=A0=A0=A0=A0=A0=A0=A0 // 17 is irq1,=
 8 is level low, see
> include/linux/irq.h for others
>
> =A0=A0=A0 interrupt-parent =3D < &ipic >;

This looks correct

> 2. but now we need to relate the actual interrupt to the virtual interrup=
t
> called in the driver... by invoking the function irq_of_parse_and_map - b=
ut
> we don't know how to do it - nor have we found how to do it in browsing
> through the open source documentation

You need to write an of_platform_driver which will bind against the
'compatible' property in your GPS node.

> A secondary question: where to properly add this function call in the fil=
e
> system?

Use of_register_platform_driver() to register your of_platform_driver
in your module's init function.

> Are we on the right track here? Is there sample/ tutorial code you could
> point us to?

Search for of_register_platform_driver() in the kernel source.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
