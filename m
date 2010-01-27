Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
	[209.85.211.175]) by ozlabs.org (Postfix) with ESMTP id 1E266B8131
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 03:44:17 +1100 (EST)
Received: by ywh5 with SMTP id 5so12775392ywh.11
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 08:44:16 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1264594052-20317-4-git-send-email-agust@denx.de>
References: <1264594052-20317-1-git-send-email-agust@denx.de>
	<1264594052-20317-4-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 27 Jan 2010 09:43:56 -0700
Message-ID: <fa686aa41001270843u3b4e9687k699ad579de4460d4@mail.gmail.com>
Subject: Re: [PATCH 3/8 v2] mtd: Add MPC5121 NAND Flash Controller driver
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2010 at 5:07 AM, Anatolij Gustschin <agust@denx.de> wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>

Again, it is appropriate for you to claim patch ownership now as long
as you preserve the signed-off-by history.

>
> Adds NAND Flash Controller driver for MPC5121 Revision 2.
> All device features, except hardware ECC and power management,
> are supported.

A few comments below.

> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index 4745028..6b8314c 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -82,6 +82,7 @@ void __init mpc512x_init_IRQ(void)
> =A0static struct of_device_id __initdata of_bus_ids[] =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5121-immr", },
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5121-localbus", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-nfc", },
> =A0 =A0 =A0 =A0{},
> =A0};

This hunk shouldn't be in this patch since it touches arch code.  Keep
the NAND and arch bits in separate patches.

Also, this is probably not what you really want.  Doing it this way
means that each of the child nodes also get registered as of_platform
devices.  You want the platform code to only register the nfc@40000000
node.

> +static int __init mpc5121_nfc_probe(struct of_device *op,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct of_device_id *match)

__devinit

> +{
> + =A0 =A0 =A0 struct device_node *rootnode, *dn =3D op->node;
> + =A0 =A0 =A0 struct device *dev =3D &op->dev;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv;
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 struct mtd_info *mtd;
> +#ifdef CONFIG_MTD_PARTITIONS
> + =A0 =A0 =A0 struct mtd_partition *parts;
> +#endif
> + =A0 =A0 =A0 struct nand_chip *chip;
> + =A0 =A0 =A0 unsigned long regs_paddr, regs_size;
> + =A0 =A0 =A0 const uint *chips_no;
> + =A0 =A0 =A0 int resettime =3D 0;
> + =A0 =A0 =A0 int retval =3D 0;
> + =A0 =A0 =A0 int rev, len;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Check SoC revision. This driver supports only NFC
> + =A0 =A0 =A0 =A0* in MPC5121 revision 2.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 rev =3D (mfspr(SPRN_SVR) >> 4) & 0xF;
> + =A0 =A0 =A0 if (rev !=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "SoC revision %u is not suppor=
ted!\n", rev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
> + =A0 =A0 =A0 }

*Only* revision 2?  Are future revisions of silicon assumed to be broken th=
en?

> +static int __exit mpc5121_nfc_remove(struct of_device *op)

__devexit

> +static struct of_device_id mpc5121_nfc_match[] =3D {

...match[] __devinitdata =3D {

> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-nfc", },
> + =A0 =A0 =A0 {},
> +};
> +
> +static struct of_platform_driver mpc5121_nfc_driver =3D {
> + =A0 =A0 =A0 .match_table =A0 =A0=3D mpc5121_nfc_match,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mpc5121_nfc_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(mpc5121_nfc_remove),

__devexit_p()

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
