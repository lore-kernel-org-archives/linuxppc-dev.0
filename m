Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55912DE317
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 09:30:51 +1000 (EST)
Message-Id: <3F8109F5-F512-48CD-AD93-2C6B4164E5AA@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 0/5] dynamic detection of gianfar TPIPA
Date: Thu, 10 Apr 2008 18:30:37 -0500
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-net@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 10, 2008, at 12:51, Paul Gortmaker wrote:

>
> This patch series consists of some minor cleanups that eventually
> allow us to implement a dynamic assignment of the gianfar TBIPA.
> This was the implementation that Andy and Scott indicated was
> the most desireable solution at the bottom of this discussion:
>
> http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=12902
>
> The lead up patches are as follows:
>
> -dont allocate a phydev for the "ghost" phy that seems to appear
>  on ID 0x1f of all the MDIO bus scans.
>
> -add in the missing assignment to priv->mii_bus when we assign a
>  phy to the device.
>
> -cleanup of unnecessary externs that the above change allows us.
>
> -make the mii_bus->priv point to struct gianfar_mdio_data
>
> At this point, we can then actually use the phy_map of the mii_bus
> to tell us which MDIO ID we can use for the TBIPA, instead of just
> hard coding 0x1f.


I may be missing something, but I don't think this quite right.

If you have a PHY at 0x1f, this patchset will cause no PHY device to  
be allocated for that address, and you'll actually end up assigning  
TBIPA to be 0x1f again, since there's no PHY there.  Right?  Were you  
able to use this code with a PHY at 0x1f?

I like the idea of passing around priv->mii_bus instead of regs, but I  
think it won't work without becoming unnecessarily unwieldy.  The  
problem is that the TBI PHY is not necessarily accessed through the  
same bus as the PHY.  Each controller has its own TBI PHY, and that  
PHY can only be accessed from *that* controller's MDIO bus.  So if you  
want to configure TSEC2's TBI PHY, you use TSEC2's MDIO regs.  That's  
what gfar_local_mdio_* allowed; they write the *local* controller's  
MDIO regs.  It looks like this code sets up priv->mii_bus to point at  
the bus which holds the PHY, but only TSEC0's bus (on most SoCs) is  
connected to actual PHYs.  So you will only ever be able to configure  
the TBI PHY on TSEC0, which will not allow any of the other TSECs to  
use an SGMII PHY.  Were you able to use other TSECs to connect to an  
SGMII PHY?

We could still pass around an mii_bus reference, but this would  
require creating an mii_bus instance for every single TSEC, which is a  
little heavyweight when we just want to configure the TBI PHY once on  
startup.

After some thinking, I went ahead and implemented a patch which isn't  
ideal, but should solve the problems your patches set out to solve.   
I've sent it in a separate message.  If you have some systems with  
SGMII and/or a PHY at 0x1f, please test this patch on them.  I don't  
currently have either.

Andy
