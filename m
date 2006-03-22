Return-Path: <bersace03@laposte.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <82FEFC77-5EDB-4349-B935-AD422913F3F7@laposte.net>
From: =?ISO-8859-1?Q?=C9tienne_Bersac?= <bersace03@laposte.net>
Subject: Running Linux 2.6.16 and Xorg 7.0 on iMac G5 rev C (iSight)
Date: Wed, 22 Mar 2006 01:11:48 +0100
To: Linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	ubuntu-devel@lists.ubuntu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

With the great help of Benjamin Herrenschmidt, i reach to run linux =20
and Xorg on an iMac G5 rev C 20" (the iSight line) with an Ati Radeon =20=

X600 XT Pro (RV380). Make your backup ! You should verify each file i =20=

ship with this howto. Conf files are available at http://=20
bersace03.free.fr/pub/Linux/iMac%20G5/.

You need at least a 2.6.15-rc1 kernel, a Mac OS X installation and an =20=

install cd. (I use an ubuntu one). I advice you to make a place for =20
linux before installation.

  - Get Ben's kernel at http://bersace03.free.fr/pub/iMac%20G5/=20
vmlinux.bz2 (mirror of http://gate.crashing.org/~benh/vmlinux.bz2). =20
bunzip2 it at /.

  - Copy install/yaboot and initrd.gz from the installer to /. Rename =20=

initrd.gz to initrd-cd.gz. Copy yaboot.conf from the website to /. I =20
assume you will install linux in /dev/sda5, if this is not the case, =20
edit yaboot.conf

  - Insert your cd. It's time to reboot !

  - Type Option+Command+O+F at boot time. This should open the OF =20
terminal.

  -  Type "boot hd:X,yaboot" where X is the number of the Mac OS X =20
volume (often 3). Remember this each time you have to use yaboot =20
while we have not run "ybin".

  - Choose the "cd" label at yaboot prompt. First questions should =20
arrives such as language, country, etc. Then the installation should =20
go on.

  - Reboot at the end of the installation, using yaboot from OF prompt.

  - Choose the "rescue" label to boot. Copy the installed initrd.gz =20
to your Macintosh Volume, using an usb key/hd/whatever you want. Copy =20=

this initrd.gz as /initrd-hd.gz at root of your Macintosh Volume. =20
Here you may have to change the /yaboot.conf to reflect the =20
installation (especially the root=3D/dev/sda5 option). This might be =20
possible to run ybin here, but i'm not sure.

  - Disable the display manager (e.g. update-rc.d -f gdm remove).

  - Now it's time to boot the installed system, still using ben's =20
kernel. Choose the "hd" label at yaboot prompt. Once your system is =20
booted, configure network (network-manager work fine), install build-=20
essential and other good stuffs like kernel-package and fakeroot. Get =20=

the source ! 2.6.16 is fine. use g5_defconfig as .config and compile =20
the kernel.

  - Modify /etc/yaboot.conf, add an entry for your kernel and set it =20
as default (of course), add macosx option, etc.. When you are sure, =20
run ybin. Now you don't need OF prompt anymore.

  - You may want to restart, but we can continue.


Next step is xorg. You need a special branch of the ati driver for =20
xorg. Thanks to the new modular Xorg :)

  - Install automake-1.7, x11proto-*, xserver-xorg-dev, xlibs-dev and =20=

other stuff you may need to compile this. ./configure will help you. =20
The CVSROOT is :pserver:anoncvs@cvs.freedesktop.org:/cvs/xorg . I =20
install stuff with --prefix=3D/usr.

  - Checkout  and install util/macros.

  - Use ati-1-0-branch branch of the ati driver ( http://=20
webcvs.freedesktop.org/xorg/driver/xf86-video-ati/?=20
only_with_tag=3Dati-1-0-branch ). Checkout and install it.

  - Use the xorg.conf available at http://bersace03.free.fr/pub/Linux/=20=

iMac%20G5/xorg.conf . I own an iMac G5 20", so if you have the 17" =20
one, you must use the result of 'parse-edid $(find /proc/device-tree -=20=

name EDID)'  as Screen Section, and use the resolution from xresprobe =20=

radeon in the PanelSize option of the Device Section. You should =20
check xorg.conf and track error.

  - Pray and run your display manager (e.g. invocke-rc.d gdm start). =20
If you are lucky, you will see the charming waiting cursor and then =20
the dm prompt. Eur=EAka !!

  - If it work, enable your diplays manager with z.B. dpkg-=20
reconfigure gdm.

OR

  - If you get a blank screen, try to play with radeon(4) options in =20
xorg.conf. Send feedbacks. Blank screen seems to mean that you won't =20
see anything while you do not reboot the box. This is where ssh is =20
usefull.

This is the end of this howto.

I had had some difficulties to write this howto because i did the two =20=

step  with several weeks and a lot of failures between them . So i =20
might have forgottent some important points. Please send feedbacks.

I really want to thank Benjamin Herrenschmidt who helps me several =20
times and does great work to support those computers. Merci Benjamin !

=C9tienne.
