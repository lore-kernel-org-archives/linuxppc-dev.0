Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A8808DDECE
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 15:43:11 +1100 (EST)
Date: Wed, 12 Dec 2007 15:43:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
Message-Id: <20071212154306.dee76c80.sfr@canb.auug.org.au>
In-Reply-To: <20071211212247.GB3620@loki.buserror.net>
References: <20071211212247.GB3620@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__12_Dec_2007_15_43_06_+1100_SGH=91RDE9Zb=Z4u"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__12_Dec_2007_15_43_06_+1100_SGH=91RDE9Zb=Z4u
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Dec 2007 15:22:47 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +++ b/arch/powerpc/platforms/82xx/ep8248e.c
> +
> +static int __devinit ep8248e_mdio_probe(struct of_device *ofdev,
> +                                        const struct of_device_id *match)
> +{
> +	struct mii_bus *bus;
> +	struct resource res;
> +	int ret, i;
> +
> +	if (of_get_parent(ofdev->node) !=3D ep8248e_bcsr_node)
> +		return -ENODEV;

You need to do of_node_put() on the result of of_get_parent().

> +static struct cpm_pin ep8248_pins[] =3D {

Should this be const?

> +static void __init ep8248_setup_arch(void)
> +{
> +	if (ppc_md.progress)
> +		ppc_md.progress("ep8248_setup_arch()", 0);
> +
> +	cpm2_reset();
> +
> +	/* When this is set, snooping CPM DMA from RAM causes
> +	 * machine checks.  See erratum SIU18.
> +	 */
> +	clrbits32(&cpm2_immr->im_siu_conf.siu_82xx.sc_bcr, MPC82XX_BCR_PLDP);
> +
> +	ep8248e_bcsr_node =3D
> +		of_find_compatible_node(NULL, NULL, "fsl,ep8248e-bcsr");
> +	if (!ep8248e_bcsr_node) {
> +		printk(KERN_ERR "No bcsr in device tree\n");
> +		return;
> +	}
> +
> +	ep8248e_bcsr =3D of_iomap(ep8248e_bcsr_node, 0);

of_node_put(ep8248e_bcsr_node;

> +static int __init ep8248_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +	return of_flat_dt_is_compatible(root, "fsl,ep8248e");

Again you should include asm/prom.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__12_Dec_2007_15_43_06_+1100_SGH=91RDE9Zb=Z4u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHX2beTgG2atn1QN8RAqqAAJ9nr3Wc9T7yUS/LcG55g4bMxEbh9gCfdxYz
AhpJInh+W98AYIId1bPei48=
=yHvi
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Dec_2007_15_43_06_+1100_SGH=91RDE9Zb=Z4u--
