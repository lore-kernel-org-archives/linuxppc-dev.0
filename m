Return-Path: <llau@mistletoetech.com>
Received: from smtp.mistletoetech.com (h-66-134-241-90.snvacaid.covad.net
	[66.134.241.90]) by ozlabs.org (Postfix) with ESMTP id BFB9767A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 07:33:41 +1100 (EST)
Received: from llaudesk (llau-desk.mistletoetech.com [10.0.0.144])
	by smtp.mistletoetech.com (Postfix) with ESMTP id 4C6803C01A3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Feb 2005 12:06:39 -0800 (PST)
From: "llau" <llau@mistletoetech.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 28 Feb 2005 12:06:39 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050228131918.5609967A88@ozlabs.org>
Message-Id: <20050228200639.4C6803C01A3@smtp.mistletoetech.com>
Subject: RE: Linuxppc-embedded Digest, Vol 7, Issue 1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Emre:

If your network average packet size is small (ie: < 256/512Byte), you may
consider using polling on packet receive side, instead using interrupt. 
This is one of the few cases that polling scheme is better than interrupt.
Of cause, your must be careful of designing your polling scheme.  I have
successfully implemented a terabit router using polling scheme because of
the huge interrupt overhead that killing the routing protocol processing
performance. But for the line rate (CPU packet) requirement I am not very
sure.


-- Larry --


-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of
linuxppc-embedded-request@ozlabs.org
Sent: Monday, February 28, 2005 5:19 AM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 7, Issue 1

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. [PATCH] ppc4xx_sgdma.c (Roger Larsson)
   2. RE: High processing power and gigabit interface (emre kara)
   3. isp1362 (Marco Schramel)
   4. [PATCH 1/3] PowerPC4xx/E500 WatchDogTimerDriver(Core and
      PPC4xx	part) (Takeharu KATO)


----------------------------------------------------------------------

Message: 1
Date: Mon, 28 Feb 2005 02:22:46 +0100
From: "Roger Larsson" <roger.larsson@optronic.se>
Subject: [PATCH] ppc4xx_sgdma.c
To: <linuxppc-embedded@ozlabs.org>
Cc: roger.larsson@norran.net
Message-ID:
	
<518B77BB6246D54D9E88FC49AFB0389D1E6C2C@seskoptronicmsx.optronic.local>
	
Content-Type: text/plain; charset="iso-8859-1"

Skipped content of type multipart/alternative-------------- next part
--------------
A non-text attachment was scrubbed...
Name: ppc4xx_sgdma.c.patch
Type: text/x-diff
Size: 10625 bytes
Desc: ppc4xx_sgdma.c.patch
Url :
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20050228/9076f40e/
ppc4xx_sgdma.c-0001.bin

------------------------------

Message: 2
Date: Mon, 28 Feb 2005 13:16:26 +0000 (GMT)
From: emre kara <emrekara2002@yahoo.co.uk>
Subject: RE: High processing power and gigabit interface
To: "Howell, Kyle" <Kyle.Howell@barco.com>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <20050228131626.78019.qmail@web25704.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1

Hi everyone;
Thank you all for your valueable answers.
For summarizing the solutions, to overcome the problem
about getting high troughput on ethernet devices:
1- Use NAPI version of ethernet drivers(I didnt hear
its implemented for 440gx)
2- Change the processor with an much powerful one(like
8540, and I think there was also a NAPI driver for
this processor, so it can also cover the first
solution)
3- Use network processor

The third solution is an expensive one,my project is
not at that huge, so I eliminate this.
And my question, I have good hardware and mid level
linux device driver knowledge, but I never wrote an
ethernet driver.
Is there a lot of work for 440gx NAPI driver,can I
write it easly,if so where can I start,(or did someone
make it before?)
or must I throw 440gx eval board to waste basket and
buy a new platform?
Thank you all..
Emre

 
--- "Howell, Kyle" <Kyle.Howell@barco.com> wrote: 
> Hi Emre,
> 
> I am not familiar with the Linux network driver for
> the 440, but the first
> thing I would check is that your network driver is
> using the new NAPI. With
> packets as small as 64 bytes, this kind of interrupt
> traffic would floor any
> processor without some form of coalescing.
> 
> I am currently achieving ~800Mbits/sec throughput on
> a Motorola MPC8540
> @800MHz (very comparable to the 440, AFAIK). That
> project involves passing
> data from a non-network interface onto the network
> and vice-versa. Achieving
> that speed required using the NAPI version of the
> net driver and using 4KB
> packets (Jumbo packets). I don't know how great the
> hit would be if that was
> network-network traffic or if we were doing anything
> more complex than
> simple data routing.
> 
> I suspect that unless your encryption is hardware
> accelerated, you won't
> have a chance with anything less than a full
> multi-GHz processor. The other
> tasks could probably manage your required 200Mb/s on
> the 440 with enough
> tuning, though I'm not confident that would be true
> with packets as small as
> 64Bytes.
> 
> Regards,
> Kyle Howell
> Engineer, BarcoView LLC
> kyle.howell@barco.com
> 
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org]On
> Behalf Of emre kara
> Sent: Thursday, February 17, 2005 9:11 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: High processing power and gigabit interface
> 
> 
> Dear All,
> I'am not sure if this kind of question can be asked
> on
> this mail-list, if not, sorry about it.
> In my project, we need high processing power on
> gigabit network interfaces. our system will achive
> routing,nat, encryption at minimum 200 Mbits
> bandwith.
>  Firstly we decide to use amcc 440gx(ocotea)(because
> of TAH,2 gigabit interfaces etc..) and I had loaded
> linux kernel 2.6.10 and also denx's 2.4 kernel for
> our
> board..(with our (linux community) valueable
> helps..thanks alot..)
> I have tested 440gx routing performance with this
> two
> kernels, for doing this, we had send 64 bytes
> packets
> between two computer,but we could'nt see much more
> then 40Mbits routing performance on this tests. I
> think the problem with hardware, we have reached the
> limits.  
> I need your suggestions,which processor is suitable
> for our app or where am I wrong.
> Thanks alot for the answers.
> Emre
> 
> 
> 	
> 	
> 		
>
___________________________________________________________
> 
> ALL-NEW Yahoo! Messenger - all new features - even
> more fun!
> http://uk.messenger.yahoo.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  

