Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB1E31A0477
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 10:09:45 +1100 (AEDT)
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7931F140E31
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2015 10:09:45 +1100 (AEDT)
Received: by padhk11 with SMTP id hk11so201603484pad.1
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Oct 2015 16:09:44 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: eeh_pci_enable(): fix checking of
 post-request state
In-Reply-To: <1445581186-10533-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1445581186-10533-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Tue, 27 Oct 2015 10:09:30 +1100
Message-ID: <87twpdp6qd.fsf@gamma.ozlabs.ibm.com>
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

iQIcBAEBCgAGBQJWLrKqAAoJEPC3R3P2I92FYksQANdPQ1xfYEcb71gnREhqL93Z
WHJAE2yVasL1L6PObY5dCUzZb7sPwC69E2Ug4NBLCgtjBgm1v7xm12DSnPlU6MyE
0iNrVAvEB313gosuEt1HnykcKppN4xAro8mzWAHmk2qrCEM4zVkjWJXEBXYf4Uev
OQsrQ50vZsUHcP774iFnZppLUpPYdftqkbiz6SQTPs9UjnZu9V/9Xs8ZNDbhRked
uDLxmWh7vhhUigKdIMl3+Y6lUc3GeqBULPTjR6XhLhSZeG2nUF9knP193woICVeO
XLAOizgxGIgmyo/Zs8GvCFRCdSpPIhOU8hTKm7frh2m3j30LAMK/X4wHoI0sM66s
IU+qYsDhiLHmqYf3epij7k5JpoF+jSMghDEayGaXdPbkshoLhFsIQVtq6AZqxusE
Zju/3YzissZ9VZhIItf9gDL8U8+d5x44REBAUmpQj+/t4w9RzPGmgcMzZ03leEns
Wzu2SxWKf/EhRd+vBfjN5p0l6/TZNtNYj+F/3fEBCWFz8lQgNgN16sUQjxiPB8Yh
8zgad0K7TkjpX6tnJq4PRuPP45IQFT1O4bAnjPWMUNn+7TS50nfgkvitOKIBfhpG
IphrXvYSgmXflt/RuBz/9SvJLe1FUTxoc/9FqI8KKHVdgaEqtBDHIoYANIHmfIEW
ZcLNYkt+XyBdhOpssPn1
=aIUV
-----END PGP SIGNATURE-----
--=-=-=--
