Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC4BC2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 04:16:10 +1000 (EST)
Date: Tue, 30 Apr 2013 13:15:51 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
To: Anthony Foiani <tkil@scrye.com>
In-Reply-To: <517F67AD.2010101@scrye.com> (from tkil@scrye.com on Tue Apr 30
 01:41:49 2013)
Message-ID: <1367345751.24133.0@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>, Anthony Foiani <tkil@scrye.com>,
 "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/30/2013 01:41:49 AM, Anthony Foiani wrote:
> Apologies for resurrecting a very old thread, but...
>=20
> On 05/30/2012 02:14 PM, Anthony Foiani wrote:
>>=20
>> Maybe someone who knows devtree really well could crank that out in a
>> few minutes... but I'm not that person.  :)
> Well, I wasn't last year, but this year I decided that I didn't =20
> care.  Took me about an hour, not a minute, but...
>=20
> Having been bitten by this config symbol disappearing one more time, =20
> please find attached my attempt at using information out of the =20
> device tree to enable this hack.
>=20
> Patch is against 3.4.36 or so; hopefully upstream hasn't diverged =20
> very much.
>=20
> Tested by me, so feel free to add that tag if required.
>=20
> Thanks,
> Anthony Foiani

------quoted attachment =20
"0001-sata-fsl-allow-device-tree-to-limit-sata-speed.patch"------
> >From c0a85758a669b430c0a6af825e71d18a54ef88d0 Mon Sep 17 00:00:00 =20
> 2001
> From: Anthony Foiani <anthony.foiani@gmail.com>
> Date: Mon, 29 Apr 2013 23:44:14 -0600
> Subject: [PATCH] sata: fsl: allow device tree to limit sata speed.
>=20
> There used to be an "orphan" config symbol (CONFIG_MPC8315_DS) that
> would artificially limit SATA speed to generation 1 (1.5Gbps).
>=20
> Since that config symbol got lost whenever any sort of configuration
> was done, we instead extract the limitation from the device tree.
>=20
> Signed-off-by: Anthony Foiani <anthony.foiani@gmail.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/board.txt      | 23 +++++++++++
>  drivers/ata/sata_fsl.c                             | 44 =20
> ++++++++++++++++++----
>  2 files changed, 59 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt =20
> b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> index 380914e..6a30398 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> @@ -67,3 +67,26 @@ Example:
>  			gpio-controller;
>  		};
>  	};
> +
> +* Maximum SATA Generation workaround
> +
> +Some boards advertise SATA speeds that they cannot actually achieve.
> +Previously, this was dealt with via the orphaned config symbol
> +CONFIG_MPC8315_DS.  We now have a device tree property
> +"fsl,sata-max-gen" to control this.  It should live within the "sata"
> +block.
> +
> +Example:
> +
> +		sata@18000 {
> +			compatible =3D "fsl,mpc8315-sata", "fsl,pq-sata";
> +			reg =3D <0x18000 0x1000>;
> +			cell-index =3D <1>;
> +			interrupts =3D <44 0x8>;
> +			interrupt-parent =3D <&ipic>;
> +			fsl,sata-max-gen =3D <1>;
> +		};
> +

This might be OK for a new board, but adding it now means that people =20
using existing device trees won't get the workaround.  It might be =20
better to just put the knowledge in platform code.

> +By default, there is no limitation; if a value is given, it indicates
> +the maximum "generation" that should be negotiated.  Gen 1 is =20
> 1.5Gbps,
> +Gen 2 is 3.0Gbps.
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index d6577b9..6d3ec47 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -274,6 +274,17 @@ struct sata_fsl_port_priv {
>  };
>=20
>  /*
> + * speed negotiation.
> + */
> +
> +enum {
> +	SCR_SPEED_NEG_MASK	=3D 0xf0,
> +	SCR_SPEED_NEG_UNLIMITED	=3D 0x00,
> +	SCR_SPEED_NEG_GEN_1	=3D 0x10, /* 1.5Gbps max */
> +	SCR_SPEED_NEG_GEN_2	=3D 0x20  /* 3.0Gbps max */
> +};
> +
> +/*
>   * ata_port->host_set private data
>   */
>  struct sata_fsl_host_priv {
> @@ -282,6 +293,7 @@ struct sata_fsl_host_priv {
>  	void __iomem *csr_base;
>  	int irq;
>  	int data_snoop;
> +	u32 speed_neg;
>  	struct device_attribute intr_coalescing;
>  };
>=20
> @@ -726,19 +738,23 @@ static int sata_fsl_port_start(struct ata_port =20
> *ap)
>  	VPRINTK("HControl =3D 0x%x\n", ioread32(hcr_base + HCONTROL));
>  	VPRINTK("CHBA  =3D 0x%x\n", ioread32(hcr_base + CHBA));
>=20
> -#ifdef CONFIG_MPC8315_DS
>  	/*
>  	 * Workaround for 8315DS board 3gbps link-up issue,
>  	 * currently limit SATA port to GEN1 speed
>  	 */
> -	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
> -	temp &=3D ~(0xF << 4);
> -	temp |=3D (0x1 << 4);
> -	sata_fsl_scr_write(&ap->link, SCR_CONTROL, temp);
> +	if ( host_priv->speed_neg !=3D SCR_SPEED_NEG_UNLIMITED )
> +	{
>=20
> -	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
> -	dev_warn(dev, "scr_control, speed limited to %x\n", temp);
> -#endif
> +		u32 orig;
> +		sata_fsl_scr_read(&ap->link, SCR_CONTROL, &orig);
> +		temp =3D ( ( orig                 & ~SCR_SPEED_NEG_MASK ) =20
> |
> +			 ( host_priv->speed_neg &  SCR_SPEED_NEG_MASK ) =20
> );
> +		sata_fsl_scr_write(&ap->link, SCR_CONTROL, temp);
> +
> +		sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
> +		dev_warn(dev, "speed limited, scr_control 0x%x -> =20
> 0x%x\n",
> +			 orig, temp);
> +	}
>=20
>  	return 0;
>  }
> @@ -1437,6 +1453,18 @@ static int sata_fsl_probe(struct =20
> platform_device *ofdev)
>  	else
>  		host_priv->data_snoop =3D DATA_SNOOP_ENABLE_V1;
>=20
> +	if (!of_property_read_u32(ofdev->dev.of_node, =20
> "fsl,sata-max-gen",
> +				  &temp))
> +	{
> +		switch (temp)
> +		{
> +		case 1: host_priv->speed_neg =3D SCR_SPEED_NEG_GEN_1; =20
> break;
> +		case 2: host_priv->speed_neg =3D SCR_SPEED_NEG_GEN_2; =20
> break;
> +		}
> +		dev_warn(&ofdev->dev, "speed limit set to gen %u =20
> (0x%x)\n",
> +			 temp, host_priv->speed_neg);
> +	}
> +
>  	/* allocate host structure */
>  	host =3D ata_host_alloc_pinfo(&ofdev->dev, ppi, =20
> SATA_FSL_MAX_PORTS);
>  	if (!host) {

Please use standard Linux coding style, and submit the patch inline =20
rather than as an attachment (e.g. use git send-email).

-Scott=
