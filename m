Return-Path: <aris@conectiva.com.br>
Received: from orion.netbank.com.br (orion.netbank.com.br [200.203.199.90])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D55367B6A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 00:37:18 +1000 (EST)
Date: Thu, 30 Jun 2005 11:11:38 -0300
From: aris@conectiva.com.br
To: Samuel Osorio Calvo <samuel.osorio@nl.thalesgroup.com>
Message-ID: <20050630141138.GD5338@oops.ghostprotocols.net>
References: <s2c4153f.011@scms1.sc.signaal.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s2c4153f.011@scms1.sc.signaal.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: eth0 autonegotation 8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> First of all sorry if this answer has been answered before, I have looked into the archives and did not find the answer.
> 
> We are using a 8260 processor with ELDK 3.1.1,  kernel 2.4.25 patched with lck1. We have configured the kernel with USE_MDIO and LXT971.
> The problem we face is that the boot process stops after displaying the configuration of the card:
> eth0: config: autonegotiation on, 100FDX,...
> and after the board seems to freeze.
> 
> Following the code, I located the error in the startup command of the LXT971, concretely in the line setting the autonegotiation:
> {mk_mii_write(MII_REG_CR, 0x1200), NULL}, /* autonegotiate */ 
I have the same here but it doesn't freezes, it just doesn't works :).
(maybe it "freezes" because next step depends on the eth like RARP?)
I digged into LXT971 datasheet and 0x1200 appears to be correct. I was thinking
in add an module option to manually set it (and thus avoiding the need to use
ethtool). Any MII guru around to help us on this?

--
Aristeu
