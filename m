Message-ID: <39B9194C.D917F3BC@student.ethz.ch>
Date: Fri, 08 Sep 2000 18:52:28 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: debian-powerpc@lists.debian.org
CC: linuxppc-dev@lists.linuxppc.org,
        Steffen Haeuser <SteffenH@hyperion-software.de>
Subject: [ANN] Updated Rage128 (Pro) DRI test binaries
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Grab them at http://n.ethz.ch/student/daenzerm/download/DRI/ .


Here's the updated DRI.readme you find there:


Direct Rendering Infrastructure for Rage128 (Pro) on PowerPC
------------------------------------------------------------


These are test binaries. If you have installed XFree86 4.0.2 or later,
chances are it already supports DRI. Please check before trying these
tarballs.

You can find general information about the DRI at http://dri.sourceforge.net .


For flexibility, I have split things up in three tarballs:

- dri-main

  This contains the X server binary, the common modules, the libraries and
  an example XF86Config (etc/X11/XF86Config.dri). Just untar into / and
  start the server like this:

    /usr/XF86-DRI/bin/X :1 -xf86config /etc/X11/XF86Config.dri

  The :1 is only needed if you already have an X server running on display
  :0 .

  You may have to set the environment variable LD_LIBRARY_PATH to
  /usr/XF86-DRI/lib for GL apps to use the correct libraries.


- dri-r128

  This contains the Rage128 (Pro) specific modules for the X server and
  libGL. You have to untar this into / as well for things to work.

  I have split these from the main tarball to allow for frequent updates
  without having to download too much.


- drm-source

  This contains the source for the Direct Rendering Manager kernel module.

  The following assumes you are running kernel version <ver>:

  Untar anywhere, cd drm-source, make, cp r128.o /lib/modules/<ver>/misc/ ,
  as of Linux 2.4.0-test7 to /lib/modules/<ver>/kernel/drivers/char/drm/ .
  If your kernel source isn't in /usr/src/linux{,-<ver>}, you have to set
  TREE to where the kernel headers are, e.g.
  make TREE=/usr/src/linux-pmac-benh/include .



History
-------


- 20000908 (XFree86 4.0.1b):

The lighting problems (moebius showed them badly e.g.) are fixed, thanks to
the upgrade to Mesa 3.4 .

A few other things have improved, but there are still wrong colors sometimes.


- 20000814 (XFree86 4.0.1):

It Works(TM) :)

There are color problems here and there, I'm working on that.

Performance isn't too exciting without AGP GART, however before you give up
frustrated, try something which uses (preferrably lots of) textures. :)

The kernel modules sometimes can't be loaded successfully upon the first
server start. Just exit and restart. Or load it manually before starting the
server to be on the safe side.



Please report any bugs but also success to me!

Have fun and be happy,

Michel Dänzer <daenzerm@student.ethz.ch>


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
