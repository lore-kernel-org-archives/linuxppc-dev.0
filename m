Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79D15DE2D3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 07:20:48 +1000 (EST)
Message-ID: <4835E3E3.4050004@freescale.com>
Date: Thu, 22 May 2008 16:21:39 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Suvidh Kankariya <suvidh.kankariya@ntigo.com>
Subject: Re: adding external interrupt support for MPC8313e bsp
References: <4835DA6E.2020709@ntigo.com>
In-Reply-To: <4835DA6E.2020709@ntigo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Suvidh Kankariya wrote:
> I have mpc8313e local bus connected to a external UART. and the 
> interrupt is connected to EXT_INT2.
> I am able to communicate to UART if I disable IRQ i.e IRQ = 0 in port 
> structure.
> 
> I am not able to understand how to tell kernel to use external IRQ -2.
> Should I put the external interrupts in device tree and if so how?

Yes, you should put them in the device tree in the interrupts property 
of the node corresponding to the device that is using the interrupt. 
The first cell should be 18 (decimal) for IRQ2 (see the IPIC section of 
the user manual for other external IRQs).  The second cell is defined 
the same as the PQ1/CPM2 PIC described in 
Documentation/booting-without-of.txt (2 for falling edge, 8 for active low).

> or can I use the interrupt directly in the driver  and in that case do I 
> need to map the interrupt.

Yes, if you don't put it in the device tree you need to call 
irq_create_mapping().  Using the device tree is recommended.

-Scott
