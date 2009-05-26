Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: David Miller <davem@davemloft.net>
Subject: Re: [net-next-2.6 PATCH v2] can: SJA1000: generic OF platform bus
	driver
Date: Tue, 26 May 2009 10:42:05 +0100
References: <200905242327.15139.arnd@arndb.de>
	<200905261010.31364.arnd@arndb.de>
	<20090526.022508.238274281.davem@davemloft.net>
In-Reply-To: <20090526.022508.238274281.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200905261042.05967.arnd@arndb.de>
Cc: devicetree-discuss@ozlabs.org, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Greg Ungerer <gerg@uclinux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 26 May 2009, David Miller wrote:
> It's such a baroque thing, there is no reason to set it at all if you
> ask me.  It's only use is to allow ISA and similar primitive bus
> devices to have their I/O ports changed via ifconfig.

My original comment was about the fact that sja1000 was doing
dev->base_addr = (unsigned long)ioremap(phys_addr, size), I didn't
even think about SIOCGIFMAP and command line overrides, but that
surely makes it worse and the driver should be changed to
store the virtual register address in its private data structure.

drivers/net/fec.c seems to have the same problem, which manifests
in a number of ugly casts and direct pointer dereferences in places
where it should do writel() or out_be32().

	Arnd <><
