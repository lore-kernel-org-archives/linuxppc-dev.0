Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A7A2E2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 12:20:37 +1100 (EST)
Received: by mail-pd0-f176.google.com with SMTP id w10so11238000pde.35
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 17:20:34 -0800 (PST)
Date: Fri, 14 Feb 2014 09:20:10 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: give priority to the compatible match in
 __of_match_node()
Message-ID: <20140214012010.GA26019@pek-khao-d1.corp.ad.wrs.com>
References: <1392205084-2351-1-git-send-email-haokexin@gmail.com>
 <CAL_JsqKMi2H=vwoxrOt8QRA2xJeiLqBKKfLtt4QRCRoFk6JUHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
In-Reply-To: <CAL_JsqKMi2H=vwoxrOt8QRA2xJeiLqBKKfLtt4QRCRoFk6JUHg@mail.gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Chris Proctor <cproctor@csc.com.au>,
 Stephen N Chivers <schivers@csc.com.au>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 01:01:42PM -0600, Rob Herring wrote:
> On Wed, Feb 12, 2014 at 5:38 AM, Kevin Hao <haokexin@gmail.com> wrote:
> > When the device node do have a compatible property, we definitely
> > prefer the compatible match besides the type and name. Only if
> > there is no such a match, we then consider the candidate which
> > doesn't have compatible entry but do match the type or name with
> > the device node.
> >
> > This is based on a patch from Sebastian Hesselbarth.
> >   http://patchwork.ozlabs.org/patch/319434/
> >
> > I did some code refactoring and also fixed a bug in the original patch.
>=20
> I'm inclined to just revert this once again and avoid possibly
> breaking yet another platform.
>=20
> However, I think I would like to see this structured differently. We
> basically have 2 ways of matching: the existing pre-3.14 way and the
> desired match on best compatible only. All new bindings should match
> with the new way and the old way needs to be kept for compatibility.
> So lets structure the code that way. Search the match table first for
> best compatible with name and type NULL, then search the table the old
> way. I realize it appears you are doing this, but it is not clear this
> is the intent of the code. I would like to see this written as a patch
> with commit 105353145eafb3ea919 reverted first and you add a new match
> function to call first and then fallback to the existing function.

OK, I will git it a try.

Thanks,
Kevin

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJS/W9KAAoJEJNY7TDerrFx1AIH/1eZ+ZP6oOR8Bj18Y8vEItDj
a0Z2n2Qe3s2LWTxBR/kKHkMFS2aNcObrZ3nMZjgrZDyzfxd3Z/9gwi3Crhxqiq+j
EbDDzB0u9IleT5oeDNHOdzl/8itf4hpbezU4FdaJUxdFPTi20ssYA0qKinkV9xVo
GGAHpqQ8uyru2h8jcfIzZFSfuvPRWOdBT7vezTKlE+fgYvQKdzZGhGl/J9/olP1s
+++v0TO8I/gtleOzZP5JEgoYT9X/9lrd1CDG6Zv/LYjFYBRPpY+Yl3uZB8x6CIo0
rzdTxWrpUYRaceIx/O0VyFTLd3i8+wSA5Ng9HEupOp0iZa+TGbi0+ekAt07gQzM=
=mV8L
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
