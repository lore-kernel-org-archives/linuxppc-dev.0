Date: Thu, 11 Jan 2001 17:28:20 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: pdisk weirdness
Message-ID: <20010111172820.T29805@plato.local.lan>
References: <3A5E21E6.DE26A121@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ESALR2nqcUcb10U9"
In-Reply-To: <3A5E21E6.DE26A121@wanadoo.fr>; from costabel@wanadoo.fr on Thu, Jan 11, 2001 at 10:13:10PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--ESALR2nqcUcb10U9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2001 at 10:13:10PM +0100, Martin Costabel wrote:
>=20
> Having observed for a while that pdisk (linux) doesn't work on my iBook,
> I tried to understand what is going on. It's weird.

pdisk sucks, deal with it. =20

> Doesn't work means that 'pdisk /dev/hda' (or 'pdisk -l' likewise) gives
> me the output:
>=20
> pdisk: Can't read block 0 from '/dev/hda'
> Edit /dev/hda -
> Command (? for help): p
> No partition map exists
> Command (? for help): q
> Segmentation fault

see above.  you can probably create a new partition table with the `i'
command, though i have seen this has a tendency to create wildly bogus
partition tables (tables wtih the size of the disk being 500GB or some
such bollocks)

> This is pdisk version 0.8a2 (16 May 2000) from the pdisk-0.8-1.ppc.rpm
> as it is contained in LinuxPPC 2000 and LinuxPPC 2000 Q4 aka Halloween.
> When I downgrade to the pdisk-0.7-2 RPM from LinuxPPC 1999, it works as
> it is supposed to. Also I think I remember that the new pdisk works when
> run with a 2.2 kernel. Only the combination of new pdisk and 2.4 kernel
> doesn't work.

i have been told that some versions of pdisk do not use the ioctl to
the kernel correctly, perhaps thats why. =20

> What is weirder is that there is (almost) no source to be found for this
> pdisk-0.8-1! On the LPPC 2000 source CD, there is no pdisk at all, and
> in the LPPC 2000 Q4 source directory, there is the SRPM for the old
> pdisk-0.7-2. I finally found the sources at the defunct dev-rel CVS
> repository at gate.crashing.org.

i don't know.

> There is a llseek-patch (by Tom Rini, IIUC) which seems to be the origin
> of the problem. If I back it out, pdisk works again.
>=20
> Is anyone successfully running pdisk-0.8-1 with kernel 2.4?

why use pdisk when you can use GNU parted?  here is the correct
solution to pdisk:

rm -rf pdisk=20
get ftp://ftp.gnu.org/gnu/parted/parted-1.4.5.tar.gz
tar -zxvf parted-1.4.5.tar.gz
cd parted-1.4.5
=2E/configure && make && make install

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--ESALR2nqcUcb10U9
Content-Type: application/pgp-signature
Content-Disposition: inline


--ESALR2nqcUcb10U9--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
