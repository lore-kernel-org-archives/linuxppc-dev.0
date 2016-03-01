Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D56781A074D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 13:28:13 +1100 (AEDT)
Date: Tue, 1 Mar 2016 13:27:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [3/4] powerpc/mm: Clean up memory hotplug failure paths
Message-ID: <20160301022741.GK5427@voom.redhat.com>
References: <1454988763-5580-4-git-send-email-david@gibson.dropbear.id.au>
 <20160301015907.D4344140BA7@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4wkndigzIeYF6Hbg"
In-Reply-To: <20160301015907.D4344140BA7@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4wkndigzIeYF6Hbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2016 at 12:59:07PM +1100, Michael Ellerman wrote:
> On Tue, 2016-09-02 at 03:32:42 UTC, David Gibson wrote:
> > This makes a number of cleanups to handling of mapping failures during
> > memory hotplug on Power:
> >
> > For errors creating the linear mapping for the hot-added region:
> >   * This is now reported with EFAULT which is more appropriate than the
> >     previous EINVAL (the failure is unlikely to be related to the
> >     function's parameters)
> >   * An error in this path now prints a warning message, rather than just
> >     silently failing to add the extra memory.
> >   * Previously a failure here could result in the region being partially
> >     mapped.  We now clean up any partial mapping before failing.
> >
> > For errors creating the vmemmap for the hot-added region:
> >    * This is now reported with EFAULT instead of causing a BUG() - this
> >      could happen for external reason (e.g. full hash table) so it's be=
tter
> >      to handle this non-fatally
> >    * An error message is also printed, so the failure won't be silent
> >    * As above a failure could cause a partially mapped region, we now
> >      clean this up.
> >
> ...
> > diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> > index baa1a23..fbc9448 100644
> > --- a/arch/powerpc/mm/init_64.c
> > +++ b/arch/powerpc/mm/init_64.c
> > @@ -217,15 +219,20 @@ static void vmemmap_remove_mapping(unsigned long =
start,
> >  }
> >  #endif
> >  #else /* CONFIG_PPC_BOOK3E */
> > -static void __meminit vmemmap_create_mapping(unsigned long start,
> > -					     unsigned long page_size,
> > -					     unsigned long phys)
> > +static int __meminit vmemmap_create_mapping(unsigned long start,
> > +					    unsigned long page_size,
> > +					    unsigned long phys)
> >  {
> > -	int  mapped =3D htab_bolt_mapping(start, start + page_size, phys,
> > -					pgprot_val(PAGE_KERNEL),
> > -					mmu_vmemmap_psize,
> > -					mmu_kernel_ssize);
> > -	BUG_ON(mapped < 0);
> > +	int rc =3D htab_bolt_mapping(start, start + page_size, phys,
> > +				   pgprot_val(PAGE_KERNEL),
> > +				   mmu_vmemmap_psize, mmu_kernel_ssize);
> > +	if (rc < 0) {
> > +		int rc2 =3D htab_remove_mapping(start, start + page_size,
> > +					      mmu_vmemmap_psize,
> > +					      mmu_kernel_ssize);
>=20
> This breaks the build when CONFIG_MEMORY_HOTPLUG=3Dn, because
> htab_remove_mapping() is not defined.
>=20
> The obvious fix of moving htab_remove_mapping() out of CONFIG_MEMORY_HOTP=
LUG
> works, so I'll do that unless anyone objects.

Sounds good, thanks for the catch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4wkndigzIeYF6Hbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1P4cAAoJEGw4ysog2bOSZAUP/RTLXJY1KwfgLBqdbfNL5IUy
fdDi7ObyOv6IN2BPCTTmkkXoB72qaXoVi6GpYej6ZS5i+zME6z3Tpr4Wc6SnK92w
23S9Fs3SuC2w1uLkY+iMzLoiCvWLQjIWSltFTgEeiwumX5u3M/cfGkWRbPnswTa8
+SMmQzQBpLufkciSqUX/LB6cZO1S3L3L/pe21NLq5aNH4Fu73A+tbJcwl1w2F9R8
RUTjL8GO6yzCgmFK1ayyeSn2JcsSPTqcHxZ3bcKUtO6Hp98xThI2phuJoCEMxinE
8qwjSpedCJC7LaTXbDToflnDhQOUIGGpR8V3itTOs9yUkx7RsFZU63i80hcBFUGm
0imTVKWGG73rD/mLGq4oG/GDr8jy3Q2Fhu1DCeWfn/S/azhNMv9IwTsP56S/a555
Sjvahf1tpAQO+4tikzzVujBrexXAIdF3DKysN2uxwww5GvbwgxBArBCVHDJ7dhlm
TV/YcqRJjg2qoN5t+AypWEVVWBx0+ZqZbP7zJmIh9SSEbl3vammPLDu+nZ3jczR3
lo1efrgzUviPggZzOucSHUX0wrnovn3hkbl5Ukcq52WtYMQHiCEz7wUUE/lLw3Ti
0Z9WD/tbyhQKVi6v3k6rORGr1OVqBtp1pJlINOHnxm4aFfaazGwNP/OVcaUn0FTF
2pdJOc55RGcO//n38VaQ
=PIZB
-----END PGP SIGNATURE-----

--4wkndigzIeYF6Hbg--
