Return-Path: <michael@ellerman.id.au>
Subject: Re: Kernel Panic booting cdrom
From: Michael Ellerman <michael@ellerman.id.au>
To: David Huffman <dhuffman@storix.com>
In-Reply-To: <46292B07.3030907@storix.com>
References: <46202254.1090606@storix.com>
	<20070414044529.GE6062@localdomain> <4623F574.1030804@storix.com>
	<20070417054537.GF6062@localdomain>  <46292B07.3030907@storix.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-i0uLWTZ4rvsTLc+Bt9Hf"
Date: Mon, 23 Apr 2007 12:10:22 +1000
Message-Id: <1177294222.3889.9.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-i0uLWTZ4rvsTLc+Bt9Hf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-20 at 14:05 -0700, David Huffman wrote:
> Nathan,
>=20
> I think I determined why I received a kernel panic and the numa=3Doff=20
> argument fixed the problem. When we boot from cdrom we specify maxcpus=3D=
1=20
> as a kernel argument. A system with numa enabled fails.  I plan on=20
> adding numa=3Doff whenever I use maxcpus=3D1, but I wonder if you could=20
> answer a question for me.
>=20
> I originally was told that in the case where I am booting a basic system=20
> into an initrd instead of in normal mode, I should use maxcpus=3D1 becaus=
e=20
> there may be power and cooling daemons that are not running and try to=20
> limit the system resources by limiting the number of cpus. Does this=20
> sound right? I can successfully boot a cdrom without the maxcpus flag on=20
> an SMP system but maybe it is typically not a good idea?
>=20
> I can prevent the kernel panics by removing maxcpus=3D1 and not adding=20
> numa=3Doff. I am a little more informed about numa (now), but I am fuzzy=20
> as to all the implications with allowing more cpus for cdrom install=20
> media. The maxcpus=3D1 argument was something we added to our install boo=
t=20
> media years ago and few here remember why it was such a great idea. The=20
> power/resource management was the only thing we could come up with.

maxcpus=3Dx is poorly tested, I would definitely NOT recommend it.

I don't think there's any issue with power etc. With maxcpus=3D1 all the
other CPUs are still running, they're just not used by the kernel - in
fact a cursory glance suggests they will do less power saving in that
situation than when they're in use but idle.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-i0uLWTZ4rvsTLc+Bt9Hf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGLBWOdSjSd0sB4dIRAirSAJ48cgjD8PFGognQg4qf6c1BC7a2VQCeN6jg
kZfLY28R5ZbcW0ebYQXYqww=
=kJL5
-----END PGP SIGNATURE-----

--=-i0uLWTZ4rvsTLc+Bt9Hf--
