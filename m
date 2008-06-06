Return-Path: <ludovic.desroches@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id E9372DDF8D
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 17:51:39 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so998063rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Jun 2008 00:51:38 -0700 (PDT)
Message-ID: <388e90610806060051w6826b028h464cd5bc321f75fe@mail.gmail.com>
Date: Fri, 6 Jun 2008 09:51:37 +0200
From: "Ludovic Desroches" <ludovic.desroches@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Using GPIO
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5100_22927129.1212738697880"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_5100_22927129.1212738697880
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am also trying to use Xilinx GPIO driver on my board but I encounter some
problems. I thought they will be resolved with this information but it
doesn't.

I use GPIO driver as built-in but during kernel boot but I don't see log
about it contrary to Xemac driver for instance. First I wanted to create my
gpio driver normally without using Xilinx one, with ioremap and writel/readl
but I didn't write anything in the register, I don't know why. Then I tried
to use Xilinx GPIO driver but I don't know why I don't hit xgpio_probe,
xgpio_init returns 0 so it's OK.

Do you have any idea ?

Thanks

Ludovic Desroches


> arch/ppc/syslib/virtex_devices.c:
>
> >* // 0 is LEDS_4BIT, 1 is LEDS_POSITIONS, 2 is PUSH_BUTTONS_POSITION
> *>* #define XPAR_GPIO(num) { \
> *>*    .name = "xilinx_gpio", \
> *>*    .id = num, \
> *>*    .num_resources = 2, \
> *That was a 2.
> If anybody wants to make a patch out of those few lines of code, I couldn't
> figure out how to do this with git... But I will use a more general GPIO
> approach as soon as I can put my hands on our custom card.
>
> >*    .resource = (struct resource[]) { \
> *>*        { \
> *>*            .start = XPAR_GPIO_##num##_BASEADDR, \
> *>*            .end = XPAR_GPIO_##num##_HIGHADDR, \
> *>*            .flags = IORESOURCE_MEM, \
> *>*        }, \
> *>*        { \
> *>*            .start = XPAR_INTC_0_GPIO_##num##_VEC_ID, \
> *>*            .flags = IORESOURCE_IRQ, \
> *>*        }, \
> *>*    }, \
> *>* }
> *>* [...]
> *>*      /* GPIO instances */
> *>* #if defined(XPAR_GPIO_0_BASEADDR)
> *>*      XPAR_GPIO(0),
> *>* #endif
> *>* #if defined(XPAR_GPIO_1_BASEADDR)
> *>*      XPAR_GPIO(1),
> *>* #endif
> *>* #if defined(XPAR_GPIO_2_BASEADDR)
> *>*      XPAR_GPIO(2),
> *>* #endif
> *
>
>

------=_Part_5100_22927129.1212738697880
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,<br><br>I am also trying to use Xilinx GPIO driver on my board but I encounter some problems. I thought they will be resolved with this information but it doesn&#39;t.<br><br>I use GPIO driver as built-in but during kernel boot but I don&#39;t see log about it contrary to Xemac driver for instance. First I wanted to create my gpio driver normally without using Xilinx one, with ioremap and writel/readl but I didn&#39;t write anything in the register, I don&#39;t know why. Then I tried to use Xilinx GPIO driver but I don&#39;t know why I don&#39;t hit xgpio_probe, xgpio_init returns 0 so it&#39;s OK.<br>
<br>Do you have any idea ?<br><br>Thanks<br><br>Ludovic Desroches<br>&nbsp;</div><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote"><pre>arch/ppc/syslib/virtex_devices.c:<br>
<br>&gt;<i> // 0 is LEDS_4BIT, 1 is LEDS_POSITIONS, 2 is PUSH_BUTTONS_POSITION<br></i>&gt;<i> #define XPAR_GPIO(num) { \<br></i>&gt;<i>    .name = &quot;xilinx_gpio&quot;, \<br></i>&gt;<i>    .id = num, \<br></i>&gt;<i>    .num_resources = 2, \<br>
</i>That was a 2.<br>If anybody wants to make a patch out of those few lines of code, I couldn&#39;t <br>figure out how to do this with git... But I will use a more general GPIO <br>approach as soon as I can put my hands on our custom card.<br>
<br>&gt;<i>    .resource = (struct resource[]) { \<br></i>&gt;<i>        { \<br></i>&gt;<i>            .start = XPAR_GPIO_##num##_BASEADDR, \<br></i>&gt;<i>            .end = XPAR_GPIO_##num##_HIGHADDR, \<br></i>&gt;<i>            .flags = IORESOURCE_MEM, \<br>
</i>&gt;<i>        }, \<br></i>&gt;<i>        { \<br></i>&gt;<i>            .start = XPAR_INTC_0_GPIO_##num##_VEC_ID, \<br></i>&gt;<i>            .flags = IORESOURCE_IRQ, \<br></i>&gt;<i>        }, \<br></i>&gt;<i>    }, \<br>
</i>&gt;<i> }<br></i>&gt;<i> [...]<br></i>&gt;<i>      /* GPIO instances */<br></i>&gt;<i> #if defined(XPAR_GPIO_0_BASEADDR)<br></i>&gt;<i>      XPAR_GPIO(0),<br></i>&gt;<i> #endif<br></i>&gt;<i> #if defined(XPAR_GPIO_1_BASEADDR)<br>
</i>&gt;<i>      XPAR_GPIO(1),<br></i>&gt;<i> #endif<br></i>&gt;<i> #if defined(XPAR_GPIO_2_BASEADDR)<br></i>&gt;<i>      XPAR_GPIO(2),<br></i>&gt;<i> #endif<br></i></pre></blockquote><br clear="all"><br>

------=_Part_5100_22927129.1212738697880--
