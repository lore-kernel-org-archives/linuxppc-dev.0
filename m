Return-Path: <michael@ellerman.id.au>
Message-ID: <1330520204.15023.16.camel@concordia>
Subject: Re: [PATCH 20/21] Introduce struct eeh_stats for EEH
From: Michael Ellerman <michael@ellerman.id.au>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 29 Feb 2012 23:56:44 +1100
In-Reply-To: <1330409051-8941-21-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1330409051-8941-21-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-sDBsaO329znndT0Y1e6B"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-sDBsaO329znndT0Y1e6B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-28 at 14:04 +0800, Gavin Shan wrote:
> With the original EEH implementation, the EEH global statistics
> are maintained by individual global variables. That makes the
> code a little hard to maintain.

Hi Gavin,

> @@ -1174,21 +1182,24 @@ static int proc_eeh_show(struct seq_file *m, void=
 *v)
>  {
>  	if (0 =3D=3D eeh_subsystem_enabled) {
>  		seq_printf(m, "EEH Subsystem is globally disabled\n");
> -		seq_printf(m, "eeh_total_mmio_ffs=3D%ld\n", total_mmio_ffs);
> +		seq_printf(m, "eeh_total_mmio_ffs=3D%d\n", eeh_stats.total_mmio_ffs);
>  	} else {
>  		seq_printf(m, "EEH Subsystem is enabled\n");
>  		seq_printf(m,
> -				"no device=3D%ld\n"
> -				"no device node=3D%ld\n"
> -				"no config address=3D%ld\n"
> -				"check not wanted=3D%ld\n"
> -				"eeh_total_mmio_ffs=3D%ld\n"
> -				"eeh_false_positives=3D%ld\n"
> -				"eeh_slot_resets=3D%ld\n",
> -				no_device, no_dn, no_cfg_addr,=20
> -				ignored_check, total_mmio_ffs,=20
> -				false_positives,
> -				slot_resets);
> +				"no device           =3D%d\n"
> +				"no device node      =3D%d\n"
> +				"no config address   =3D%d\n"
> +				"check not wanted    =3D%d\n"
> +				"eeh_total_mmio_ffs  =3D%d\n"
> +				"eeh_false_positives =3D%d\n"
> +				"eeh_slot_resets     =3D%d\n",

There *might* be tools out there that parse this output, so I'd say
don't change it unless you have to - and I don't think you have to?

cheers

--=-sDBsaO329znndT0Y1e6B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCAAGBQJPTiCMAAoJEFHr6jzI4aWAzn4P/3cdUDFqDDU/euXo8FmBO104
L/wKdDfqbCEwm9vmRDbsKR3tXxWWo6bPHosvoy0Bl1tMr0SJGYPIFM6MYZ0Xc3cE
tMLOM30SsIk4DrxQEYCN9e5gVctBHcqnWiS/rfGIzvJ12wf0pEOc5GXuQeoS8+st
BFjRdlnPT4bEmAnnqp29r3pJGi3R2AMVnjAv9vV30NkIkaUD/yZ/Ms7MyPUZial5
UUtmmu4cYc9QZ1JjSX0MagfE3U848j97ADjGcTjmvDySfkW5xrLNWVHbszes0kzo
KTpxCSJyNWBveQ3DCAEZOzgDxRMVyxcSPjRGK15GnrzHYjrhENjVvErDnetmCcJs
uaQ65MZ3FrUsQHr/pW6Y72L2Qze+uEXUI66ehB0eh0RMj2l+ivuPOD8g+rHk9jdI
0o0Os8EIsFvAxXvMoMfTG3axmCSshZiVIztf6EYaIEWT8YvbXfYhtVg4hGfmpOV3
mtW/Rqare9mrbwBK2drPNYl3Pcfl5x50ZsaO+QwVfbNSXNOaq6AwgeSgmr/nSBx0
TpET2PknXMaiQnxsdSbkVKh/7v5CApSqZ69p/jHnKAw/qwJMU65dvfmuAJsb3IDX
9nwwH1fRG1e5eKAxbQ73hGlighDYznlaP4MiAEvxO88K5PQ7A/sz1HFz5qm+wY1o
+Koh1QRxGapu/whOZPBT
=kaEN
-----END PGP SIGNATURE-----

--=-sDBsaO329znndT0Y1e6B--
