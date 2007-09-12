Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25034DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 04:21:21 +1000 (EST)
In-Reply-To: <20070912112601.GE15556@localhost.localdomain>
References: <20070912112601.GE15556@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <349316B4-E3B3-4F03-9847-6FE4B7405414@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] phy: implement release function
Date: Wed, 12 Sep 2007 13:21:22 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 12, 2007, at 06:26, Anton Vorontsov wrote:

> Lately I've got this nice badness on mdio bus removal:
>
> Device 'e0103120:06' does not have a release() function, it is  
> broken and must be fixed.
> ------------[ cut here ]------------
> Badness at drivers/base/core.c:107
> NIP: c015c1a8 LR: c015c1a8 CTR: c0157488
> REGS: c34bdcf0 TRAP: 0700   Not tainted  (2.6.23-rc5-g9ebadfbb-dirty)
> MSR: 00029032 <EE,ME,IR,DR>  CR: 24088422  XER: 00000000
> ...
> [c34bdda0] [c015c1a8] device_release+0x78/0x80 (unreliable)
> [c34bddb0] [c01354cc] kobject_cleanup+0x80/0xbc
> [c34bddd0] [c01365f0] kref_put+0x54/0x6c
> [c34bdde0] [c013543c] kobject_put+0x24/0x34
> [c34bddf0] [c015c384] put_device+0x1c/0x2c
> [c34bde00] [c0180e84] mdiobus_unregister+0x2c/0x58
> ...
>
> Though actually there is nothing broken, it just device
> subsystem core expects another "pattern" of resource managment.
>
> This patch implement phy device's release function, thus
> we're getting rid of this badness.
>
> Also small hidden bug fixed, hope none other introduced. ;-)
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Andy Fleming <afleming@freescale.com>

Andy
