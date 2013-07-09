Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE9CA2C016A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 11:27:04 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id 14so4630490pdj.40
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jul 2013 18:27:02 -0700 (PDT)
Date: Tue, 9 Jul 2013 09:26:51 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20130709012651.GA13551@pek-khao-d1.corp.ad.wrs.com>
References: <20130702032447.GA26391@pek-khao-d1.corp.ad.wrs.com>
 <1372804758.8183.124@snotra>
 <20130703030044.GA25190@pek-khao-d1.corp.ad.wrs.com>
 <1372883907.8183.151@snotra>
 <20130704010818.GA16188@pek-khao-d1.corp.ad.wrs.com>
 <1373302105.8183.160@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
In-Reply-To: <1373302105.8183.160@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 11:48:25AM -0500, Scott Wood wrote:
> On 07/03/2013 08:08:18 PM, Kevin Hao wrote:
> >On Wed, Jul 03, 2013 at 03:38:27PM -0500, Scott Wood wrote:
> >> On 07/02/2013 10:00:44 PM, Kevin Hao wrote:
> >> >On Tue, Jul 02, 2013 at 05:39:18PM -0500, Scott Wood wrote:
> >> >> How much overhead (space and time) is this really?
> >> >
> >> >The following is the additional sections when relocatable is
> >> >enabled for
> >> >a p2020rdb board.
> >> >   section        size
> >> >  .dynsym       000007f0
> >> >  .dynstr       00000926
> >> >  .dynamic      00000080
> >> >  .hash         00000388
> >> >  .interp       00000011
> >> >  .rela.dyn     00215250
> >> >
> >> >The time for the relocation is about 32ms on a p2020rdb board.
> >>
> >> Hmm... more relocations than I expected.  What percentage is this of
> >> the total image size?
> >
> >The size of vmlinux.bin is about 10M. The percentage of the relocation
> >section is about 20%. But look on the bright side of thing, all
> >the relocation
> >stuff are in init section and should be discarded at runtime. :-)
>=20
> That doesn't reduce the space it takes up in flash...

Yes. But since we always use a compressed uImage kernel in flash,
the increasing size of the image would shrink to about 500K.

Thanks,
Kevin

>=20
> -Scott

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR22bbAAoJEJNY7TDerrFxvZAH/0oFmewwr89z2utC/sw5wNYH
+voFLKwb5tGyN6/UNfnWUKxwZjCG1xuYjH4KDGedAwP6jCo6PNs210q6DsSblLhY
QToJqxmtqSg5Q7ojCxWKqsddgNMCP+zhQ31AOrgMOZK1OjRqDtBEYjF4JMUDAbNb
FqSvcpSrAzBQ+UQi4C2Wc5ZM3mmdD90JYwt99xZ+ZLXISCAJ9cakAoUV8HiOfE+C
bCQk/szECJmrM3M6D6MKNSuatmBtSoPFftiOkqPi2rtkTQlKcCE7q0so5Atiohcn
fLQwiGA5oG5DHIQkFdsdIKtRTaVK4ASZge5IEIvKLx5UkjkCmLTbdKW6BKQ9+S8=
=SBpk
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
