Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B90F31A0CFB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 10:05:28 +1100 (AEDT)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CD241140E31
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2015 10:05:27 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so92652421pad.1
 for <linuxppc-dev@ozlabs.org>; Thu, 05 Nov 2015 15:05:26 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, imunsie@au1.ibm.com
Subject: Re: [PATCH] cxl: use correct operator when writing pcie config space
 values
In-Reply-To: <1446603849-26796-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1446603849-26796-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Fri, 06 Nov 2015 10:05:13 +1100
Message-ID: <87oaf8hwt2.fsf@gamma.ozlabs.ibm.com>
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

> When writing a value to config space, cxl_pcie_write_config() calls
> cxl_pcie_config_info() to obtain a mask and shift value, shifts the new
> value accordingly, then uses the mask to combine the shifted value with t=
he
> existing value at the address as part of a read-modify-write pattern.
>
> Currently, we use a logical OR operator rather than a bitwise OR operator,
> which means any use of this function results in an incorrect value being
> written. Replace the logical OR operator with a bitwise OR operator so the
> value is written correctly.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: stable@vger.kernel.org

Given that there are no current users of this function, does this need
to go to stable? Does it actually fix a real (as opposed to theoretical)
bug?

Regards,
Daniel

> Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---
>  drivers/misc/cxl/vphb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index 94b5208..9be09bb 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -203,7 +203,7 @@ static int cxl_pcie_write_config(struct pci_bus *bus,=
 unsigned int devfn,
>  	mask <<=3D shift;
>  	val <<=3D shift;
>=20=20
> -	v =3D (in_le32(ioaddr) & ~mask) || (val & mask);
> +	v =3D (in_le32(ioaddr) & ~mask) | (val & mask);
>=20=20
>  	out_le32(ioaddr, v);
>  	return PCIBIOS_SUCCESSFUL;
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

iQIcBAEBCgAGBQJWO+CpAAoJEPC3R3P2I92FjacQAIcaWVRwPmwWPzCh8vlUTGBC
DxDmA6gHnFcigsFZaIZY1vlipHlF3Q3gOsvDnywCF6p6sqvEAMraceLl8XdH9Ltg
n9Gr5VJ4oCmdobuoSA6QCo9p3LuKS9thhLAMXgglwm9dNyOppLwvU4zBtpjBAH5y
kWMlCmvwWSV/DNRkk3pgLX+A6DJYrPLr6UVQ/Ux0bXy/PCh8Nx24EhjwHVv9dPfN
XnTaWGZ6IiyIstSPzXEbNM3HEZhtbv2K6y+QjididpCwiaPOUORui4apzyFLIfuh
GLAH3zPYZby0Zt6q/vCHaNK1WWmE0AP0/zpFfzsUQoe3BAyzV997iARgfyToflUu
ojQf8xT6awhJQO3Q4h/6NMZvoGwnzCuviUi5XuIZeIUKqj8zSYOzQQRmdtR/caoJ
kIOyB58V7A5ZBFpchM3XTkaKVDrRZnFCYAtFhaom/rzWru/XWchqpybZfVV7kt1Y
ydZOwfFOQ2A46IEZukkktPRkjAaXjZKxp0gvMPrw7AJP1BtiurnEudlXes//7kz0
YQQeLGLJS/0H7haeQk+Rvq1amhbYpOQEHiIdnWAT0eXb5pdv51cLrp9uddLjoTdY
6Ph8kNMvPWVlX+YypeoQGLt9ZRI/A7f2osQ2fb7zjdHSwa0Nkw8fWc85vq+dSnWn
HMqK/LTzQkgLcAo3LV1z
=wwvl
-----END PGP SIGNATURE-----
--=-=-=--
