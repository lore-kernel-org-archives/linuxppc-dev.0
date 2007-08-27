Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89F2ADDF15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 04:07:31 +1000 (EST)
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EA18371@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8EA18371@aquib01a>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ABC17B04-C603-42B1-8B74-56197D9D953D@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: MDIO bus hotplug
Date: Mon, 27 Aug 2007 13:07:14 -0500
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 27, 2007, at 06:12, DI BACCO ANTONIO - technolabs wrote:

> Hi,
>
> I have an hot pluggable MDIO bus (connected to MDC, MDIO of an  
> MPC880) and thus I would like to rescan the bus on certain events  
> (for example fs_enet_open) to access the numerous PHYs I have on  
> this bus. I saw that it is "simply" a matter of calling  
> mdiobus_register but I would like an advice how to design the  
> modification


There are a few problems, here:

1)  Do you expect only to add/remove PHYs, or to completely swap out  
the entire set?

2)  If you bring up one interface, swap out the PHYs, and then bring  
up a second interface, the first one will be broken

I think the best solution is to add the capability for the PHY Lib to  
tell attached ethernet controllers that the PHY has been disconnected/ 
deallocated.  Perhaps protected by a CONFIG_ option.

Then you would add support for taking down a PHY, and probably the  
whole bus, on the fly.  This would require making sure that all  
outstanding transactions are done, and may be as simple as invoking  
mdiobus_unregister.  The tricky part is that we really need to have  
some way to tell the ethernet controllers that were up that the new  
bus is there.  If we're really fancy, the PHY Lib could even hook  
those controllers up automatically, but it may be necessary for the  
drivers to change which address they connect to.

Andy
