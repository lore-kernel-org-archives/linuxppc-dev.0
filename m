Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EB361A0679
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 11:35:40 +1100 (AEDT)
Received: by pabve7 with SMTP id ve7so80026824pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2015 17:35:37 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Colin King <colin.king@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/hvcserver: don't memset pi_buff if it is
 null
In-Reply-To: <1444330858-5508-1-git-send-email-colin.king@canonical.com>
References: <1444330858-5508-1-git-send-email-colin.king@canonical.com>
Date: Mon, 12 Oct 2015 11:35:20 +1100
Message-ID: <878u7853g7.fsf@gamma.ozlabs.ibm.com>
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


Hi Colin,

This looks good. Out of curiousity, how did you find it? Code
inspection? Bug? Static analysis?

Not that it's particularly meaningful for such a trivial fix, but FWIW:

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> pi_buff is being memset before it is sanity checked. Move the
> memset after the null pi_buff sanity check to avoid an oops.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/powerpc/platforms/pseries/hvcserver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/hvcserver.c b/arch/powerpc/pl=
atforms/pseries/hvcserver.c
> index eedb645..94a6e56 100644
> --- a/arch/powerpc/platforms/pseries/hvcserver.c
> +++ b/arch/powerpc/platforms/pseries/hvcserver.c
> @@ -142,11 +142,11 @@ int hvcs_get_partner_info(uint32_t unit_address, st=
ruct list_head *head,
>  	int more =3D 1;
>  	int retval;
>=20=20
> -	memset(pi_buff, 0x00, PAGE_SIZE);
>  	/* invalid parameters */
>  	if (!head || !pi_buff)
>  		return -EINVAL;
>=20=20
> +	memset(pi_buff, 0x00, PAGE_SIZE);
>  	last_p_partition_ID =3D last_p_unit_address =3D ~0UL;
>  	INIT_LIST_HEAD(head);
>=20=20
> --=20
> 2.5.0
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

iQIcBAEBCgAGBQJWGwBIAAoJEPC3R3P2I92Fq1kQANpeOBt2e596Y7gVyZLeQfBQ
xEaFx70ZZh4SWJMU1ZRPKh4ur+GPPobYsQSCPpBCHq4xM+qCnQYN4Rly3BY/FL4/
K488PltYjzM1ixbzz7egtJB0zdNLeRXTt+Go2B0C4oqy6kwd8ePYyQBwqnJ/SmKt
A6EhfESLvNnEN06LBzqiz8RzD7hTsYkfGzDEemwoVVT4zMdbzFkRNbOLerRGsUKW
cPpRjKsxUtnSAaMDuO8mH0U77HpQK7qlNbN0m8Gnv87QmIbxcYr0b9egGZVsUEZP
Sx5FuIuisH8mIl4V41f8kczvngHWJpzfeecgZiiAEG+fO+y6pYiRJEP0Dr/+AqSZ
3a0eJowZEyxZGibLYtja7y7yJV2cJGmAhO+jJRHNPojj+2tq2+H5IIEt+PF9X9nI
bIM23FVwfxqPb+M/qd8HnBHiiJY680x8X0L7Vvmdhtf4CT/6vUrmPsNIhQqLdARF
GcXkaQ4NWyi46sGZ/PXLe3F3WdSyLVRbfzbG0L/mUG70Rqa/wSQ/g0qTXdzpnP+G
1Csvr/J3HD+fDVxTi11wWOBsb8RP8AIHW+Jq4tNDDLafQQO1nNVYW6vZ6mKKkUrA
tIh6GNDEjPp7nY3KBBI0OnpCKj3ZzJG6TDV6fCZQMSbmiLBljVA+DVD4ZWML4ykS
Ac6OV93aU6aKt1l3lc1G
=dQiX
-----END PGP SIGNATURE-----
--=-=-=--
