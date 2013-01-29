Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Tue, 29 Jan 2013 17:01:31 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 5/5] mv643xx_eth: convert to use the Marvell Orion MDIO
 driver
Message-ID: <20130129170131.7964a110@skate>
In-Reply-To: <1359473048-26551-6-git-send-email-florian@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-6-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, netdev@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org,
 Rob Landley <rob@landley.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Florian Fainelli,

On Tue, 29 Jan 2013 16:24:08 +0100, Florian Fainelli wrote:
> This patch converts the Marvell MV643XX ethernet driver to use the
> Marvell Orion MDIO driver. As a result, PowerPC and ARM platforms
> registering the Marvell MV643XX ethernet driver are also updated to
> register a Marvell Orion MDIO driver. This driver voluntarily overlaps
> with the Marvell Ethernet shared registers because it will use a subset
> of this shared register (shared_base + 0x4 - shared_base + 0x84). The
> Ethernet driver is also updated to look up for a PHY device using the
> Orion MDIO bus driver.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/arm/plat-orion/common.c               |   84 +++++++++++--

In this file, there was one "MV643XX_ETH_SHARED_NAME" platform_device
registered for each network interface. Why? If the driver is shared,
isn't the whole idea to register it only once?

In any case, one of the idea of separating the mvmdio driver from the
mvneta driver in the first place is that there should be only one
instance of the mvmdio device, even if there are multiple network
interfaces. The reason is that from a HW point of the view, the MDIO
unit is shared between the network interfaces. If you look at
armada-370-xp.dtsi, there is only one mvmdio device registered, and two
network interfaces (using the mvneta driver) that are registered (and
actually up to four network interfaces can exist, they are added by
some other .dtsi files depending on the specific SoC).

So I don't think there should be one instance of the mvmdio per network
interface.

Also, I am wondering what's left in this MV643XX_ETH_SHARED_NAME driver
once the MDIO stuff has been pulled out in a separate driver? I think
the whole point of this work should be to get rid of this
MV643XX_ETH_SHARED_NAME driver, no?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
