Message-ID: <20020501170822.7469.qmail@web13005.mail.yahoo.com>
Date: Wed, 1 May 2002 10:08:22 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: initrd in 2.4.19
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed initrd handling has changed recently in the
kernel (init/do_mounts.c).  This new code is causing
me problems.  Has anyone else run into this?

Using the 'new style' (not terminating linuxrc)
/linuxrc runs the following sequence:
  mount -o ro /dev/hda2 /new-root
  cd /new-root
  mkdir initrd
  pivot_root . initrd
  exec chroot . sbin/init dev/console 2>&1
But /linuxrc seems to be runnnig as PID 10, and
sbin/init doesn't start.

Using the 'old style' (linuxrc terminates and kernel
starts init):
  mount -o ro /dev/hda2 /new-root
  cd /new-root
  mkdir initrd
  echo 0x0302 > /proc/sys/kernel/real-root-dev
  exit 0
The mount fails with EBUSY in mount_block_root()
because the root device is already mounted:

Attempting to find a root file system on hda2...
 hda1 hda2
 hda: hda1 hda2
XFS mounting filesystem ide0(3,2)
Starting XFS recovery on filesystem: ide0(3,2) (dev:
3/2)
Ending XFS recovery on filesystem: ide0(3,2) (dev:
3/2)
VFS: busy inodes on changed media.
err=-16, p=ext2, name=/dev/root  <--
VFS: Cannot open root device "" or 03:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:02


For the old style to work, I have to not mount the
filesystem at all in my /linuxrc. I'm using
2.4.19-pre7 from bk (1.948)

-Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
