Return-Path: <f.fainelli@gmail.com>
Sender: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <514300E0.2030108@openwrt.org>
Date: Fri, 15 Mar 2013 12:07:12 +0100
From: Florian Fainelli <florian@openwrt.org>
MIME-Version: 1.0
To: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 4/4 v2] mv643xx_eth: convert to use the Marvell Orion
 MDIO driver
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-5-git-send-email-florian@openwrt.org>
In-Reply-To: <1363284515-9865-5-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
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

Le 03/14/13 19:08, Florian Fainelli a écrit :
> This patch converts the Marvell MV643XX ethernet driver to use the
> Marvell Orion MDIO driver. As a result, PowerPC and ARM platforms
> registering the Marvell MV643XX ethernet driver are also updated to
> register a Marvell Orion MDIO driver. This driver voluntarily overlaps
> with the Marvell Ethernet shared registers because it will use a subset
> of this shared register (shared_base + 0x4 - shared_base + 0x84). The
> Ethernet driver is also updated to look up for a PHY device using the
> Orion MDIO bus driver.

Thanks to the help of Andrew Lunn, there is at least two known issues 
with this patch version:

- we need to move up the mvmdio line in 
drivers/net/ethernet/marvell/Makefile to make sure that configs having 
both mvmdio and mv643xx_eth built-in get the probing order right
- the bus name used by mv643xx_eth is not the right now (orion-mdio.0 vs 
expected orion-mdio) so the PHY device will not be found during 
phy_connect()

I will fix these two issues in the next version of the patchset.
--
Florian
