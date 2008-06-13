Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D3B34DDF4A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 15:12:30 +1000 (EST)
Date: Fri, 13 Jun 2008 15:12:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 12/19] powerpc: vio bus support for CMO
Message-Id: <20080613151221.47f02e6d.sfr@canb.auug.org.au>
In-Reply-To: <20080612221958.GT30916@linux.vnet.ibm.com>
References: <20080612215312.GF30916@linux.vnet.ibm.com>
	<20080612221958.GT30916@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__13_Jun_2008_15_12_21_+1000_3n0UdxraWTaVaK7t"
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__13_Jun_2008_15_12_21_+1000_3n0UdxraWTaVaK7t
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robert,

Firstly, can all this new stuff be ifdef'ed out if not needed as the
vio infrastructure is also used on legacy iSeries and this adds quite a
bit of stuff that won't ever be used there.

On Thu, 12 Jun 2008 17:19:59 -0500 Robert Jennings <rcj@linux.vnet.ibm.com>=
 wrote:
>
> +static int vio_cmo_num_OF_devs(void)
> +{
> +	struct device_node *node_vroot;
> +	int count =3D 0;
> +
> +	/*
> +	 * Count the number of vdevice entries with an
> +	 * ibm,my-dma-window OF property
> +	 */
> +	node_vroot =3D of_find_node_by_name(NULL, "vdevice");
> +	if (node_vroot) {
> +		struct device_node *of_node;
> +		struct property *prop;
> +
> +		for (of_node =3D node_vroot->child; of_node !=3D NULL;
> +		                of_node =3D of_node->sibling) {

Use:
		for_each_child_of_node(node_vroot, of_node) {


--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__13_Jun_2008_15_12_21_+1000_3n0UdxraWTaVaK7t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhSAbUACgkQTgG2atn1QN+qmQCfXCn3yiDGVLUhU7nrsqFoi2Ux
xWkAn1tW9+Ui2AnMVOZAqM+efAGTvABv
=bLux
-----END PGP SIGNATURE-----

--Signature=_Fri__13_Jun_2008_15_12_21_+1000_3n0UdxraWTaVaK7t--
