Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thtrC1rmVzDwM6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:10:03 +1100 (AEDT)
Date: Mon, 19 Dec 2016 17:36:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Cc: paulus@samba.org, michael@ellerman.id.au, benh@kernel.crashing.org,
 sjitindarsingh@gmail.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 01/11] powerpc/kvm: Reserve capabilities and ioctls for
 HPT resizing
Message-ID: <20161219063614.GA23176@umbus.fritz.box>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-2-david@gibson.dropbear.id.au>
 <25bcced1-4903-2cf7-6a56-14c3ced5cd28@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <25bcced1-4903-2cf7-6a56-14c3ced5cd28@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2016 at 10:25:55AM +0100, Thomas Huth wrote:
> On 15.12.2016 06:53, David Gibson wrote:
> > This adds a new powerpc-specific KVM_CAP_SPAPR_RESIZE_HPT capability to
> > advertise whether KVM is capable of handling the PAPR extensions for
> > resizing the hashed page table during guest runtime.
> >=20
> > At present, HPT resizing is possible with KVM PR without kernel
> > modification, since the HPT is managed within qemu.  It's not possible =
yet
> > with KVM HV, because the HPT is managed by KVM.  At present, qemu has to
> > use other capabilities which (by accident) reveal whether PR or HV is in
> > use to know if it can advertise HPT resizing capability to the guest.
> >=20
> > To avoid ambiguity with existing kernels, the encoding is a bit odd.
> >     0 means "unknown" since that's what previous kernels will return
> >     1 means "HPT resize possible if available if and only if the HPT is=
 allocated in
> >       userspace, rather than in the kernel".  Userspace can check
> >       KVM_CAP_PPC_ALLOC_HTAB to determine if that's the case.  In pract=
ice
> >       this will give the same results as userspace's fallback check.
> >     2 will mean "HPT resize available and implemented via ioctl()s
> >       KVM_PPC_RESIZE_HPT_PREPARE and KVM_PPC_RESIZE_HPT_COMMIT"
>=20
> This encoding IMHO clearly needs some proper documentation in
> Documentation/virtual/kvm/api.txt ... and maybe also some dedicated
> #defines in an uapi header file.

Ah, yeah.  Actually I'm talking to paulus again to see if we can come
up with a way to encode the necessary facts without something as weird
as this one.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYV3/cAAoJEGw4ysog2bOSKMoQAIDPdMvxya660/rLCTjLfbBB
qsCeiRngpkhVfBIN8Klr05ofOLqwe/G5qIN+3r9aDziHFuAknZpjRr5k9rkFCK/z
LGJyKj3EP8Rb6rwq2Bhe+kEIAuaEaXdbDoqXCAm7R3sf2GUY2o7mHhru0DaiEHLG
fTqC21/oTCXiHzpzQIdtzEVxqA7rBbiaTeIOdaSL9JfOIcqf3H51s2dVCCMxi3hN
A2y5fcSlEjPqsW0gWd1QBlxgytOjipie8HxESYxc26ZI3k5EOJ0XbOCaCMRtjDU6
VCXHJfi6vuMvQTETyj3nXajeis3k+BZf8hH2E9LAhpQ4ddNM41/q0MtdgLTuKQgE
UdqznBCuHxWgKcKgGAc0fcjMk3+op6cunhL5jwZRUljwoMLs+ktfAwsB5x9vUEqh
O2a2SfiHjiMqPFlFsm4sa6mjFRNVyDrIwpMrEPuSbUlmLnNN1gE4ga6DP+2NQtoP
srIp5ZMXVktJ3maz7SJklpVwFs0smPCZ2hjrFqFAwSnt0oP1HaIPyZ6NU4xtI5PE
9BtxF5Lx91vbakOhZx4BLrxCPEdxALbUx+S/7dKnZUEj2Su+BNKzJaIj4C28tsfv
O8Lo5q3BWP6ooSHiLrxH2SH10aHPNfNIHhvv8aU+FWjRe5Wp+V4vK8S34pzCIzQ+
TtaK3co+XK6RVYXXYrgN
=+g1N
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
