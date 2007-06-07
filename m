Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch 08/18] PS3: Kexec support
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <46672D34.8010808@am.sony.com>
References: <20070606024407.786638029@am.sony.com> >
	<4666233F.1080103@am.sony.com>
	<1181102510.5536.15.camel@concordia.ozlabs.ibm.com>
	<46672D34.8010808@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9L+0TbELAOfsWI3WzAuh"
Date: Thu, 07 Jun 2007 12:31:08 +1000
Message-Id: <1181183468.4166.5.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9L+0TbELAOfsWI3WzAuh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-06-06 at 14:55 -0700, Geoff Levand wrote:
> Michael Ellerman wrote:
> >> --- a/arch/powerpc/platforms/ps3/htab.c
> >> +++ b/arch/powerpc/platforms/ps3/htab.c
> >> @@ -234,10 +234,18 @@ static void ps3_hpte_invalidate(unsigned
> >> =20
> >>  static void ps3_hpte_clear(void)
> >>  {
> >> -	/* Make sure to clean up the frame buffer device first */
> >> -	ps3fb_cleanup();
> >> +	int result;
> >> =20
> >> -	lv1_unmap_htab(htab_addr);
> >> +	DBG(" -> %s:%d\n", __func__, __LINE__);
> >> +
> >> +	result =3D lv1_unmap_htab(htab_addr);
> >> +	BUG_ON(result);
> >> +
> >> +	ps3_mm_shutdown();
> >> +
> >> +	ps3_mm_vas_destroy();
> >> +
> >> +	DBG(" <- %s:%d\n", __func__, __LINE__);
> >>  }
> >=20
> > Do you really want to be calling DBG() here? Hmm, it looks like it
> > doesn't actually do anything?
>=20
>=20
> Sure, it uses udbg_printf, and works OK.

Which is hooked up to what?

> >> +static void ps3_chip_mask(unsigned int virq)
> >> +{
> >> +	struct ps3_private *pd =3D get_irq_chip_data(virq);
> >> +	u64 bit =3D 0x8000000000000000UL >> virq;
> >> +	u64 *p =3D &pd->bmp.mask;
> >> +	u64 old;
> >> +	unsigned long flags;
> >> +
> >> +	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, vi=
rq);
> >> +
> >> +	local_irq_save(flags);
> >> +	asm volatile(
> >> +		     "1:	ldarx %0,0,%3\n"
> >> +		     "andc	%0,%0,%2\n"
> >> +		     "stdcx.	%0,0,%3\n"
> >> +		     "bne-	1b"
> >> +		     : "=3D&r" (old), "+m" (*p)
> >> +		     : "r" (bit), "r" (p)
> >> +		     : "cc" );
> >> +
> >> +	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
> >> +	local_irq_restore(flags);
> >=20
> > How is this different from set_bit() ?  (asm-powerpc/bitops.h)
> >=20
> > ps. now that I see you're just moving this code around someone's
> > probably already asked that question.
>=20
>=20
> This was contributed by Ben H as the fastest way.  I think the
> reason was that we could minimize the time between local_irq_save
> and local_irq_restore?

To save ~10 instructions? Followed by a HV call? I guess Ben has some
really good benchmark data to support it ;)

cheers


--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-9L+0TbELAOfsWI3WzAuh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZ23rdSjSd0sB4dIRAggKAKCLZmQmX/xj58lwh1790Pjx0ey4cgCdFg4v
91FPiOV/ZxlbaM9la/MDN64=
=vuBM
-----END PGP SIGNATURE-----

--=-9L+0TbELAOfsWI3WzAuh--