Send instant messages to your online friends http://uk.messenger.yahoo.com 


------------------------------

Message: 3
Date: Mon, 28 Feb 2005 14:15:00 +0100
From: Marco Schramel <Schramel.Linux@go.bartec.de>
Subject: isp1362
To: linuxppc-embedded@ozlabs.org
Message-ID: <200502281415.00431.Schramel.Linux@go.bartec.de>
Content-Type: text/plain;  charset="us-ascii"

Hi,

to realize a usb-host on 8270 we use the isp1362 and the working device
driver of the denx kernel.
A little code and the 82xx can talk with the usb host.

The boot messages are

...
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
isp1362-HC Detected
usb.c: new USB bus registered, assigned bus number 1
Product: USB OHCI Root Hub
SerialNumber: c7f4b000
hub.c: USB hub found
hub.c: 2 ports detected
isp1362-HC Initialization Successful
...

It seems it is initialized well.

But if i connect a device on the usb bus it is not able to address the usb
device.
It outputs :

hub.c: new USB device L-1, assigned address 2
usb_control/bulk_msg: timeout
unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device L-1, assigned address 3
usb_control/bulk_msg: timeout
unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-110)

Maybe interrupt handling ??

Any ideas ?? All hints are welcome.

Thanks in advance
Marco


---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112


------------------------------

Message: 4
Date: Mon, 28 Feb 2005 22:18:20 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
Subject: [PATCH 1/3] PowerPC4xx/E500 WatchDogTimerDriver(Core and
	PPC4xx	part)
To: Matt Porter <mporter@kernel.crashing.org>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Message-ID: <42231A1C.4020106@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed

Dear Matt and all:

I finished writing PowerPC4xx/e500 Watch Dog Timer Driver.
This driver consist of three parts of patches:

1) ppc4xx-wdt.patch  ... Driver core and PowerPC4xx relevant setup.
2) e500-wdt.patch    ... PowerPC e500 (MPC85xx) relevant setup.
3) exc-wdt.patch     ... Exception handler fixes.

Please apply these patches.

This driver is tested on following environments:

i)  Ebony evaluation board(CPU:PowerPC440GP)
ii) MPC8560 CDS evaluation board (CPU:MPC8560)

Please contact me via e-mail if there is a person who cooperates in the
test.
I can send test-sets for this driver off-list.

Regards,

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>

--- linux-2.6.11-rc5.orig/arch/ppc/syslib/ppc4xx_setup.c	2005-02-27
15:26:57.000000000 +0900
+++ linux-2.6.11-rc5/arch/ppc/syslib/ppc4xx_setup.c	2005-02-28
20:51:45.000000000 +0900
@@ -48,10 +48,6 @@
  extern void abort(void);
  extern void ppc4xx_find_bridges(void);

-extern void ppc4xx_wdt_heartbeat(void);
-extern int wdt_enable;
-extern unsigned long wdt_period;
-
  /* Global Variables */
  bd_t __res;

