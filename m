Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x229.google.com (mail-pb0-x229.google.com
 [IPv6:2607:f8b0:400e:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 482222C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 16:42:26 +1100 (EST)
Received: by mail-pb0-f41.google.com with SMTP id up15so16356952pbc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 21:42:23 -0800 (PST)
Date: Tue, 18 Feb 2014 13:41:45 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 2/2] of: search the best compatible match first in
 __of_match_node()
Message-ID: <20140218054145.GD10028@pek-khao-d1.corp.ad.wrs.com>
References: <1392355366-1445-1-git-send-email-haokexin@gmail.com>
 <1392355366-1445-3-git-send-email-haokexin@gmail.com>
 <20140217175834.62ED6C403C8@trevor.secretlab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
In-Reply-To: <20140217175834.62ED6C403C8@trevor.secretlab.ca>
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Stephen N Chivers <schivers@csc.com.au>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2014 at 05:58:34PM +0000, Grant Likely wrote:
> This seems wrong also. The compatible order should be checked for even
> when m->name or m->type are set.  You actually need to score the entries
> to do this properly. The pseudo-code should look like this:
>=20
> uint best_score =3D ~0;
> of_device_id *best_match =3D NULL;
> for_each(matches) {
> 	uint score =3D ~0;
> 	for_each_compatible(index) {
> 		if (match->compatible =3D=3D compatible[index])
> 			score =3D index * 10;
> 	}
>=20
> 	/* Matching name is a bit better than not */
> 	if (match->name =3D=3D node->name)
> 		score--;
>=20
> 	/* Matching type is better than matching name */
> 	/* (but matching both is even better than that */
> 	if (match->type =3D=3D node->type)
> 		score -=3D 2;
>=20
> 	if (score < best_score)
> 		best_match =3D match;
> }
> return best_match;
>=20
> This is actually very similar to the original code. It is an easy
> modification. This is very similar to how the of_fdt_is_compatible()
> function works.

I like this idea and will make a new patch based on this.

Thanks,
Kevin
>=20
> g.

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJTAvKZAAoJEJNY7TDerrFx2QwH/im1TUhMORxD3cW861eZjPi1
+fgtodcxwYf15R6dmU0Pc5pNpt7sLaD0rqbuwYFKbaaBS5+uXIK44HT3nGGgT0ZB
AO0Cel2X0KPuTtyFAlDgT4PNDlyMNV9xPgJ/zq2afNZKdHkZpeWdBwNgCWDcNRUt
PvXLn+6a8mNG34yrSSSGHqQpVKgA/8OOEJOoMs/aQP5bhugivH1D7tcg9/TxWIpL
l2EkB/+iD+5v5OnWAm/SECiyEHxBPt7wOCxBeMAAesDVmC/ghKJ+s6qQKbn22+FZ
NL+wcbhT032ZxmIYTx79oncv8I+A3Nx495djFpryq0RBf3eiylZ37KvwcTVmO5k=
=cRcK
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
