Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 947DEDDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 10:00:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 51/61] cpm_uart: Be an of_platform device when using
	arch/powerpc.
Date: Thu, 19 Jul 2007 01:59:52 +0200
References: <20070718013606.GW15238@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070718013606.GW15238@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707190159.52695.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 18 July 2007, Scott Wood wrote:
> +
> +static struct of_device_id cpm_uart_match[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.compatible =3D "fsl,cpm-ua=
rt",
> +=A0=A0=A0=A0=A0=A0=A0},
> +=A0=A0=A0=A0=A0=A0=A0{}
> =A0};
> +

I guess it's fine as it is, but it might be nicer if you change
this to have separate entries for scc and smc, and then pass
different values though of_device_id->data into the probe()
function.

Not sure if it makes much difference at all, but that's what
I did in the of_serial driver.

	Arnd <><
