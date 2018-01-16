Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLYjC4BYnzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 02:16:47 +1100 (AEDT)
Date: Tue, 16 Jan 2018 15:38:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "madskateman@gmail.com" <madskateman@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
Message-ID: <20180116143836.GC22903@lunn.ch>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516035556.18795.71.camel@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hi, just saw this and thought of a small patch I just wrote for mdio bus, o idea
> if it is relevant but here goes:
> 
> From fe0b98d54a79779482700676331b4d10a0f3cada Mon Sep 17 00:00:00 2001
> From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> Date: Sun, 14 Jan 2018 21:27:20 +0100
> Subject: [PATCH] of_mdiobus_register: Continue after error
> 
> of_mdiobus_register unregister itself if one phy fails to register
> which is bad for system having all its PHYs on the same MDIO bus.
> Just log the error and continue with the remaining PHYs instead.
> 
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>

Hi Joakim

You appear to be using an old kernel. Take a look at:

commit 95f566de0269a0c59fd6a737a147731302136429
Author: Madalin Bucur <madalin.bucur@nxp.com>
Date:   Tue Jan 9 14:43:34 2018 +0200

    of_mdio: avoid MDIO bus removal when a PHY is missing
    
    If one of the child devices is missing the of_mdiobus_register_phy()
    call will return -ENODEV. When a missing device is encountered the
    registration of the remaining PHYs is stopped and the MDIO bus will
    fail to register. Propagate all errors except ENODEV to avoid it.
    
    Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: David S. Miller <davem@davemloft.net>


    Andrew
