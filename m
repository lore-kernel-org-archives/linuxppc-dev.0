Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 93DDDDDDF3
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 13:40:13 +1000 (EST)
Date: Tue, 6 May 2008 13:40:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 1/4] [v4][POWERPC] refactor dcr code
Message-Id: <20080506134006.62900cce.sfr@canb.auug.org.au>
In-Reply-To: <20080505175647.5C26F2B0059@mail60-sin.bigfish.com>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.5C26F2B0059@mail60-sin.bigfish.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_May_2008_13_40_06_+1000_n83LeH0uHQ92e686"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__6_May_2008_13_40_06_+1000_n83LeH0uHQ92e686
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Mon,  5 May 2008 10:56:38 -0700 Stephen Neuendorffer <stephen.neuendorff=
er@xilinx.com> wrote:
>
> +static struct device_node *find_dcr_parent(struct device_node *node)
> +{
> +	struct device_node *par, *tmp;
> +	const u32 *p;
> +
> +	for (par =3D of_node_get(node); par;) {
> +		if (of_get_property(par, "dcr-controller", NULL))
> +			break;
> +		p =3D of_get_property(par, "dcr-parent", NULL);
> +		tmp =3D par;
> +		if (p =3D=3D NULL)
> +			par =3D of_get_parent(par);
> +		else
> +			par =3D of_find_node_by_phandle(*p);
> +		of_node_put(tmp);
> +	}
> +	return par;
> +}

	.
	.

> +dcr_host_t dcr_map_generic(struct device_node *dev,
> +			   unsigned int dcr_n,
> +			   unsigned int dcr_c)
> +{
> +	dcr_host_t host;
> +	struct device_node *dp;
> +	const char *prop;
> +
> +	host.type =3D DCR_HOST_INVALID;
> +
> +	dp =3D find_dcr_parent(dev);
> +	if (dp =3D=3D NULL)
> +		return host;
> +
> +	prop =3D of_get_property(dp, "dcr-access-method", NULL);
> +
> +	pr_debug("dcr_map_generic(dcr-access-method =3D %s)\n", prop);
> +
> +	if (!strcmp(prop, "native")) {
> +		host.type =3D DCR_HOST_NATIVE;
> +		host.host.native =3D dcr_map_native(dev, dcr_n, dcr_c);
> +	} else if (!strcmp(prop, "mmio")) {
> +		host.type =3D DCR_HOST_MMIO;
> +		host.host.mmio =3D dcr_map_mmio(dev, dcr_n, dcr_c);
> +	}
> +
> +	return host;

Since find_dcr_parent has done a of_node_get on its return value, you
leak a reference to dp here i.e. you need an of_node_put(dp) before you
return.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_May_2008_13_40_06_+1000_n83LeH0uHQ92e686
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIH9MaTgG2atn1QN8RAsmPAJ9m5noV8f3SzEzusDx8hCoJnyQ6fwCfW8j5
MZV/TRQwmjDPirB6f0572PI=
=1i49
-----END PGP SIGNATURE-----

--Signature=_Tue__6_May_2008_13_40_06_+1000_n83LeH0uHQ92e686--
