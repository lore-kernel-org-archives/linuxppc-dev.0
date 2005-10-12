Return-Path: <extabe@bredband.net>
Received: from mxfep01.bredband.com (mxfep01.bredband.com [195.54.107.70])
	by ozlabs.org (Postfix) with ESMTP id A70E3684C7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Oct 2005 03:07:23 +1000 (EST)
Received: from mxfep03 ([195.54.107.76] [195.54.107.76])
	by mxfep03.bredband.com with SMTP
	id <20051012170048.QRLV3110.mxfep03.bredband.com@mxfep03>
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Oct 2005 19:00:48 +0200
From: <extabe@bredband.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 12 Oct 2005 19:00:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20051012170048.QRLV3110.mxfep03.bredband.com@mxfep03>
Subject: "PPC 405 MAL0 eth: receive descriptor error"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!
We have built a board based on AMCC 440ep and used bamboo as reference board. We are running montavista 2.4.20 kernel and have problems with the network.
After a while when using the network linux outputs this:

"PPC 405 MAL0 eth: receive descriptor error"

Searching the kernelsource shows that this output comes from

static void ppc405_eth_rxde(int irq, void *dev_instance, struct pt_regs *regs)

in drivers/net/ibm_ocp/ibm_ocp_enet.c

and the comment for this function is:

"This interrupt should be very rare at best.  This occurs when
the hardware has a problem with the receive descriptors.  The manual
states that it occurs when the hardware cannot the receive descriptor
empty bit is not set.  The recovery mechanism will be to traverse through the descriptors, handle any that are marked to be
handled and reinitialize each along the way.  At that point the driver
will be restarted."

Can anybody help me with this problem? After it occurs the system freezes for about 2 minutes.

We are using u-boot configured for bamboo with small modifications and the same goes for the kernel.

//Andre
