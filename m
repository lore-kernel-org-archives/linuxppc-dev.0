Return-Path: <dgibson@ozlabs.org>
Date: Sun, 7 Apr 2013 15:58:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Chris Friesen <chris.friesen@genband.com>
Subject: Re: powerpc userspace address space layout information
Message-ID: <20130407055844.GB17787@truffula.fritz.box>
References: <515E58E6.9030802@genband.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
In-Reply-To: <515E58E6.9030802@genband.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2013 at 10:53:58PM -0600, Chris Friesen wrote:
>=20
> Hi,
>=20
> I'm running with glibc 2.11 on a 2.6.34 kernel.  32-bit userspace on 64-b=
it kernel.
>=20
> On a complicated process the memory map looks something like this:
>=20
> <vdso, executable, heap, etc.>
> 5b2c000-f5b38000 r-xp 00000000 00:0f 3636                               /=
lib/libnss_files-2.11.1.so
> <lots of libraries snipped>
> f6026000-f6035000 ---p 00096000 00:0f 3628                               =
/lib/libkrb5.so.3.3
> <lots of libraries snipped>
> f7902000-f7905000 r-xp 00000000 00:0f 3607                               =
/lib/libdl-2.11.1.so
> f7905000-f7914000 ---p 00003000 00:0f 3607                               =
/lib/libdl-2.11.1.so
> f7914000-f7915000 r--p 00002000 00:0f 3607                               =
/lib/libdl-2.11.1.so
> f7915000-f7916000 rw-p 00003000 00:0f 3607                               =
/lib/libdl-2.11.1.so
> f7918000-f7919000 rw-p 00000000 00:00 0
> f7919000-f791a000 r--p 0001a000 00:0f 3646                               =
/lib/libpthread-2.11.1.so
> f791a000-f791b000 r--p 00001000 00:0f 2306001                            =
/path/to/binary
> f791b000-f791c000 r--p 00001000 00:0f 2306001                            =
/path/to/binary
> f791c000-f791d000 r--p 00001000 00:0f 2306001                            =
/path/to/binary
> f791d000-f7923000 rw-p 00000000 00:00 0
> f7923000-f7943000 r-xp 00000000 00:0f 13323                              =
/lib/ld-2.11.1.so
> f7943000-f7944000 r--p 00020000 00:0f 13323                              =
/lib/ld-2.11.1.so
> f7944000-f7945000 rw-p 00021000 00:0f 13323                              =
/lib/ld-2.11.1.so
> f9000000-fac01000 rw-p 00000000 00:00 0
> fac06000-fac07000 rw-s 00000000 00:04 327690                             =
/SYSV41050355 (deleted)
> fad00000-fae00000 rw-s 00000000 00:04 98307                              =
/SYSVee113d3f (deleted)
> fae00000-fb000000 rw-s 00000000 00:04 7503872                            =
/SYSVc5050355 (deleted)
> fb000000-fb200000 rw-s 00000000 00:04 7536641                            =
/SYSV5c050355 (deleted)
> fb200000-fb600000 rw-s 00000000 00:0d 30647                              =
/var/log/blah
> ffa8e000-ffab0000 rwxp 00000000 00:00 0                                  =
[stack]
>=20
>=20
> I have a few questions I'm hoping someone can help me with.
>=20
> First, what determines where /lib/ld-2.11.1.so gets mapped? It seems like
> it never goes above 0xf8000000 or so.

I think the mapping in of the ELF interpreter just calls the mmap()
code without hint address, so it goes where get_unmapped_area() puts
things by default, which can depend on a number of configuration settings.

> Second, what is the mapping at 0xf9000000-0xfac01000?  Is this just empty
> space or is it reserved for something in particular?

Looks like anonymous memory, which could have been mapped by your
program or any of the libraries.

> Third, what's the most reliable way to ensure a block of addresses around
> 0xf6000000 don't get used for shared libraries?  (We want to preserve
> those addresses for emulating hardware in a virtual machine.)  We have
> this working on an older system but after upgrading to new software the
> libraries now extend further down the address space.

The only reliable method I can think of would be to use a custom
linker script to give your binary an extra program header specifying
that virtual region to map.  In theory it can have zero size, and
whatever mem size you need to avoid adding any data to the binary
itself.  In practice you may need to set a (small) non-zero filesize,
since some kernel versions had bugs handling segments with zero
filesize.

That would bring your program up with anonymous memory mapped across
the "reserved" region.  You could then remap over it using MAP_FIXED
for the stuff you really want.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFhCxQACgkQaILKxv3ab8agDgCgiYD2FrtA1BaOYWKf0Iw/Z1Ac
lL8An25M7QH2BmA76UlHUsbWN15hwn72
=e3As
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
