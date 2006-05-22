Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F03E67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 00:11:36 +1000 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4MEBOc6004678
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 May 2006 16:11:24 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4MEBJWt004597
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 May 2006 16:11:19 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: SCC1 as serial console
Date: Mon, 22 May 2006 16:12:53 +0200
References: <e65a39032a7d4cdbbf87ecc1daa271cd@pobox.sk>
In-Reply-To: <e65a39032a7d4cdbbf87ecc1daa271cd@pobox.sk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605221612.53452.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ladislav,

> can anybody help me to setup the SCC1 port as serial console on MPC860 with
> kernel 2.6.15.4? I would like to use it as system console during the
> booting proccess. I can not get any output on serial console during booting
> proccess, I use uboot.

Does SCC1 work correctly in U-Boot ? If not, you should fix that first. I'll 
assume it does.

There are many issues which could lead to a silent serial console. The serial 
port could be misconfigured, or the kernel could crash for another reason 
before the serial port is initialized.

Have you been able to get a serial console on another serial port (SMC) ? Are 
the clock frequencies computed by U-Boot and passed to the Linux kernel 
correct ?

Do you have a hardware debugger (BDI2000) that you can connect to the 
processor to see if Linux crashes before initializing the serial port ? If 
not, you will probably have to take a try at led-debugging (make some leds 
blink at various point in the Linux kernel to try to find out what happens), 
but that's really no fun.

Laurent Pinchart
