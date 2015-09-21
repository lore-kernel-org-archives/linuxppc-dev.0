Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id E76001A0146
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 05:02:03 +1000 (AEST)
Date: Mon, 21 Sep 2015 12:01:59 -0700 (PDT)
Message-Id: <20150921.120159.326170798236851436.davem@davemloft.net>
To: rmk+kernel@arm.linux.org.uk
Cc: f.fainelli@gmail.com, devicetree@vger.kernel.org,
 frowand.list@gmail.com, grant.likely@linaro.org, isubramanian@apm.com,
 kchudgar@apm.com, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, leoli@freescale.com,
 michal.simek@xilinx.com, netdev@vger.kernel.org, rric@kernel.org,
 robh+dt@kernel.org, soren.brinkmann@xilinx.com, sgoutham@cavium.com,
 thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] phy: fix of_mdio_find_bus() device refcount leak
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1ZcsNb-0001Bf-U5@rmk-PC.arm.linux.org.uk>
References: <20150918094625.GB21084@n2100.arm.linux.org.uk>
 <E1ZcsNb-0001Bf-U5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Fri, 18 Sep 2015 10:54:55 +0100

> Update the comment, and arrange for the only user of this function
> to drop this refcount when disposing of a reference to it.

mdio_mux is not the only user of of_mdio_find_bus(), DSA uses it as
well.

So if anything this commit message is inaccurate.

I also wonder about this refcounting scheme.

If you are going to drop the inner device reference, then we take the
mdio bus returned from of_mdio_find_bus() what holds onto it and keeps
it from disappearing on us?

Don't we have to hold onto some reference count of some kind here?