@@ -257,22 +253,13 @@ ppc4xx_init(unsigned long r3, unsigned l
  		*(char *) (r7 + KERNELBASE) = 0;
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}
-#if defined(CONFIG_PPC405_WDT)
-/* Look for wdt= option on command line */
-	if (strstr(cmd_line, "wdt=")) {
-		int valid_wdt = 0;
-		char *p, *q;
-		for (q = cmd_line; (p = strstr(q, "wdt=")) != 0;) {
-			q = p + 4;
-			if (p > cmd_line && p[-1] != ' ')
-				continue;
-			wdt_period = simple_strtoul(q, &q, 0);
-			valid_wdt = 1;
-			++q;
-		}
-		wdt_enable = valid_wdt;
+#ifdef CONFIG_PPC4xx_WATCHDOG
+	{
+	  extern void ppc4xx_wdt_setup_options(char *cmd_line);
+
+	  ppc4xx_wdt_setup_options(cmd_line);
  	}
-#endif
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */

  	/* Initialize machine-dependent vectors */

@@ -287,9 +274,9 @@ ppc4xx_init(unsigned long r3, unsigned l

  	ppc_md.calibrate_decr = ppc4xx_calibrate_decr;

-#ifdef CONFIG_PPC405_WDT
+#ifdef CONFIG_PPC4xx_WATCHDOG
  	ppc_md.heartbeat = ppc4xx_wdt_heartbeat;
-#endif
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */
  	ppc_md.heartbeat_count = 0;

  	ppc_md.find_end_of_memory = ppc4xx_find_end_of_memory;
@@ -319,3 +306,5 @@ void platform_machine_check(struct pt_re
  #endif

  }
+
+
--- linux-2.6.11-rc5.orig/drivers/char/watchdog/Kconfig	2005-02-27
15:29:22.000000000 +0900
+++ linux-2.6.11-rc5/drivers/char/watchdog/Kconfig	2005-02-28
19:33:10.000000000 +0900
@@ -346,6 +346,13 @@ config 8xx_WDT
  	tristate "MPC8xx Watchdog Timer"
  	depends on WATCHDOG && 8xx

+config PPC4xx_WATCHDOG
+	bool "Watchdog on PowerPC 4xx/e500"
+	depends on WATCHDOG && ( 4xx || E500 )
+	---help---
+	  This is the driver for the watchdog timers present on
+	  PowerPC 4xx series(PPC405GP/GPr,PPC440GP/GX and so on).
+
  # MIPS Architecture

  config INDYDOG
--- linux-2.6.11-rc5.orig/drivers/char/watchdog/Makefile	2005-02-27
15:29:33.000000000 +0900
+++ linux-2.6.11-rc5/drivers/char/watchdog/Makefile	2005-02-27
21:37:31.000000000 +0900
@@ -39,3 +39,4 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.
  obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
  obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
  obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_PPC4xx_WATCHDOG)   += ppc4xx_wdt.o
\ No newline at end of file
--- linux-2.6.11-rc5.orig/drivers/char/watchdog/ppc4xx_wdt.c	1970-01-01
09:00:00.000000000 +0900
+++ linux-2.6.11-rc5/drivers/char/watchdog/ppc4xx_wdt.c	2005-02-28
20:51:45.000000000 +0900
@@ -0,0 +1,635 @@
+/*
+ *    Copyright (c) 2005 Fujitsu Limited
+ *
+ *    Module name: ppc4xx_wdt.c
+ *    Author:      Takeharu KATO<kato.takeharu@jp.fujitsu.com>
+ *
+ *    This program is free software; you can redistribute it and/or
+ *    modify it under the terms of the GNU General Public License
+ *    as published by the Free Software Foundation; either version 2
+ *    of the License, or (at your option) any later version.
+ *
+ *    Neither Takeharu KATO nor Fujitsu Ltd. admit liability nor provide
+ *    warranty for any of this software.
+ *
+ *    Description:
+ *     Watchdog driver for PowerPC 4xx-based processors.
+ *     Derived from drivers/char/watchdog/wdt.c by Alan cox
+ *              and  drivers/char/watchdog/ppc405_wdt.c by Armin Kuster.
+ *     PPC4xx WDT operation is driverd from Appendix of
+ *     PowerPC Embedded Processors Application Note
+ *      ``PowerPC 40x Watch Dog Timer'' published from IBM.
+ *     This driver is written according to ``PowerPC e500 Core Complex
+ *     Reference Manual'' for e500 part.
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/fs.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/capability.h>
+#include <linux/string.h>
+#include <asm/reg.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include "ppc4xx_wdt.h"
+
+/* micro seconds per one milli-second(used to calculatewatchdog
+ * counter to be set). */
+#define US_PER_MS 1000
+/*  Calculate watchdog count   */
+#define calculate_wdt_count(t) ((((unsigned long)(t))*HZ)/1000)
+
+int wdt_enable=0;             /* WDT start on boot  */
+int wdt_period=WDT_TIMO;       /* Time out in ms */
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+/*
+ * Global variables
+ */
+static int wdt_count = 0;            /* WDT intrrupt counter to be reloaded
*/
+static volatile int wdt_heartbeat_count = 0;  /* WDT intrrupt
counter(compatible mode)*/
+static unsigned long driver_state; /* Driver status (see: ppc4xx_wdt.h) */
+/*
+ *  Identifier for this watchdog
+ */
+static struct watchdog_info ident = {
+  .options=WDIOF_SETTIMEOUT|WDIOF_KEEPALIVEPING|WDIOF_MAGICCLOSE,
+  .firmware_version =	0, /*  This is filled with PVR in initialization. */
+  .identity =		"PPC4xx WDT",
+};
+
+/*
+ *  External linkage functions
+ */
+void ppc4xx_wdt_heartbeat(void);
+void ppc4xx_wdt_setup_options(char *cmd_line);
+/*
+ * Internal linkage functions
+ */
+static __inline__ void __ppc4xx_wdt_setup_val(int period,int reset);
+static __inline__ void __ppc4xx_wdt_enable(void);
+static __inline__ void __ppc4xx_wdt_disable(void);
+static __inline__ int  __ppc4xx_wdt_is_enabled(void);
+static __inline__ void __ppc4xx_wdt_clear_int_stat(void);
+static __inline__ void __ppc4xx_wdt_set_timeout(int t);
+static __inline__ void ppc4xx_wdt_init_device(void);
+static __inline__ int  ppc4xx_wdt_is_enabled(void);
+static __inline__ int  ppc4xx_wdt_start(void);
+static __inline__ int  ppc4xx_wdt_stop(void);
+static __inline__ int  ppc4xx_wdt_ping(void);
+static __inline__ int  ppc4xx_wdt_set_timeout(int t);
+static __inline__ int  ppc4xx_wdt_get_status(int *status);
+static ssize_t ppc4xx_wdt_write(struct file *file, const char *buf, size_t
count, loff_t *ppos);
+static int ppc4xx_wdt_ioctl(struct inode *inode, struct file *file,
unsigned int cmd,unsigned long 
arg);
+static int ppc4xx_wdt_open(struct inode *inode, struct file *file);
+static int ppc4xx_wdt_release(struct inode *inode, struct file *file);
+static int ppc4xx_wdt_notify_sys(struct notifier_block *this, unsigned long
code,void *unused);
+static int __init ppc4xx_wdt_init(void);
+static void __exit ppc4xx_wdt_exit(void);
+
+/*
+ *	Watchdog operations on PPC4xx MPU
+ */
+
+/**
+ *      __ppc4xx_wdt_setup_val
+ *      Enable 4xx Watchdog, sets up passed in values for TCR[WP],
+ *      TCR[WRC]
+ *
+ *	@period:	Input Watchdog Period - TCR[WP]
+ *                      0 = 2^17 clocks
+ *                      1 = 2^21 clocks
+ *                      2 = 2^25 clocks
+ *                      3 = 2^29 clocks
+ *      @reset:         Watchdog reset control - TCR[WRC]
+ *                      0 = No reset
+ *                      1 = PPC Core reset only
+ *                      2 = PPC Chip reset
+ *                      3 = System reset
+ *     Note: The meaning of period number is differ PPC440GP from PPC440GX.
+ */
+#if defined(CONFIG_4xx)
+static __inline__ void
+__ppc4xx_wdt_setup_val(int period,int reset)
+{
+  unsigned long val;
+
+  /*  Set up TCR  */
+
val=((period)<<WDT_TCR_WP_SHIFT|(reset)<<WDT_TCR_WRC_SHIFT)|mfspr(SPRN_TCR);
+  /*  Disable WDT  */
+  val &= ~(WDT_TCR_WDT_ENABLE);
+
+  mtspr(SPRN_TCR,val);
+}
+#else
+/*  e500  */
+static __inline__ void
+__ppc4xx_wdt_setup_val(int period,int reset)
+{
+  unsigned long val;
+  /*  Set up TCR  */
+
+  val=(((period)&(WDT_TCR_WP_BITMSK)) << WDT_TCR_WP_SHIFT|
+       ( ( (period) >> 2 )&(WDT_TCR_WPEXT_BITMSK)) << WDT_TCR_WPEXT_SHIFT|
+       (reset)<<WDT_TCR_WRC_SHIFT)|mfspr(SPRN_TCR);
+  /*  Disable WDT  */
+  val &= ~(WDT_TCR_WDT_ENABLE);
+
+  mtspr(SPRN_TCR,val);
+}
+#endif  /*  CONFIG_E500 */
+/**
+ *      __ppc4xx_wdt_enable
+ *      Enable 4xx Watchdog
+ */
+static __inline__ void
+__ppc4xx_wdt_enable(void)
+{
+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)|WDT_TCR_WDT_ENABLE));
+}
+/**
+ *      __ppc4xx_wdt_disable
+ *      Disable 4xx Watchdog
+ */
+static __inline__ void
+__ppc4xx_wdt_disable(void)
+{
+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)&(~(WDT_TCR_WDT_ENABLE))));
+}
+/**
+ *      __ppc4xx_wdt_is_enabled
+ *      Check whether 4xx Watchdog is enabled.
+ */
+static __inline__ int
+__ppc4xx_wdt_is_enabled(void)
+{
+  return (mfspr(SPRN_TCR) & WDT_TCR_WDT_ENABLE);
+}
+/**
+ *      __ppc4xx_wdt_clear_init_stat
+ *      Clear interrupt status of PPC4xx Watchdog to ping it.
+ */
+static __inline__ void
+__ppc4xx_wdt_clear_int_stat(void)
+{
+  mtspr(SPRN_TSR, (TSR_ENW|TSR_WIS));
+}
+/**
+ *	__ppc4xx_wdt_set_timeout:
+ *	@t:	the new time out value that needs to be set.
+ *
+ *	Set a new time out value for the watchdog device.
+ *
+ */
+static __inline__ void
+__ppc4xx_wdt_set_timeout(int t)
+{
+  wdt_count=calculate_wdt_count(t);
+  return;
+}
+
+/*
+ * Driver specific functions
+ */
+
+/**
+ *   ppc4xx_wdt_setup_options
+ *   @cmd_line : a pointer to kernel command line.
+ *
+ */
+void
+ppc4xx_wdt_setup_options(char *cmd_line)
+{
+/*
+ * Look for wdt= option on command line
+ */
+  if (strstr(cmd_line, "wdt=")) {
+    int valid_wdt = 0;
+    char *p, *q;
+
+    for (q = cmd_line; (p = strstr(q, "wdt=")) != 0;) {
+      q = p + 4;
+      if (p > cmd_line && p[-1] != ' ')
+	continue;
+      wdt_period = simple_strtoul(q, &q, 0);
+      valid_wdt = 1;
+      ++q;
+    }
+    wdt_enable = valid_wdt;
+  }
+  return;
+}
+/**
+ *	ppc4xx_wdt_heartbeat:
+ *      Ping routine called from kernel.
+ */
+void
+ppc4xx_wdt_heartbeat(void)
+{
+  /* Disable watchdog */
+  __ppc4xx_wdt_disable();
+
+  /* Write a watchdog value */
+  __ppc4xx_wdt_clear_int_stat();
+
+  if (!wdt_enable)
+    goto out;
+
+  if  (wdt_heartbeat_count > 0)
+    wdt_heartbeat_count--;
+  else
+    panic(ppc4xx_mkmsg("Initiating system reboot.\n"));
+
+  /* Enable watchdog */
+  __ppc4xx_wdt_enable();
+ out:
+  /*  Reset count  */
+  ppc_md.heartbeat_count = 0;
+}
+

