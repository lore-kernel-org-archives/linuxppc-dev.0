Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 5C05167A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 19:57:26 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k5LA8GQt020629 for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 03:08:16 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5L9vNiv008719
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 04:57:24 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD958@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: "'Laurent Pinchart'" <laurent.pinchart@tbox.biz>,
	linuxppc-embedded@ozlabs.org
Subject: RE: Adding an external interrupt controller
Date: Wed, 21 Jun 2006 17:57:21 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> Hi everybody,
> 
> I'm trying to write a driver for a custom extension bus 
> mapped in my MPC8248 
> memory space.
> 
> The bus has 32 interrupt lines which are handled by an 
> interrupt controller 
> connected to a single external interrupt on the MPC8248.
> 
> I've had a look at the Linux interrupt management code, but 
> haven't found any 
> easy API to add an external interrupt controller. Could 

No, the linux kernel has this feature.

> someone give me a few 
> pointers regarding how to proceed ? I would like to 
> "register" the interrupt 
> controller with the interrupt management core, so that 
> request_irq()/free_irq() could be used with the extra interrupts.
> 
Need define the struct hw_interrupt_type <your_interrupt_controller>
and the struct irqaction <your_irqaction>, and 
implement member function and hook your interrupt controller to
The interrupt controller of MPC8248 with setup_irq.

-Dave
