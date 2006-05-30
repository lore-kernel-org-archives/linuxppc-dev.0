Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72493679FB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 18:46:39 +1000 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4U8kSGh006845
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 May 2006 10:46:28 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4U8kKUL006754
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 May 2006 10:46:21 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: LXT973 support (dual PHY with single MDIO)
Date: Tue, 30 May 2006 10:48:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605301048.01209.laurent.pinchart@tbox.biz>
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

I'm trying to bring up the two ethernet ports on a LXT973 dual-PHY chip. I've 
declared two FCC platform devices, which are detected and handled by the 
driver/net/fs_enet driver. My issue comes from MDIO support.

The LXT973 has a single MDIO port which answers to two addresses, one for each 
PHY. The MDC and MDIO lines are connected to GPIO pins (no PHY interrupt), so 
I'm using the bitbang MDIO driver. I've declared a MPC82xx_MDIO_BB platform 
device, and set bus_id to "0:00" for both FCC ethernet devices. The first 
ethernet device works fine, but the second complains that the PHY is already 
in use.

As the PHY read/write accesses are protected by the bus->mdio_lock, I thought 
about declaring a second MDIO platform device using the same I/O pins as the 
first. Does anybody knows any problem I could run into using that approach ? 
Is there a better method to handle the LXT973 MDIO ?

Thanks in advance for any help you can provide.

Best regards,

Laurent Pinchart
