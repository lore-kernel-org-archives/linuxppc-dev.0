Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8D2F567A73
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Mar 2005 11:41:25 +1100 (EST)
In-Reply-To: <4230D1AC.5070506@katalix.com>
References: <1107b64b01fb8e9a6c84359bb56881a6@freescale.com>	<1110334456.32556.21.camel@gaston>	<20050308194229.41c23707.davem@davemloft.net>	<1110340214.32524.32.camel@gaston>
	<57a429f8eb807987d88b06129861d507@freescale.com>
	<4230D1AC.5070506@katalix.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ba5d844255b5ba76b2685f9397faf689@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Mon, 14 Mar 2005 18:41:10 -0600
To: James Chapman <jchapman@katalix.com>
Cc: netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>,
	linuxppc-embedded@ozlabs.org
Subject: Re: RFC: PHY Abstraction Layer II
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 10, 2005, at 17:01, James Chapman wrote:

> Hi Andy,
>
> Can you elaborate on why this phy abstraction is needed?
>
> In your original post, you mentioned that you were going to post a
> patch to show how your code would be hooked up in an existing net
> driver. Did I miss it? It would help in understanding the pros and cons
> of using genphy over using plain old mii.c.

Hi James,

I haven't posted it yet, since it's a large patch (it deletes a lot of 
code from my driver), but I can give a basic overview of how my driver 
hooks into this code:

1) The driver connects to the PHY when opened, calling phy_connect, and 
then clears some bits to declare functionality it doesn't support (my 
driver, for instance, does not support gigabit in half-duplex mode).

2) The driver implements a function which reads the speed/duplex 
settings, and modifies the controller registers as appropriate (also 
bringing the carrier up and down depending on link state).  My driver 
needs to note whether it's gigabit or not (for GMII vs MII mode), and 
the duplex (to set the MAC full or half).

Both of those steps are very straightforward.  The PHY layer will 
invoke the callback whenever the link state changes, so the controller 
will always be up-to-date.

3) The third step is the part that can make things a little messier.  
My driver implements a second driver for the MDIO bus, which is 
connected through its registers.  This bus needs to be registered, and 
the driver also needs to register.  Then some code needs to be written 
to deal with initialization, and takedown.  I can send out that patch 
anytime, if there's demand.

>
> btw, I recently posted a patch to add GigE support to mii.c which is
> in Jeff's netdev-2.6 queue. Some register definitions were added in
> mii.h that will collide with yours.

Yeah, I ran in to some of those.  I can't remember whether they're in 
the patch or not, I suspect not.  I will have to submit a new patch to 
cover those (I just changed my code to use your definitions).

Andy
