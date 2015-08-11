Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A04841A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 09:50:21 +1000 (AEST)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 785F01401AD
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 09:50:20 +1000 (AEST)
Received: by pacrr5 with SMTP id rr5so889258pac.3
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 16:50:18 -0700 (PDT)
Message-ID: <1439336878.24419.41.camel@axtens.net>
Subject: Re: [PATCH v2 08/10] cxl: Allow the kernel to trust that an image
 won't change on PERST.
From: Daniel Axtens <dja@axtens.net>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, "Matthew R. Ochs"
 <mrochs@linux.vnet.ibm.com>, imunsie@au.ibm.com, Manoj Kumar
 <kumarmn@us.ibm.com>
Date: Wed, 12 Aug 2015 09:47:58 +1000
In-Reply-To: <1439292157.24419.37.camel@axtens.net>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-9-git-send-email-dja@axtens.net>
 <20150811171538.477c3842@camb691> <1439292157.24419.37.camel@axtens.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-S+y/Tegu+Hed+K1E9uwe"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-S+y/Tegu+Hed+K1E9uwe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So after further offline conversations,

Yes, Cyril, you are right, I don't need the ifdef in my code. I just
need the symbol. I will amend my patches appropriately.

On Tue, 2015-08-11 at 21:22 +1000, Daniel Axtens wrote:
> > So I'm not super all over the putting all sorts of code inside CONFIG_C=
XL_EEH,
> > I understand that there is another driver being merged and they'll use
> > CONFIG_CXL_EEH so that both this driver and the other driver can go in =
the same
> > merge window but does this mean you need to put it around everything he=
re?
> >=20
> > I may have misunderstood what you've told me but if the other driver de=
pends on
> > work done in this one (and not the other way around), if they depend on
> > CONFIG_CXL_EEH which you create in the last patch, then they cannot be =
built
> > until this series exists, so they can't have issues.
> >=20
> > The one catch is that this series as is waits untill the last patch to =
actually
> > create the symbol, and therefore compile everything so lets be sure you=
 don't
> > break bisecting. You might need to rethink the order of things in 8/10 =
and 9/10,
> > I can't see anything obvious if it helps...
> >=20
>=20
> Yeah, so you're right. I've taken the guards off everything except the
> new API function. I still want to leave the patch that adds the symbol
> at the end: that way you don't get the function unless it is actually
> going to make a difference in the EEH process.=20
>=20
> The other driver (cxlflash) just guards the API function, inserting a
> stub if it's not defined. So this setup will make our code cleaner and
> will still let their code merge cleanly.
>=20
> Thanks again for the review.
>=20

--=20
Regards,
Daniel

--=-S+y/Tegu+Hed+K1E9uwe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVyomuAAoJEPC3R3P2I92FDQUQALsM7Plue1/U8h9iS/YIAWYt
B+6Aw5wiogfWi/09vlej3KpSGInqREob+jelZKknZj5K0kGPo3pp5WIfdUa/WBmf
cccYGOmIDdSW8/jFqEOzcbk5YIjxk6/I4H+NW/9b3y07bvNTesvk0EcErI87yZCG
utUjLGdOZS2gva3y28QiK6D61dsCGiERPOx4og00dRYShiFSPKuJSxB0pLH3Zqix
uNyojdbO9IxsmGZKjvh5xTGpPU0VmNdl4S3YrtTfkq+UR+lUmCq9tDNNtFMKTGSO
xUJstpZdJ4IkH6tAMo4BUzieXDlMT+JGNMH3i1XAG2tQm0tkdN+dID2CQJUyazkh
wsXZBlBg7eQazqgdAOfAqtbLkjMJ5SEMcYE6kRFbp4g9ZPspQQZn2i6xeTGe31s+
yUCl64WI7cvSq/LZdgz16l1ZAjzXVXeDgKgY1O2yhnfFZEL7E9RwRgLnDUBJPeaO
f5pbzLIlTlxTHPtbl2whglRAWs6T6kcOJ/T1a6j2PJZiOvjBaYes1PdBu2sgh7Oj
SOndWz5wWytaddYhYs2RoRwJp1RLXlJpOA3ECjK41k149oZRwxpOilEiiz1sjk+L
Ebn8HDSiKerlcvl5dW9Vu7IF6XT/fBiE1w8LhOicNAMNZzjrusOr2RJtQRTpWnWs
vsGNWmiAAP724dlu7ib1
=3Hno
-----END PGP SIGNATURE-----

--=-S+y/Tegu+Hed+K1E9uwe--
