Message-ID: <392EA146.757517C3@mvista.com>
Date: Fri, 26 May 2000 11:07:34 -0500
From: Jim Lewis <jlewis@mvista.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root fs on hdd
References: <392E92E3.62847D28@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need to make the following soft link in your target :
opt/hardhat/devkit/ppc/8xx/powerpc-linux ----> /

I think that will fix your problem.
-Jim
Steve Rossi wrote:

> Hi All,
>
> well after stepping away from it for a while then coming back to it I've
> managed to track down the problems with my filesystems getting
> corrupted. Now I've got stable hard disk i/o and so I'm trying to mount
> the root file system from the disk. I get the feeling I'm missing
> something incredibly obvious ... perhaps someone can help point it out
> to me.
> I've copied the the /bin, /dev, /etc, /lib, /libexec, /sbin, and /share
> directories from the monta vista sdk to the root direectory of my ext2
> partition (/dev/sda2) using "cp -a" while the root partition was
> NFS mounted. What I copied is basically the filesystem that I mount over
> NFS and it works fine. I've also created empty /proc and /tmp
> directories on sda2. I've modifed etc/fstab on sda2 so that /dev/sda2 is
> mounted as the root filesystem. I've also changed my bootline to read
> root=/dev/sda2 rw
>
> OK, so the kernel boots, it mounts the root partition on /dev/sda2, init
> runs, but init complains:
>
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 52k init
> init: error in loading shared libraries: libc.so.6: cannot open shared
> object file: No such file or directory
>
> Then it just stops. I've verified that the lib directory on /dev/sda2
> contains libc.so.6 as a link to libc-2.1.2.so
>
> So what am I missing? Where is init looking for libc.so.6 and why can't
> it find it? Is there something stupid about the way I just copied the
> root filesystem from the NFS mounted root to the disk?
>
> Thanks,
> Steve
>
> --
> -------------------------------------------------------
> Steven K. Rossi                     srossi@ccrl.mot.com
> Staff Engineer
> Multimedia Communications Research Laboratory
> Motorola Labs
> -------------------------------------------------------
>

--
Jim Lewis
Sr. Field Applications Engineer
MontaVista Software, Inc.
(817)261-9088 http://www.mvista.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
