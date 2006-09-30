Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id D90E967A39
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 20:36:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 4/6]: powerpc/cell spidernet ethtool -i version number
	info.
Date: Sat, 30 Sep 2006 12:33:45 +0200
References: <20060929230552.GG6433@austin.ibm.com>
	<20060929232139.GL6433@austin.ibm.com>
In-Reply-To: <20060929232139.GL6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609301233.45871.arnd@arndb.de>
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Saturday 30 September 2006 01:21 schrieb Linas Vepstas:
> This patch adds version information as reported by
> ethtool -i to the Spidernet driver.
>
> From: James K Lewis <jklewis@us.ibm.com>
> Signed-off-by: James K Lewis <jklewis@us.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Same comment as last time this was submitted:

> @@ -2303,6 +2304,8 @@ static struct pci_driver spider_net_driv
> =A0 */
> =A0static int __init spider_net_init(void)
> =A0{
> +=A0=A0=A0=A0=A0=A0=A0printk("spidernet Version %s.\n",VERSION);
> +
> =A0=A0=A0=A0=A0=A0=A0=A0if (rx_descriptors < SPIDER_NET_RX_DESCRIPTORS_MI=
N) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rx_descriptors =3D SPIDER=
_NET_RX_DESCRIPTORS_MIN;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr_info("adjusting rx des=
criptors to %i.\n",

This is missing a printk level and a space character. More importantly,
you should not print the presence of the driver to the syslog, but
the presence of a device driven by it.

	Arnd <><
