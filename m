Return-Path: <jason@lakedaemon.net>
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 428502C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 06:35:48 +1100 (EST)
Date: Thu, 14 Mar 2013 13:25:44 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 0/5] mv643xx_eth: use mvmdio MDIO bus driver
Message-ID: <20130314172544.GT12700@titan.lakedaemon.net>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359473048-26551-1-git-send-email-florian@openwrt.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Lennert Buytenhek <buytenh@wantstofly.org>,
 Rob Landley <rob@landley.net>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Florian,

Any word on version 2 of this series?  I'd like to base the conversion
of kirkwood to DT based ethernet init on it.

thx,

Jason.

On Tue, Jan 29, 2013 at 04:24:03PM +0100, Florian Fainelli wrote:
> Hi all,
> 
> This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus driver
> instead of rolling its own implementation. As a result, all users of this
> mv643xx_eth driver are converted to register an "orion-mdio" platform_device.
> The mvmdio driver is also updated to support an interrupt line which reports
> SMI error/completion, and to allow traditionnal platform device registration
> instead of just device tree.
> 
> David, I think it makes sense for you to merge all of this, since we do
> not want the architecture files to be desynchronized from the mv643xx_eth to
> avoid runtime breakage. The potential for merge conflicts should be very small.
> 
> You can probably safely merge patches 1 to 4 if Thomas agrees, and we will
> see what kind of feeback I get on patch 5.
> 
> Florian Fainelli (5):
>   net: mvmdio: unmap base register address at driver removal
>   net: mvmdio: rename base register cookie from smireg to regs
>   net: mvmdio: enhance driver to support SMI error/done interrupts
>   net: mvmdio: allow Device Tree and platform device to coexist
>   mv643xx_eth: convert to use the Marvell Orion MDIO driver
> 
>  .../devicetree/bindings/net/marvell-orion-mdio.txt |    3 +
>  arch/arm/plat-orion/common.c                       |   84 +++++++--
>  arch/powerpc/platforms/chrp/pegasos_eth.c          |   20 +++
>  arch/powerpc/sysdev/mv64x60_dev.c                  |   14 +-
>  drivers/net/ethernet/marvell/Kconfig               |    1 +
>  drivers/net/ethernet/marvell/mv643xx_eth.c         |  187 +-------------------
>  drivers/net/ethernet/marvell/mvmdio.c              |  136 +++++++++++---
>  7 files changed, 226 insertions(+), 219 deletions(-)
> 
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
