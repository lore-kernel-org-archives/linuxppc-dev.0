Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E8C6DB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 18:32:17 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB826DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 18:32:17 +1000 (EST)
Subject: Re: [PATCH] kmemleak: Allow kmemleak to be built on powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <1247819195.32760.7.camel@pc1117.cambridge.arm.com>
References: <f18967360113efe4354a9ad0d71ead9a0f7579ea.1247707485.git.michael@ellerman.id.au>
	<1247730230.18228.5.camel@concordia>
	<1247766739.27689.63.camel@pc1117.cambridge.arm.com>
	<1247790558.16836.4.camel@concordia>
	<1247819195.32760.7.camel@pc1117.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-no6AxcV1Eszv7N2jQtgv"
Date: Fri, 17 Jul 2009 18:32:16 +1000
Message-Id: <1247819536.19156.13.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-no6AxcV1Eszv7N2jQtgv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-07-17 at 09:26 +0100, Catalin Marinas wrote:
> On Fri, 2009-07-17 at 10:29 +1000, Michael Ellerman wrote:
> > On Thu, 2009-07-16 at 18:52 +0100, Catalin Marinas wrote:
> > > On Thu, 2009-07-16 at 17:43 +1000, Michael Ellerman wrote:
> > > > On Thu, 2009-07-16 at 11:25 +1000, Michael Ellerman wrote:
> > > > > Very lightly tested, doesn't crash the kernel.
> > > > >=20
> > > > > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > > > > ---
> > > > >=20
> > > > > It doesn't look like we actually need to add any support in the
> > > > > arch code - or is there something I'm missing?
> > > >=20
> > > > Hmm, I think we want to add annotations in lib/lmb.c don't we? That=
's
> > > > our low-level pre-bootmem allocator.
> > >=20
> > > Yes, I think so (I'm not using this on ARM or x86 so I can't really t=
est
> > > it). Without these hooks, there kmemleak reports aren't that useful
> > > (probably too many).
> >=20
> > The wrinkle is that lmb never frees, so by definition it can't leak :)
>=20
> You can pass min_count =3D 0 to kmemleak_alloc() so that it would never
> report such blocks as leaks (see the alloc_bootmem hooks).

OK. I couldn't see any description of what min_count meant anywhere,
I'll try that though.

> > But we could have memory allocated with lmb that has pointers to other
> > objects allocated later, and we want kmemleak to scan the lmb allocated
> > blocks to find those references.
> >=20
> > So the question is do we need to annotate lmb so that will happen, or
> > does kmemleak scan all kernel memory, regardless of where it's
> > allocated?
>=20
> Apart from the data and bss sections, it only scans the memory which was
> explicitly allocated. So, you need these hooks in the lmb code.

OK, cool, I'll do a patch to add them.

> The mainline kernel scans for the task stacks by going through the full
> tasks list. However, traversing this list requires a lock which
> increases the latency quite a lot. For the next merging window, I added
> hooks to the alloc_thread_info/free_thread_info functions. If the ppc
> code has __HAVE_ARCH_THREAD_INFO_ALLOCATOR defined, you may need to add
> some hooks in there as well (but note that kmallloc/kmem_cache_alloc are
> tracked by kmemleak already, so you only need the hooks if the
> thread_info allocator uses __get_free_pages).

We do have our own allocator, but it just uses a kmem_cache, so that
should be fine.

cheers

--=-no6AxcV1Eszv7N2jQtgv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpgNxAACgkQdSjSd0sB4dIr4QCgor+er6CwRvKLGeHZrhTGlsjK
/VEAnRDv1zt3sC8V1MNygnbud5IMG6Ps
=dtwz
-----END PGP SIGNATURE-----

--=-no6AxcV1Eszv7N2jQtgv--
