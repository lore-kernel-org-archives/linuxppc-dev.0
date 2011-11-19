Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id 85AC8B7230
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2011 12:05:24 +1100 (EST)
Date: Sat, 19 Nov 2011 12:04:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
Message-Id: <20111119120455.8435467a8c11a2a122321670@canb.auug.org.au>
In-Reply-To: <4EC5860D.5000606@freescale.com>
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
 <20111118082929.5ee8d4f07d84f2bf65e18006@canb.auug.org.au>
 <4EC5860D.5000606@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__19_Nov_2011_12_04_55_+1100_NH10vPkSwBHwabRN"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__19_Nov_2011_12_04_55_+1100_NH10vPkSwBHwabRN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Timur,

On Thu, 17 Nov 2011 16:09:17 -0600 Timur Tabi <timur@freescale.com> wrote:
>
> Stephen Rothwell wrote:
>=20
> >> +	struct device_node *indirect_node =3D NULL;
> >> +	struct ccsr_guts_85xx __iomem *guts =3D NULL;
> >> +	u8 __iomem *lbc_lcs0_ba =3D NULL;
> >> +	u8 __iomem *lbc_lcs1_ba =3D NULL;
> >=20
> > And if you had multiple error path labels, you could avoid these others
> > as well (and the NULL checks on the error path).
>=20
> But I don't want multiple error path labels.  The error path could only
> happen if someone passed in a broken device tree (i.e. pretty much
> never), so I'm not keen on complicating my code just to optimize
> something that will never be used.

But you are already optimizing for the error path by doing the
assignments and NULL checks that are unneeded in the non error path.
What I am suggesting is adding a little more code that could end up doing
less at run time.

How about (not even compile tested):

