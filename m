Date: Sat, 22 Jan 2000 15:53:47 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Troy Benjegerdes <hozer@drgw.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Argh, PReP netbooting doesn't use residual data
In-Reply-To: <Pine.LNX.4.10.10001172159080.20769-100000@altus.drgw.net>
Message-ID: <Pine.HPX.4.10.10001221531010.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 17 Jan 2000, Troy Benjegerdes wrote:

>
>
> Is there any sane way to fix arch/ppc/boot/misc.c so that PReP machines
> that are network booting can figure out how much memory the machine has?
>
> I have a MVME 2600 with 16 MB of RAM I have been fighting with the last
> week until I realized it assumed 32 MB while the machine only had 16, and
> *did not* print a warning message of any sorts.
>
> Gabriel Paubert has done quite a bit of work on his prep bootloader.. Are
> there some reasons that this bootloader could not be included as a config
> option?

On this subject, I've just created a new linux-2.3 directory in which
you'll find the patches for the kernel I boot on my MVME2600 and 2400.
They include prepboot as config option, but the patch includes many other
things too.

Note that this kernel is still unstable at least on the machines wit root
on NFS (the 2600 with SCSI disk seems to work fine): after some time and
for unknown reasons, filesystems, except the root filesystems, disappear:
the result of ls -a on these nodes returns only . and .. (but if proc is
still mounted /proc/mounts does not show anything abnormal):

Then strange things happen like:
[root@vdevel packages]# df
Filesystem           1k-blocks      Used Available Use% Mounted on
vlab1:/acroot/vdevel   2012932   1514623    394272  79% /
none                   2012932   1514623    394272  79% /proc
none                   2012932   1514623    394272  79% /dev/pts
vlab1:/usr/src/        2012932   1514623    394272  79% /usr/src
vlab1:/home            2012932   1514623    394272  79% /home

but I'm still in /usr/src/packages and ls works:

[root@vdevel packages]# pwd
/usr/src/packages
[root@vdevel packages]# ls
XFree      gcc-newppc-branch    gcc_work 	glibc-linuxthreads-2.1.tar.gz
gcc-build  gcc_latest_snapshot  glibc-2.1.tar.gz

and funny things:
[root@vdevel packages]# uptime
Error: /proc must be mounted
  To mount /proc at boot you need an /etc/fstab line like:
      /proc   /proc   proc    defaults
  In the meantime, mount /proc /proc -t proc
Error: /proc must be mounted
  To mount /proc at boot you need an /etc/fstab line like:
      /proc   /proc   proc    defaults
  In the meantime, mount /proc /proc -t proc
Error: /proc must be mounted
  To mount /proc at boot you need an /etc/fstab line like:
      /proc   /proc   proc    defaults
  In the meantime, mount /proc /proc -t proc
  1:31pm  up -24855 days, -3:-14,  1 user,  load average: 0.00, 0.00, 0.00

I suspect a VFS/dcache issue with NFS or something similar. Not the HW
since 2.2.12 is rock solid on the same machine...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
