Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ABD51A046D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 10:05:47 +1100 (AEDT)
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5971214132F
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2015 10:05:45 +1100 (AEDT)
Received: by pacfv9 with SMTP id fv9so210303549pac.3
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Oct 2015 16:05:43 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: eeh_pci_enable(): fix checking of
 post-request state
In-Reply-To: <1445581186-10533-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1445581186-10533-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Tue, 27 Oct 2015 10:05:28 +1100
Message-ID: <87vb9tp6x3.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:


> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 40e4d4a..d757e7c 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -677,7 +677,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
>  	/* Check if the request is finished successfully */
>  	if (active_flag) {
>  		rc =3D eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
> -		if (rc <=3D 0)
> +		if (rc < 0)
>  			return rc;
>=20=20
>  		if (rc & active_flag)


Reviewed-by: Daniel Axtens <dja@axtens.net>


> --=20
> Andrew Donnellan              Software Engineer, OzLabs
> andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
> +61 2 6201 8874 (work)        IBM Australia Limited
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWLrG4AAoJEPC3R3P2I92FITMQAMwAswNLhPMxgXoYdDaNgyFx
C/BBUf9A7vp0veiuGpFovGsykMquafNuk1TxvMqryhW4zdSNgAsLEVaNJqAlIC/X
wbOUPoFojqTpp40IRycULmjtnglGAFM8NBtBjtBwUeoDR4vCpC1G98aslB9eBBmZ
SeY9hdN8ZRyY+TztqbbWHqf1DPXOvMx5uF5wr76me1kblDiINqypBW0oBnn7m2um
7prpKdAy2w7/Ibe4lhfGZtdHHFbhZmONwyc53jL7C2UICqEqMzwUZ6GDQhux3rCW
8TTg88v4BSiFjxAk6Iy7BmJ10nRO/UVu2OUJYLpeQBAD1nGwmC4vb+8csXhgJoM5
T0AW4BOvhchWxmRkSB06UuaTl/6T7GV8u0qE3A5ACOOer+Q3pe2u14Eia8FFMOQc
TFXIAPI8XAgK0vEGutlkdtVwb7SOPybvHDn0U/dZ5df4zsMiDyAF03rtnGqKcP9y
s8c0w8FskIIWPw9Ktke9TRbBhdauCiuQOw5QodC9JuZcnpUcD38BbUXWXuUpINvD
/S3tdy0QbqyfuaVDqAlpjk/l2217gN7SdiMtRUMEsCay0EjEOMfpCUF5GxdwWYSs
XUTCdq7jR4VBlwI3nXZH+nY5mft+dlYPd5HkX4lWss/Ae8Z1aa2DVqTdDI2SQoLf
dRskN+nyU+97c5DF7JBj
=JVbS
-----END PGP SIGNATURE-----
--=-=-=--
