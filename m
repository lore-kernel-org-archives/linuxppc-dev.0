Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
 by ozlabs.org (Postfix) with ESMTP id DCF28B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 15:31:01 +1100 (EST)
Received: from edison.ad.selinc.com (edison.ad.selinc.com [10.100.0.15])
 by duster.selinc.com (8.14.4/8.14.4) with ESMTP id q0R4UvQj025628
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 20:30:57 -0800
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: Question about GPIO Lib
Message-ID: <OF2BD13139.450D178D-ON88257992.0018BB93-88257992.0018CFCA@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 26 Jan 2012 20:31:00 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(This time with a subject line, sorry)

Hi,

I'm using the 3.0.3 kernel on an MPC8308 and have turned on GPIO support 
(CONFIG_GPIOLIB = Y) because the SPI sub-system needed to use it for the 
GPIO pin I'm using as a CS to a NvRAM part.  I also have some jumpers on 
the processor GPIO pins and I thought it would be really slick to use the 
built in GPIO support in the kernel rather than roll my own driver to read 

five pins.  So I've got GPIO sysfs support turned on (CONFIG_GPIO_SYSFS = 
Y) and everything shows up in /sys/class/gpio and works as advertised. 
Really nice.

The problem is we've got a number of other things hooked up to the GPIO 
pins that it would be very bad if someone from user space played with 
them, like our FPGA configuration pin.  Some one toggles that and our box 
goes stupid.  So what I'm wondering is if there's a way, preferably via 
the device tree, to limit the GPIOs that GPIO Lib exposes to user space?

I tried the following in my device tree without success:

      gpio1: gpio@c00 {
         #gpio-cells = <2>;
         device_type = "gpio";
         compatible = "fsl,mpc8308-gpio", "fsl,mpc8349-gpio";
         reg = <0xc00 0x18>;
         interrupts = <74 0x8>;
         interrupt-parent = <&ipic>;
         gpio-controller;
         gpios = <&gpio1 0 0
                  &gpio1 1 0
                  &gpio1 2 0
                  &gpio1 3 0
                  &gpio1 4 0
                  &gpio1 5 0
                  &gpio1 6 0>;
      };

I also thought maybe a separate child node of the gpio1 node, but I think 
it would require a "compatible" attribute which would mean a driver to 
bind it to, and the whole point is to avoid writing a driver if someone 
else has already got something that will work.

Thanks.

Bruce
