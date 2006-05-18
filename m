Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (unknown [192.88.165.103])
	by ozlabs.org (Postfix) with ESMTP id 5EB1867A64
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 14:03:56 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k4I4E3TB016908
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 21:14:03 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k4I43q4Y007840
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 23:03:54 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: jgarzik@pobox.com
Subject: RE: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
Date: Thu, 18 May 2006 12:03:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Cc: Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]
Sent: 2006=E5=B9=B45=E6=9C=8817=E6=97=A5 21:28
To: Zang Roy-r61911
Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com; =
Yang Xin-Xin-r48390
Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on =
powerpc pl atform



On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:

> Fix Marvell SATA driver bugs on PowerPC platform:
> SATA device can't work for the problem on little-endian mode.
> U-Boot can't find SATA device after kernel reboots.
>
> Signed-off-by: Hongjun cheng	<hong-jun.chen@reescale.com>
> Signed-off-by: Roy Zang		<tie-fei.zang@freescale.com>
>
>> From nobody Mon Sep 17 00:00:00 2001
> From: roy zang <tie-fei.zang@freescale.com>
> Date: Tue May 16 15:25:23 2006 +0800
> Subject: [PATCH] Fix bugs on powerpc platform for mv sata driver

This needs to go to Jeff Garzik as SATA driver maintainer.

- kumar

>
>  drivers/scsi/sata_mv.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> d82ac19d259f8487a31105eaf844a93cbd9008e8
> diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
> index d5fdcb9..4166422 100644
> --- a/drivers/scsi/sata_mv.c
> +++ b/drivers/scsi/sata_mv.c
> @@ -1032,6 +1032,9 @@ static inline void mv_crqb_pack_cmd(u16
>  {
>  	*cmdw =3D data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>  		(last ? CRQB_CMD_LAST : 0);
> +#ifdef CONFIG_PPC
> +	*cmdw =3D cpu_to_le16(*cmdw);
> +#endif
>  }
>
>  /**
> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void =20
> __iomem *mmio)
>  {
>  	u32 tmp;
> -
> +#ifndef CONFIG_PPC
>  	writel(0, mmio + MV_GPIO_PORT_CTL);
> +#endif
>
>  	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
>
>  	tmp =3D readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
> +#ifdef CONFIG_PPC
> +	tmp &=3D ~(1 << 0);
> +#else=09
>  	tmp |=3D ~(1 << 0);
> +#endif
>  	writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
>  }
>
> --=20
> 1.3.0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
