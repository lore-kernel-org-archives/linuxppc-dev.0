Message-ID: <39EE00CA.BE9889DC@talknet.de>
Date: Wed, 18 Oct 2000 21:58:02 +0200
From: Alois Fertl <alois_fertl@talknet.de>
MIME-Version: 1.0
To: Xavier Grave <grave@ipno.in2p3.fr>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: initial console
References: <39EDC604.A6776B85@muenchen.europe.mcd.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The problem you are seeing here is probably prep_init in prep_setup.c
not copying the arguments passed by the boot loader into the kernels command
line. Your root=/dev/sda5 is probably ignored.
Look at your early log messages during boot. There should be a line
"Boot arguments: ..." telling you those things seen by the kernel.

In case the arguments aren't as you typed them, try putting the following
lines at the beginning of prep_init:

+       if (r6) {
+               *(char *)(r7 + KERNELBASE) = 0;
+               strcpy(cmd_line, (char *)(r6 + KERNELBASE));
+       }

What hardware is this running on? If it is Motorola VME this failure is only
the starting point and other trouble will follow. There are additional fixes
but I can't verify them against a working source at the moment. test9 and test10
from fmlabs currently both panic during init as soon as the process starts using
the hard drive (this is on a PowerStack).

Xavier Grave wrore:
>
> On Thu, 19 Oct 2000, Chris Leishman wrote:
> > I know it sounds dumb, but have you ensured that you've got the root partition
> > set correctly?  I've seen these errors before when I had a root partition
> > specified that didn't contain /dev or /sbin/init.
>
> /dev/sda5 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
> proc on /proc type proc (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> /dev/sda2 on /boot type ext2 (rw)
> /dev/sda6 on /home type ext2 (rw)
> /dev/sda7 on /export/data1 type ext2 (rw)
> /dev/sda8 on /export/data2 type ext2 (rw)
>
> And I give the following argument root=/dev/sda5
> with the 2.4.0 kernel it fails but with a 2.2.17 kernel it works.
>
> 33 (0) 1 69 15 79 59
> De chacun selon ses forces, a chacun selon ses besoins
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
