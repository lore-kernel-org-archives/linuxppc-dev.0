Message-Id: <4.3.2.7.0.20000727145521.00ae8410@10.0.0.2>
Date: Thu, 27 Jul 2000 15:01:02 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Mike Coy <coym@embeddedplanet.com>
Subject: 2.3 kernels
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to get a 2.3 kernel working on an RPX-LITE board.  After a bunch
of guesswork, I got it to compile.  A good number of hte things I disabled
can probably be re-enabled now, but that isn't the problem.  It now
compiles OK, but when I download it to the board and run it, I get no
output whatsoever.

Has anyone successfully ran a 2.3 kernel on one of these boards?

Thanks,
Mike

btw, the steps I took to get it to compile (from a stock 2.3.99pre9 kernel
from kernel.org) are:

edit the Makefile
         set ARCH to ppc
         set CROSS-COMPILE to powerpc-linux-
         comment out all lines referring to macintosh.a (odd linking problems)

in hte menuconfig,
         select 8xx-processors
         select rpx-lite
         turn off mouse support (i had some odd problem with adbmouse...)
         turn off special partition support (some odd problem with mac
partition)
         turn off ide support
         turn off ppp support
         turn off support for all ethernet devices (but leave ethernet on
if you want)
         turn off qspan-pci
         turn off magic sysreq key
         turn off appletalk
         turn off scsi
         turn off framebuffers
         turn off nvram support
         turn off usb support
         turn off virtual terminal support.
         turn on xmon debugging (or it complains for lack of debugger?)

after the make fails,
         add a symlink
                 arch/ppc/mbxboot/vmlinux.lds -> ../vmlinux.lds
         and rebuild (just the make zImage part)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