static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
{
	struct device_node *guts_node;
	struct device_node *indirect_node;
	struct ccsr_guts_85xx __iomem *guts;
	u8 __iomem *lbc_lcs0_ba;
	u8 __iomem *lbc_lcs1_ba;
	u8 b;

	/* Map the global utilities registers. */
	guts_node =3D of_find_compatible_node(NULL, NULL, "fsl,p1022-guts");
	if (!guts_node) {
		pr_err("p1022ds: missing global utilties device node\n");
		return;
	}

	guts =3D of_iomap(guts_node, 0);
	of_node_put(guts_node);
	if (!guts) {
		pr_err("p1022ds: could not map global utilties device\n");
		return;
	}

	indirect_node =3D of_find_compatible_node(NULL, NULL,
					     "fsl,p1022ds-indirect-pixis");
	if (!indirect_node) {
		pr_err("p1022ds: missing pixis indirect mode node\n");
		goto exit_guts_iounmap;
	}

	lbc_lcs0_ba =3D of_iomap(indirect_node, 0);
	if (!lbc_lcs0_ba) {
		pr_err("p1022ds: could not map localbus chip select 0\n");
		goto exit_indirect_node;
	}

	lbc_lcs1_ba =3D of_iomap(indirect_node, 1);
	if (!lbc_lcs1_ba) {
		pr_err("p1022ds: could not map localbus chip select 1\n");
		goto exit_lcs0_iounmap;
	}

	/* Make sure we're in indirect mode first. */
	if ((in_be32(&guts->pmuxcr) & PMUXCR_ELBCDIU_MASK) !=3D
	    PMUXCR_ELBCDIU_DIU) {
		struct device_node *pixis_node;
		void __iomem *pixis;

		pixis_node =3D
			of_find_compatible_node(NULL, NULL, "fsl,p1022ds-fpga");
		if (!pixis_node) {
			pr_err("p1022ds: missing pixis node\n");
			goto exit_lcs1_iounmap;
		}

		pixis =3D of_iomap(pixis_node, 0);
		of_node_put(pixis_node);
		if (!pixis) {
			pr_err("p1022ds: could not map pixis registers\n");
			goto exit_lcs1_iounmap;
		}

		/* Enable indirect PIXIS mode.  */
		setbits8(pixis + PX_CTL, PX_CTL_ALTACC);
		iounmap(pixis);

		/* Switch the board mux to the DIU */
		out_8(lbc_lcs0_ba, PX_BRDCFG0);	/* BRDCFG0 */
		b =3D in_8(lbc_lcs1_ba);
		b |=3D PX_BRDCFG0_ELBC_DIU;
		out_8(lbc_lcs1_ba, b);

		/* Set the chip mux to DIU mode. */
		clrsetbits_be32(&guts->pmuxcr, PMUXCR_ELBCDIU_MASK,
				PMUXCR_ELBCDIU_DIU);
		in_be32(&guts->pmuxcr);
	}


	switch (port) {
	case FSL_DIU_PORT_DVI:
		/* Enable the DVI port, disable the DFP and the backlight */
		out_8(lbc_lcs0_ba, PX_BRDCFG1);
		b =3D in_8(lbc_lcs1_ba);
		b &=3D ~(PX_BRDCFG1_DFPEN | PX_BRDCFG1_BACKLIGHT);
		b |=3D PX_BRDCFG1_DVIEN;
		out_8(lbc_lcs1_ba, b);
		break;
	case FSL_DIU_PORT_LVDS:
		/*
		 * LVDS also needs backlight enabled, otherwise the display
		 * will be blank.
		 */
		/* Enable the DFP port, disable the DVI and the backlight */
		out_8(lbc_lcs0_ba, PX_BRDCFG1);
		b =3D in_8(lbc_lcs1_ba);
		b &=3D ~PX_BRDCFG1_DVIEN;
		b |=3D PX_BRDCFG1_DFPEN | PX_BRDCFG1_BACKLIGHT;
		out_8(lbc_lcs1_ba, b);
		break;
	default:
		pr_err("p1022ds: unsupported monitor port %i\n", port);
	}

exit_lcs1_iounmap:
	iounmap(lbc_lcs1_ba);
exit_lcs0_iounmap:
	iounmap(lbc_lcs0_ba);
exit_indirect_node:
	of_node_put(indirect_node);
exit_guts_iounmap:
	iounmap(guts);
}

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__19_Nov_2011_12_04_55_+1100_NH10vPkSwBHwabRN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOxwC3AAoJEECxmPOUX5FEUDwP/jSKV4RuIyLFhTpUGldeHt4p
kvXMSjfc2AnSQt4ZVTIIrouJcTuKJVT0YRdDbwbL5XjhrvwRAauMuiuyHbD+3OA5
N0Cz1Udrppk9h70WyoXgfThZOURy8IfF+FYQuJL6IwR2l98JEPQWd2DDP9yVN5sv
fJVZeEX5SrBRqTiDIAumtj+Nr/FwQdDGAmNq34WL6PE5JLd2DvcJ9ta1hy9vJN1i
P3DtGTVBQOsA9/EWLg1vw93qr0UW1VrvTJU6BxPUioJT4YwszKuj9LZfjr5sfvX5
qhQWaHvfRC8H3/l13AjHtCfN3QFyfPpH9HXGHXEQ8/4SHc9v/5+0WMX6edHs5tfY
YMivLZ1VL6ham5SCrJrxgi61X45Oy7EEy9IkM+0GHxBhfrGxlx56Pr3wTVZ0jRqo
2nsm3DW6Nf1xmcQXlqvpe9StKwp1frtD17XhzsrOu6jkMuBahuJkkgQsRf/eoVKC
KtZ08Cs431ouGsM+DTWOT9gHRuG2r97pYOJsliuTWpMSlaDFVP79fJiwF+ZRffQb
qosDWV8HOipWbPg5SVOelvVdE95LCq9HvI9nktHOSX9I35/iQZRUxYAzVAAlIwds
MbEPHUHXPAFy9WgOz/8rAXRvIGEVCocXoL739aY88aemvN6bJo7yzuuqd2KnIkbQ
AiIdydwf5pQXantqORx+
=p33k
-----END PGP SIGNATURE-----

--Signature=_Sat__19_Nov_2011_12_04_55_+1100_NH10vPkSwBHwabRN--
