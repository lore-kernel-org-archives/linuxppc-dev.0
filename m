From: "Henry A. Worth" <haworth@ncal.verio.com>
Date: Wed, 29 Mar 2000 11:20:17 -0800 (PST)
Message-Id: <200003291920.LAA08359@ shell1.ncal.verio.com>
To: erbenson@alaska.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Pismo Powerbook
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> From: Ethan Benson <erbenson@alaska.net>


> --opJtzjQTFsWo+cga
> Content-Type: text/plain; charset=us-ascii
> Content-Transfer-Encoding: quoted-printable

> On Tue, Mar 28, 2000 at 11:03:29PM -0800, Henry Worth wrote:

> > > * STEPS :
> > > 1.  partitioned the HD into three partititions: MacOS, Linux, Swap
> >=20
> > I'd strongly recommend a small HFS boot partition (~32MB).

> 32MB??  lord no, 800K is more then enough for yaboot.

I filled 32MB up quite easily with test kernels. Of course
normal users won't have that problem.  You should
leave enough room for several kernels so you can have a
basic rescue kernel and ramdisk, a good stable kernel, and
that spiffy new kernel that's going to mess everything up
and require you to use that rescue kernel. Also if you start
experimenting with the system folder approach you'll be dupping
yaboot and conf into the system folder.


> this partition should also be given a partition type of
> Apple_Bootstrap to prevent Macos from mounting, and subsquently
> screwing it up.  (it removes the `blessing' from anything that might
> not be a valid macos system folder)

Hm, didn't have that problem when I was using that.

> > 2) Set up a "blessed" system folder in the HFS boot partition
> >    containing yaboot and yaboot.conf. There is a link to tool
> >    on Ben's website to help with that (or copy the system folder
> >    from the LinuxPPC 2000 CD). You can then:

> the tool i think you are refering to is ybin, which i wrote to format
> bootstrap partitions in such a way that OpenFirmware will boot from
> them with its default settings.

> the following is required for this to work:

> * bootstrap partition must be placed BEFORE the macos partition.

> * bootstrap partition must NOT be mountable by macos, otherwise it
> will undo my changes.  so you MUST use the Apple_Bootstrap partition
> type.

> once you have this, you can run the following command with ybin 0.11
> (0.12 will be a bit better)

> mkofboot --boot /dev/hda5 --magicboot /boot/ofboot.b=20

> you must have yaboot installed at /boot/yaboot and the yaboot.conf at
> /etc/yaboot.conf, if not specify the paths with -i /path/to/yaboot and
> -c /path/to/yaboot.conf=20

> ofboot.b is a small openfirmware script, i include 2, one is intendted
> for linux only systems, the other has a mini boot menu, you need to
> edit them to correct the OF partitions for macos and the bootstrap
> partition. =20

> now what mkofboot does for you is create the HFS filesystem on the
> bootstrap partition (example above is /dev/hda5, adjust for your
> system) and copy yaboot, yaboot.conf, and the ofboot.b OF script to
> the boot partition.  it then sets the filetype on the ofboot.b script
> to `tbxi' and blesses the root directory.  this way when you reboot
> you can hold down:

> command option o f=20

> while your system boots to reset OF to default values, and up comes
> the multiboot menu. neat eh? no need to enter OF at all under most
> circumstances.=20

> >    a> Set that partition as the default boot partition from
> >       the MacOS partition.

> no need. and you can't, if macos is allowed to mount the bootstrap
> partition it will remove the blessing and OF will reject the partition
> as bootable.

Didn't have that problem with OS/9, and it is a widely suggested
method. Still it's not the nice solution.

> =09
> >=20
> >    c> The OF boot-device and boot-file variables can be set to change
> >       the default boot partition and file. With this approach you
> >       don't need the system folder, see the maillist archives.

> if you must set the boot-device (i have not had to on my blue g3, you
> might for a scsi system) set it to:

> hd:<#>,\\:tbxi

> where <#> is the partition number of the bootstrap partition.

You shouldn't need the system folder nonsense if you also set boot-file.
Which is one of the nice things about this approach if a Linux-only
system.

> >=20
> > 3) There are examples of some slick dual-boot OF scripts in the
> >    recent mail archives. I need to find them again myself (there was
> >    a thread with a good writeup), and set my system up that way, it's

> there is a simple one with ybin, fancier ones may be found elsewhere,
> just drop whichever one you prefer in /boot/ofboot.b and ybin will use
> it.

> ybin is available at my web page (.sig) or at
> http://www.linuxppc.org/ybin/


The problem I had with ybin (of course my perpective is someone
trying to debug support for a machine that will not boot and
install Linux yet), is that this has to be done from Linux.
It would be a lot more usefull if it was a MacOS tool
or you at least had seperate docs, after downloading it I couldn't
unpackage it in MacOS and with no docs decided it wasn't worth
the trouble to transfer to my x86 system to see what it consisted
of. Until someone produces some definitative consolidated
documentation for yaBoot and these other tools, so users can plan
ahead, they are already going to have their system repartioned and
have reinstalled MacOS and install Linux to find out they are going
to have to do it all over again, yeh...right.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
