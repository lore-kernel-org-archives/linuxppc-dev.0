Date: Sat, 27 May 2000 19:15:58 -0800
From: Ethan Benson <erbenson@alaska.net>
To: "Michael A. Peters" <mpeters@mac.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ybin and kernel level
Message-ID: <20000527191558.C29071@plato.local.lan>
References: <392C4F17.61D04687@mac.com> <20000524225002.O383@plato.local.lan> <v04220804b555aff9390d@[192.168.0.2]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uBaQ+BsiqpBBIRFI"
In-Reply-To: <v04220804b555aff9390d@[192.168.0.2]>; from mpeters@mac.com on Sat, May 27, 2000 at 10:33:04AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--uBaQ+BsiqpBBIRFI
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2000 at 10:33:04AM -0700, Michael A. Peters wrote:
> I saw it noted in the preliminary yBin/yaBoot documentation that a=20
> newer kernel was recommended, suggesting a 2.2.15pre3 or later.
>=20
> Is there anything specific about the 2.2.14 that won't allow it to work?

well it will work if you apply patches by BenH, there are changed to
prom.c and such to make it compatible with yaboot. =20

> I'm using a 2.2.14 kernel built from standard source (ftp.kernel.org)=20
> with the 2.3.50 usb backport.

you would need BenH patches (no longer avaiable AFAIK)

> I tried that backport with a 2.2.15 kernel, and it boots (BootX), but=20
> when booting the typical USB info doesn't scroll by the screen and no=20
> usb devices are available (for example, upon starting X, error 19,=20
> can't open usb mouse device)

2.2.15 Linus is pretty close, but there is still alot of PPC stuff
that needs patching, i still reccommend the Paul tree for newworlds.
i have a final (no pre) 2.2.15 with paul's patches, in case he has
already thrown away 2.2.15 in favor of unstable 2.2.16pres, if that
happens (like it has for the last 4 kernels i have kept track of) i
will make a unified diff to the linus tree avialable.

> Part of me thinks that may be BootX related, I had to upgrade BootX=20
> when switching to my current kernel due to usb weirdness, but I don't=20
> know for sure.

Bootx does all kinds of strange things on newworlds anymore.
especially on OS9. (it gets worse the newwer the hardware it would
appear)=20

> I know the FAQ is up, but its not quite finished yet- (but what is=20
> done is very good so far)

compliments to Eric for the great work on the FAQ.  i think he is
working on partitioning help now. =20

> The way I made a boostrap partition was to first create apple hfs=20
> partition. I then wrote down the start block and length in blocks,=20
> and (using pdisk) deleted the partition, using a C {create by=20
> specified type), entering Apple_Bootstrap when it asked for file=20
> system type.
>=20
> Is that correct?

yup that should work fine, i typically just create a single HFS
partition that spans all the space i will need for all the linux
partitions and delete it in pdisk/mac-fdisk creating all the linux
partitions i need.  the main problem i see with using apples fdisk for
only the bootstrap partition is i don't think it lets your create it
800K, anything larger then that is just a huge waste of space (even
with 800K partition 740 of it is wasted)

> ***
>=20
> The drive my bootstrap partition will be located on is internal scsi,=20
> attached to an adaptec 2930u controller.

do you have macos on an internal IDE? or is there even an internal IDE
at all?  if not default OF settings will probably work but it might
be slow.  if that is the case you will have to set the boot-device
yourself unfortunatly.  (is anyone still working on reenabling
/dev/nvram on newworld?)

> I'm fairly sure I can find the full path to the device in the open=20
> firmware, but interestingly enough- Apple System Profiler does NOT=20
> see the scsi card or give any info on it.

interesting, yes you can find it in OF, just do:

dev / ls
and walk the tree like so:

dev /pci@XXXXXXXX ls

until you find it, it sucks but thats the price you pay for scsi i
suppose (after the dent in the wallet scsi makes ;-))

> It does not appear in the pci devices, although volumes attached to=20
> the card ARE seen by System Profiler, and seen on bus 1 (opposed to=20
> the built in bus 0)

are you sure it has an OF ROM?  for it to be bootable it must have an
OF bootrom on the card, otherwise it probably just uses a MacOS
extension to make it visable to macos.  linux could do the same but it
would be impossible to boot from it.  (from either OS since OF must be
able to read it)

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--uBaQ+BsiqpBBIRFI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkwj24ACgkQJKx7GixEevz6CwCdFzDvsPztcBA8XEDXwNOdgLdI
haYAn0+p0pkSEnHOat8yJsi8y3psCb1t
=xz5+
-----END PGP SIGNATURE-----

--uBaQ+BsiqpBBIRFI--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
