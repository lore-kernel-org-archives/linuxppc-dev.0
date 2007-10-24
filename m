Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 002F8DDE43
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 05:25:21 +1000 (EST)
Message-ID: <471F9BD8.905@ru.mvista.com>
Date: Wed, 24 Oct 2007 23:24:08 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support
	to NEW EMAC.
References: <20071015175717.GA4602@ru.mvista.com>
	<1193196718.2085.35.camel@pasglop>
In-Reply-To: <1193196718.2085.35.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, jeff@garzik.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2007-10-23 at 20:57 -0500, Valentine Barshak wrote:
> 
>> +static int m88e1111_init(struct mii_phy *phy)
>> +{
>> +	printk("%s: Marvell 88E1111 Ethernet\n", __FUNCTION__);
>> +	phy_write(phy, 0x14, 0x0ce3);
>> +	phy_write(phy, 0x18, 0x4101);
>> +	phy_write(phy, 0x09, 0x0e00);
>> +	phy_write(phy, 0x04, 0x01e1);
>> +	phy_write(phy, 0x00, 0x9140);
>> +	phy_write(phy, 0x00, 0x1140);
>> +
>> +	return  0;
>> +}
> 
> Care to put a few comments on why the above is necessary and what it
> does ?

I think this set's up Marvell ext control (0x14) and led control (0x18) 
registers with some default values, Also sets some bits in the
CTRL1000, ADVERTISE and basic mode control registers and resets the phy 
for the changes to take effect. Unfortunately, I don't have a detailed 
88E1111 description and can't tell anything about it. Looks like the 
code was originally ported from u-boot and is needed to init the phy :)
Stefan, do you have any info on this?
Thanks,
Valentine.

> 
> Thanks !
> Ben.
> 
>> +static struct mii_phy_ops m88e1111_phy_ops = {
>> +	.init		= m88e1111_init,
>> +	.setup_aneg	= genmii_setup_aneg,
>> +	.setup_forced	= genmii_setup_forced,
>> +	.poll_link	= genmii_poll_link,
>> +	.read_link	= genmii_read_link
>> +};
>> +
>> +static struct mii_phy_def m88e1111_phy_def = {
>> +
>> +	.phy_id		= 0x01410CC0,
>> +	.phy_id_mask	= 0x0ffffff0,
>> +	.name		= "Marvell 88E1111 Ethernet",
>> +	.ops		= &m88e1111_phy_ops,
>> +};
>> +
>>  static struct mii_phy_def *mii_phy_table[] = {
>>  	&cis8201_phy_def,
>> +	&bcm5248_phy_def,
>> +	&m88e1111_phy_def,
>>  	&genmii_phy_def,
>>  	NULL
>>  };
> 
