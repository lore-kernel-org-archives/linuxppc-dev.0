Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC PATCH 14/19] powerpc: allow ioremap within reserved fake
	ram 	regions
From: Michael Ellerman <michael@ellerman.id.au>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0AED90.6050600@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221536pf558b1fte36dc88bdf58e883@mail.gmail.com>
	<4B0AED90.6050600@yahoo.es>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-yaXlj1FrHkr+6mTscI/6"
Date: Tue, 24 Nov 2009 10:45:09 +1100
Message-ID: <1259019909.31172.63.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-yaXlj1FrHkr+6mTscI/6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-11-23 at 21:16 +0100, Albert Herranz wrote:
> >>  arch/powerpc/mm/pgtable_32.c |   19 ++++++++++++++++---
> >>  1 files changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32=
.c
> >> index cb96cb2..ba00cb1 100644
> >> --- a/arch/powerpc/mm/pgtable_32.c
> >> +++ b/arch/powerpc/mm/pgtable_32.c
> >> @@ -191,9 +191,22 @@ __ioremap_caller(phys_addr_t addr, unsigned long =
size, unsigned long flags,
> >>         * Don't allow anybody to remap normal RAM that we're using.
> >>         * mem_init() sets high_memory so only do the check after that.
> >>         */
> >> -       if (mem_init_done && (p < virt_to_phys(high_memory))) {
> >> -               printk("__ioremap(): phys addr 0x%llx is RAM lr %p\n",
> >> -                      (unsigned long long)p, __builtin_return_address=
(0));
> >> +       if (mem_init_done && (p < virt_to_phys(high_memory))
> >> +#ifdef CONFIG_WII
> >> +               /*
> >> +                * On some systems, though, we may want to remap an ar=
ea
> >> +                * declared as normal RAM that we have memreserve'd at=
 the
> >> +                * device tree. See wii.dts.
> >> +                * But we can't do that safely if we are using BATs to=
 map
> >> +                * part of that area.
> >> +                */
> >> +           && !__map_without_bats
> >> +#endif
> >> +           ) {
> >> +               printk(KERN_WARNING
> >> +                      "__ioremap(): phys addr 0x%llx is RAM lr %p\n",
> >> +                      (unsigned long long)p,
> >> +                        __builtin_return_address(0));
> >=20
> > This could adversely affect multiplatform kernels.  I'd rather get the
> > RAM problem fixed and not hack up common code to work around the hack.
> >=20
> > g.
> >=20
>=20
> Would it be acceptable to create a global var __allow_ioremap_normal_ram =
that by default would have a value of 0 and would be set _only_ for those p=
latforms needing it?
>=20
> The other solutions I see is:
> - add support for discontiguous memory to powerpc 32-bits (which is not s=
omething that I can look into now)
> - don't use the precious second 64MB area (which is a waste)

- Implement your own ppc_md.ioremap(), see iseries & cell for example.

Currently that's only called on 64-bit, but you could change that.

If I'm reading your patch right, you should be able to do that check in
your platform's ioremap() and then call the generic implementation to do
the actual work.

cheers

--=-yaXlj1FrHkr+6mTscI/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksLHoUACgkQdSjSd0sB4dKUpgCdHejes07cfynbhew/1SWwnWsi
9moAnRFerOoNbYUphVz5NsEVmwsss8mr
=lZUL
-----END PGP SIGNATURE-----

--=-yaXlj1FrHkr+6mTscI/6--
