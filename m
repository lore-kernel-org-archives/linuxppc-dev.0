Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC5A1DDF17
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:08:13 +1000 (EST)
Subject: Re: [PATCH] fix powerpc breakage in sg chaining code (again)
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <1193173222.7733.42.camel@johannes.berg>
References: <1193173222.7733.42.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nwDzQKlOZw5LzSb3aGIT"
Date: Tue, 23 Oct 2007 23:47:14 +0200
Message-Id: <1193176034.4097.3.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nwDzQKlOZw5LzSb3aGIT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-23 at 23:00 +0200, Johannes Berg wrote:
> Commit 33ff910f0f466184ffc3514628f18403dcd86761 fixed commit
> 78bdc3106a877cfa50439fa66b52acbc4e7868df but the code that got put in
> uses struct scatterlist->page which no longer exists since commit
> 18dabf473e15850c0dbc8ff13ac1e2806d542c15 which requires using
> sg_page(sg) instead of sg->page.

This doesn't help though, when I boot I get a NULL-pointer dereference
that looks approximately like this:

NIP blk_rq_map_sg + 0x64/0x190
LR ide_map_sg + 0x38/?
Call trace:
cfq_remove_request + 0x168 (unreliable)
cfq_dispatch_request + 0x44
ide_build_sglist + 0x38?
pmac_ide_dma_setup + 0xa0?
ide_do_rw_disk? + ?
[...]

I can upload the picture I took but it's hardly readable (taken with my
crappy cell phone)

johannes

--=-nwDzQKlOZw5LzSb3aGIT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx5r4aVg1VMiehFYAQJuZhAAi1gdWoqHG02BnMyVzldd59S5ze3vrI3G
qBpRf2cnd6EoSgSbB7Y5VdsCgxKSEP3WxuhgjG2TEQth/xRrSnYaGoSVoMrcJAq5
oYtcqD4gZLdE1PGKMeTk5xRJfoEXk7+VxpzDma7MaasF5p6qB7e1ymLsP93VtgHN
gMlscHwFXsaHk+XSRl4rN02QbtU+N1W+THKrqeLYVZsXaqG41YzG8g+773wrEcVG
G9dzMmEcTeWe1LNXEDlnNAWa0243kUuJ5JTB+ylMZhtBjPO5ohh4Dgic5fPpIuN/
/eqfY47+Mh9zf/3qd5wOYL1FvTkrPZZcfB92C01zbYfHyzEjfSG45S/8zVq5r02n
OvgaXOSereiPzzZS+IOUb+vn+TvXUh1N3FVyYBAjF8flUWIJ5pr4arev0xnug7HX
JmhLHpP2+37ffEYC8Yylp4ssfWV58da9cfI2cm1RPtlD9pyAS2LooUtM7x8/27w2
BB5OMIA3RDipiwuJqYHpccqQqbmjiSwn+KMFXBkmO/sm5ZbBZkygi0WSZPxAWM10
D1pxhu3zRrKS1lzdpKyM2HC1Ymimlo5jUkyUL2/E4Cu7dwDX3ThkV1mzLWuoew2v
8WNtcGuN3/ZotbCG2J28C8NcDZEq3VwzOz5KAOHneXSiyoIBsxXAnpgX+SYk6NIG
JXUYM+6FGhc=
=6TOJ
-----END PGP SIGNATURE-----

--=-nwDzQKlOZw5LzSb3aGIT--
