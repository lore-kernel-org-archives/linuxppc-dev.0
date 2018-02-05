Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZjFz3tLzzF0Sy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 20:38:44 +1100 (AEDT)
Subject: PA Semi PWRficient Gigabit Ethernet doesn't work anymore since the
 first networking updates for the kernel 4.16
To: Andrew Lunn <andrew@lunn.ch>
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
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <93dcb6c1-75d5-539c-c867-09266d43dbd0@xenosoft.de>
Date: Mon, 5 Feb 2018 10:38:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180204171626.GE10544@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Andrew,

Many thanks for your patch. I compiled the latest git kernel today and 
the PA Semi PWRficient Gigabit Ethernet works with your patch.

Have a nice week!

Thanks,
Christian


On 04 February 2018 at 6:16PM, Andrew Lunn wrote:
 > On Sun, Feb 04, 2018 at 05:47:03PM +0100, Christian Zigotzky wrote:
 >> Hello,
 >>
 >> The PA Semi PWRficient Gigabit Ethernet doesn't work anymore since 
the first
 >> networking updates [1] for the kernel 4.16.
 >>
 >> Error messages:
 >>
 >> [    0.634241] libphy: pasemi gpio mdio bus: probed
 >> [    0.634749] pasemi gpio mdio bus: Cannot register as MDIO bus, 
err -38
 >
 > -38 is ENOSYS.
 >
 >> --- a/drivers/net/phy/mdio_bus.c    2018-02-03 17:34:46.973045321 +0100
 >> +++ b/drivers/net/phy/mdio_bus.c    2018-02-04 11:03:14.909093360 +0100
 >> @@ -47,41 +47,11 @@
 >>
 >>  #include "mdio-boardinfo.h"
 >>
 >> -static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
 >> -{
 >> -    struct gpio_desc *gpiod = NULL;
 >> -
 >> -    /* Deassert the optional reset signal */
 >> -    if (mdiodev->dev.of_node)
 >> -        gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
 >> -                           "reset-gpios", 0, GPIOD_OUT_LOW,
 >> -                           "PHY reset");
 >
 > So i think you don't have GPIOLIB enabled. Hence you are hitting
 >
 > 
http://elixir.free-electrons.com/linux/latest/source/include/linux/gpio/consumer.h#L470
 >
 > static inline
 > struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 >                      const char *propname, int index,
 >                      enum gpiod_flags dflags,
 >                      const char *label)
 > {
 >     return ERR_PTR(-ENOSYS);
 > }
 >
 > So rather than just deleting all this code, breaking other platforms
 > that need this gpio, lets try a real fix. Please try this. If it
 > works, i will formally submit it.
 >
 >    Andrew
 >
 > >From a4210ba306948497d7360927c1e532eb903c58b2 Mon Sep 17 00:00:00 2001
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
 > ---
 >  drivers/net/phy/mdio_bus.c | 3 ++-
 >  1 file changed, 2 insertions(+), 1 deletion(-)
 >
 > diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
 > index 88272b3ac2e2..24b5511222c8 100644
 > --- a/drivers/net/phy/mdio_bus.c
 > +++ b/drivers/net/phy/mdio_bus.c
 > @@ -56,7 +56,8 @@ static int mdiobus_register_gpiod(struct 
mdio_device *mdiodev)
 >          gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
 >                             "reset-gpios", 0, GPIOD_OUT_LOW,
 >                             "PHY reset");
 > -    if (PTR_ERR(gpiod) == -ENOENT)
 > +    if (PTR_ERR(gpiod) == -ENOENT ||
 > +        PTR_ERR(gpiod) == -ENOSYS)
 >          gpiod = NULL;
 >      else if (IS_ERR(gpiod))
 >          return PTR_ERR(gpiod);
