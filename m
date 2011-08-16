Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6B2BB6F7B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 07:46:35 +1000 (EST)
Message-ID: <4E4AE535.4070400@freescale.com>
Date: Tue, 16 Aug 2011 16:46:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: Re: [PATCH] mtd/nand: Don't add disabled nand flash devices
References: <1313486855-15233-1-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1313486855-15233-1-git-send-email-Chunhe.Lan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: dwmw2@infradead.org, kumar.gala@freescale.com,
	linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/16/2011 04:27 AM, Chunhe Lan wrote:
> Nand flash nodes with the property status=3D"disabled" are not
> usable and so avoid adding "disabled" nand flash devices with
> the system.
>=20
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
>  drivers/mtd/nand/fsl_elbc_nand.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_el=
bc_nand.c
> index 33d8aad..8212c12 100644
> --- a/drivers/mtd/nand/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/fsl_elbc_nand.c
> @@ -1,6 +1,6 @@
>  /* Freescale Enhanced Local Bus Controller NAND driver
>   *
> - * Copyright =C2=A9 2006-2007, 2010 Freescale Semiconductor
> + * Copyright =C2=A9 2006-2007, 2010-2011 Freescale Semiconductor
>   *
>   * Authors: Nick Spence <nick.spence@freescale.com>,
>   *          Scott Wood <scottwood@freescale.com>
> @@ -849,6 +849,9 @@ static int __devinit fsl_elbc_nand_probe(struct pla=
tform_device *pdev)
>  	struct device *dev;
>  	struct device_node *node =3D pdev->dev.of_node;
> =20
> +	if (!of_device_is_available(node))
> +		return -ENODEV;
> +
>  	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
>  		return -ENODEV;
>  	lbc =3D fsl_lbc_ctrl_dev->regs;

Same comment as the other patch -- unavailable devices should already
not be getting probed.  Also, this subject line makes it sound like this
is a NAND subsystem change rather than a change in one specific driver.

-Scott
