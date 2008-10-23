Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE004.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id C12B6474C2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Oct 2008 04:58:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Compile program using XGpio
Date: Thu, 23 Oct 2008 11:58:19 -0600
In-Reply-To: <fa686aa40810231046k783099d2gddec1dbbede86b7@mail.gmail.com>
References: <d43ae5a00810210735k2e2068aew3e67e36bd079805@mail.gmail.com>
	<20081021200830.436214D8052@mail10-sin.bigfish.com>
	<d43ae5a00810230958w147d810v363263ab55dc1550@mail.gmail.com>
	<fa686aa40810231046k783099d2gddec1dbbede86b7@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Bruno Monteiro" <bms.monteiro@gmail.com>
Message-ID: <20081023175821.581F5BE808F@mail197-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Bruno,

If you're needing a GPIO driver (not wanting to write one) we have one
in the development branch of our GIT tree that's working.  This is
arch/powerpc only, no arch/ppc.

You could use it for turning LEDS on as I just tested it and updated the
wiki to show how to use it from user space.  There is also an LED driver
that is in the kernel that sits on top of a GPIO driver specifically for
LEDs.

http://xilinx.wikidot.com/osl-gpio-driver

Thanks,
John

> -----Original Message-----
> From: Grant Likely [mailto:grant.likely@secretlab.ca]
> Sent: Thursday, October 23, 2008 11:46 AM
> To: Bruno Monteiro
> Cc: John Linn; linuxppc-embedded@ozlabs.org
> Subject: Re: Compile program using XGpio
> =

> On Thu, Oct 23, 2008 at 10:58 AM, Bruno Monteiro
<bms.monteiro@gmail.com> wrote:
> > Hi,
> >
> > I'm a new driver writer and i'm trying to understand how to deal
with XGpio.
> > My goal is writing a small piece of code that can turn leds on and
off. I
> > think this driver should do it:
> >
> >
> > #include <linux/init.h>
> > #include <linux/module.h>
> >
> > #include "xgpio.h"
> > #include "xgpio_ioctl.h"
> > #include "xparameters.h"
> >
> > XGpio led;
> >
> > static int myteste_init(void)
> > {
> >     XGpio_Initialize (&led, LEDs_4Bit);
> >     XGpio_SetDataDirection(&led,1,0);
> >     XGpio_DiscreteWrite(&led,1,0xf);
> >     printk (KERN_ALERT "LEDS: Turn off\n");
> >
> >     return 0;
> > }
> >
> > static int myteste_exit(void)
> > {
> >
> >     XGpio_DiscreteWrite(&led,1,0x0);
> >     printk (KERN_ALERT "LEDS: Turn on\n");
> >     return 0;
> > }
> >
> > module_init(myteste_init);
> > module_exit(myteste_exit);
> >
> > But i have this error:
> > ERROR: "XGpio_SetDataDirection" [drivers/char/mytest/mytest.ko]
undefined!
> > ERROR: "XGpio_Initialize" [drivers/char/mytest/mytest.ko] undefined!
> > ERROR: "XGpio_DiscreteWrite" [drivers/char/mytest/mytest.ko]
undefined!
> =

> None of the XGpio functions are available in Linux.  You need to use
> the Linux kernel memory access functions instead (in_be32() and
> out_be32()).
> =

> You also need to use the ioremap() function to map the physical
> address of the GPIO block into a virtual address that the kernel can
> use:
> =

> ie:
> static int myteste_init(void)
> {
>     u32 __iomem *regs;
> =

>     regs =3D ioremap([address of GPIO block], 0x100);
>     if (regs =3D=3D NULL)
>         return -ENOMEM;
> =

>     /* configure as output */
>     out_be32(regs + 4, 0);
>     /* turn on leds */
>     out_be32(regs, 0);
>     printk (KERN_ALERT "LEDS: Turn on\n");
>     return 0;
> }
> =

> This is just a simple example though.  You should follow the pattern
> of other device drivers and bind against the of_platform_bus so your
> device can be described in the device tree (.dts) file.
> =

> Or, better yet, use the existing driver from the Xilinx linux-2.6 git
tree.
> =

> g.
> =

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
