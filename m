Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id CA6A4DDF6F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:18:54 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/13] powerpc: Add arch/powerpc mv64x60_eth platform data
	setup
Date: Thu, 26 Apr 2007 02:18:45 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000009.GJ4046@mag.az.mvista.com>
In-Reply-To: <20070426000009.GJ4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260218.45503.arnd@arndb.de>
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
> Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60.c
> +++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
> @@ -511,3 +511,138 @@ ret_node_put:
> =A0}
> =A0
> =A0arch_initcall(mv64x60_mpsc_platform_device_init);
> +
> +/*
> + * Create mv64x60_eth platform device
> + */
> +static int __init eth_register_shared_pdev(struct device_node *np)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct platform_device *pdev;

No need to put this into architecture specific code, just register
the of_platform_driver from mv643xx_init_module and use the device
you get passed in there.

Once arch/ppc is dead, you can remove the platform_driver from mv643xx
entirely.

	Arnd <><
