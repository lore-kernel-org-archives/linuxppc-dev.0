Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch] Possible fix for kexec-tools dynamic range allocation
From: Michael Ellerman <michael@ellerman.id.au>
To: Simon Horman <horms@verge.net.au>
In-Reply-To: <20090120212959.GA3564@verge.net.au>
References: <20090120212959.GA3564@verge.net.au>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-xoTqL495mndz7kR+I9Ut"
Date: Wed, 21 Jan 2009 12:06:09 +1100
Message-Id: <1232499969.11241.27.camel@localhost>
Mime-Version: 1.0
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org,
	Milton Miller <miltonm@bga.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, muvarov@gmail.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xoTqL495mndz7kR+I9Ut
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-21 at 08:30 +1100, Simon Horman wrote:
> On Wed, Jan 07, 2009 at 05:01:26PM +1100, Michael Ellerman wrote:
> > Hi all,
> >=20
> > The patch to dynamically allocate memory regions for ppc64 kexec-tools,
> > ie. "ppc64: kexec memory ranges dynamic allocation" (d182ce5), has neve=
r
> > worked AFAICT.
> >=20
> > Chandru reported it as broken when it was posted:
> > http://lists.infradead.org/pipermail/kexec/2008-October/002751.html
> >=20
> > Still, it's in now, and I'm trying to work out what's going wrong.
> >=20
> > The symptom is as reported by Chandru, we end up not being able to
> > allocate any memory (in locate_hole()). This is caused by the list of
> > memory_ranges being empty.
> >=20
> > The memory_ranges are empty because they have been realloc'ed (by the
> > dynamic alloc code), and the generic code is still looking at the old
> > version.
> >=20
> > What I'm not clear on is why the ppc64 code is even calling
> > setup_memory_ranges() a second time (in elf_ppc64_load()). It's already
> > been called by get_memory_ranges() from my_load(). Or is there another
> > route into elf_ppc64_load() that I'm not seeing?
> >=20
> > And in fact if I just remove that call, then everything is peachy.
> >=20
> > The following patch makes it work for me at least.
>=20
> Hi Michael,
>=20
> I must confess that I don't have a complete understanding of this problem=
.
> Does Bernhard's recent patch (sorry that I applied it even though
> it came in after your patch) help this problem?

Hi Horms,

Well to be honest neither do I, I was hoping someone who'd written or
helped write the original code would comment.

Bernhard's patch will help, but I think mine is a better solution.

> commit 95c74405638c786bc76fbca5e4e8427dfe26e907
> Author: Bernhard Walle <bwalle@suse.de>
> Date:   Fri Jan 16 19:11:34 2009 +0100
> Subject: Fix memory corruption when using realloc_memory_ranges()

> Because realloc_memory_ranges() makes the old memory invalid, and we retu=
rn
> a pointer to memory_range in get_memory_ranges(), we need to copy the con=
tents
> in get_memory_ranges().
>=20
> Some code that calls realloc_memory_ranges() may be triggered by
> get_base_ranges() which is called after get_memory_ranges().
>=20
> Yes, the memory needs to be deleted somewhere, but I don't know currently
> where it's the best, and since it's not in a loop and memory is deleted
> anyway after program termination I don't want to introduce unneccessary
> complexity. The problem is that get_base_ranges() gets called from
> architecture independent code and that allocation is PPC64-specific here.

I don't see where get_base_ranges() is called other than from PPC64
code, so I'm confused about this comment.

What I see happening is:
      * get_memory_ranges() is called early in kexec.c and saves a
        pointer to the memory ranges in "info".
      * Any subsequent call which causes the memory ranges to be
        realloc'ed will screw that up, because now info will point at
        free'd memory.
      * Later on in elf_ppc64_load() we call setup_memory_ranges()
        (again).
      * That may cause the ranges to be realloc'ed, which would be bad.
      * But the second call to setup_memory_ranges() is useless, because
        it doesn't update info, and info is what we keep using for
        allocations.
      * So if setup_memory_ranges() found new ranges, they would never
        be used, even apart from the corruption issue. So we may as well
        not call it.
      * If there are /other/ code paths where we can realloc memory
        ranges then maybe we /also/ need Bernhard's patch.

But that was only a 10 minute analysis, so maybe I'm wrong ;)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-xoTqL495mndz7kR+I9Ut
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl2dQEACgkQdSjSd0sB4dJu1ACguUG53LcSYJoTh/L+xIJL1QxI
NPYAn28Y+0t5U4Y7M1YY7QE52ztKMFLE
=FPJG
-----END PGP SIGNATURE-----

--=-xoTqL495mndz7kR+I9Ut--
