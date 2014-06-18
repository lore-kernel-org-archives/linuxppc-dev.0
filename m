Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62C071A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 01:28:37 +1000 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>
Subject: RE: [PATCH] fsl-rio: add support for mapping inbound windows
Date: Wed, 18 Jun 2014 15:17:31 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D15CC9575C@corpmail1.na.ads.idt.com>
References: <1402657758-3019-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
In-Reply-To: <1402657758-3019-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "stef.van.os@prodrive-technologies.com"
 <stef.van.os@prodrive-technologies.com>,
 Martijn de Gouw <martijn.de.gouw@prodrive.nl>, "Wood,
 Barry" <Barry.Wood@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, June 13, 2014 7:09 AM Martijn de Gouw [mailto:martijn.de.gouw@pr=
odrive-
technologies.com] wrote:

> Add support for mapping and unmapping of inbound rapidio windows.
>=20
> Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive.nl>
> ---
... skip ...

> +
> +int fsl_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
> +	u64 rstart, u32 size, u32 flags)
> +{
> +	struct rio_priv *priv =3D mport->priv;
> +	u32 base_size;
> +	unsigned int base_size_log;
> +	u64 win_start, win_end;
> +	u32 riwar;
> +	int i;
> +
> +	base_size_log =3D __ilog2(size) + ((size & (size - 1)) !=3D 0);
> +	base_size =3D 1 << base_size_log;
> +
> +	for (i =3D 0; i < RIO_INB_ATMU_COUNT; i++) {
> +		riwar =3D in_be32(&priv->inb_atmu_regs[i].riwar);
> +		if ((riwar & RIWAR_ENABLE) =3D=3D 0)
> +			break;
> +		/* check conflicting ranges */
> +		win_start =3D ((u64)(in_be32(&priv->inb_atmu_regs[i].riwbar) & RIWBAR_=
BADD_MASK))
> +			<< RIWBAR_BADD_VAL_SHIFT;
> +		win_end =3D win_start + ((1 << ((riwar & RIWAR_SIZE_MASK) + 1)) - 1);
> +		if (rstart < win_end && (rstart + size) > win_start)
> +			return -EINVAL;
> +	}

It looks like the check for conflicting ranges assumes sequential mapping r=
equests only.
This check will be missed if ATMU windows are dynamically mapped/unmapped o=
ut-of-order.
Because the unmap callback is implemented please consider possibility of us=
ing ATMU windows
in any order.
