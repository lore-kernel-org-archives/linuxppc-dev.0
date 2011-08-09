Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5F00B6F67
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2011 18:14:44 +1000 (EST)
Message-ID: <4E40EC6F.30601@embedded-sol.com>
Date: Tue, 09 Aug 2011 11:14:39 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"jacmet@sunsite.dk" <jacmet@sunsite.dk>, grant.likely@secretlab.ca
Subject: GPIO IRQ dts bindings for MPC85xx and QorIQ
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

DTS bindings document for mpc8xxx GPIOs implies that to use GPIO as IRQ
one should specify GPIO controller node and GPIO number in device tree 
node,
like this:

     funkyfpga@0 {
         compatible = "funky-fpga";
         ...
         interrupts = <9 2>;
         interrupt-parent = <&gpio2>;
     };

I suppose the intention here is to do the following in driver code:

int irq;
struct device node *np;

np = of_find_compatible_node((NULL, NULL, "funky-fpga");
irq = irq_of_parse_and_map(np, 0);
request_irq(irq, ...);

However this doesn't work as expected.  The resulting virq
is connected to real interrupt controller, mpic, and not to
GPIO controller. As a result, interrupt handler is never invoked.

This is what /proc/interrupts shows:

  20:          0    OpenPIC         Edge         funky-fpga


On the other hand, when using

#define FPGA_IRQ_GPIO    169

request_gpio(FPGA_IRQ_GPIO);
gpio_direction_input(FPGA_IRQ_GPIO);
irq = gpio_to_irq(FPGA_IRQ_GPIO);
request_irq(irq, ...);

the connection to GPIO controller is created properly,
/proc/interrupts shows

20:          0    mpc8xxx_gpio         Edge         funky-fpga

The drawback of this approach is that GPIO IRQ cannot
be naturally specified in device tree by GPIO controller number
and GPIO pin number.

So what is the correct way to refer to 85XX GPIO IRQs in driver
code ?

Thanks.

Felix.
