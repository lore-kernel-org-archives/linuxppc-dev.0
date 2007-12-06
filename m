Return-Path: <bersace@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 1D542DDE23
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:30:58 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so130122nfd
	for <linuxppc-dev@ozlabs.org>; Thu, 06 Dec 2007 07:30:56 -0800 (PST)
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
From: =?ISO-8859-1?Q?=C9tienne?= Bersac <bersace@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <1196904050.7132.36.camel@thilivren>
References: <1196904050.7132.36.camel@thilivren>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6htvF0Eu5v/CY29jJEnD"
Date: Thu, 06 Dec 2007 16:30:51 +0100
Message-Id: <1196955051.6862.10.camel@thilivren>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6htvF0Eu5v/CY29jJEnD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

> +	/* First, locate the params for this model */
> +	for (i =3D 0; i < PM121_NUM_CONFIGS; i++) {
> +		param =3D &(pm121_sys_all_params[loop_id][i]);
> +		if (param->model_id =3D=3D pm121_mach_model)
> +			break;
> +	}
> +
> +	/* No params found, put fans to max */
> +	if (param =3D=3D NULL) {
> +		printk(KERN_WARNING "pm121: %s fan config not found "
> +		       " for this machine model\n",
> +		       loop_names[loop_id]);
> +		goto fail;
> +	}

This part might be buggy. param NULL only when PM121_NUM_CONFIGS is 0.
The original code was :


+	for (i =3D 0; i < PM121_NUM_CONFIGS; i++) {
+		if (pm121_sys_all_params[loop_id][i].model_id =3D=3D pm121_mach_model) {
+			param =3D &(pm121_sys_all_params[loop_id][i]);
+			break;
+		}
+	}

But the line is wider than 80 chars. An alternative would be  :


+	for (i =3D 0; i < PM121_NUM_CONFIGS; i++) {
+		param =3D &(pm121_sys_all_params[loop_id][i]);
+		if (param->model_id =3D=3D pm121_mach_model)
+			break;
+		else
+			param =3D NULL;
+	}

I wonder if that's more readable.


Regards,
=C3=89tienne.
--=20
E Ultre=C3=AFa !

--=-6htvF0Eu5v/CY29jJEnD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHWBWrbyMDDeXZS7URAgFAAJ9fS4pQp5lGFVpHff1hAclb7lPIzQCfX1zm
+hi6KZr7whSyl06ziJDBj5k=
=9C0N
-----END PGP SIGNATURE-----

--=-6htvF0Eu5v/CY29jJEnD--
