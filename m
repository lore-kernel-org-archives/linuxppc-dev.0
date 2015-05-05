Return-Path: <haokexin@gmail.com>
Received: from mail-qg0-x232.google.com (mail-qg0-x232.google.com
 [IPv6:2607:f8b0:400d:c04::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11E021A06B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 12:27:53 +1000 (AEST)
Received: by qgej70 with SMTP id j70so75123239qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2015 19:27:50 -0700 (PDT)
Date: Tue, 5 May 2015 10:27:43 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: fix the dependency issue for CRASH_DUMP
Message-ID: <20150505022743.GB24874@pek-khao-d1.corp.ad.wrs.com>
References: <1430396997-14656-1-git-send-email-haokexin@gmail.com>
 <1430396997-14656-2-git-send-email-haokexin@gmail.com>
 <1430777837.16357.227.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
In-Reply-To: <1430777837.16357.227.camel@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 05:17:17PM -0500, Scott Wood wrote:
> On Thu, 2015-04-30 at 20:29 +0800, Kevin Hao wrote:
> > In the current code, the RELOCATABLE will be forcedly enabled when
> > enabling CRASH_DUMP. But for ppc32, the RELOCABLE also depend on
> > ADVANCED_OPTIONS and select NONSTATIC_KERNEL. This will cause build
> > error when CRASH_DUMP=3Dy && ADVANCED_OPTIONS=3Dn. Even there is no such
> > issue for ppc64, but select is only for non-visible symbols and for
> > symbols with no dependencies. As for a symbol like RELOCATABLE, it is
> > definitely not suitable to select it. So choose to depend on it.
>=20
> Why is it "definitely not suitable to select it", provided the
> ADVANCED_OPTIONS dependency is removed, and the FLATMEM dependency is
> moved to places that select RELOCATABLE?

Even with this change, the definition of RELOCATABLE still be something like
this:
    config RELOCATABLE
           bool "Build a relocatable kernel"
           depends on (PPC64 && !COMPILE_TEST) || 44x || FSL_BOOKE
           select NONSTATIC_KERNEL

Quoted form Documentation/kbuild/kconfig-language.txt:
        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

So it is always error prone to select a kernel option like this.

>  It seems wrong that the user
> should have to enable ADVANCED_OPTIONS to even see the option to build a
> crash kernel.

Yes, it seems ridiculous. But this is fixed in the patch 2.

Thanks,
Kevin

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVSCqfAAoJEJNY7TDerrFxSgMH/2A8VIKAxWTZfvts5hAWjsFl
qb5HTBIVRe48kXqvvFlgnc0HGxKh5JNOUnRqwDQ0qL+9o6toxs3UX6JNbGFnmEJR
Jmn0lTXf++S+gfOqRx2tY9eD002cnU/yGPq5MWR5hd8RGZlZvu6j3FheUmy9qXmk
+BXFLHhwqk+u/puhACURSetuJSpIhoSVAftFb3jU10d+gj3IlpjozGOhuM4Ir+rU
Hyp9/e3BU62KPuAJCitrzak6BUNANa+Qdv9SaYm/c1BFe+1ZA+FGk65MV3gd+haW
fIhlpdU0StJh5MuDTPoHYLuK+p6ll/4L/HFAUe80y7K7dtPG7stMf3o/cFEJp8Y=
=2EUP
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
