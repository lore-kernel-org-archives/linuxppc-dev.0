Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5233C1A023F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 02:01:28 +1000 (AEST)
Date: Thu, 24 Sep 2015 17:00:58 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: f.fainelli@gmail.com, devicetree@vger.kernel.org,
 frowand.list@gmail.com, grant.likely@linaro.org,
 isubramanian@apm.com, kchudgar@apm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, leoli@freescale.com,
 michal.simek@xilinx.com, netdev@vger.kernel.org, rric@kernel.org,
 robh+dt@kernel.org, soren.brinkmann@xilinx.com, sgoutham@cavium.com,
 thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH v2 0/9] Phy, mdiobus, and netdev struct device fixes
Message-ID: <20150924160058.GA21513@n2100.arm.linux.org.uk>
References: <20150922161710.GA21084@n2100.arm.linux.org.uk>
 <20150923.162417.814596822188458346.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150923.162417.814596822188458346.davem@davemloft.net>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 23, 2015 at 04:24:17PM -0700, David Miller wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Date: Tue, 22 Sep 2015 17:17:10 +0100
> 
> > This is the second version of the series, with the comments David had
> > on the first patch fixed up.  Original series description with updated
> > diffstat below.
> 
> This needs some build fixes:
> 
> drivers/net/ethernet/apm/xgene/xgene_enet_hw.c: In function ‘xgene_enet_phy_connect’:
> drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:694:20: error: too few arguments to function ‘of_phy_connect’
>    pdata->phy_dev = of_phy_connect(ndev, phy_np,
>                     ^
> In file included from drivers/net/ethernet/apm/xgene/xgene_enet_main.h:31:0,
>                  from drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:22:
> include/linux/of_mdio.h:18:27: note: declared here
>  extern struct phy_device *of_phy_connect(struct net_device *dev,
>                            ^

Sorry about that, I'll send a new series later this evening.

Unfortunately, that's also not the only one - Cavium Thunder BGX also
fails.  Looking again at that driver, the driver structure doesn't lend
itself well to having the refcount balancing added to it due to the
multiple different paths which it obtains a phy_device.  I think this is
best left to the maintainers of this driver to fix, so I'm intending to
drop the change to that driver.

That's not a problem: the driver is already buggy in this regard today,
and that's won't be any different as a result of omitting it.  It's just
a shame to leave one instance unfixed.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
