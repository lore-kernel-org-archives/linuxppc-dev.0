Return-Path: <f.fainelli@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZM7d0y82zF0qm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 07:02:04 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id j188so18395828oib.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Feb 2018 12:02:04 -0800 (PST)
Subject: Re: PA Semi PWRficient Gigabit Ethernet doesn't work anymore since
 the first networking updates for the kernel 4.16
To: Andrew Lunn <andrew@lunn.ch>, Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <DB3PR0402MB38492999533EB4400DED45BFECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516348851.4730.15.camel@infinera.com> <20180119132251.GJ32299@lunn.ch>
 <9e8e906d-b2b7-f11c-30ed-ccdf91ac563c@xenosoft.de>
 <20180204171626.GE10544@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fcd3f634-d24f-7aa6-ec75-7b3ea37e2321@gmail.com>
Date: Sun, 4 Feb 2018 12:01:56 -0800
MIME-Version: 1.0
In-Reply-To: <20180204171626.GE10544@lunn.ch>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/04/2018 09:16 AM, Andrew Lunn wrote:
> On Sun, Feb 04, 2018 at 05:47:03PM +0100, Christian Zigotzky wrote:
>> Hello,
>>
>> The PA Semi PWRficient Gigabit Ethernet doesn't work anymore since the first
>> networking updates [1] for the kernel 4.16.
>>
>> Error messages:
>>
>> [    0.634241] libphy: pasemi gpio mdio bus: probed
>> [    0.634749] pasemi gpio mdio bus: Cannot register as MDIO bus, err -38
> 
> -38 is ENOSYS.
> 
>> --- a/drivers/net/phy/mdio_bus.c	2018-02-03 17:34:46.973045321 +0100
>> +++ b/drivers/net/phy/mdio_bus.c	2018-02-04 11:03:14.909093360 +0100
>> @@ -47,41 +47,11 @@
>>  
>>  #include "mdio-boardinfo.h"
>>  
>> -static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
>> -{
>> -	struct gpio_desc *gpiod = NULL;
>> -
>> -	/* Deassert the optional reset signal */
>> -	if (mdiodev->dev.of_node)
>> -		gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
>> -					       "reset-gpios", 0, GPIOD_OUT_LOW,
>> -					       "PHY reset");
> 
> So i think you don't have GPIOLIB enabled. Hence you are hitting
> 
> http://elixir.free-electrons.com/linux/latest/source/include/linux/gpio/consumer.h#L470
> 
> static inline
> struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
> 					 const char *propname, int index,
> 					 enum gpiod_flags dflags,
> 					 const char *label)
> {
> 	return ERR_PTR(-ENOSYS);
> }
> 
> So rather than just deleting all this code, breaking other platforms
> that need this gpio, lets try a real fix. Please try this. If it
> works, i will formally submit it.
> 
>    Andrew
> 
> From a4210ba306948497d7360927c1e532eb903c58b2 Mon Sep 17 00:00:00 2001
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Sun, 4 Feb 2018 11:09:20 -0600
> Subject: [PATCH] net: phy: Handle not having GPIO enabled in the kernel
> 
> If CONFIG_GPIOLIB is disabled, fwnode_get_named_gpiod() becomes a stub
> function, which return -ENOSYS. Handle this in the same way as
> -ENOENT, i.e. assume there is no GPIO used to reset the PHYs.
> 
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support")

> ---
>  drivers/net/phy/mdio_bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 88272b3ac2e2..24b5511222c8 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -56,7 +56,8 @@ static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
>  		gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
>  					       "reset-gpios", 0, GPIOD_OUT_LOW,
>  					       "PHY reset");
> -	if (PTR_ERR(gpiod) == -ENOENT)
> +	if (PTR_ERR(gpiod) == -ENOENT ||
> +	    PTR_ERR(gpiod) == -ENOSYS)
>  		gpiod = NULL;
>  	else if (IS_ERR(gpiod))
>  		return PTR_ERR(gpiod);
> 

-- 
Florian
