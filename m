Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25B921A08C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 09:56:13 +1100 (AEDT)
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 00100140DA3
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 09:56:11 +1100 (AEDT)
Received: by pabve7 with SMTP id ve7so580861pab.2
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 15:56:10 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/8] powerpc/eeh: More relexed hotplug criterion
In-Reply-To: <1444276739-20372-3-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-3-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Tue, 13 Oct 2015 09:55:53 +1100
Message-ID: <87612b4rye.fsf@gamma.ozlabs.ibm.com>
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

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

Hi Gavin,

> Currently, we rely on the existence of struct pci_driver::err_handler
> to judge if the corresponding PCI device should be unplugged during
> EEH recovery (partially hotplug case). However, it's not elaborate.
> some device drivers are implementing part of the EEH error handlers
> to collect diag-data. That means the driver still expects a hotplug
> to recover from the EEH error.


> This makes the hotplug criterion more relaxed: if the device driver
> doesn't provide all necessary EEH error handlers, it will experience
> hotplug during EEH recovery.

Interesting.

My understanding of Documentation/PCI/pci-error-recovery.txt is that a
driver should be able to just supply an error_detected() callback. If
the driver just wants to collect diag-data and wants to be hotplugged,
it should return PCI_ERS_RESULT_NONE.

What drivers did you have in mind?

Regards,
Daniel

>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_d=
river.c
> index 3a626ed..32178a4 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -416,7 +416,10 @@ static void *eeh_rmv_device(void *data, void *userda=
ta)
>  	driver =3D eeh_pcid_get(dev);
>  	if (driver) {
>  		eeh_pcid_put(dev);
> -		if (driver->err_handler)
> +		if (driver->err_handler &&
> +		    driver->err_handler->error_detected &&
> +		    driver->err_handler->slot_reset &&
> +		    driver->err_handler->resume)
>  			return NULL;
>  	}
>=20=20
> --=20
> 2.1.0
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

iQIcBAEBCgAGBQJWHDp6AAoJEPC3R3P2I92Fk74QAJruAj+6D7O8ekEmSd49UxXa
HYu95/Bgkmhm1SYbajgNN2pLuh/yZ9l01090EWZh/uf3fu64k/qm2SgpbU4tnl5j
dnQLllNaie2gpf7T7T27jzeFIL2deGePsYmzY5Frio6ACMEAHR8JhpnSZsk+JYgW
uh6UOipaMf1zwusHjuPrdniaQxUjTcGtmgfZrkRXh51zKJDkLRKHn8jU7AG/jzF5
scg52ryOtDs/VaypE4gNNbvS3RNAQQjQQD5viDG3HrYzXZhxF5xXBqA0EGRu56Iz
wk6JOn0NRAF8lYl1EgVTm1+x6ua8b8x3yMGRXePDdbO325FcW2vAdBYgMKiqvEqZ
buDAKaOlQRwX2lxrUcrePQwNAC82AtKX0KwQN69zn8BuM/hFbe9fU380gRflHaMy
sxuYjjYLtxOJrUU++64ELaQxsbXdpLmfLfAHnPifeY+wTeRXAX2pvNT+LNZ+/NK2
40RNhrIQI/nrfO3rYvgwiX00FN9uzvhACnKtwwFpdKc4dhyoqiAvPT+RMAhWR9V2
rYd9Fji2380WJcl6ISL/q1tCcPGa9s9OzqxmU+bVqrSc51f2zT+MkHP3F//ZdtMR
UMtYut5kU4wcsL7AF/6cLbjX9oVgOReri92vv+9BkA08BSwJL/KOcmvHjW1HMLSX
0KESXkWthM93WA0iQJFQ
=rq3T
-----END PGP SIGNATURE-----
--=-=-=--
