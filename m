Date: Wed, 29 Mar 2000 04:33:55 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Henry Worth <haworth@ncal.verio.com>
Cc: "Min Shin (CS)" <shin@csee.usf.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Pismo Powerbook
Message-ID: <20000329043355.A27338@plato.localdomain.local>
References: <Pine.GSO.4.05.10003281041030.24048-100000@grad> <38E1AAC1.A8999A9B@ncal.verio.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <38E1AAC1.A8999A9B@ncal.verio.com>; from haworth@ncal.verio.com on Tue, Mar 28, 2000 at 11:03:29PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2000 at 11:03:29PM -0800, Henry Worth wrote:

> > * STEPS :
> > 1.  partitioned the HD into three partititions: MacOS, Linux, Swap
>=20
> I'd strongly recommend a small HFS boot partition (~32MB).

32MB??  lord no, 800K is more then enough for yaboot.

this partition should also be given a partition type of
Apple_Bootstrap to prevent Macos from mounting, and subsquently
screwing it up.  (it removes the `blessing' from anything that might
not be a valid macos system folder)

> 2) Set up a "blessed" system folder in the HFS boot partition
>    containing yaboot and yaboot.conf. There is a link to tool
>    on Ben's website to help with that (or copy the system folder
>    from the LinuxPPC 2000 CD). You can then:

the tool i think you are refering to is ybin, which i wrote to format
bootstrap partitions in such a way that OpenFirmware will boot from
them with its default settings.

the following is required for this to work:

* bootstrap partition must be placed BEFORE the macos partition.

* bootstrap partition must NOT be mountable by macos, otherwise it
will undo my changes.  so you MUST use the Apple_Bootstrap partition
type.

once you have this, you can run the following command with ybin 0.11
(0.12 will be a bit better)

mkofboot --boot /dev/hda5 --magicboot /boot/ofboot.b=20

you must have yaboot installed at /boot/yaboot and the yaboot.conf at
/etc/yaboot.conf, if not specify the paths with -i /path/to/yaboot and
-c /path/to/yaboot.conf=20

ofboot.b is a small openfirmware script, i include 2, one is intendted
for linux only systems, the other has a mini boot menu, you need to
edit them to correct the OF partitions for macos and the bootstrap
partition. =20

now what mkofboot does for you is create the HFS filesystem on the
bootstrap partition (example above is /dev/hda5, adjust for your
system) and copy yaboot, yaboot.conf, and the ofboot.b OF script to
the boot partition.  it then sets the filetype on the ofboot.b script
to `tbxi' and blesses the root directory.  this way when you reboot
you can hold down:

command option o f=20

while your system boots to reset OF to default values, and up comes
the multiboot menu. neat eh? no need to enter OF at all under most
circumstances.=20

>    a> Set that partition as the default boot partition from
>       the MacOS partition.

no need. and you can't, if macos is allowed to mount the bootstrap
partition it will remove the blessing and OF will reject the partition
as bootable.
=09
>=20
>    c> The OF boot-device and boot-file variables can be set to change
>       the default boot partition and file. With this approach you
>       don't need the system folder, see the maillist archives.

if you must set the boot-device (i have not had to on my blue g3, you
might for a scsi system) set it to:

hd:<#>,\\:tbxi

where <#> is the partition number of the bootstrap partition.

>=20
> 3) There are examples of some slick dual-boot OF scripts in the
>    recent mail archives. I need to find them again myself (there was
>    a thread with a good writeup), and set my system up that way, it's

there is a simple one with ybin, fancier ones may be found elsewhere,
just drop whichever one you prefer in /boot/ofboot.b and ybin will use
it.

ybin is available at my web page (.sig) or at
http://www.linuxppc.org/ybin/


--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjjiBkMACgkQJKx7GixEevzGtwCfWcRQxMy25W8wwhYvd1+36b52
L10AoI8h5cg6FeMsyztYRxLq9TinYINa
=9PHx
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
