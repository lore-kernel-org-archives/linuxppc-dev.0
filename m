Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 114A9B6F7C
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jul 2011 20:38:24 +1000 (EST)
Message-ID: <4E35309E.4000202@embedded-sol.com>
Date: Sun, 31 Jul 2011 13:38:22 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	jacmet@sunsite.dk, Tabi Timur-B04825 <B04825@freescale.com>
Subject: GPIO IRQ on P1022
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm running kernel 3.0 on a custom board based on Freescale P1022.
The interrupt line of on-board FPGA is connected to GPIO2_9. FPGA
IRQ is level, active low. The GPIOs are mapped like this:

GPIOs 160-191, /soc@ffe00000/gpio-controller@f200:

GPIOs 192-223, /soc@ffe00000/gpio-controller@f100:

GPIOs 224-255, /soc@ffe00000/gpio-controller@f000:

I've verified that pin mixing is done correctly, and the
FPGA IRQ line is indeed configured as GPIO.

I have the following code in my driver:

     #define FPGA_IRQ_GPIO 169

     err = gpio_request(FPGA_IRQ_GPIO, "FPGA IRQ");
     if (err) {
         printk(KERN_ERR "Failed to request FPGA IRQ GPIO, err=%d\n", 
err);
         goto out;
     }

     gpio_direction_input(FPGA_IRQ_GPIO);

     irq = gpio_to_irq(FPGA_IRQ_GPIO);
     if (irq < 0) {
         printk(KERN_ERR "Failed to map FPGA GPIO to IRQ\n");
         goto out;
     }

     err = request_irq(irq, gsat_interrupt,
               IRQF_TRIGGER_FALLING, DRVNAME, priv);

     Interrupt handler reads FPGA interrupt status register to clear 
interrupt
     and exits.

     What happens when I load my driver is single execution of 
interrupt handler
     followed by system freeze. Even if I call disable_irq() in 
interrupt handler the
     system still freezes.

     I've added some prints to mpc8xxx_gpio.c driver, here's what I get:

     mpc8xxx_gpio_to_irq: offset 9
     mpc8xxx_gpio_irq_map: virq 31
     irq: irq 9 on host /soc@ffe00000/gpio-controller@f200 mapped to 
virtual irq 31
     mpc8xxx_irq_set_type: virq 9 flow_type 2
     mpc8xxx_irq_unmask: irq 9
     mpc8xxx_gpio_irq_cascade: irq 47
     mpc8xxx_irq_mask: irq 9
     mpc8xxx_irq_ack: irq 9


What am I doing wrong ?

Thanks a lot.

Felix.
