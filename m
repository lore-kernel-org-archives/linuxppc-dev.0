Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVMYT0jkvzDrBt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 16:05:48 +1100 (AEDT)
Date: Fri, 2 Dec 2016 05:05:42 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org
Message-ID: <20161202050542.GL2697@decadent.org.uk>
References: <20161202023552.GJ2697@decadent.org.uk>
 <87a8cf7zls.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4IFtMBbmeqbTM/ox"
In-Reply-To: <87a8cf7zls.fsf@concordia.ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc: Remove Mac-on-Linux hooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4IFtMBbmeqbTM/ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2016 at 02:56:47PM +1100, Michael Ellerman wrote:
> Ben Hutchings <ben@decadent.org.uk> writes:
>=20
> > [ Unknown signature status ]
> > The symbols exported for use by MOL aren't getting CRCs and I was
> > about to fix that.  But MOL is dead upstream, and the latest work on
> > it was to make it use KVM instead of its own kernel module.  So remove
> > them instead.
>=20
> Sounds good to me.
>=20
> > diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_3=
2.S
> > index 9d963547d243..87998430cd9b 100644
> > --- a/arch/powerpc/kernel/head_32.S
> > +++ b/arch/powerpc/kernel/head_32.S
> > @@ -735,11 +735,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
> >  	EXCEPTION(0x2c00, Trap_2c, unknown_exception, EXC_XFER_EE)
> >  	EXCEPTION(0x2d00, Trap_2d, unknown_exception, EXC_XFER_EE)
> >  	EXCEPTION(0x2e00, Trap_2e, unknown_exception, EXC_XFER_EE)
> > -	EXCEPTION(0x2f00, MOLTrampoline, unknown_exception, EXC_XFER_EE_LITE)
> > -
> > -	.globl mol_trampoline
> > -	.set mol_trampoline, i0x2f00
> > -	EXPORT_SYMBOL(mol_trampoline)
> > +	EXCEPTION(0x2f00, Trap_2f, unknown_exception, EXC_XFER_EE)
> > =20
> >  	. =3D 0x3000
> > =20
> > @@ -1289,7 +1285,6 @@ intercept_table:
> >  	.long 0, 0, 0, 0, 0, 0, 0, 0
> >  	.long 0, 0, 0, 0, 0, 0, 0, 0
> >  	.long 0, 0, 0, 0, 0, 0, 0, 0
> > -EXPORT_SYMBOL(intercept_table)
>=20
> I don't see intercept_table used anywhere, so I think we can just remove
> it entirely?

That's strange, so it's actually constant data.

And... I've managed to confuse myself about which symbols are for
MOL.  This one was actually used by rtlinux, which AFAICS is also
long dead.
=20
> > diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_3=
2.S
> > index 09cc50c8dace..cddf14f60bf3 100644
> > --- a/arch/powerpc/mm/hash_low_32.S
> > +++ b/arch/powerpc/mm/hash_low_32.S
> > @@ -34,7 +34,6 @@
> >  	.globl mmu_hash_lock
> >  mmu_hash_lock:
> >  	.space	4
> > -EXPORT_SYMBOL(mmu_hash_lock)
> >  #endif /* CONFIG_SMP */
>=20
> And now mmu_hash_lock is only used in this file, so doesn't need to be
> global anymore.

Right.

Ben.

> I can fix both of those up here, will just wait a bit to see if anyone
> else has comments.
>=20
> cheers

--=20
Ben Hutchings
It's easier to fight for one's principles than to live up to them.

--4IFtMBbmeqbTM/ox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWEEBJee/yOyVhhEJAQo0xhAAtjh6b7L6enmnRffWh8XtH/Ks+Xt0qVcX
pURMSTIAWFKwujCBpUN0+hGNOik03/nFZo7EwJcX+wGhB1u5JKFHcf30FBRXEeY5
5Gw5pMnNf0HI7mQ/ImBlh7OJNz7uRV+MU+pP6q1XuGadVCeH2NI6TlbTOHOED0jm
aZWetTN8jm7zlQ+nSjMxSz6gLL9amzECaVZ0Z5LeRGXxvdd2uw3cvH5hjs497roE
c7dNd7xGvYABiaLFh3rTG7XzeAkzwlPj+cYEE4L8TatA1b5gERnoZFHvB5Gy+/qG
k2zflMT11aq8+XBhvWlIkYbJc/1fallYpIO6acb3htILb7cV6tw/C437gy9/NC/B
YjQI9HhfV9jL7BhNPg8oBDiJwFiRVkqbrltlIGpK9XOOZII+bFsvhD6Uo/7ueOgI
z3fX1LUmSFXWu1XHRywc/3y4FfN5iYQ4lpRMy7EMdywyjqaeekWV/Hcs6ZLxzbQt
0uWOVvyVikLuHl5XPeyfuCiG4/QvaZgBmVJwy4Em7ZNOjQixOoM1nuEozE0JLFQ3
53R3YfOTHO/K5NL5AyxYRW6jW5oLdwqJr7c8AbCRZGBGz3QydorpuNTAHtjZX1l6
zVnvwq9TCG0M5hio3PnMpGDy4TnGmN6p9idCffOtdf2ATJyOIcxSYkMGEm6l6Qvu
+91RKMEGnXg=
=Fibn
-----END PGP SIGNATURE-----

--4IFtMBbmeqbTM/ox--
