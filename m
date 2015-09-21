Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68F241A0293
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 08:08:31 +1000 (AEST)
Date: Mon, 21 Sep 2015 15:08:27 -0700 (PDT)
Message-Id: <20150921.150827.116958889622345434.davem@redhat.com>
To: linux@arm.linux.org.uk
Cc: f.fainelli@gmail.com, devicetree@vger.kernel.org, frowand.list@gmail.com,
 grant.likely@linaro.org, isubramanian@apm.com, kchudgar@apm.com,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 leoli@freescale.com, michal.simek@xilinx.com, netdev@vger.kernel.org,
 rric@kernel.org, robh+dt@kernel.org, soren.brinkmann@xilinx.com,
 sgoutham@cavium.com, thomas.petazzoni@free-electrons.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] phy: fix of_mdio_find_bus() device refcount leak
From: David Miller <davem@redhat.com>
In-Reply-To: <20150921193206.GU21084@n2100.arm.linux.org.uk>
References: <E1ZcsNb-0001Bf-U5@rmk-PC.arm.linux.org.uk>
 <20150921.120159.326170798236851436.davem@davemloft.net>
 <20150921193206.GU21084@n2100.arm.linux.org.uk>
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

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 21 Sep 2015 20:32:07 +0100

> In the case of the mdio mux code, I'm dropping the reference when
> either (a) we've encountered an error during initialisation and
> we're cleaning up, or (b) when the mdio mux code is being torn down
> after the mdiomux bus has been unregistered and freed.  In both
> cases, we're done with the mdio bus that was returned from
> of_mdio_find_bus().
> 
> In case (a), the devres code will release the kmalloc'd memory when
> mdio_mux_gpio_probe() or mdio_mux_mmioreg_probe() propagates the error
> out of their probe() function.
> 
> I'm not sure why you think anything is wrong here - maybe it's the odd
> code structure to the success path at the bottom of mdio_mux_init()?

Ok I may have misread your change.  I'll restudy it when you respin
the series with the commit message fixed and the DSA change added.

Thanks.
