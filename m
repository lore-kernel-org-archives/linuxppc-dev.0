Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BE73DDEC6
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 21:56:23 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m4JBuHGf001300
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 13:56:18 +0200
Message-ID: <040b01c8b9a7$589c3b90$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <02f401c8b6a9$b1e062e0$ad289e86@LPSC0173W><20080515183910.6B40A75007E@mail106-va3.bigfish.com>
	<032c01c8b72d$0555cea0$ad289e86@LPSC0173W>
	<20080516161713.9DAAD708056@mail93-wa4.bigfish.com>
Subject: Re: Using GPIO
Date: Mon, 19 May 2008 13:56:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the answer,

> Dts files are not used with arch/ppc.
My question was more general, since arch/ppc will soon (?) disapear...

> In arch/ppc, the drivers that are in the system depend on the
> arch/ppc/platforms/4xx/xparameters/xparameters_ml405.h to setup the
> addresses of the devices and their configuration.
Yes, and I've taken care to define that.

> I looked at the ML405 setup in the git tree and it appears that it would
> need to be added to arch/ppc/syslib/virtex_devices.c. The platform data
> in virtex_devices.c must include the GPIO for it to be probed correctly.
> It should be easy for you to add the data to make it work.

Seems straightforward enough, but when I add the following:

// 0 is LEDS_4BIT, 1 is LEDS_POSITIONS, 2 is PUSH_BUTTONS_POSITION
#define XPAR_GPIO(num) { \
    .name = "xilinx_gpio", \
    .id = num, \
    .num_resources = 3, \
    .resource = (struct resource[]) { \
        { \
            .start = XPAR_GPIO_##num##_BASEADDR, \
            .end = XPAR_GPIO_##num##_HIGHADDR, \
            .flags = IORESOURCE_MEM, \
        }, \
        { \
            .start = XPAR_INTC_0_GPIO_##num##_VEC_ID, \
            .flags = IORESOURCE_IRQ, \
        }, \
    }, \
}
[...]
      /* GPIO instances */
#if defined(XPAR_GPIO_0_BASEADDR)
      XPAR_GPIO(0),
#endif
#if defined(XPAR_GPIO_1_BASEADDR)
      XPAR_GPIO(1),
#endif
#if defined(XPAR_GPIO_2_BASEADDR)
      XPAR_GPIO(2),
#endif

Then the boot stops right after "Uncompressing Linux...done.
Now booting the kernel"

I've probably overlooked something obvious, but I'm pretty new in putting my 
greasy fingers on delicate kernel internals...
In particular I don't know what is this .num_resources value.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
