Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id B871F679E2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 20:40:43 +1000 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 7137C409A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 12:40:51 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Date: Wed, 11 May 2005 12:40:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200505111240.35425.david.jander@protonic.nl>
Subject: Status of isp116x driver... (on mpc8xx)?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I connected a Philips ISP1160 usb host controller to a MPC852T-based custom 
board. I am using CVS kernel from DENX. 
I added some stuff to hcd-1161.h and hcd-1161.c to support our hardware, and 
it seems to work at first.
The controller is recognized, initialized and everything seems fine, but when 
I connect a device to one of the two ports, every time the function 
fnvIsp1161AtlRead() is called, it reads in a 72 byte-long block of zeroes.
Then I get "not enough configurations..." (error=-22).
If I printk-out the contents of the buffer status register (REG_BUFF_STS) at 
that point, it is zero (=no data read).
Nevertheless, putting a scope on the physical USB wires, I can see quite some 
amount of non-zero data flying by.

Is the isp1160 chip really supported by the driver? tested?
Are access timings very critical? I see some ugly iodelay_hcd() calls here and 
there, are they necessary? why?

What about the other (older??) hc_isp116x.c driver floating around somewhere 
on the net, from Roman Weissgaerber? I found version 0.9.6 (apparently for 
kernel 2.4.22) somewhere, made some adaptations to get it loaded in our 
kernel but it either oopses after initializing the hc, or simply freezes.
Whats the relationship between this and the driver hacked by Wolfgang Denk?

Is someone using a isp116x on a mpc8xx and can tell his experience on getting 
it working?

Greetings,

-- 
David Jander
Protonic Holland.
