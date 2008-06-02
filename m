Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C43EDE695
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 05:45:08 +1000 (EST)
Message-Id: <83820D83-487C-4586-9867-F4226A87A276@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BF15FEBB-4876-4B16-915B-1D21BF989DA8@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] phylib: Don't allow core of phylib to build as a module
Date: Mon, 2 Jun 2008 14:44:42 -0500
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
	<484419EE.5040503@garzik.org>
	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
	<48442239.7090906@garzik.org>
	<BF15FEBB-4876-4B16-915B-1D21BF989DA8@kernel.crashing.org>
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 2, 2008, at 14:30, Kumar Gala wrote:

>
> On Jun 2, 2008, at 11:39 AM, Jeff Garzik wrote:
>
> If you really think the core of the phylib should be able to be  
> built as a module than we could possibly add function pointers to  
> phy_dev to do the real phy_read()/phy_write() and change phy_read/ 
> _write to look like:
>
> int phy_read(struct phy_device *phydev, u16 regnum) {
> 	return phydev->read(phydev, regnum);
> }

That would be a bit silly, since this is the definition of phy_read():

int phy_read(struct phy_device *phydev, u16 regnum)
{
         int retval;
         struct mii_bus *bus = phydev->bus;

         BUG_ON(in_interrupt());

         mutex_lock(&bus->mdio_lock);
         retval = bus->read(bus, phydev->addr, regnum);
         mutex_unlock(&bus->mdio_lock);

         return retval;
}


We could, of course, move phy_read *out* of the phylib module.  And  
also phy_register_fixup and any other functions needed by board code.

I'm partial to the select-it-if-you-need-it paradigm.

Andy
