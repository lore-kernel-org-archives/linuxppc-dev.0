Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: devicetree-discuss@ozlabs.org
Subject: Re: [net-next-2.6 PATCH v2] can: SJA1000: generic OF platform bus
	driver
Date: Sat, 23 May 2009 13:15:56 +0200
References: <4A16BAAE.3070401@grandegger.com>
In-Reply-To: <4A16BAAE.3070401@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905231315.57016.arnd@arndb.de>
Cc: Linux Netdev List <netdev@vger.kernel.org>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 22 May 2009, Wolfgang Grandegger wrote:
> This patch adds a generic driver for SJA1000 chips on the OpenFirmware
> platform bus found on embedded PowerPC systems. 

Nice driver!

> +static u8 sja1000_ofp_read_reg(const struct net_device *dev, int reg)
> +{
> +	return in_8((void __iomem *)(dev->base_addr + reg));
> +}
> +
> +static void sja1000_ofp_write_reg(const struct net_device *dev, int reg, u8 val)
> +{
> +	out_8((void __iomem *)(dev->base_addr + reg), val);
> +}

Minor nitpicking: dev->base_addr should be defined as an __iomem pointer
so you can avoid the cast here and in the ioremap/iounmap path.

	Arnd <><
