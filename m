Date: Tue, 23 May 2000 23:01:28 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Eric Peden <ericpeden@homemail.com>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: partition size funkiness
Message-ID: <20000523230128.F7243@plato.local.lan>
References: <B550A5BA.464A%ericpeden@homemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K5rlT6r/WqkiQKGB"
In-Reply-To: <B550A5BA.464A%ericpeden@homemail.com>; from ericpeden@homemail.com on Tue, May 23, 2000 at 09:16:42PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--K5rlT6r/WqkiQKGB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2000 at 09:16:42PM -0500, Eric Peden wrote:

[deletia]
>=20
> I've begun to suspect that my problems are due to the method I used to
> "re-partition" the drive; I simply used pdisk to re-arrange the partition
> map, thus doing a non-destructive repartitioning. I've only managed to fi=
nd
> one mention of a problem similar to mine at:

how exactly did you backup/restore the data?  you cannot just change
the partition tables without doing something to the filesystems too,
you can use ext2resize, or tar up the data and mke2fs the partition,
and untar everything back.  but if you just changed the partition
table and did nothing to the filesystems you are looking at filesystem
corruption and massive data loss to occur very soon.  this is because
the filesystem has its own idea about the size of the partition. =20

> http://slashdot.org/askslashdot/99/08/09/0315246.shtml
>=20
> The cause is different, and of course no solution is offered, but the
> symptoms are the same. Is partition information stored somewhere other th=
an
> the partition map? Is df just reading this information incorrectly, or is
> the extra space on /dev/sda7 truly unusable? Is there some low-level
> information I could modify to properly reflect the size of root?

partition sizes just define to the kernel how much space it should
allocate to a given device node eg /dev/hda2.  the filesystem when
mounted has its own definition of its size, and this has nothing to do
with the partition size.  if they do not match though you can end up
in trouble, either the partition is larger then the filesystem and you
have hidden wasted space or you have the filesystem too large and you
end up writing data off the end of the device (which the kernel won't
permit i don't think) either way its a bad thing. =20

this is why i am not a big fan of screwing with partitions in
non-destructive ways, it just is more trouble then it is worth and
usually does not work that well.

> Again, help is appreciated...

wipe your partition table entirely, partition everything properly and
install debian while your at it ;-)

i know its harsh advice but really i think your just going to waste
alot of time and trouble messing around trying to get this fixed with
a high liklyhood of destroying the filesystems anyway, why bother with
the headache you will be happier in the long run with a properly
partitioned, cleaned up system.=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--K5rlT6r/WqkiQKGB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkrfkgACgkQJKx7GixEevyy9QCcC4Wy3+Rn6U8R7J6PNJ/EQlcU
eRoAn2gNy726vmRw5kMSgNZdK+E1SM5D
=RTZz
-----END PGP SIGNATURE-----

--K5rlT6r/WqkiQKGB--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
