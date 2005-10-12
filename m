Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8AA76684E3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Oct 2005 03:25:00 +1000 (EST)
Date: Wed, 12 Oct 2005 10:24:57 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: extabe@bredband.net
Message-ID: <20051012172457.GA13924@gate.ebshome.net>
References: <20051012170048.QRLV3110.mxfep03.bredband.com@mxfep03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051012170048.QRLV3110.mxfep03.bredband.com@mxfep03>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: "PPC 405 MAL0 eth: receive descriptor error"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2005 at 07:00:48PM +0200, extabe@bredband.net wrote:
> We have built a board based on AMCC 440ep and used bamboo as reference board. We are running montavista 2.4.20 kernel and have problems with the network.
> After a while when using the network linux outputs this:
> 
> "PPC 405 MAL0 eth: receive descriptor error"
> 
> Searching the kernelsource shows that this output comes from
> 
> static void ppc405_eth_rxde(int irq, void *dev_instance, struct pt_regs *regs)
> 
> in drivers/net/ibm_ocp/ibm_ocp_enet.c
> 
> and the comment for this function is:
> 
> "This interrupt should be very rare at best.  This occurs when
> the hardware has a problem with the receive descriptors.  The manual
> states that it occurs when the hardware cannot the receive descriptor
> empty bit is not set.  The recovery mechanism will be to traverse through the descriptors, handle any that are marked to be
> handled and reinitialize each along the way.  At that point the driver
> will be restarted."
> 
> Can anybody help me with this problem? After it occurs the system freezes for about 2 minutes.
> 

Current EMAC driver (in both 2.4 and 2.6) is buggy. That comment is 
actually misleading, because this IRQ can happen during normal 
operation, e.g. under heavy packet load.

There is re-write available for both 2.4 and 2.6. You can find more 
information at http://kernel.ebshome.net/.

2.4 patch is against 2.4.31, so you'll have to back port all required 
stuff to 2.4.21.

-- 
Eugene
