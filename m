Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0FF8D2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 18:02:48 +1100 (EST)
Date: Wed, 5 Jan 2005 23:02:45 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andy Fleming <afleming@freescale.com>
Message-ID: <20050106070245.GA6539@gate.ebshome.net>
References: <FC6D9B81-5514-11D9-8D51-000393C30512@freescale.com>
	<A3A281FF-5525-11D9-80ED-000393C30512@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A3A281FF-5525-11D9-80ED-000393C30512@freescale.com>
Cc: Netdev <netdev@oss.sgi.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] Patch to Abstract Ethernet PHY support (using driver
	model)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 23, 2004 at 03:00:13PM -0600, Andy Fleming wrote:
> 
> >Adds a Phy Abstraction Layer which allows ethernet controllers to 
> >manage their PHYs without knowing the details of how the particular 
> >PHY device operates.  This code steals heavily from BenH's  sungem 
> >driver, and got some stuff out of Jason McMullan's patch.

Some random notes from quick look at the code:

1) IMO if we can extract some info from the PHY using _standard_ 
registers we should use them, even if the PHY provides some custom 
ones. 

I suspect that _all_ XXX_read_status functions for different PHYs in 
your patch can be easily handled by generic IEEE 802.3 compliant code 
(you need to update genphy_read_status to properly handle GigE of 
course).

2) genphy can be changed to handle GigE speeds as well.

3) I think it's better for the genphy case to _detect_ PHY features 
instead of hard coding PHY_BASIC_FEATURES. In this case you can easily 
handle 10/100 and 10/100/1000 PHYs by genphy code.

4) Pause negotiation/advertising is completely missing.

5) PHY interrupt sharing looks broken. Although you request_irq using 
SA_SHIRQ flag, in the handler itself you don't detect whether this 
interrupt is for this PHY or not, and return IRQ_HANDLED. This will 
result in first registered PHY hijacking IRQs from other PHYs (or 
devices) sharing the same IRQ line.

--
Eugene