+/*
+ *	Driver Logic functions
+ */
+static __inline__ int
+ppc4xx_wdt_is_enabled(void)
+{
+  return  __ppc4xx_wdt_is_enabled();
+}
+/**
+ *	ppc4xx_wdt_start:
+ *
+ *	Start the watchdog driver.
+ */
+static __inline__ int
+ppc4xx_wdt_start(void)
+{
+  __ppc4xx_wdt_enable();
+  return 0;
+}
+
+/**
+ *	ppc4xx_wdt_stop:
+ *
+ *	Stop the watchdog driver.
+ */
+static __inline__ int
+ppc4xx_wdt_stop (void)
+{
+  __ppc4xx_wdt_disable();
+  return 0;
+}
+/**
+ *	ppc4xx_wdt_ping:
+ *
+ *	Reload counter one with the watchdog heartbeat. We don't bother
reloading
+ *	the cascade counter.
+ */
+static __inline__ int
+ppc4xx_wdt_ping(void)
+{
+  /* Disable watchdog */
+  __ppc4xx_wdt_disable();
+  /* Write a watchdog value */
+  __ppc4xx_wdt_clear_int_stat();
+  /*  Reset count  */
+  wdt_heartbeat_count=wdt_count;
+  /* Enable watchdog */
+  __ppc4xx_wdt_enable();
+
+  return 0;
+}
+/**
+ *	ppc4xx_wdt_set_timeout:
+ *	@t:		the new timeout value that needs to be set.
+ *
+ *	Set a new time out value for the watchdog device.
+ *      If the heartbeat value is incorrect we keep the old value
+ *      and return -EINVAL. If successfull we return 0.
+ */
+static __inline__ int
+ppc4xx_wdt_set_timeout(int t)
+{
+  if ((t < WDT_HEARTBEAT_MIN) || (t > WDT_HEARTBEAT_MAX))
+    return -EINVAL;
+
+  wdt_period = t;
+  __ppc4xx_wdt_set_timeout(t);
+  wdt_heartbeat_count=wdt_count;
+  ppc4xx_wdt_dbg("The WDT counter set %d.\n",wdt_count);
+
+  return 0;
+}
+
+/**
+ *	ppc4xx_wdt_get_status:
+ *	@status: the new status.
+ *
+ *	Return the enable/disable card status.
+ */
+static __inline__ int
+ppc4xx_wdt_get_status(int *status)
+{
+  if (wdt_enable)
+	  *status = WDIOS_ENABLECARD;
+  else
+	  *status = WDIOS_DISABLECARD;
+
+  return 0;
+}
+/*
+ *	Kernel Interfaces
+ */
+/**
+ *	ppc4xx_wdt_init_device:
+ *
+ *      Initilize PowerPC 4xx family Watch Dog facility.
+ */
+static void
+ppc4xx_wdt_init_device(void)
+{
+        /* Hardware WDT provided by the processor.
+	 * So, we set firmware version as processor version number.
+	 */
+	ident.firmware_version=mfspr(PVR);
+	__ppc4xx_wdt_setup_val(WDT_WP,WDT_RESET_NONE);
+}
+/**
+ *	ppc4xx_wdt_write:
+ *	@file: file handle to the watchdog
+ *	@buf: buffer to write (unused as data does not matter here
+ *	@count: count of bytes
+ *	@ppos: pointer to the position to write. No seeks allowed
+ *
+ *	A write to a watchdog device is defined as a keepalive signal. Any
+ *	write of data will do, as we we don't define content meaning expept
+ *      'V' character. It is performed as a sign to set stop-on-close mode.
+ */
+
+static ssize_t
+ppc4xx_wdt_write(struct file *file, const char *buf, size_t count, loff_t
*ppos)
+{
+  size_t i;
+
+    if (!nowayout) {
+      /* In case it was set long ago */
+      clear_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+
+      for (i = 0; i < count; i++) {
+	char c;
+
+	if (get_user(c, buf + i))
+	  return -EFAULT;
+
+	if (c == 'V') {
+	  set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+	}
+      }
+    }
+    ppc4xx_wdt_ping();
+
+  return count;
+}
+
+/**
+ *	ppc4xx_wdt_ioctl:
+ *	@inode: inode of the device
+ *	@file: file handle to the device
+ *	@cmd: watchdog command
+ *	@arg: argument pointer
+ *
+ */
+static int
+ppc4xx_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	unsigned long arg)
+{
+	int new_timeout;
+	int status;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;  /*  It may be too strict manner.  */
+	switch(cmd)
+	{
+	default:
+		return -ENOIOCTLCMD;
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user((struct watchdog_info *)arg, &ident,
sizeof(struct watchdog_info)))
+			return -EFAULT;
+		else
+			break;
+	case WDIOC_GETSTATUS:
+		ppc4xx_wdt_get_status(&status);
+		return put_user(status,(int *)arg);
+	case WDIOC_KEEPALIVE:
+		ppc4xx_wdt_ping();
+		break;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_timeout, (int *)arg))
+			return -EFAULT;
+		if (ppc4xx_wdt_set_timeout(new_timeout))
+			return -EINVAL;
+		ppc4xx_wdt_ping();
+		break;
+	case WDIOC_GETTIMEOUT:
+		return put_user(wdt_period, (int *)arg);
+	case WDIOC_SETOPTIONS:
+		if (get_user(status, (int *)arg))
+			return -EFAULT;
+		/*  Return -EINVAL when the driver can not figure out
+		 *  what it should do. Unknown cases are just ignored.
+		 */
+		if ( (status & (WDIOS_DISABLECARD|WDIOS_ENABLECARD))
+		     == (WDIOS_DISABLECARD|WDIOS_ENABLECARD) )
+			return -EINVAL;
+		if (status & WDIOS_DISABLECARD) {
+			wdt_enable = 0;
+			ppc4xx_wdt_stop();
+			ppc4xx_wdt_note("Watchdog timer is disabled\n");
+		}
+		if (status & WDIOS_ENABLECARD) {
+			wdt_enable = 1;
+			ppc4xx_wdt_start();
+			ppc4xx_wdt_note("Watchdog timer is enabled\n");
+		}
+		break;
+	}
+	return 0;
+}
+/**
+ *	ppc4xx_wdt_open:
+ *	@inode: inode of device
+ *	@file: file handle to device
+ *
+ *	The watchdog device has been opened. The watchdog device is single
+ *	open and start the WDT timer.
+ */
+static int
+ppc4xx_wdt_open(struct inode *inode, struct file *file)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (test_and_set_bit(WDT_STATE_OPEN, &driver_state))
+		return -EBUSY;
+	/*
+	 * Activate
+	 */
+	ppc4xx_wdt_start();
+	wdt_enable=1;
+
+	if (nowayout)
+	  set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+
+	return 0;
+}
+
+/**
+ *	ppc4xx_wdt_release:
+ *	@inode: inode to board
+ *	@file: file handle to board
+ *
+ */
+static int
+ppc4xx_wdt_release(struct inode *inode, struct file *file)
+{
+  if (test_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state)) {
+      ppc4xx_wdt_note("WDT device is stopped.\n");
+    ppc4xx_wdt_stop();
+    wdt_enable=0;
+  } else {
+    if ( (ppc4xx_wdt_is_enabled()) && (!nowayout) ) {
+      ppc4xx_wdt_note("WDT device may be closed unexpectedly.  WDT will not
stop!\n");
+      ppc4xx_wdt_ping();
+    }
+  }
+  clear_bit(WDT_STATE_OPEN, &driver_state);
+
+  return 0;
+}
+/**
+ *	notify_sys:
+ *	@this: our notifier block
+ *	@code: the event being reported
+ *	@unused: unused
+ *
+ */
+
+static int
+ppc4xx_wdt_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	if(code==SYS_DOWN || code==SYS_HALT) {
+	  /* Turn the card off */
+	  ppc4xx_wdt_stop();
+	}
+	return NOTIFY_DONE;
+}
+
+static struct file_operations ppc4xx_wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= ppc4xx_wdt_write,
+	.ioctl		= ppc4xx_wdt_ioctl,
+	.open		= ppc4xx_wdt_open,
+	.release	= ppc4xx_wdt_release,
+};
+
+static struct miscdevice ppc4xx_wdt_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &ppc4xx_wdt_fops,
+};
+
+/*
+ *	The WDT card needs to know about shutdowns in order to
+ *	turn WDT off.
+ */
+
+static struct notifier_block ppc4xx_wdt_notifier = {
+	.notifier_call = ppc4xx_wdt_notify_sys,
+};
+
+/**
+ *	cleanup_module:
+ *
+ *	If your watchdog is set to continue ticking on close and you unload
+ *	it, well it keeps ticking.  You just have to load a new
+ *	module in 60 seconds or reboot.
+ *      This behavior(more over the comments as above) is borrowed from
+ *      Alan cox's driver.
+ */
+
+static void __exit
+ppc4xx_wdt_exit(void)
+{
+	misc_deregister(&ppc4xx_wdt_miscdev);
+	unregister_reboot_notifier(&ppc4xx_wdt_notifier);
+}
+
+/**
+ * 	ppc4xx_wdt_init:
+ *
+ *	Set up the WDT relevant timer facility.
+ */
+
+static int __init
+ppc4xx_wdt_init(void)
+{
+	int ret;
+	unsigned long flags;
+
+	ret = register_reboot_notifier(&ppc4xx_wdt_notifier);
+	if(ret) {
+	  ppc4xx_wdt_err("Cannot register reboot notifier (err=%d)\n", ret);
+	  return ret;
+	}
+
+	ret = 0;
+	ppc4xx_wdt_init_device();
+	/* Check that the heartbeat value is within it's range ; if not
reset to the default */
+	if (ppc4xx_wdt_set_timeout(wdt_period)) {
+	  if (wdt_period)
+	    ppc4xx_wdt_info("The heartbeat value must be %d < wdt_period <
%d, using 
%d\n",WDT_HEARTBEAT_MIN,WDT_HEARTBEAT_MAX,WDT_TIMO);
+	  ppc4xx_wdt_set_timeout(WDT_TIMO);
+	}
+	
+	local_irq_save(flags); /* Prevent timer interrupt */
+	ppc_md.heartbeat_count = 0;	
+	ppc_md.heartbeat=ppc4xx_wdt_heartbeat;
+	local_irq_restore(flags);
+
+	ppc4xx_wdt_info("PowerPC 4xx Watchdog Driver. period=%d ms
(nowayout=%d)\n",wdt_period, nowayout);
+
+	ret = misc_register(&ppc4xx_wdt_miscdev);
+	if (ret) {
+	  ppc4xx_wdt_err("Cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		goto outmisc;
+	}
+
+	if (wdt_enable) {
+	  ppc4xx_wdt_info("WDT start on boot.\n");
+	  ppc4xx_wdt_start();
+	}
+out:
+	return ret;
+outmisc:
+	unregister_reboot_notifier(&ppc4xx_wdt_notifier);
+	local_irq_save(flags);
+	ppc_md.heartbeat=NULL;
+	ppc_md.heartbeat_count = 0;
+	local_irq_restore(flags);
+	goto out;
+}
+
+module_init(ppc4xx_wdt_init);
+module_exit(ppc4xx_wdt_exit);
+
--- linux-2.6.11-rc5.orig/drivers/char/watchdog/ppc4xx_wdt.h	1970-01-01
09:00:00.000000000 +0900
+++ linux-2.6.11-rc5/drivers/char/watchdog/ppc4xx_wdt.h	2005-02-28
19:33:10.000000000 +0900
@@ -0,0 +1,125 @@
+/*
+ *
+ *    Copyright (c) 2004 Fujitsu Limited
+ *
+ *    Module name: ppc4xx_wdt.h
+ *    Author:      Takeharu KATO<kato.takeharu@jp.fujitsu.com>
+ *    Description:
+ *      Header file for PPC4xx watchdog driver.
+ *
+ *    This program is free software; you can redistribute it and/or
+ *    modify it under the terms of the GNU General Public License
+ *    as published by the Free Software Foundation; either version 2
+ *    of the License, or (at your option) any later version.
+ *
+ *    Neither Takeharu KATO nor Fujitsu Ltd. admit liability nor provide
+ *    warranty for any of this software.
+ *
+ */
+#ifndef _DRIVERS_CHAR_WATCHDOG_PPC4XX_WDT_H
+#define _DRIVERS_CHAR_WATCHDOG_PPC4XX_WDT_H
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/watchdog.h>
+
+/*
+ *  Driver state flags(bit position)
+ */
+#define WDT_STATE_OPEN                  0   /* driver is opend  */
+#define WDT_STATE_STOP_ON_CLOSE         1   /* Stop with close is expected
*/
+/*
+ * Configurations
+ */
+#define WDT_TIMO           60000	/* Default timeout = 60000 ms(1min)
*/
+#define WDT_HEARTBEAT_MIN  100          /* Minimum timeout = 100 ms */
+#define WDT_HEARTBEAT_MAX  600000       /* Maximum timeout =
600000ms(1hour) */
+#ifdef __KERNEL__
+//#define WDT_DEBUG                     /*  Debug switch */
+/*
+ *  Reset type
+ */
+#define WDT_RESET_NONE     0
+#define WDT_RESET_CORE     1
+#define WDT_RESET_CHIP     2
+#define WDT_RESET_SYS      3
+/*
+ *   Bit positions in  TCR register on PPC4xx/e500 series.
+ */
+#define WDT_TCR_WP_BIT     1   /*  WP  bit in TCR (bit[0..1])   */
+#define WDT_TCR_WRC_BIT    3   /*  WRC bit in TCR (bit[2..3])   */
+#define WDT_TCR_WIE_BIT    4   /*  WIE bit in TCR (bit[4])      */
+/*
+ *  TCR[WP] relevant definitions
+ */
+#define WDT_TCR_WP_SHIFT       (31 - WDT_TCR_WP_BIT)
+#define WDT_TCR_WRC_SHIFT      (31 - WDT_TCR_WRC_BIT)
+#define WDT_TCR_WIE_SHIFT      (31 - WDT_TCR_WIE_BIT)
+#define WDT_TCR_WDT_ENABLE     (1<<WDT_TCR_WIE_SHIFT)
+/*  MASK value to obatain TCR[WP]  */
+#define WDT_TCR_WP_MASK        (3<<(WDT_TCR_WP_SHIFT))
+
+/*  Watchdog timer periods can be set on PPC4xx cpus. */
+#if defined(CONFIG_4xx)
+/*
+ *  For PowerPC4xx
+ */
+#define WDT_WP0               0
+#define WDT_WP1               1
+#define WDT_WP2               2
+#define WDT_WP3               3
+#else
+#if defined(CONFIG_E500)
+/*
+ *  For e500 CPU
+ *  Actually, e500 can arbitrary periods can be set,
+ *  But this driver uses fix period value as same as PPC440
+ *  on purpose for simplicity.
+ *  Following values split into WP and WP_EXT parts in ppc4xx_wdt.c.
+ */
+#define WDT_WP0               21
+#define WDT_WP1               25
+#define WDT_WP2               29
+#define WDT_WP3               33
+#define WDT_TCR_WP_BITMSK     0x3  /*  2bit length  */
+#define WDT_TCR_WPEXT_BITMSK  0xf  /*  4bit length  */
+#define WDT_TCR_WPEXT_SHIFT  17
+#else
+#error "PPC4xx WDT Detect invalid configuration(Unknown CPU)"
+#endif  /*  CONFIG_E500  */
+#endif  /*  CONFIG_4xx   */
+/*
+ *  WP relevant values used in our driver.
+ *  Note:WDT period must be more than HZ(Timer ticks)
+ */
+#define WDT_WP                 WDT_WP3
+
+/*
+ *  IOCTL commands for comaptiblity for old driver
+ */
+#define WDIOC_GETPERIOD         WDIOC_GETTIMEOUT
+#define WDIOC_SETPERIOD         WDIOC_SETTIMEOUT
+
+/*
+ *  output messages
+ */
+#define __PPC4xx_WDT_MSG "PPC4xx WDT : "
+#define ppc4xx_mkmsg(str) __PPC4xx_WDT_MSG str
+#define ppc4xx_wdt_info(fmt,arg...) \
+	printk(KERN_INFO __PPC4xx_WDT_MSG fmt,##arg)
+#define ppc4xx_wdt_note(fmt,arg...) \
+	printk(KERN_NOTICE __PPC4xx_WDT_MSG fmt,##arg)
+#define ppc4xx_wdt_err(fmt,arg...) \
+	printk(KERN_ALERT __PPC4xx_WDT_MSG fmt,##arg)
+#define ppc4xx_wdt_crit(fmt,arg...) \
+	printk(KERN_ALERT __PPC4xx_WDT_MSG fmt,##arg)
+#if defined(WDT_DEBUG)
+#define ppc4xx_wdt_dbg(fmt,arg...) \
+	printk(KERN_ALERT __PPC4xx_WDT_MSG fmt,##arg)
+#else
+#define ppc4xx_wdt_dbg(fmt,arg...) \
+        do{}while(0)
+#endif  /*  WDT_DEBUG  */
+
+#endif  /* __KERNEL__  */
+#endif  /*  _DRIVERS_CHAR_WATCHDOG_PPC4XX_WDT_H  */



------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 7, Issue 1
***********************************************
