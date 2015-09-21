Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E5A51A014B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 05:32:35 +1000 (AEST)
Date: Mon, 21 Sep 2015 20:32:07 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: f.fainelli@gmail.com, devicetree@vger.kernel.org,
 frowand.list@gmail.com, grant.likely@linaro.org,
 isubramanian@apm.com, kchudgar@apm.com,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 leoli@freescale.com, michal.simek@xilinx.com,
 netdev@vger.kernel.org, rric@kernel.org, robh+dt@kernel.org,
 soren.brinkmann@xilinx.com, sgoutham@cavium.com,
 thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] phy: fix of_mdio_find_bus() device refcount leak
Message-ID: <20150921193206.GU21084@n2100.arm.linux.org.uk>
References: <20150918094625.GB21084@n2100.arm.linux.org.uk>
 <E1ZcsNb-0001Bf-U5@rmk-PC.arm.linux.org.uk>
 <20150921.120159.326170798236851436.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150921.120159.326170798236851436.davem@davemloft.net>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2015 at 12:01:59PM -0700, David Miller wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Date: Fri, 18 Sep 2015 10:54:55 +0100
> 
> > Update the comment, and arrange for the only user of this function
> > to drop this refcount when disposing of a reference to it.
> 
> mdio_mux is not the only user of of_mdio_find_bus(), DSA uses it as
> well.
> 
> So if anything this commit message is inaccurate.

Yes, I missed that as it wasn't under drivers/net.  It doesn't change
the validity of this patch, the existing code is wrong and I'm not
introducing anything that makes the code any more wrong than it is.

I'll fix the commit message, and I'll fix the DSA code too but in a
separate patch.  Thanks for pointing it out.

> I also wonder about this refcounting scheme.

It's the standard driver model refcounting rules that we've lived with
for about a decade, ever since the driver model was introduced by
Patrick Mochel.

> If you are going to drop the inner device reference, then we take the
> mdio bus returned from of_mdio_find_bus() what holds onto it and keeps
> it from disappearing on us?
> 
> Don't we have to hold onto some reference count of some kind here?

In the case of the mdio mux code, I'm dropping the reference when
either (a) we've encountered an error during initialisation and we're
cleaning up, or (b) when the mdio mux code is being torn down after
the mdiomux bus has been unregistered and freed.  In both cases, we're
done with the mdio bus that was returned from of_mdio_find_bus().

In case (a), the devres code will release the kmalloc'd memory when
mdio_mux_gpio_probe() or mdio_mux_mmioreg_probe() propagates the error
out of their probe() function.

I'm not sure why you think anything is wrong here - maybe it's the odd
code structure to the success path at the bottom of mdio_mux_init()?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
