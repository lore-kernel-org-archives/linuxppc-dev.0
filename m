Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60892C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:32:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB082087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB082087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TBrs5cYlzF3Ct
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:32:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=spopovyc@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TBpS6lfFzF36m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 18:30:04 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 117E0C04B925;
 Mon,  8 Oct 2018 07:30:02 +0000 (UTC)
Received: from v-cos7-x64-rh.tuxracer.vpn.as41781.net
 (ovpn-116-165.ams2.redhat.com [10.36.116.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ACA261147;
 Mon,  8 Oct 2018 07:29:56 +0000 (UTC)
Subject: Re: [RFC PATCH kernel] vfio/spapr_tce: Get rid of possible infinite
 loop
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
References: <20181002032231.7494-1-aik@ozlabs.ru>
From: Serhii Popovych <spopovyc@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=spopovyc@redhat.com; prefer-encrypt=mutual; keydata=
 xsBNBFmvho4BCADMfRwAvr/tb7zXD5kYOukSIAUZz7lZY6mFiFD4+xcmHyhy4mrHzFsaQA5g
 j6PF9Z0J4OcYO4bJw4xEbzu+liQhekWXFdo3gwqttWg/PdVVeLLBtvRHxjK9cZYY9+OJ9Y2q
 CwRwxh7fDZJzp7oHlBQpSBcWkbYVh4rd775dIs49ayh87K73yw58TBDp211tyoqgNaztrQIB
 ZlSm87nls7E322ZsdpnBO9Wr+JVfPKxpODc3Hmqux3eD2zh+1Y2QCb3BMDe8pBRhkhSqLS+V
 Y8+oq8lWmQRD/zRc6g9kDCM+2szO/C2V96UAc6RVivwbQirraTVMlNBXr0ZRnd/pUtdtABEB
 AAHNKlNlcmhleSBQb3BvdnljaCA8c2VyaGUucG9wb3Z5Y2hAZ21haWwuY29tPsLAggQTAQIA
 LAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAhkBBQJbj6vKBQkDwVi8AAoJEBTawMmQ
 61bB0Q4H/1nNRo0wdZileOAcsbgSaXVJiFGhj+QOdgLwBhpu3ITPPg7Neu3KAcndX1RhLwF/
 9hgtzhjBiyGpe/Yb50CYS/3GFNTg30ObWyj25xpS9l6RdrEoUVtd1e7W41ar6Cc7kH/+j1Tb
 9ucH3pBwQ5lvFi7zAK2YLkbHNhqGkxDG5AcacDzvHMTxLzgXckF4AFFY3tWeJoA/Y6s7+edY
 tD93835duXeaQcdbeUmqB9ATQdZFbdMTmP/ly76w9Wu/TKtszCmXw/iKfC1VKPC4GQoDpI5r
 X0Kwum/K1kTFmpvq2EtdYxpuFXalvAvVunH+0ekmY3ymcCOLQzalY+dcl2gbJqTOwE0EWa+G
 jgEIAKTdE/a3gw5WnUHzPdTP95V0xz5xgWZ66Q10cIjbFkUOl/UvxkemkqKV1Bw4EG901FzQ
 jvP/eZJhaN2XNRUogD3A3uAA7tW41d8+CCePDYGlGy/G0jzx0AeI+XCJtCyVNaHNzI3sQBy5
 0Qcs1rKkagjtOPSX+IzDOjslNHDCVQ38RTr9Cwl60va+rAi1F5psdQcmIFM5L4WCWt2y416F
 o01UJQVwo071/Z7DWT2Jy/uDxnplI5+C8jmd3mkV8xzPtguM6AuektFQLVhdLzcMZdkA35fO
 UH55ku/HbGyEmxOlhXgzwhmtkrvz9JYe+MYKW1nx3TIXcJVtWS7D94zlZeUAEQEAAcLAZQQY
 AQIADwIbDAUCW4+sTgUJA8FZQAAKCRAU2sDJkOtWwaxRB/sHfDv7KHQAh8PBBLTI9XVv4duQ
 TRVIXscZpLvgITxdp6apMk+l1IqzWVU0/zHOfdh0eoA9VRDq0km7UsH4rv1/HYSkXIRXjLF+
 JZCsAjDMpnzpbP1L+r+y8RrA086KPoZXz0CknejVAUo3EOEeh5SrCO+s+mhe7GyXVJvkGD5F
 JaPLQq5v3xlGbA49tQ/FZIAKScY6jgLnEg+pva+/QCilU1Jo+YXsZcfG2LaVjc1ywwZVf8ry
 0tM7SFKwzbRl47jXWGgap8qpyWYKw4mkA/g8J2XS4fRaW0Lxr42EzEHy+ecaJf4c4P95vmhg
 JFZShk/daSkIyLcj/AmcABZPNW0K
Organization: Red Hat
Message-ID: <74ee5fc5-839b-27d6-5731-1b2731f9f95b@redhat.com>
Date: Mon, 8 Oct 2018 10:29:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:51.0) Gecko/20100101
 Firefox/51.0
MIME-Version: 1.0
In-Reply-To: <20181002032231.7494-1-aik@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mlNQ9P0PV7bTzILEy0bFLL1jJXITV6LBX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 08 Oct 2018 07:30:02 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mlNQ9P0PV7bTzILEy0bFLL1jJXITV6LBX
Content-Type: multipart/mixed; boundary="m286uEMlX1QUTLnXN10RttdcTSXZj5F3F";
 protected-headers="v1"
From: Serhii Popovych <spopovyc@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
Message-ID: <74ee5fc5-839b-27d6-5731-1b2731f9f95b@redhat.com>
Subject: Re: [RFC PATCH kernel] vfio/spapr_tce: Get rid of possible infinite
 loop
References: <20181002032231.7494-1-aik@ozlabs.ru>
In-Reply-To: <20181002032231.7494-1-aik@ozlabs.ru>

--m286uEMlX1QUTLnXN10RttdcTSXZj5F3F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alexey Kardashevskiy wrote:
> As a part of cleanup, the SPAPR TCE IOMMU subdriver releases preregiste=
red
> memory. If there is a bug in memory release, the loop in
> tce_iommu_release() becomes infinite; this actually happened to me.
>=20
> This makes the loop finite and prints a warning on every failure to mak=
e
> the code more bug prone.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> index b1a8ab3..ece0651 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -371,6 +371,7 @@ static void tce_iommu_release(void *iommu_data)
>  {
>  	struct tce_container *container =3D iommu_data;
>  	struct tce_iommu_group *tcegrp;
> +	struct tce_iommu_prereg *tcemem, *tmtmp;
>  	long i;
> =20
>  	while (tce_groups_attached(container)) {
> @@ -393,13 +394,8 @@ static void tce_iommu_release(void *iommu_data)
>  		tce_iommu_free_table(container, tbl);
>  	}
> =20
> -	while (!list_empty(&container->prereg_list)) {
> -		struct tce_iommu_prereg *tcemem;
> -
> -		tcemem =3D list_first_entry(&container->prereg_list,
> -				struct tce_iommu_prereg, next);
> -		WARN_ON_ONCE(tce_iommu_prereg_free(container, tcemem));
> -	}
> +	list_for_each_entry_safe(tcemem, tmtmp, &container->prereg_list, next=
)
> +		WARN_ON(tce_iommu_prereg_free(container, tcemem));

I'm not sure that tce_iommu_prereg_free() call under WARN_ON() is good
idea because WARN_ON() is a preprocessor macro:

  if CONFIG_WARN=3Dn is added by the analogy with CONFIG_BUG=3Dn defining=

  WARN_ON() as empty we will loose call to tce_iommu_prereg_free()
  leaking resources.

There is no problem at the moment: WARN_ON() defined for PPC in
arch/powerpc/include/asm/bug.h unconditionally.

So your first version with intermediate variable looks better to me.

> =20
>  	tce_iommu_disable(container);
>  	if (container->mm)
>=20


--=20
Thanks,
Serhii


--m286uEMlX1QUTLnXN10RttdcTSXZj5F3F--

--mlNQ9P0PV7bTzILEy0bFLL1jJXITV6LBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJbuwdxAAoJEBTawMmQ61bB/R0H/jQUzYa7A+l2JHPgyJ4hGrgI
MoI+4Ar2QyMvRbwoYX5mT1TmpSLcNU5ygwlYr2owCzV/NjfOm0SNGIx0X525+5kX
LK2ThUOikkgpoensvVMcAHKcmxd74t/MqbU+lWhkxcO82/YGOdmgQoF2TDUvkiHp
1IXq1w1pSjUPidkyQG9ynwZdR/stw5mPRF0Y6HP+BmwSz7HhxTSv+TS+gLdRvb7+
KZg66JYOlo4qIYXFhc5caxKZH0vysRyUkSKnsPGwGbB5VdVZ2xQKRZ2aWjHEezKp
fTQ9T6Ph9UvDNQzVUWLCo80FYONbWNMFgWoQ4cGZ0KRurws5Cp+QqGBJsbMb0P8=
=wktK
-----END PGP SIGNATURE-----

--mlNQ9P0PV7bTzILEy0bFLL1jJXITV6LBX--
