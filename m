Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 03679DDF7F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:25:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/13] powerpc: Add arch/powerpc mv64x60 PCI setup
Date: Thu, 26 Apr 2007 02:25:27 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000107.GL4046@mag.az.mvista.com>
In-Reply-To: <20070426000107.GL4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260225.27740.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Mark A. Greer wrote:
> +void __init mv64x60_pci_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct device_node *np =3D NULL;
> +
> +=A0=A0=A0=A0=A0=A0=A0ppc_md.pci_exclude_device =3D mv64x60_exclude_devic=
e;
> +
> +=A0=A0=A0=A0=A0=A0=A0while ((np =3D of_find_compatible_node(np, "pci", "=
mv64x60-pci")))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mv64x60_add_bridge(np);
> +}

This is a similar mistake to the previous two, but somewhat different:

You actually duplicate code that is already present in of_platform.c.
AFAICS, all you should need to do is implement the ppc_md.pci_setup_phb()
function instead of your own handmade device tree scanning.

	Arnd <><
