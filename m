Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7580ADDF55
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 11:36:53 +1000 (EST)
Date: Tue, 8 Jul 2008 11:36:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chandru <chandru@in.ibm.com>
Subject: Re: [PATCH 1/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Message-Id: <20080708113646.13836635.sfr@canb.auug.org.au>
In-Reply-To: <200807080014.24910.chandru@in.ibm.com>
References: <200807080014.24910.chandru@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jul_2008_11_36_46_+1000_qCsD8LuKexgnx0JD"
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jul_2008_11_36_46_+1000_qCsD8LuKexgnx0JD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chandru,

On Tue, 8 Jul 2008 00:14:24 +0530 Chandru <chandru@in.ibm.com> wrote:
>
> @@ -917,7 +918,33 @@ static int __init early_init_dt_scan_drc
>  			if ((base + size) > 0x80000000ul)
>  				size =3D 0x80000000ul - base;
>  		}
> -		lmb_add(base, size);
> +		strcpy(buf, "linux,usable-memory");
> +		sprintf(t, "%d", (int)n);
> +		strcat(buf, t);

Why don't you use
		snprintf(buf, sizeof(buf), "linux,usable-memory%ld", n);
instead?

> +		usm =3D (cell_t *)of_get_flat_dt_prop(node,
> +						 (const char *)buf, &l);
		      ^^^^^^^^^^		 ^^^^^^^^^^^^^^
unnecessary casts.

>  static void __init parse_drconf_memory(struct device_node *memory)
>  {

> +		strcpy(buf, "linux,usable-memory");
> +		sprintf(t, "%d", (int)n);
> +		strcat(buf, t);

See snprint comment above.

> +		usm =3D of_get_property(memory, (const char *)buf, &len);
                                              ^^^^^^^^^^^^^^
unnecessary cast.

> +		if (usm !=3D NULL) {
> +			ranges =3D (len >> 2) / (n_mem_addr_cells +
                                 ^^^^^^^^^^
len / sizeof(u32) ?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jul_2008_11_36_46_+1000_qCsD8LuKexgnx0JD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhyxK4ACgkQjjKRsyhoI8z/lwCfUmUrovaiCzuazjzJSroWY4zL
FR8An3vnb75WMrwT51NgwxuZwAT0MCXW
=3hV8
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jul_2008_11_36_46_+1000_qCsD8LuKexgnx0JD--
