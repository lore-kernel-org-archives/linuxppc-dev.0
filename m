Return-Path: <boris@fabiotec.com>
Received: from mtaout1.barak.net.il (mtaout1.barak.net.il [212.150.49.171])
	by ozlabs.org (Postfix) with ESMTP id 77E74679E0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Aug 2006 08:55:41 +1000 (EST)
Received: from [192.168.0.80] ([87.69.25.78])
	by mtaout1.barak.net.il (Sun Java System Messaging Server 6.2-6.02
	(built Apr
	25 2006)) with ESMTPA id <0J4000AW6EAJP5P0@mtaout1.barak.net.il> for
	linuxppc-embedded@ozlabs.org; Tue, 15 Aug 2006 01:25:32 +0300 (IDT)
Date: Tue, 15 Aug 2006 01:25:31 +0300
From: Boris Shteinbock <boris@fabiotec.com>
Subject: 8260  SMC1 and SMC2 serial port problems
To: linuxppc-embedded@ozlabs.org
Message-id: <44E0F85B.6000205@fabiotec.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi guys.

I am working on the Linux port on a custom 8260-based board.
During the port I've encountered a few problems with serial ports.

1. On the latest kernel 2.6.17 the cpm2 serial driver fails during the 
bus scan and fails back to so called compat mode.
2. For whatever strange reason, the driver is unable to initialize 
serial port, if the console on SMC is not selected.
3. I am unable to work with both SMC1 and SMC2 together. During driver 
init, only one port actually gets an IRQ.
In another words, if I enable both SMC1 and SMC2 in the  kernel config. 
and put console on ttyCPM0, then SMC1 gets IRQ, but SMC2 doesn't. dmesg 
actually prints IRQs for both ports, but looking into /proc/irq reveals, 
that only one interrupt is assigned only for port that is used as a console.

2) and 3) relate for both 2.6.17 and 2.6.16 kernel trees

Could someone, please, advise me, on possible solutions for those problems ?

Thanks in advance,
Boris
