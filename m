Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 8E3102BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Dec 2004 06:26:56 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647413@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Raphael Bossek'" <raphael.bossek@gmx.de>
Date: Sun, 26 Dec 2004 14:26:32 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux2.6.10-rc3 for 8xx  booting "load_kernel(...)" function
	problem vs configuring and initializing serial console ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

What flavor of 8xx do you have ?
You are correct - Wolfgang does not support it yet (neither Dan Malek nor
Tom Rini) ;-)
but some people claim that 2.6.10-rc3 boots for them - I would really
appreciate though if you could give it a try
and let me know !!! If you need CONFIG_I2C support (for your kernel build) -
you could try to use my changes,
which make the kernel to be compilable ...

1) i2c-algo-8xx.h is copied from 2.4(.26) and placed into
./include/linux/i2c-algo-8xx.h

2) i2c-algo-8xx.c is copied from 2.4(.26) and placed into
./drivers/i2c/algos/i2c-algo-8xx.c

3) added into ./drivers/i2c/algos/Makefile 
   after existing line:
   obj-$(CONFIG_I2C_ALGOITE)       += i2c-algo-ite.o
   the following new line:
   obj-$(CONFIG_I2C_ALGO8XX)       += i2c-algo-8xx.o

4) added into ./include/asm-ppc/commproc.h
   after existing line:
   extern void cpm_free_handler(int vec);
   the following new line:
   extern const char *cpm_int_name[];

5) in ./drivers/i2c/busses/i2c-rpx.c
   changed the order of include files: 
   moving the line:
   #include <asm/commproc.h>
   to be above the line:
   #include <linux/i2c-algo-8xx.h>

   so now includes are in the following order:
   ...
#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/stddef.h>
#include <linux/i2c.h>
#include <asm/commproc.h>
#include <linux/i2c-algo-8xx.h>
#include <asm/mpc8xx.h>
   ...
 
Thanks,
Alex 

-----Original Message-----
From: Raphael Bossek [mailto:raphael.bossek@gmx.de]
Sent: Sunday, December 26, 2004 2:15 PM
To: Povolotsky, Alexander
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux2.6.10-rc3 for 8xx booting "load_kernel(...)" function
problem vs configuring and initializing serial console ?

Hi Alexander,

sorry, but I'm using Wolfgang's (www.denx.de) kernel 2.4.20 from CVS for
8xx. I did not move to 2.6 yet because there was no reason (and Wolfgang 
does not support it yet, does not?).

--
Raphael Bossek

> Hi Rafael,
> 
> Do you run 2.6.10-rc3 on 8xx ?
> If so - do you have any ideas with regards to my issue/problem ?
> 
> Thanks,
> Best Regards,
> Alex
> 
> -----Original Message-----
> From: Povolotsky, Alexander 
> Sent: Thursday, December 23, 2004 12:24 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: 2.6.10-rc3 for 8xx booting "load_kernel(...)" function problem
> vs configuring and initializing serial console ?
> 
> Hi,
> 
> with
> 
> CONFIG_CMDLINE_BOOL=y
> CONFIG_CMDLINE="console=ttyCPM0 panic=3 root=/dev/ram"
> ...
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_SERIAL_NONSTANDARD=y
> # CONFIG_COMPUTONE is not set
> # CONFIG_ROCKETPORT is not set
> # CONFIG_CYCLADES is not set
> # CONFIG_DIGIEPCA is not set
> # CONFIG_DIGI is not set
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> # CONFIG_SYNCLINKMP is not set
> # CONFIG_N_HDLC is not set
> # CONFIG_RISCOM8 is not set
> # CONFIG_SPECIALIX is not set
> # CONFIG_SX is not set
> # CONFIG_RIO is not set
> # CONFIG_STALDRV is not set
> 
> #
> # Serial drivers
> #
> # CONFIG_SERIAL_8250 is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_CPM=y
> CONFIG_SERIAL_CPM_CONSOLE=y
> CONFIG_SERIAL_CPM_SCC1=y
> CONFIG_SERIAL_CPM_SCC2=y
> # CONFIG_SERIAL_CPM_SCC3 is not set
> # CONFIG_SERIAL_CPM_SCC4 is not set
> # CONFIG_SERIAL_CPM_SMC1 is not set
> # CONFIG_SERIAL_CPM_SMC2 is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256in my .config file,
> 
>  still somehow in 2.6.10-rc3 (for 8xx) the "load_kernel(...)" function in
> the 
>  ./arch/ppc/boot/simple/misc-embedded.c is not getting called during the
>  boot ? (I think ...) ... or serial is not getting initialiazed correctly
> within this function 
>  when "serial_init(...)" function is called within it ?...
> 
>  (no JTAG emulator debugging is available to me on this board ...)
>  
>  **********On Linux 2.4.26 I used to see during the boot:*********
>  
>  (M)odify any of this or (C)ontinue? [M] C
>  Updating parameter storage. This may take a while...
>  Done writing in Storage Area
>  Starting Application from bank 1
>  Done
>  
>  ********(then from load_kernel() I would see)********** 
>  loaded at:     00180000 0035622C
>  board data at: 0035313C 0035317C
>  relocated to:  001852CC 0018530C
>  zimage at:     001857F9 00226057
>  initrd at:     00227000 00352ADF
>  avail ram:     00357000 02000000
>  
>  Linux/PPC load: panic=3 root=/dev/ram
>  Uncompressing Linux...done.
>  initrd moved:  00400000 0052BADF
>  Now booting the kernel
>  Running from bank 1
>  Selecting default root device 1f04
>  Linux version 2.4.26 (apovolot@localhost.localdomain) (gcc version 3.4.1)
> #2
>  Fri  Dec 10 13:37:12 EST 2004
>  .....
>  
>  ********On 2.6.10-rc3 nothing "happens" (and then it is just getting
> reexecuted) after I see:     Done  ***********
>  
>  Any ideas ?
> 

-- 
Psssst! Mit GMX Handyrechnung senken: http://www.gmx.net/de/go/mail
100 FreeSMS/Monat (GMX TopMail), 50 (GMX ProMail), 10 (GMX FreeMail)
