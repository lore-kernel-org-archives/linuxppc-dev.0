Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 291B9DDFA5
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 06:57:22 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/5 v2] Add the platform device support with RapidIO to
	MPC8641HPCN platform.
Date: Wed, 27 Jun 2007 22:56:15 +0200
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<11829333481375-git-send-email-wei.zhang@freescale.com>
	<1182933348216-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <1182933348216-git-send-email-wei.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706272256.16418.arnd@arndb.de>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 27 June 2007, Zhang Wei wrote:
> +static struct of_device_id mpc86xx_of_ids[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{ .type =3D "soc", },
> +=A0=A0=A0=A0=A0=A0=A0{ .compatible =3D "fsl,rapidio-delta", },
> +=A0=A0=A0=A0=A0=A0=A0{},
> +};
> +
> +static __init int mpc86xx_of_device_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0return of_platform_bus_probe(NULL, mpc86xx_of_ids, =
NULL);
> +}

This will add any devices below the "fsl,rapidio-delta" device
as an of_device. Is that what you actually want? I would guess that
you want to add the bridge itself, not the devices below it.

Is the rapidio device at the root of the device tree, and if so, why
not under the soc bus?

	Arnd <><
