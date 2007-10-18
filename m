Return-Path: <alan@akb.net>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 4B71FDDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:41:37 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id d23so31102and
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 07:41:36 -0700 (PDT)
Message-ID: <bfa0697f0710180741i5063ad94ga13086bf3c43a511@mail.gmail.com>
Date: Thu, 18 Oct 2007 08:41:35 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: linuxppc-dev@ozlabs.org
Subject: Freescale Interrupt enabling
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We were developing with Linux 2.6.10 and a Planetcore boot loader,
however, recent work has us up and running with 2.6.23+ and U-boot
1.2.0.  However, we are now running into a few challenges regarding
the differences.

Our driver writer's code isn't functioning, but it was with 2.6.10 and
planet core.  The best I can tell is that the default interrupt
controller configuration isn't where it was in the planetcore/2.6.10
version.

for example, let's look at enabling timer1 / interrupt number 12

simple description.
	       timer1 {
	 	       name = "timer1";
 		       compatible = "fsl,mpc8248_timer";
		       interrupts = <c 8>;
		       interrupt-parent = <&PIC>;

What should be done to consume the above description in the device
tree, program the SIU and configure the irq for request?  I'm looking
through the existing drivers to get a feel, but both the enets and the
uarts are overly complex for the simple task of enabling a timer, as
our driver code already works with the irq on other linux
kernels/bootloaders.

-Alan
