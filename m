Date: Sun, 23 Sep 2001 19:17:13 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
Message-ID: <20010923191713.E14835@plato.local.lan>
References: <20010923154607.A14835@plato.local.lan> <Pine.LNX.4.21.0109232307500.13300-100000@cr242184-a.etob1.on.wave.home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DOr+hlVy7JMLa9bO"
In-Reply-To: <Pine.LNX.4.21.0109232307500.13300-100000@cr242184-a.etob1.on.wave.home.com>; from tendim@tendim.cjb.net on Sun, Sep 23, 2001 at 11:09:24PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--DOr+hlVy7JMLa9bO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2001 at 11:09:24PM -0400, patrick wrote:
> On Sun, 23 Sep 2001, Ethan Benson wrote:
>=20
> > is it possible you have an x86 BIOS partition table on that disk as
> > well?  if mac-fdisk -l doesn't work then your mac partition table is
> > corrupt.  but if that does work but the kernel is getting other ideas
> > about your partitions you probably have both an x86 and mac partition
> > table (its actually possible for them to coexist, but its a gross and
> > uneeded hack).  what does /proc/partitions say?
>=20
> But if the Mac partition table were corrupt, wouldn't it also be
> skewed under my 2.2.18 Kernel as well? =20

yes most likely.

>    8    16    4194157 sdb
>    8    17         31 sdb1
>    8    18         64 sdb2
>    8    19    2000000 sdb3
>    8    20    2194040 sdb4
>    8    21         21 sdb5

the kernel is detecting your partition table just fine it seems.  the
8 is the major number of the device, 16, 17... are the minor numbers,
they correlate with the major/minors of the /dev/ nodes.  the third is
the number of 1k blocks that device has, sdb1 is clearly the mac
partition table as they are almost always 31.5k

the dd trick shows you can read the device without problems, are you
sure the filesystem is not corrupt? or that the disk is not failing?

try:

badblocks -sv /dev/sdb=20

and see what happens.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--DOr+hlVy7JMLa9bO
Content-Type: application/pgp-signature
Content-Disposition: inline


--DOr+hlVy7JMLa9bO--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
