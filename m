Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C342EB7B86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 15:04:56 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B46FBDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 15:04:56 +1000 (EST)
Subject: Re: Extending virtio_console to support multiple ports
From: Michael Ellerman <michael@ellerman.id.au>
To: Amit Shah <amit.shah@redhat.com>
In-Reply-To: <20090826154552.GA31910@amit-x200.redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-zDgknRdlrvhso4zVsYgt"
Date: Thu, 27 Aug 2009 15:04:45 +1000
Message-Id: <1251349485.6267.6.camel@concordia>
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
	brueckner@linux.vnet.ibm.com,
	virtualization@lists.linux-foundation.org, alan@linux.intel.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-zDgknRdlrvhso4zVsYgt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-08-26 at 21:15 +0530, Amit Shah wrote:
> [cc'ing some people who have made some commits in hvc_console.c]
>=20
> On (Wed) Aug 26 2009 [16:57:18], Amit Shah wrote:
> > On (Tue) Aug 25 2009 [11:47:20], Amit Shah wrote:
> > >=20
> > > Hello all,
> > >=20
> > > Here is a new iteration of the patch series that implements a
> > > transport for guest and host communications.
> > >=20
> > > The code has been updated to reuse the virtio-console device instead
> > > of creating a new virtio-serial device.
> >=20
> > And the problem now is that hvc calls the put_chars function with
> > spinlocks held and we now allocate pages in send_buf(), called from
> > put_chars.
> >=20
> > A few solutions:
>=20
> [snip]
>=20
> > - Convert hvc's usage of spinlocks to mutexes. I've no idea how this
> >   will play out; I'm no expert here. But I did try doing this and so fa=
r
> >   it all looks OK. No lockups, lockdep warnings, nothing. I have full
> >   debugging enabled. But this doesn't mean it's right.
>=20
> So just to test this further I added the capability to have more than
> one hvc console spawn from virtio_console, created two consoles and did
> a 'cat' of a file in each of the virtio-consoles. It's been running for
> half an hour now without any badness. No spew in debug logs too.
>=20
> I also checked the code in hvc_console.c that takes the spin_locks.
> Nothing there that runs from (or needs to run from) interrupt context.
> So the change to mutexes does seem reasonable. Also, the spinlock code
> was added really long back -- git blame shows Linus' first git commit
> introduced them in the git history, so it's pure legacy baggage.

I won't tell Ryan you called his code "pure legacy baggage" if you
don't ;)

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/old-2.6-bkcvs.git;a=3D=
commitdiff;h=3Dd450b4ae023fb4be175389c18f4f87677da03020


cheers

--=-zDgknRdlrvhso4zVsYgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqWE+oACgkQdSjSd0sB4dJ77QCglGJ1hqEa1QKiDnJYj5Wd7qZ3
BZgAoIKPSyPRRk69t+vlctG7SDLv/SSX
=lH9C
-----END PGP SIGNATURE-----

--=-zDgknRdlrvhso4zVsYgt--
