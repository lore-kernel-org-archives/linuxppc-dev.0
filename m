Message-Id: <200205021127.g42BRYx03373@p2.parker.boston.ma.us>
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initrd in 2.4.19 
In-Reply-To: Message from Brian Kuschak <bkuschak@yahoo.com>
   of "Wed, 01 May 2002 10:08:22 PDT." <20020501170822.7469.qmail@web13005.mail.yahoo.com>
Date: Thu, 02 May 2002 07:27:34 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:
>
>I noticed initrd handling has changed recently in the
>kernel (init/do_mounts.c).  This new code is causing
>me problems.  Has anyone else run into this?

heh.  I found that every shred of documentation on this was 1/2 right and
1/2 wrong.

I came to the conclusion that you can either pivot_root or use /linuxrc
but not both.

i.e. if you 'turn on' the special /linuxrc running code you can't pivot
root from it.  it's designed to modload a few modules, enough so the kernel's
own code can mount a file system.  that's it.  and it better return since
the kernel is not done initializing.

I want to use pivot_root, so I don't use the special /linuxrc running
code.  Instead I use "init=/linuxrc" as part of the command line.  If
you do this your first script should work fine (pivot follwed by
chroot).  But to be honest, I don't chroot.  I don't think it's
necessary.

I'd love to hear comments on this.

(actually, looking closer, your 2nd script solves the big problem, which
it the changing of the real root dev #.   I'll bet it would work if it
unmounted /dev/hda2 before returning)

-brad

>
>Using the 'new style' (not terminating linuxrc)
>/linuxrc runs the following sequence:
>  mount -o ro /dev/hda2 /new-root
>  cd /new-root
>  mkdir initrd
>  pivot_root . initrd
>  exec chroot . sbin/init dev/console 2>&1
>But /linuxrc seems to be runnnig as PID 10, and
>sbin/init doesn't start.
>
>Using the 'old style' (linuxrc terminates and kernel
>starts init):
>  mount -o ro /dev/hda2 /new-root
>  cd /new-root
>  mkdir initrd
>  echo 0x0302 > /proc/sys/kernel/real-root-dev
>  exit 0
>The mount fails with EBUSY in mount_block_root()
>because the root device is already mounted:
>
>Attempting to find a root file system on hda2...
> hda1 hda2
> hda: hda1 hda2
>XFS mounting filesystem ide0(3,2)
>Starting XFS recovery on filesystem: ide0(3,2) (dev:
>3/2)
>Ending XFS recovery on filesystem: ide0(3,2) (dev:
>3/2)
>VFS: busy inodes on changed media.
>err=-16, p=ext2, name=/dev/root  <--
>VFS: Cannot open root device "" or 03:02
>Please append a correct "root=" boot option
>Kernel panic: VFS: Unable to mount root fs on 03:02
>
>
>For the old style to work, I have to not mount the
>filesystem at all in my /linuxrc. I'm using
>2.4.19-pre7 from bk (1.948)
>
>-Brian
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
