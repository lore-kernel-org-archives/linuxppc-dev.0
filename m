Message-ID: <397C8BFC.AF7AEF5C@snmc.com>
Date: Mon, 24 Jul 2000 13:33:32 -0500
From: Daris Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: Mike Coy <coym@embeddedplanet.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: flash filesystem
References: <4.3.2.7.0.20000824132843.00b1f9a0@10.0.0.2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mike,

We currently do what you suggest with our QS850 product using
our modified version of Linux 2.2.5 (QSLinux).  We have a small
(640K) "boot" area that contains the processor IPL+Kernel.  The
remainder of the FLASH we allocate as a FLASH Filesystem,
and we run the Ext2fs filesystem along with E2cfs (compression).
The /bin, /dev, /lib, /etc directories and files reside in the FLASH
filesystem and are retrieved at boot time.

We are working to cleanup our source for distribution.  I am hoping to
have it ready for publication later this week.

Please note that we developed our code "outside" the main linux
directory tree.  This was done to make it easier to fold these changes
into future kernel releases.  We are hoping that our code gets integrated
into the main branch of the Linux Kernel by some good hearted soul,
but we do not have the manpower to tackle that task at the moment.

There are also other components that may be of interest.  We have
an HDLC/PPP driver for the SCCs.  We have split Dan Malek's
SCC/SMC uart driver into 2 parts (1 for SCC and one for SMC),
but there is still more work to be done on it.  We also have an
ATM/UTOPIA driver, a driver for allocating and controlling the
I/O ports of the MPC850, a watchdog driver, and other features
worth looking at.

To learn about the features of QSLinux you can visit qslinux.com.
To learn about or QS850 product you can visit www.snmc.com.

Regards,
Daris A Nevil
SiSIC Inc/Simple Network Magic Corporation



Mike Coy wrote:

> I've noticed that the size of my initrd is limited not by the size of my
> flash, but by the amount of ram I have to decompress it into.
> I would like to put a filesystem in the unused portion of my flash and read
> it (read-only) without first copying it into ram.
> I'm not entirely sure how to get at this filesystem, though.  The only way
> I've seen flash accessed is with the initrd at boottime.
> Has anyone done this?
>
> The best that I can come up with is that the flash is probably mapped into
> memory somewhere, and maybe I could fool the ramdisk code into reading a
> pre-existant ramdisk at a given address.  This didn't appear to be too
> trivial at my first browse through the code, though.
> What is the right way to get at data in flash?
>
> Thanks,
> Mike
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
