Date: Fri, 10 Nov 2000 18:09:24 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Steven Hanley <sjh@wibble.net>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: booting with quik off hard disk on 7220
Message-ID: <20001110180924.Q4577@plato.local.lan>
References: <20001111134337.A4931@wibble.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LkYZvX65tyO4RZtj"
In-Reply-To: <20001111134337.A4931@wibble.net>; from sjh@svana.org on Sat, Nov 11, 2000 at 01:43:38PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--LkYZvX65tyO4RZtj
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2000 at 01:43:38PM +1100, Steven Hanley wrote:
>=20
> I have the quik.conf
> partition=3D6
> root=3D/dev/hda6
> timeout=3D1
> image=3D/boot/vmlinux-2.2.17
> label=3Dlinux
> read-only
> append=3D"video=3Datyfb:vmode:6"

looks ok, though i think it would be easier to read if you format it
with the indented image section:

partition=3D6
root=3D/dev/hda6
timeout=3D10

image=3D/boot/vmlinux-2.2.17
	label=3Dlinux
	read-only
	append=3D"video=3Datyfb:vmode:6"

but then im just a nitpicker ;-)

btw i think you want timeout=3D10 not 1, that is in tenths of seconds.=20

> So I have a file I run when i boot off floppy that does some nvsetenv stu=
ff
> this is
> nvsetenv boot-device ata/ata-disk@0:0

should be close..

> nvsetenv input-device kbd
> nvsetenv output-device screen

this may or may not do you any good if your machine lacks a OF video
driver.=20

> nvsetenv boot-file ' /boot/vmlinux-2.2.17 root=3D/dev/hda6'

this is redunant, when you have a proper quik.conf you don't need the
boot-file variable, in fact it seems to bork things up in my
experience helping someone with a 7200.  i would null out the
boot-file variable.

> quik
>=20
> the boot device seems to be correct, although that ofpath script when I r=
un
> ./ofpath /dev/hda reports "This machine is not suhpported: AAPL,e826"
> I looked through /proc/device-tree myself and the ata and ata-disk things
> are there where it seems they should be.

yeah that is basically what ofpath does, would it be possible for you
to give me temporary shell access so i could add support to ofpath for
it?  if not i can ask you some questions and figure it out. more then
likely its exactly the same as a 7200 or a 7300 but has a different
compatible entry. =20

> I dont get output from OF on this machine when I enter OF at bootup (7200
> dont get OF display or something) but if I dont set the input and output
> device I dont see anything from quik, when they are set I see the grey
> screen for the quik second stage loader.

hmm im not sure i understand this... =20

> If I dont have the boot-file set quik asks me every time to enter the
> boot-file argument. I have the space infront of /boot as I read in some p=
ost
> to debian-powerpc that the 7200 series needed the space there.

really?  i have a friend booting a 7200 with no boot-file variable set
and it boots just fine.  boot-file overrides /etc/quik.conf iirc. =20

> the partition map for the machine has hda[1234] as the apple partitions f=
or
> drivers and such. Then it has Swap on hda5

just a note you don't need all that driver crap with quik booting.

> /dev/hda5 Apple_UNIX_SVR2 Swap 262144 @ 704 (128.0M) Linux Swap
> and / on hda6
> /dev/hda6 Apple_UNIX_SVR2 Linux_Root 2097152 @ 262848 ( 1.0G) Linux Native

its better to name these `swap' and `root' respectivly as that is what
the kernel actually looks for, but if you specify root=3D in quik.conf
it doesn't really matter.

> and then some free space after that.
>=20
> Now when I boot up I get the quik second stage loader and it has a spinni=
ng
> | / - \ thing briefly and then the screen goes entirely blank wnad there =
is
> no hard disk activity or anything.

ah it sounds like its loading the kernel but the kernel is hanging.
that is how my friends 7200 always failed with 2.2.15/16 kernels. =20

> I am wondering how to get the machine to boot.
>=20
> I have seen in many places mentions of the 7200 with scsi not spinning the
> disks up fast enough for booting and the quik boot fails, so there are sm=
all
> scripts to make it wait around on maling lists, however I have seen menti=
on
> of the fact this only affects scsi and that ide doesnt have the slow spin=
 up
> problem. So for now I have discounted that as being the cause.

yeah the spinup problem usually results in quik barfing with DEFAULT
CACHE type errors.

> I am guessing I may need to get a serial cable link up to have a look and
> play around in OF to get this running. (unless someone can tell me how to
> get it running with out this) Though it would be good to be able to see O=
F I
> suppose and thus I am wondering what cables I need to hook up the little
> round modem or printer port on the back of the machine to an x86 box, I h=
ave
> a null modem cable and all, but not something that will speak to the litt=
le
> modem or printer ports on the mac. I saw the details in some list post
> yesterday arvo but didnt make a note of it and now cant find that post ag=
ain
> searching for likely keywords on google.

i think you just need an ordinary mac serial cable, like you use for
printers and such, then use a comm program like minicom or Zterm if
your stuck with MacOS on the other box. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--LkYZvX65tyO4RZtj
Content-Type: application/pgp-signature


--LkYZvX65tyO4RZtj--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
