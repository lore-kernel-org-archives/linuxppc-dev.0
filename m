Return-Path: <strejc@unicontrols.cz>
Received: from posta.unicontrols.cz (94.113.242.66.static.b2b.upcbusiness.cz
 [94.113.242.66]) by ozlabs.org (Postfix) with ESMTP id 4687AB70D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 21:54:24 +1000 (EST)
Message-ID: <4F86BF84.1050107@unicontrols.cz>
Date: Thu, 12 Apr 2012 13:41:56 +0200
From: Cyril Strejc <strejc@unicontrols.cz>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: mpc5200b: invalid IRQ
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

I've just tried to boot 2.6.32, 3.0 and mainline kernel on my mpc5200b 
based board, on 3.0 and mainline resulting in

mpc52xx_irqhost_map: invalid irq: virq=16, l1=0, l2=3

The device tree is based on mpc5200b.dtsi, hence the invalid irq comes from

gpio_wkup: gpio@c00 {
      ...
      interrupts = <1 8 0 0 3 0>;
      ...
};

Being new in the kernel powerpc internals, I've found, that in the 
kernel 2.6.32 interrupts section has no generic meaning and specific 
device driver should handle it itself. Since commit 
ac80a51e2ce5c431de9997085f33cb6093218b1f (of/device: populate 
platform_device (of_device) resource table on allocation) interrupts 
section is handled by of_device_alloc and irq mapping is done regardless 
of specific device driver.

In 2.6.32, gpio_wkup interrupts section was unused in my case, so never 
had a problem. Since the commit, mpc5200-pic driver is asked to make a 
mapping during platform bus initialization resulting in the "invalid 
irq" error.

There are four critical interrupts on MPC5200b, but only IRQ[0] critical 
interrupt is handled by mpc5200-pic driver, the others, like WakeUp from 
deep-sleep mode (CCS) interrupt (my case) are not.

I do not need WakeUp interrupt and I think I can simply remove gpio_wkup 
interrupts section from the device tree, but I would like to ask you, 
what does it mean. If it is mpc5200-pic driver's incompleteness or some 
other error.

Thanks.

Cyril Strejc
