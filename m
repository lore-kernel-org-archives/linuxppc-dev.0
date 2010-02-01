Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com
	[209.85.211.172]) by ozlabs.org (Postfix) with ESMTP id 11831B7D4E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 08:57:53 +1100 (EST)
Received: by ywh2 with SMTP id 2so729538ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Feb 2010 13:57:51 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1263456799-3306-2-git-send-email-yu.liu@freescale.com>
References: <1263456799-3306-1-git-send-email-yu.liu@freescale.com>
	<1263456799-3306-2-git-send-email-yu.liu@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 1 Feb 2010 14:57:31 -0700
Message-ID: <fa686aa41002011357pb24d8a6k640ab5ae13f8fbbc@mail.gmail.com>
Subject: Re: [PATCH 2/4] mpc8569mds: Add bscr setting for rtbi mode
To: Liu Yu <yu.liu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 14, 2010 at 1:13 AM, Liu Yu <yu.liu@freescale.com> wrote:
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> =A0arch/powerpc/platforms/85xx/mpc85xx_mds.c | =A0 24 +++++++++++++++++++=
+++++
> =A01 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/pla=
tforms/85xx/mpc85xx_mds.c
> index c5028a2..0872e4a 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -237,6 +237,8 @@ static void __init mpc85xx_mds_setup_arch(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (machine_is(mpc8569_mds)) {
> =A0#define BCSR7_UCC12_GETHnRST =A0 (0x1 << 2)
> =A0#define BCSR8_UEM_MARVELL_RST =A0(0x1 << 1)
> +#define BCSR_UCC_RGMII =A0 =A0 =A0 =A0 (0x1 << 6)
> +#define BCSR_UCC_RTBI =A0 =A0 =A0 =A0 =A0(0x1 << 5)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * U-Boot mangles interrup=
t polarity for Marvell PHYs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * so reset built-in and U=
EM Marvell PHYs, this puts
> @@ -247,6 +249,28 @@ static void __init mpc85xx_mds_setup_arch(void)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setbits8(&bcsr_regs[7], BC=
SR7_UCC12_GETHnRST);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clrbits8(&bcsr_regs[8], BC=
SR8_UEM_MARVELL_RST);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (np =3D NULL; (np =3D o=
f_find_compatible_node(np,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "network",

Don't match on the 'type' field.  Replace "network" with NULL and just
rely on "ucc_geth" for matching.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ucc_geth")) !=3D NULL;) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const unsig=
ned int *prop;

u32 please.

Also, rather than reusing 'prop' for both char* and u32 values, which
forces you to use ugly casts, use 2 local variables here.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ucc_num=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of=
_get_property(np, "cell-index", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop =
=3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucc_num =3D=
 *prop - 1;

Ugh.  No bounds checking...

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of=
_get_property(np, "phy-connection-type", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop =
=3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(=
"rtbi", (const char *)prop) =3D=3D 0)

(This is the ugly cast I was talking about.)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 clrsetbits_8(&bcsr_regs[7 + ucc_num],

...not having bounds checking could result in badness in this array index.

This patch is dangerous as written.

Finally, while using cell-index seems convenient, I think it would be
better to have a lookup table of the index into the BCSR register
block from the UCC base address, which also gives you implicit bounds
checking.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
