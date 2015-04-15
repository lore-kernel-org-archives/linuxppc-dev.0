Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 951F01A0B8D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:10:09 +1000 (AEST)
Date: Wed, 15 Apr 2015 14:03:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 03/31] vfio: powerpc/spapr: Check that IOMMU
 page is fully contained by system page
Message-ID: <20150415040325.GE25040@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
In-Reply-To: <1428647473-11738-4-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:45PM +1000, Alexey Kardashevskiy wrote:
> This checks that the TCE table page size is not bigger that the size of
> a page we just pinned and going to put its physical address to the table.
>=20
> Otherwise the hardware gets unwanted access to physical memory between
> the end of the actual page and the end of the aligned up TCE page.
>=20
> Since compound_order() and compound_head() work correctly on non-huge
> pages, there is no need for additional check whether the page is huge.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Only thing I'm not sure about is...

> +		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
> +			ret =3D -EPERM;
> +			break;

=2E. whether EPERM is the right error code.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLeMNAAoJEGw4ysog2bOSD7IP+gP6DCTkkMcGtjVWSXJ3KqZn
Jk1fjxFEMD6sD6eSq5+KtH1W1Da91u+/4Uplltw3iq2a26W/rsgoR5dE3TXiEv9q
/iO8J0MFh2xKXkeFaz3qfPW+kFFZ/4n5LohxvtgAOies65ZXcuLPPl193ADbI1oN
8JuG9bRHcKnxibRqkQqgirD6Mn8UD2jEgdwcz9s/dbIR6g2V2jS2UICYbTkbkwUi
RCxN0BHNTun6IkvnHqrVH3ndJDvykBsJZ/ZdRVK4ST5EFIZrt8+pUy1s7h9CAP02
CZcrOqVRwIf8adlqLIUZ4ZMxA8yhby4ughJSa52JOtcpstP9fYpwmNZ4qpJwiMBL
bcn8EFWWTPoO8KwPt1NTNAhyFaoSTdUZGRO/Xn3MCMbtiep2zv3T9eB69el1X89B
xqDbUwKcPaKxVoKxu3Gpf44gMUgyRk9e/N+mt4SImOn0J52P0gyF4VUtR6IBTFkC
KVn6BRQYPSJcCtFmfpqlzmKREQ4Eac1XSkJUFh5A5kYKR+OKiZlygIT/o+4OEmj6
pASGVjp2XRuZhN1S3YYmFkdqtHK0Zw2w2oYfw5x1HgHoJVwLHlwcedKdwf1xpYzH
m82fVPoEK0oew8Z79+ni2cTIWIHFZiAPmxQJt3Uhh2xJQYitqQCAZa+50WgWCPbc
TafD2eV9guSPPUmbbckf
=unh+
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
