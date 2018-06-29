Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H3Fh3jkzzF1RL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 14:14:48 +1000 (AEST)
Date: Fri, 29 Jun 2018 14:14:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH kernel v2 0/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180629041438.GD3422@umbus.fritz.box>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <877emiwe3n.fsf@concordia.ellerman.id.au>
 <20180629130007.1b78e168@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
In-Reply-To: <20180629130007.1b78e168@aik.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 01:00:07PM +1000, Alexey Kardashevskiy wrote:
> On Fri, 29 Jun 2018 11:55:40 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>=20
> > Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> >=20
> > > This is to improve page boundaries checking and should probably
> > > be cc:stable. I came accross this while debugging nvlink2 passthrough
> > > but the lack of checking might be exploited by the existing userspace=
=2E =20
> >=20
> > Do you really mean "exploited" ? As in there's a security issue?
> >=20
> > Your change log for patch 2 sort of suggests that but then says that
> > without the fix you just hit an error in vfio code.
>=20
>=20
> The bug is that I can easily make unmodified guest use 16MB IOMMU pages
> while guest RAM is backed with system 64K pages so unless the guest RAM
> is allocated contigously (which is unlikely), a 16MB TCE will provide
> the hardware access to the host physical memory it is not supposed to
> have access to, which is 16MB minus first 64K.
>=20
> There is a fast path for H_PUT_TCE - via KVM - there is no contained
> test.
>=20
> There is a slow path for H_PUT_TCE - via VFIO ioctl() - there is a
> contained test.
>=20
> Because of a different feature of VFIO on sPAPR (it stores an array of
> userspace addresses which we received from QEMU and translated to host
> physical addresses and programmed those to the TCE table) we do not take
> the fast path on the very first H_PUT_TCE (because I allocate the
> array when the slow path is taken the very first time), fail there,
> pass the failure to the guest the guest decides that is over.
>=20
> But a modified guest could ignore that initial H_PUT_TCE failure and
> simply repeat H_PUT_TCE again - this time it will take the fast path
> and allow the bad mapping.

In short, yes, it's an exploitable security hole in the host.  An
unmodified Linux guest kernel just doesn't happen to exploit it, even
if the guest userspace tries to get it to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1si4ACgkQbDjKyiDZ
s5IYLw/7Bz2PH9lR1Ge2RjN55xehA0nikTHvWjE23LUtouUApyoSe8PmT2uAgq3O
7nEpoGrhaGb0+8t9pTWnaxoMRQJmQz0bgxbeeM7EJ/FXL1xgypDEmEmTsRw/Jq8B
zLtM7CBGAL230RB6N+uPOK91FuORsP3P1QgjnvkFX9P1JT37xhK4rB4cvjLE6t2E
qR4mLgJcXuYw3HTmGVYgy+OpJ+H2UDBb77udQL/bzPRLUqNkhE237WBA0uNSVlzn
xw8EalfYWZj9OTCoLd7RWZf7aSy0vE8VT4bh/f84go9AcQ+4mbI+C5adybPa6igM
IToCKmwuzEltMOnLZ/uKb1GKwilip4tJPGQHHspvk5ZEowqfTRw3owbNuKzrX7Wd
79TDbymH/y83LJ13+kL1e02HfT2AHQ04Ha9SqeuXrejXL1MUkWcO86ceGoHrxa5E
UN2tuV64fmhwtgHd3qVp/7Gnhv9ksPbFK8u5xI404SPbZcO1rHXskkYixQR+Vo3Q
qejI2gcIuRMA1KokxXGFhI/UHRBMiltabYXC6ZdpCqbDPsV8VQ4cvXrIr4yDaskR
OafHrf+6+V7kvwaucQiaaHehYWg8vbwwmIL0dxF/COU+501RVjEqzreZjNbyttzr
KtXzqIs9OdzZD5Yoec/Pu6o+hbarXTWQGNv9YtK8AT1nrqrMjgU=
=lbnw
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
