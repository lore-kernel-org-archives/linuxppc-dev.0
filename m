Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 51E9B2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 06:50:53 +1100 (EST)
In-Reply-To: <20050106070245.GA6539@gate.ebshome.net>
References: <FC6D9B81-5514-11D9-8D51-000393C30512@freescale.com>
	<A3A281FF-5525-11D9-80ED-000393C30512@freescale.com>
	<20050106070245.GA6539@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <61A37C72-659C-11D9-8D70-000393C30512@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Thu, 13 Jan 2005 13:50:31 -0600
To: Eugene Surovegin <ebs@ebshome.net>
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


On Jan 6, 2005, at 01:02, Eugene Surovegin wrote:

> On Thu, Dec 23, 2004 at 03:00:13PM -0600, Andy Fleming wrote:
>>
>>> Adds a Phy Abstraction Layer which allows ethernet controllers to
>>> manage their PHYs without knowing the details of how the particular
>>> PHY device operates.  This code steals heavily from BenH's  sungem
>>> driver, and got some stuff out of Jason McMullan's patch.
>
> Some random notes from quick look at the code:
>
> 1) IMO if we can extract some info from the PHY using _standard_
> registers we should use them, even if the PHY provides some custom
> ones.
>
> I suspect that _all_ XXX_read_status functions for different PHYs in
> your patch can be easily handled by generic IEEE 802.3 compliant code
> (you need to update genphy_read_status to properly handle GigE of
> course).

Ok, I understand this, but a part of me rebels.  The "standard" 
procedure is to read the Link Partner Advertisement, AND it with the 
Advertisement, and then find the highest setting that works.  It seems 
to me that this is replicating work that is already done by the PHY, 
and I hate to do work that's already been done.

I also have one worry about this technique (though I'm still reading 
the 802.3 spec to see if my worry is valid).  Is it possible that the 
PHY would choose a setting which is lower than the highest possible, 
and therefore render the method above inaccurate?

>
> 2) genphy can be changed to handle GigE speeds as well.

Yeah, that's not a problem.  I just wasn't sure if the bits were 
properly defined on non-gigabit PHYs.  I will change this, as long as 
the relevant bits are always correct on 10/100 PHYs

>
> 3) I think it's better for the genphy case to _detect_ PHY features
> instead of hard coding PHY_BASIC_FEATURES. In this case you can easily
> handle 10/100 and 10/100/1000 PHYs by genphy code.

Ok, that's easy enough

>
> 4) Pause negotiation/advertising is completely missing.

Sigh... I knew someone would ask for that.  I will get right on this.
