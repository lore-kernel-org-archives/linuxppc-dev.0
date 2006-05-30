Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.5.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8B5E67A5B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 19:27:21 +1000 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4U9RDFG011718
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 May 2006 11:27:14 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx007.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4U9R8iw011653
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 May 2006 11:27:08 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [SOLVED] LXT973 support (dual PHY with single MDIO)
Date: Tue, 30 May 2006 11:28:48 +0200
References: <200605301048.01209.laurent.pinchart@tbox.biz>
In-Reply-To: <200605301048.01209.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605301128.48580.laurent.pinchart@tbox.biz>
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

once again, posting to a mailing list helped me solving my problem. It should 
have been obvious that the MDIO bus is really a bus, and can as such support 
several devices. The issue was that the drivers/net/fs_enet driver set 
bus->phy_mask to ~0x9, and the LXT973 uses addresses 0 and 1. Address 1 thus 
never got probed. What's the reason for probing addresses 0 and 3 only ?

Laurent Pinchart
