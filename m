Date: Sun, 20 Aug 2000 10:01:20 -0700
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with linuxppc_2_2 on an MVME-2400
Message-ID: <20000820100120.A1191@drow.them.org>
References: <qpog2ory9h.fsf@erbium.epact.se> <20000820061553.V23680@cx258813-a.chnd1.az.home.com> <qpaee8rqjj.fsf@erbium.epact.se> <qp1yzjsyny.fsf@erbium.epact.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <qp1yzjsyny.fsf@erbium.epact.se>; from ml@epact.se on Sun, Aug 20, 2000 at 06:08:33PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 20, 2000 at 06:08:33PM +0200, Michael Lundkvist wrote:
> Michael Lundkvist <ml@epact.se> writes:
>
> >
> > I tried these two patches. Using the
> > kernel-patch-2.2.15-powerpc_20000422-2.2.16pre4-1.deb gives me the
> > same result as before. Panic with moderate disk activity.
> >
> > Using the kernel-patch-2.2.15-ide_20000405-1.deb I can't even boot.
> >
> > I tried applying them both to a 2.2.15 kernel but that gives me too
> > many conflicts that I'm not smart enough to resolve.
> >
> > /Micke
> >
>
> Now I've played around a bit more.
>
> Something is wierd here. I got the new precompiled Debian kernels from
> stable and tried booting both the file called 'bootfull.bin' and the
> one called 'linux'. I assume that the both are built from the same
> source.
>
> 'bootfull.bin' is stable but 'linux' is not.
>
> I would really like to see the config file used for bootfull.bin. Does
> anyone know where I can find it?

It's installed by the kernel image package: /boot/config-2.2.15
probably.

Did you try the 2.2.17 packaged kernels?

I'm wondering if there's a difference in config between the two you
tried... the installer does some skanky magic building them.  Here's
the difference between those two kernels:

# Fix .config for ramdisk rooting and kernel ip autoconfiguration.
# This image is >1440 KB and is suitable for CD/net booting.
sed 's:# CONFIG_CMDLINE_BOOL is not set:CONFIG_CMDLINE_BOOL=y \
CONFIG_CMDLINE="root=/dev/ram ip=off":' \
$builddir/usr/src/kernel-patches/powerpc/config.prep > .config.param

# Enable kernel ip autoconfiguration
sed 's:# CONFIG_IP_PNP is not set:CONFIG_IP_PNP=y \
CONFIG_IP_PNP_DHCP=y \
CONFIG_IP_PNP_BOOTP=y \
CONFIG_IP_PNP_RARP=y:' \
.config.param > .config.ipauto

# Enable nfsroot
sed 's:CONFIG_NFS_FS=y:CONFIG_NFS_FS=y \
CONFIG_ROOT_NFS=y:' \
.config.ipauto > .config


NFS root on, IP autoconfig on, and booting from a ramdisk.  one of
those is probably fixing your problem... i'd bet on the ramdisk.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
