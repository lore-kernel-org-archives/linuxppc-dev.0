Date: Tue, 17 Sep 2002 20:04:54 -0700
From: Dennis Khoo <dkhoo@atmxdsl.com>
Subject: modprobe:can't locate module block-major-3 problem
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <011c01c25ec0$2a0d4640$7ec7c7c7@dkhoo>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Please bear with me since I'm a total newbie.  I received a TQM850L starter
kit a couple of days ago.  I was able to replace the monitor with PPCBOOT
and also got it to boot pMulti(kernel + ramdisk image) built from SELF with
thttpd added in.  After a few tweaks here and there, most
utilites(ping,thttpd,telnet,etc) are working great.

But on bootup, I noticed that modprobe is complaining that it "Can't open
dependencies file /lib/modules/2.4.4/modules.dep".  After I copied the empty
file lib/modules/2.4.4/modules.dep from ELDK/ppc_8xx into the ramdisk and
built pMulti,  modprobe complains that it cannot locate module
block-major-3.  Here's a snippent of the bootup:
.....
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
init started: BusyBox v0.60.2 (2002.09.14-00:34+0000) multi-call
modprobe: modprobe: Can't locate module block-major-3
modprobe: modprobe: Can't locate module block-major-3
modprobe: modprobe: Can't locate module block-major-3
modprobe: modprobe: Can't locate module block-major-3
modprobe: modprobe: Can't locate module block-major-3
mount: Mounting /dev/hda1 on /mnt failed: No such device
.........

I did a "modprobe -c" after bootup and saw that block-major-3 is an alias of
ide-probe-mod.  Does this mean that I need to get ide-probe-mod.o into the
ramdisk?  I tried copying ide-probe-mod.o into /lib/modules/ide but modprobe
still complains about block-major-3 on bootup.  Keying "modprobe
ide-probe-mod.o" after bootup outputs "Can't locate ide-probe-mod.o".  Even
though I'm not using an IDE drive, I'm curious as to why modprobe would
complain...


Thanks a million,
dennis
dkhoo@atmxdsl.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
