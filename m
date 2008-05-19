Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E3A0DDF35
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 01:23:17 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m4JFNCZr009177
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 17:23:12 +0200
Message-ID: <044e01c8b9c4$409208a0$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Re: Using GPIO
Date: Mon, 19 May 2008 17:23:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/ppc/syslib/virtex_devices.c:

> // 0 is LEDS_4BIT, 1 is LEDS_POSITIONS, 2 is PUSH_BUTTONS_POSITION
> #define XPAR_GPIO(num) { \
>    .name = "xilinx_gpio", \
>    .id = num, \
>    .num_resources = 2, \
That was a 2.
If anybody wants to make a patch out of those few lines of code, I couldn't 
figure out how to do this with git... But I will use a more general GPIO 
approach as soon as I can put my hands on our custom card.

>    .resource = (struct resource[]) { \
>        { \
>            .start = XPAR_GPIO_##num##_BASEADDR, \
>            .end = XPAR_GPIO_##num##_HIGHADDR, \
>            .flags = IORESOURCE_MEM, \
>        }, \
>        { \
>            .start = XPAR_INTC_0_GPIO_##num##_VEC_ID, \
>            .flags = IORESOURCE_IRQ, \
>        }, \
>    }, \
> }
> [...]
>      /* GPIO instances */
> #if defined(XPAR_GPIO_0_BASEADDR)
>      XPAR_GPIO(0),
> #endif
> #if defined(XPAR_GPIO_1_BASEADDR)
>      XPAR_GPIO(1),
> #endif
> #if defined(XPAR_GPIO_2_BASEADDR)
>      XPAR_GPIO(2),
> #endif

-- 
Guillaume Dargaud
http://www.gdargaud.net/
