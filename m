Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8D296679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Jun 2006 18:41:09 +1000 (EST)
Date: Thu, 22 Jun 2006 12:39:44 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 1/3] PAL: Support of the fixed PHY
Message-ID: <20060622123944.445629ad@localhost.localdomain>
In-Reply-To: <200606212248.27836.mb@bu3sch.de>
References: <20060621160950.4860.92979.stgit@vitb.ru.mvista.com>
	<200606212248.27836.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

На Wed, 21 Jun 2006 22:48:27 +0200
Michael Buesch <mb@bu3sch.de> записано:

> On Wednesday 21 June 2006 18:09, Vitaly Bordug wrote:
> 
> > +static int fixed_mdio_update_regs(struct fixed_info *fixed)
> > +{
> > +	u16 *regs = fixed->regs;
> > +	u16 bmsr = 0;
> > +	u16 bmcr = 0;
> > +
> > +	if(!regs) {
> > +		printk(KERN_ERR "%s: regs not set up",
> > __FUNCTION__);
> > +		return -1;
> 
> -EINVAL perhaps?
> 
OK
> > +static int fixed_mdio_register_device(int number, int speed, int
> > duplex) +{
> > +	struct mii_bus *new_bus;
> > +	struct fixed_info *fixed;
> > +	struct phy_device *phydev;
> > +	int err = 0;
> > +
> > +	struct device* dev = kzalloc(sizeof(struct device),
> > GFP_KERNEL); +
> > +	if (NULL == dev)
> > +		return -EINVAL;
> 
> -ENOMEM here.
OK

[snip]
> > +	/*
> > +	   the mdio bus has phy_id match... In order not to do it
> > +	   artificially, we are binding the driver here by hand;
> > +	   it will be the same
> > +	   for all the fixed phys anyway.
> > +	 */
> > +	down_write(&phydev->dev.bus->subsys.rwsem);
> > +
> > +	phydev->dev.driver = &fixed_mdio_driver.driver;
> > +
> > +	err = phydev->dev.driver->probe(&phydev->dev);
> > +	if(err < 0) {
> > +		printk(KERN_ERR "Phy %s: problems with fixed
> > driver\n",
> > +				phydev->dev.bus_id);
> > +		up_write(&phydev->dev.bus->subsys.rwsem);
> > +		goto bus_register_fail;
> 
> Probably need some additional error unwinding code.
> Of doesn't device_register() have to be reverted?
> What about phy_device_create()?
> 
Definitely. Moreover, as I noticed now, phy_driver_register also has to
be error-handled and such. Will fix/update and resubmit.

Thanks for the feedback.
--

Sincerely, Vitaly
