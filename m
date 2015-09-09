Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33C011A0138
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 13:26:11 +1000 (AEST)
Received: by pacfv12 with SMTP id fv12so146198339pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2015 20:26:07 -0700 (PDT)
Date: Wed, 9 Sep 2015 11:25:48 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH] powerpc: Kconfig: remove BE-only platforms from LE
 kernel build
Message-ID: <20150909032548.GA18626@fixme-laptop.cn.ibm.com>
References: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
 <1441765604.7854.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
In-Reply-To: <1441765604.7854.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, Sep 09, 2015 at 12:26:44PM +1000, Michael Ellerman wrote:
> On Mon, 2015-09-07 at 07:58 +0800, Boqun Feng wrote:
> > diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platfor=
ms/cell/Kconfig
> > index 2f23133..808a904 100644
> > --- a/arch/powerpc/platforms/cell/Kconfig
> > +++ b/arch/powerpc/platforms/cell/Kconfig
> > @@ -25,7 +25,7 @@ config PPC_CELL_NATIVE
> > =20
> >  config PPC_IBM_CELL_BLADE
> >  	bool "IBM Cell Blade"
> > -	depends on PPC64 && PPC_BOOK3S
> > +	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
>=20
> We end up saying this five times.
>=20
> We already have PPC_BOOK3S_64 which captures the first two conditions, sh=
ould
> we add a PPC_BOOK3S_64_BE which expresses it all?
>=20

I'm not sure whether this is worth.. IMO, we add a config option only if

1.	we can use this config somewhere in the code, for example,
	"#ifdef CONFIG_XXX"
or

2.	we want to offer a option for users to choose.

PPC_BOOK3S_64_BE satisfies neither condition. Further more,
CONFIG_PPC64, CONFIG_PPC_BOOK3S and CONFIG_CPU_BIG_ENDIAN all are used
in some #ifdefs in current code. As a newbie of kernel, I'm happy to get
some knowledge like: "If I'm hacking PS3, then #ifndef CONFIG_PPC64 is
guaranteed to be false, so I can just ignore the code guarded by them".
But if we add a PPC_BOOK3S_64_BE, it will take a little more effort to
see this.

Regards,
Boqun

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV76a4AAoJEEl56MO1B/q45noIALHAdUeKxv0hNzd/3jRl0fi+
8QK2ThUrBVyLiReocMjT3YqIQWLOj5dEi9Tu3Gv4xEmnz8aXZ/FyDsP67vTkgSDQ
J4lvtrX+xlgu3/icUYaVsu4KiFdZbpiAjB5PBtdfp1qbWZQcQR1YKmhi7Sx+cxMD
CCT8RY44/ny9JsHOnJbVHCtdP9AMqY+ol7dyM8r8VEXC5iSU8A2+48ka9TD20u0v
gtgUBRQ8p1l2B0yZB5UvA14tF2gj8JlXvxR9aPL9wBemnNmH0IMHmKxu503q3bAJ
+9ttBQSZdL5qLHyHPX+VtiJtAlHGXdNS99wv7tziK1NHDTOEOn2TBgy9t+ZCvDA=
=BSSN
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
