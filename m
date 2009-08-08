Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9443B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 15:43:55 +1000 (EST)
Received: from mail-gx0-f212.google.com (mail-gx0-f212.google.com
	[209.85.217.212]) by ozlabs.org (Postfix) with ESMTP id AE38ADDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 15:43:53 +1000 (EST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1247834363-28198-1-git-send-email-w.sang@pengutronix.de>
References: <1247834363-28198-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 7 Aug 2009 23:43:32 -0600
Message-ID: <fa686aa40908072243x56d2160fk688149f4b7b912ae@mail.gmail.com>
Subject: Re: [PATCH] mtd/maps: add mtd-ram support to physmap_of
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@ozlabs.org, Vitaly Wool <vwool@ru.mvista.com>,
	Artem Bityutskiy <dedekind@infradead.org>,
	=?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ken MacLeod <ken@bitsko.slc.ut.us>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 17, 2009 at 6:39 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> Use physmap_of to access RAMs as mtd and add documenation for it. This ap=
proach
> is a lot less intrusive as adding an of-wrapper around plat-ram.c. As mos=
t
> extensions of plat-ram.c (e.g. custom map-functions) can't be mapped to t=
he
> device tree anyhow, extending physmap_of seems to be the cleanest approac=
h.
>
> Tested with a phyCORE-MPC5121e.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Looks good to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> Cc: Vitaly Wool <vwool@ru.mvista.com>
> Cc: Artem Bityutskiy <dedekind@infradead.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Ken MacLeod <ken@bitsko.slc.ut.us>
> Cc: Albrecht Dre=DF <albrecht.dress@arcor.de>
> ---
> =A0Documentation/powerpc/dts-bindings/mtd-physmap.txt | =A0 42 ++++++++++=
++-------
> =A0drivers/mtd/maps/physmap_of.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A04 ++
> =A02 files changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/mtd-physmap.txt b/Documen=
tation/powerpc/dts-bindings/mtd-physmap.txt
> index 667c9bd..80152cb 100644
> --- a/Documentation/powerpc/dts-bindings/mtd-physmap.txt
> +++ b/Documentation/powerpc/dts-bindings/mtd-physmap.txt
> @@ -1,18 +1,19 @@
> -CFI or JEDEC memory-mapped NOR flash
> +CFI or JEDEC memory-mapped NOR flash, MTD-RAM (NVRAM...)
>
> =A0Flash chips (Memory Technology Devices) are often used for solid state
> =A0file systems on embedded devices.
>
> - - compatible : should contain the specific model of flash chip(s)
> - =A0 used, if known, followed by either "cfi-flash" or "jedec-flash"
> - - reg : Address range(s) of the flash chip(s)
> + - compatible : should contain the specific model of mtd chip(s)
> + =A0 used, if known, followed by either "cfi-flash", "jedec-flash"
> + =A0 or "mtd-ram".
> + - reg : Address range(s) of the mtd chip(s)
> =A0 =A0It's possible to (optionally) define multiple "reg" tuples so that
> - =A0 non-identical NOR chips can be described in one flash node.
> - - bank-width : Width (in bytes) of the flash bank. =A0Equal to the
> + =A0 non-identical chips can be described in one node.
> + - bank-width : Width (in bytes) of the bank. =A0Equal to the
> =A0 =A0device width times the number of interleaved chips.
> - - device-width : (optional) Width of a single flash chip. =A0If
> + - device-width : (optional) Width of a single mtd chip. =A0If
> =A0 =A0omitted, assumed to be equal to 'bank-width'.
> - - #address-cells, #size-cells : Must be present if the flash has
> + - #address-cells, #size-cells : Must be present if the device has
> =A0 =A0sub-nodes representing partitions (see below). =A0In this case
> =A0 =A0both #address-cells and #size-cells must be equal to 1.
>
> @@ -22,24 +23,24 @@ are defined:
> =A0- vendor-id : Contains the flash chip's vendor id (1 byte).
> =A0- device-id : Contains the flash chip's device id (1 byte).
>
> -In addition to the information on the flash bank itself, the
> +In addition to the information on the mtd bank itself, the
> =A0device tree may optionally contain additional information
> -describing partitions of the flash address space. =A0This can be
> +describing partitions of the address space. =A0This can be
> =A0used on platforms which have strong conventions about which
> -portions of the flash are used for what purposes, but which don't
> +portions of a flash are used for what purposes, but which don't
> =A0use an on-flash partition table such as RedBoot.
>
> -Each partition is represented as a sub-node of the flash device.
> +Each partition is represented as a sub-node of the mtd device.
> =A0Each node's name represents the name of the corresponding
> -partition of the flash device.
> +partition of the mtd device.
>
> =A0Flash partitions
> - - reg : The partition's offset and size within the flash bank.
> - - label : (optional) The label / name for this flash partition.
> + - reg : The partition's offset and size within the mtd bank.
> + - label : (optional) The label / name for this partition.
> =A0 =A0If omitted, the label is taken from the node name (excluding
> =A0 =A0the unit address).
> =A0- read-only : (optional) This parameter, if present, is a hint to
> - =A0 Linux that this flash partition should only be mounted
> + =A0 Linux that this partition should only be mounted
> =A0 =A0read-only. =A0This is usually used for flash partitions
> =A0 =A0containing early-boot firmware images or data which should not
> =A0 =A0be clobbered.
> @@ -78,3 +79,12 @@ Here an example with multiple "reg" tuples:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0x04000000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0};
> +
> +An example using SRAM:
> +
> + =A0 =A0 =A0 sram@2,0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "samsung,k6f1616u6a", "mtd-r=
am";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <2 0 0x00200000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <2>;
> + =A0 =A0 =A0 };
> +
> diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.=
c
> index 39d357b..45eee20 100644
> --- a/drivers/mtd/maps/physmap_of.c
> +++ b/drivers/mtd/maps/physmap_of.c
> @@ -360,6 +360,10 @@ static struct of_device_id of_flash_match[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.data =A0 =A0 =A0 =A0 =A0 =3D (void *)"jed=
ec_probe",
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .compatible =A0 =A0 =3D "mtd-ram",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =A0 =A0 =A0 =A0 =A0 =3D (void *)"map_=
ram",
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =A0 =A0 =A0 =A0 =A0 =3D "rom",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.compatible =A0 =A0 =3D "direct-mapped"
> =A0 =A0 =A0 =A0},
> --
> 1.6.3.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
