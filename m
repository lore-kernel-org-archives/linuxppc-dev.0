Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by ozlabs.org (Postfix) with ESMTP id ACBD3DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Oct 2008 04:46:22 +1100 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so542561rvb.0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Oct 2008 10:46:21 -0700 (PDT)
Message-ID: <fa686aa40810231046k783099d2gddec1dbbede86b7@mail.gmail.com>
Date: Thu, 23 Oct 2008 11:46:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Bruno Monteiro" <bms.monteiro@gmail.com>
Subject: Re: Compile program using XGpio
In-Reply-To: <d43ae5a00810230958w147d810v363263ab55dc1550@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <d43ae5a00810210735k2e2068aew3e67e36bd079805@mail.gmail.com>
	<20081021200830.436214D8052@mail10-sin.bigfish.com>
	<d43ae5a00810230958w147d810v363263ab55dc1550@mail.gmail.com>
Cc: John Linn <John.Linn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 10:58 AM, Bruno Monteiro <bms.monteiro@gmail.com> wrote:
> Hi,
>
> I'm a new driver writer and i'm trying to understand how to deal with XGpio.
> My goal is writing a small piece of code that can turn leds on and off. I
> think this driver should do it:
>
>
> #include <linux/init.h>
> #include <linux/module.h>
>
> #include "xgpio.h"
> #include "xgpio_ioctl.h"
> #include "xparameters.h"
>
> XGpio led;
>
> static int myteste_init(void)
> {
>     XGpio_Initialize (&led, LEDs_4Bit);
>     XGpio_SetDataDirection(&led,1,0);
>     XGpio_DiscreteWrite(&led,1,0xf);
>     printk (KERN_ALERT "LEDS: Turn off\n");
>
>     return 0;
> }
>
> static int myteste_exit(void)
> {
>
>     XGpio_DiscreteWrite(&led,1,0x0);
>     printk (KERN_ALERT "LEDS: Turn on\n");
>     return 0;
> }
>
> module_init(myteste_init);
> module_exit(myteste_exit);
>
> But i have this error:
> ERROR: "XGpio_SetDataDirection" [drivers/char/mytest/mytest.ko] undefined!
> ERROR: "XGpio_Initialize" [drivers/char/mytest/mytest.ko] undefined!
> ERROR: "XGpio_DiscreteWrite" [drivers/char/mytest/mytest.ko] undefined!

None of the XGpio functions are available in Linux.  You need to use
the Linux kernel memory access functions instead (in_be32() and
out_be32()).

You also need to use the ioremap() function to map the physical
address of the GPIO block into a virtual address that the kernel can
use:

ie:
static int myteste_init(void)
{
    u32 __iomem *regs;

    regs = ioremap([address of GPIO block], 0x100);
    if (regs == NULL)
        return -ENOMEM;

    /* configure as output */
    out_be32(regs + 4, 0);
    /* turn on leds */
    out_be32(regs, 0);
    printk (KERN_ALERT "LEDS: Turn on\n");
    return 0;
}

This is just a simple example though.  You should follow the pattern
of other device drivers and bind against the of_platform_bus so your
device can be described in the device tree (.dts) file.

Or, better yet, use the existing driver from the Xilinx linux-2.6 git tree.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
