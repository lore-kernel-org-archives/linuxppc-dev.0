Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx013.isp.belgacom.be (outmx013.isp.belgacom.be
	[195.238.5.64])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2BDF67B7F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Jul 2006 19:36:49 +1000 (EST)
Received: from outmx013.isp.belgacom.be (localhost [127.0.0.1])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k6O9agkP027565
	for <linuxppc-embedded@ozlabs.org>; Mon, 24 Jul 2006 11:36:42 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k6O9aeNi027534
	for <linuxppc-embedded@ozlabs.org>; Mon, 24 Jul 2006 11:36:40 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Endless "Trying 100/HALF" messages using FCC ethernet on MPC8248
Date: Mon, 24 Jul 2006 11:39:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200607241139.02128.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I'm not sure if this issue is ppc-specific, so forgive me if it should have 
been reported to the drivers/net/phy maintainer.

When using the MPC8248 FCC ethernet ports, the following messages are printed 
by the kernel on the console when a link is down (ethernet cable unplugged):

Trying 100/FULL
Trying 100/HALF
Trying 100/HALF
Trying 100/HALF
...

This goes on forever, with a new message every 5 or 10 seconds. The message is 
printed by drivers/net/phy/phy.c at line 463.

Those messages are pretty annoying. Commenting the pr_info() call gave me some 
rest, but a proper fix is probably needed.

For the record, I'm using FCC1 and FCC2 with an LXT973 phy in bit-banging 
mode.

Laurent Pinchart
