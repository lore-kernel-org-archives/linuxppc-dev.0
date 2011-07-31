Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BC36AB6F98
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Aug 2011 01:19:38 +1000 (EST)
Message-ID: <4E357285.8080708@grandegger.com>
Date: Sun, 31 Jul 2011 17:19:33 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: GPIO IRQ on P1022
References: <4E35309E.4000202@embedded-sol.com>
In-Reply-To: <4E35309E.4000202@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/31/2011 12:38 PM, Felix Radensky wrote:
> Hi,
> 
> I'm running kernel 3.0 on a custom board based on Freescale P1022.
> The interrupt line of on-board FPGA is connected to GPIO2_9. FPGA
> IRQ is level, active low. The GPIOs are mapped like this:
> 
> GPIOs 160-191, /soc@ffe00000/gpio-controller@f200:
> 
> GPIOs 192-223, /soc@ffe00000/gpio-controller@f100:
> 
> GPIOs 224-255, /soc@ffe00000/gpio-controller@f000:
> 
> I've verified that pin mixing is done correctly, and the
> FPGA IRQ line is indeed configured as GPIO.
> 
> I have the following code in my driver:
> 
>     #define FPGA_IRQ_GPIO 169
> 
>     err = gpio_request(FPGA_IRQ_GPIO, "FPGA IRQ");
>     if (err) {
>         printk(KERN_ERR "Failed to request FPGA IRQ GPIO, err=%d\n", err);
>         goto out;
>     }
> 
>     gpio_direction_input(FPGA_IRQ_GPIO);
> 
>     irq = gpio_to_irq(FPGA_IRQ_GPIO);
>     if (irq < 0) {
>         printk(KERN_ERR "Failed to map FPGA GPIO to IRQ\n");
>         goto out;
>     }
> 
>     err = request_irq(irq, gsat_interrupt,
>               IRQF_TRIGGER_FALLING, DRVNAME, priv);
> 
>     Interrupt handler reads FPGA interrupt status register to clear
> interrupt
>     and exits.
> 
>     What happens when I load my driver is single execution of interrupt
> handler
>     followed by system freeze. Even if I call disable_irq() in interrupt
> handler the
>     system still freezes.

Try disable_irq_nosync() instead.

Wolfgang.
