From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <thomas.graichen@innominate.com>
Subject: ppc initrd problem?
Date: 24 Feb 2001 20:40:21 GMT
Message-ID: <news2mail-97967l$g4g$2@mate.bln.innominate.de>
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


is there any known problem with initrd's on the ppc?

i am currently trying to get a small initrd based standalone system
working on the ppc like i did for the i386

  http://innominate.org/~graichen/projects/miniroot/

to make the playing around with the xfs filesystem a bit more
comfortable but it does not really boot on the ppc (new world
mac, 2.4.1 kernel, SuSE 7.0/ppc) ...

the symptoms are:

* it starts booting fine
* it finds and uncomresses the initrd into the ramdisk fine too
* it mounts it as root fine too
* it starts init
* init tries to run the rc shell script and this results in bash
  failing to load it's shared libs (it fails on libreadline which
  is the first): it says something about incorrect ELF header -
  but the files in the initrd are ok and all should be there (the
  libs, ld.so and i even ran ldconfig on it)

i have no real idea what happens here - as said - the same thing
works fine in the i386 case ... ok some more details:

* yaboot.conf

  image = vmlinux-2.4.1-XFS
      label = miniroot
      append = "ramdisk_size=40000 load_ramdisk=1"
      initrd = miniroot.gz
      root = /dev/ram

* the initrd is created with:

  mkdir -p /tmp/miniroot-mnt
  dd if=/dev/zero of=/tmp/miniroot bs=1024k count=32
  mke2fs -N 32768 /tmp/miniroot
  mount -o loop /tmp/miniroot /tmp/miniroot-mnt
  cd /tmp/miniroot-mnt
  tar cSlf - `cat /root/miniroot/files.70` | tar xSpf -
  tar xSpzf /root/miniroot/miniroot-add.tgz
  ldconfig -r /tmp/miniroot-mnt
  cd ..
  umount /tmp/miniroot-mnt
  cat /tmp/miniroot | gzip -9 > /root/miniroot.gz
  rmdir /tmp/miniroot-mnt
  rm -i /tmp/miniroot

* the filelist is (excluding stuff not mattering here, all files are
from SuSE 7.0/ppc):

/lib/ld-2.1.3.so
/lib/ld.so.1 (-> /lib/ld-2.1.3.so)
/lib/libc.so.6
/lib/libpam.so.0.72
/lib/libpam_misc.so.0.72
/lib/libdl.so.2
/lib/libcrypt.so.1
/lib/librt.so.1
/lib/libresolv.so.2
/lib/libutil.so.1
/lib/libpthread.so.0
/lib/security/*
/lib/libnsl.so.1
/lib/libnss_files.so.1
/lib/libnss_files.so.2
/lib/libreadline.so.4.1
/lib/libhistory.so.4.1
/lib/libncurses.so.5.0
/bin/bash
/bin/sh (-> /bin/bash)
/sbin/init
/etc/fstab
/etc/inittab
/etc/passwd
/etc/group
/etc/rc
/etc/issue
/etc/shadow
/etc/gshadow
/etc/securetty
/etc/pwdb.conf
/etc/nsswitch.conf
/etc/termcap
...

plus all an "ldconfig -r /destdir" creates on a destdir mounted
system ... chrooting into the mounted system works fine and all
the shared libs kann be resolved fine with the chrooted system
and i can run all the bins in it - but on bootup it does not
work

any idea?

a lot of thanks in advance

t

--
thomas.graichen@innominate.com
                                                         innominate AG
                                                  the linux architects
tel: +49-30-308806-13   fax: -77             http://www.innominate.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
