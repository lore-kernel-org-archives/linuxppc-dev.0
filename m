Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E01B1A0730
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 08:35:09 +1000 (AEST)
Date: Fri, 25 Sep 2015 00:26:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Miller <davem@davemloft.net>
Cc: linux@arm.linux.org.uk, f.fainelli@gmail.com,
 thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org,
 sgoutham@cavium.com, rric@kernel.org, frowand.list@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, michal.simek@xilinx.com, netdev@vger.kernel.org,
 soren.brinkmann@xilinx.com, isubramanian@apm.com,
 grant.likely@linaro.org, leoli@freescale.com, kchudgar@apm.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/9] Phy, mdiobus, and netdev struct device fixes
Message-ID: <20150924222654.GG20825@lunn.ch>
References: <20150924191754.GC21513@n2100.arm.linux.org.uk>
 <20150924215731.GE20825@lunn.ch>
 <20150924.151554.619662567057050978.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150924.151554.619662567057050978.davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 24, 2015 at 03:15:54PM -0700, David Miller wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Thu, 24 Sep 2015 23:57:31 +0200
> 
> > I built the FEC driver as a module, and it won't unload:
> > 
> >  kernel:unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> > 
> > i assume because DSA holds a reference. I've not tried a fully module
> > build, DSA has issues with that.
> > 
> > Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> So, is this a regression?

Sorry, worded that badly. Since DSA is still active, it should not be
possible to unload the FEC driver. DSA should have a reference to it,
and mdio-mux also should have a reference to the mdio bus of the FEC
driver.

As Russell requested, i will re-test without his patches, just to make
sure.

	Andrew
