Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 9ED0CDDDD5
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 06:39:23 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/5 v3] Add the platform device support with RapidIO to
	MPC8641HPCN platform.
Date: Sun, 29 Jul 2007 15:56:35 +0200
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393741899-git-send-email-wei.zhang@freescale.com>
	<11854393753986-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11854393753986-git-send-email-wei.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707291556.35632.arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 July 2007, Zhang Wei wrote:
> +
> +static struct of_device_id mpc86xx_of_ids[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{ .type =3D "soc", },
> +=A0=A0=A0=A0=A0=A0=A0{ .compatible =3D "fsl,rapidio-delta", },
> +=A0=A0=A0=A0=A0=A0=A0{},
> +};

With the device tree source you have posted in 2/5, the rapidio node is
a child of the soc bus, and it doesn't have any children of its own.
Therefore it is completely equivalent to _only_ add the soc type
to mpc86xx_of_ids[], as in=20

static struct of_device_id mpc86xx_of_ids[] =3D {
       { .type =3D "soc", },
       {},
};

Even if you intend to add children to the rapidio node in the future,
I'd think it would be more appropriate to have those scanned by
the rapidio bus driver, not by of_platform.

	Arnd <><
