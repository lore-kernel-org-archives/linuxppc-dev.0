Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 2379167B64
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 08:56:58 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6]: powerpc/cell spidernet ethtool -i version number
	info.
Date: Sat, 19 Aug 2006 00:56:34 +0200
References: <20060818220700.GG26889@austin.ibm.com>
	<20060818222500.GK26889@austin.ibm.com>
In-Reply-To: <20060818222500.GK26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608190056.35775.arnd@arndb.de>
Cc: akpm@osdl.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 19 August 2006 00:25, Linas Vepstas wrote:
> This patch adds version information as reported by=20
> ethtool -i to the Spidernet driver.

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

except for

> @@ -2293,6 +2294,8 @@ static struct pci_driver spider_net_driv
> =A0 */
> =A0static int __init spider_net_init(void)
> =A0{
> +=A0=A0=A0=A0=A0=A0=A0printk("spidernet Version %s.\n",VERSION);
> +

This printk is missing a level (KERN_INFO or similar). Moreover,
it is rather strange for a driver to print a message when no
device is actually used by it. I'd rather drop the version
printk completely, but I know that Jim has strong feelings about
what to do with version information. I suggest that if we decide
to keep something like that in the driver, it should be printed
in spider_net_probe().

	Arnd <><
