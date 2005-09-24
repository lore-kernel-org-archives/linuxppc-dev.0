Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id C5FDA683BF
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 08:42:14 +1000 (EST)
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.36 #1 (Debian))
	id 1EJIij-0004z6-00
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 00:42:13 +0200
Date: Sun, 25 Sep 2005 00:42:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509250041530.19163@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH 2/8] apus: clean up apus support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This brings the APUS into 2.6 and cleans up a lot of indirect calls via
the mach_* functions and so allows to remove amiga/ints.c, amiga/time.c
and the the reference to <asm-m68k/machdep.h>.
Move ppc_memstart/ppc_memoffset to apus_setup.c as it's the only user.

---

 arch/ppc/amiga/Makefile         |    6 
 arch/ppc/amiga/config.c         |  383 +++++++++++-----------------------------
 arch/ppc/amiga/ints.c           |  160 ----------------
 arch/ppc/amiga/time.c           |   58 ------
 arch/ppc/mm/init.c              |    3 
 arch/ppc/platforms/apus_setup.c |  267 ++++++++++++---------------
 include/asm-ppc/amigahw.h       |   11 -
 include/asm-ppc/machdep.h       |    4 
 8 files changed, 234 insertions(+), 658 deletions(-)

Index: linux/arch/ppc/amiga/Makefile
===================================================================
--- linux.orig/arch/ppc/amiga/Makefile	2005-09-23 16:56:37.000000000 +0200
+++ linux/arch/ppc/amiga/Makefile	2005-09-23 22:32:17.000000000 +0200
@@ -1,8 +1,8 @@
 #
-# Makefile for Linux arch/m68k/amiga source directory
+# Makefile for Linux arch/ppc/amiga source directory
 #
 
-obj-y		:= config.o amiints.o cia.o time.o bootinfo.o amisound.o \
-			chipram.o amiga_ksyms.o
+obj-y	:= config.o amiints.o cia.o bootinfo.o \
+	   amisound.o chipram.o amiga_ksyms.o
 
 obj-$(CONFIG_AMIGA_PCMCIA) += pcmcia.o
Index: linux/arch/ppc/amiga/config.c
===================================================================
--- linux.orig/arch/ppc/amiga/config.c	2005-09-23 16:56:37.000000000 +0200
+++ linux/arch/ppc/amiga/config.c	2005-09-23 22:32:17.000000000 +0200
@@ -20,11 +20,12 @@
 #include <linux/mm.h>
 #include <linux/kd.h>
 #include <linux/tty.h>
+#include <linux/rtc.h>
 #include <linux/console.h>
 #include <linux/init.h>
-#ifdef CONFIG_ZORRO
+#include <linux/interrupt.h>
 #include <linux/zorro.h>
-#endif
+#include <linux/delay.h>
 
 #include <asm/bootinfo.h>
 #include <asm/setup.h>
@@ -71,29 +72,9 @@ static char amiga_model_name[13] = "Amig
 
 extern char m68k_debug_device[];
 
-static void amiga_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
-/* amiga specific irq functions */
-extern void amiga_init_IRQ (void);
-extern void (*amiga_default_handler[]) (int, void *, struct pt_regs *);
-extern int amiga_request_irq (unsigned int irq,
-			      void (*handler)(int, void *, struct pt_regs *),
-                              unsigned long flags, const char *devname,
-			      void *dev_id);
-extern void amiga_free_irq (unsigned int irq, void *dev_id);
-extern void amiga_enable_irq (unsigned int);
-extern void amiga_disable_irq (unsigned int);
 static void amiga_get_model(char *model);
 static int amiga_get_hardware_list(char *buffer);
 /* amiga specific timer functions */
-static unsigned long amiga_gettimeoffset (void);
-static void a3000_gettod (int *, int *, int *, int *, int *, int *);
-static void a2000_gettod (int *, int *, int *, int *, int *, int *);
-static int amiga_hwclk (int, struct hwclk_time *);
-static int amiga_set_clock_mmss (unsigned long);
-#ifdef CONFIG_AMIGA_FLOPPY
-extern void amiga_floppy_setup(char *, int *);
-#endif
-static void amiga_reset (void);
 extern void amiga_init_sound(void);
 static void amiga_savekmsg_init(void);
 static void amiga_mem_console_write(struct console *co, const char *b,
@@ -101,9 +82,6 @@ static void amiga_mem_console_write(stru
 void amiga_serial_console_write(struct console *co, const char *s,
 				unsigned int count);
 static void amiga_debug_init(void);
-#ifdef CONFIG_HEARTBEAT
-static void amiga_heartbeat(int on);
-#endif
 
 static struct console amiga_console_driver = {
 	.name =		"debug",
@@ -384,48 +362,15 @@ void __init config_amiga(void)
   for (i = 0; i < 4; i++)
     request_resource(&iomem_resource, &((struct resource *)&mb_resources)[i]);
 
-  mach_sched_init      = amiga_sched_init;
-  mach_init_IRQ        = amiga_init_IRQ;
-#ifndef CONFIG_APUS
-  mach_default_handler = &amiga_default_handler;
-  mach_request_irq     = amiga_request_irq;
-  mach_free_irq        = amiga_free_irq;
-  enable_irq           = amiga_enable_irq;
-  disable_irq          = amiga_disable_irq;
-#endif
-  mach_get_model       = amiga_get_model;
-  mach_get_hardware_list = amiga_get_hardware_list;
-  mach_gettimeoffset   = amiga_gettimeoffset;
   if (AMIGAHW_PRESENT(A3000_CLK)){
-    mach_gettod  = a3000_gettod;
     rtc_resource.name = "A3000 RTC";
     request_resource(&iomem_resource, &rtc_resource);
   }
   else{ /* if (AMIGAHW_PRESENT(A2000_CLK)) */
-    mach_gettod  = a2000_gettod;
     rtc_resource.name = "A2000 RTC";
     request_resource(&iomem_resource, &rtc_resource);
   }
 
-  mach_max_dma_address = 0xffffffff; /*
-				      * default MAX_DMA=0xffffffff
-				      * on all machines. If we don't
-				      * do so, the SCSI code will not
-				      * be able to allocate any mem
-				      * for transfers, unless we are
-				      * dealing with a Z2 mem only
-				      * system.                  /Jes
-				      */
-
-  mach_hwclk           = amiga_hwclk;
-  mach_set_clock_mmss  = amiga_set_clock_mmss;
-#ifdef CONFIG_AMIGA_FLOPPY
-  mach_floppy_setup    = amiga_floppy_setup;
-#endif
-  mach_reset           = amiga_reset;
-#ifdef CONFIG_HEARTBEAT
-  mach_heartbeat = amiga_heartbeat;
-#endif
 
   /* Fill in the clock values (based on the 700 kHz E-Clock) */
   amiga_masterclock = 40*amiga_eclock;	/* 28 MHz */
@@ -473,242 +418,141 @@ void __init config_amiga(void)
 	  *(unsigned char *)ZTWO_VADDR(0xde0002) |= 0x80;
 }
 
-static unsigned short jiffy_ticks;
-
-static void __init amiga_sched_init(irqreturn_t (*timer_routine)(int, void *,
-						struct pt_regs *))
-{
-	static struct resource sched_res = {
-	    "timer", 0x00bfd400, 0x00bfd5ff,
-	};
-	jiffy_ticks = (amiga_eclock+HZ/2)/HZ;
-
-	if (request_resource(&mb_resources._ciab, &sched_res))
-	    printk("Cannot allocate ciab.ta{lo,hi}\n");
-	ciab.cra &= 0xC0;   /* turn off timer A, continuous mode, from Eclk */
-	ciab.talo = jiffy_ticks % 256;
-	ciab.tahi = jiffy_ticks / 256;
-
-	/* install interrupt service routine for CIAB Timer A
-	 *
-	 * Please don't change this to use ciaa, as it interferes with the
-	 * SCSI code. We'll have to take a look at this later
-	 */
-	request_irq(IRQ_AMIGA_CIAB_TA, timer_routine, 0, "timer", NULL);
-	/* start timer */
-	ciab.cra |= 0x11;
-}
-
 #define TICK_SIZE 10000
 
-extern unsigned char cia_get_irq_mask(unsigned int irq);
-
-/* This is always executed with interrupts disabled.  */
-static unsigned long amiga_gettimeoffset (void)
-{
-	unsigned short hi, lo, hi2;
-	unsigned long ticks, offset = 0;
-
-	/* read CIA B timer A current value */
-	hi  = ciab.tahi;
-	lo  = ciab.talo;
-	hi2 = ciab.tahi;
-
-	if (hi != hi2) {
-		lo = ciab.talo;
-		hi = hi2;
-	}
-
-	ticks = hi << 8 | lo;
-
-	if (ticks > jiffy_ticks / 2)
-		/* check for pending interrupt */
-		if (cia_get_irq_mask(IRQ_AMIGA_CIAB) & CIA_ICR_TA)
-			offset = 10000;
-
-	ticks = jiffy_ticks - ticks;
-	ticks = (10000 * ticks) / jiffy_ticks;
-
-	return ticks + offset;
-}
-
-static void a3000_gettod (int *yearp, int *monp, int *dayp,
-			  int *hourp, int *minp, int *secp)
-{
-	volatile struct tod3000 *tod = TOD_3000;
-
-	tod->cntrl1 = TOD3000_CNTRL1_HOLD;
-
-	*secp  = tod->second1 * 10 + tod->second2;
-	*minp  = tod->minute1 * 10 + tod->minute2;
-	*hourp = tod->hour1   * 10 + tod->hour2;
-	*dayp  = tod->day1    * 10 + tod->day2;
-	*monp  = tod->month1  * 10 + tod->month2;
-	*yearp = tod->year1   * 10 + tod->year2;
-
-	tod->cntrl1 = TOD3000_CNTRL1_FREE;
-}
-
-static void a2000_gettod (int *yearp, int *monp, int *dayp,
-			  int *hourp, int *minp, int *secp)
-{
-	volatile struct tod2000 *tod = TOD_2000;
-
-	tod->cntrl1 = TOD2000_CNTRL1_HOLD;
-
-	while (tod->cntrl1 & TOD2000_CNTRL1_BUSY)
-		;
-
-	*secp  = tod->second1     * 10 + tod->second2;
-	*minp  = tod->minute1     * 10 + tod->minute2;
-	*hourp = (tod->hour1 & 3) * 10 + tod->hour2;
-	*dayp  = tod->day1        * 10 + tod->day2;
-	*monp  = tod->month1      * 10 + tod->month2;
-	*yearp = tod->year1       * 10 + tod->year2;
-
-	if (!(tod->cntrl3 & TOD2000_CNTRL3_24HMODE)){
-		if (!(tod->hour1 & TOD2000_HOUR1_PM) && *hourp == 12)
-			*hourp = 0;
-		else if ((tod->hour1 & TOD2000_HOUR1_PM) && *hourp != 12)
-			*hourp += 12;
-	}
-
-	tod->cntrl1 &= ~TOD2000_CNTRL1_HOLD;
-}
-
-static int amiga_hwclk(int op, struct hwclk_time *t)
+int amiga_hwclk(int op, struct rtc_time *t)
 {
 	if (AMIGAHW_PRESENT(A3000_CLK)) {
-		volatile struct tod3000 *tod = TOD_3000;
-
-		tod->cntrl1 = TOD3000_CNTRL1_HOLD;
+		tod_3000.cntrl1 = TOD3000_CNTRL1_HOLD;
 
 		if (!op) { /* read */
-			t->sec  = tod->second1 * 10 + tod->second2;
-			t->min  = tod->minute1 * 10 + tod->minute2;
-			t->hour = tod->hour1   * 10 + tod->hour2;
-			t->day  = tod->day1    * 10 + tod->day2;
-			t->wday = tod->weekday;
-			t->mon  = tod->month1  * 10 + tod->month2 - 1;
-			t->year = tod->year1   * 10 + tod->year2;
-			if (t->year <= 69)
-				t->year += 100;
+			t->tm_sec  = tod_3000.second1 * 10 + tod_3000.second2;
+			t->tm_min  = tod_3000.minute1 * 10 + tod_3000.minute2;
+			t->tm_hour = tod_3000.hour1   * 10 + tod_3000.hour2;
+			t->tm_mday = tod_3000.day1    * 10 + tod_3000.day2;
+			t->tm_wday = tod_3000.weekday;
+			t->tm_mon  = tod_3000.month1  * 10 + tod_3000.month2 - 1;
+			t->tm_year = tod_3000.year1   * 10 + tod_3000.year2;
+			if (t->tm_year <= 69)
+				t->tm_year += 100;
 		} else {
-			tod->second1 = t->sec / 10;
-			tod->second2 = t->sec % 10;
-			tod->minute1 = t->min / 10;
-			tod->minute2 = t->min % 10;
-			tod->hour1   = t->hour / 10;
-			tod->hour2   = t->hour % 10;
-			tod->day1    = t->day / 10;
-			tod->day2    = t->day % 10;
-			if (t->wday != -1)
-				tod->weekday = t->wday;
-			tod->month1  = (t->mon + 1) / 10;
-			tod->month2  = (t->mon + 1) % 10;
-			if (t->year >= 100)
-				t->year -= 100;
-			tod->year1   = t->year / 10;
-			tod->year2   = t->year % 10;
+			tod_3000.second1 = t->tm_sec / 10;
+			tod_3000.second2 = t->tm_sec % 10;
+			tod_3000.minute1 = t->tm_min / 10;
+			tod_3000.minute2 = t->tm_min % 10;
+			tod_3000.hour1   = t->tm_hour / 10;
+			tod_3000.hour2   = t->tm_hour % 10;
+			tod_3000.day1    = t->tm_mday / 10;
+			tod_3000.day2    = t->tm_mday % 10;
+			if (t->tm_wday != -1)
+				tod_3000.weekday = t->tm_wday;
+			tod_3000.month1  = (t->tm_mon + 1) / 10;
+			tod_3000.month2  = (t->tm_mon + 1) % 10;
+			if (t->tm_year >= 100)
+				t->tm_year -= 100;
+			tod_3000.year1   = t->tm_year / 10;
+			tod_3000.year2   = t->tm_year % 10;
 		}
 
-		tod->cntrl1 = TOD3000_CNTRL1_FREE;
+		tod_3000.cntrl1 = TOD3000_CNTRL1_FREE;
 	} else /* if (AMIGAHW_PRESENT(A2000_CLK)) */ {
-		volatile struct tod2000 *tod = TOD_2000;
+		int cnt = 5;
 
-		tod->cntrl1 = TOD2000_CNTRL1_HOLD;
-	
-		while (tod->cntrl1 & TOD2000_CNTRL1_BUSY)
-			;
+		tod_2000.cntrl1 = TOD2000_CNTRL1_HOLD;
+
+		while ((tod_2000.cntrl1 & TOD2000_CNTRL1_BUSY) && cnt--) {
+			tod_2000.cntrl1 &= ~TOD2000_CNTRL1_HOLD;
+			udelay(70);
+			tod_2000.cntrl1 |= TOD2000_CNTRL1_HOLD;
+		}
+
+		if (!cnt)
+			printk(KERN_INFO "hwclk: timed out waiting for RTC (0x%x)\n", tod_2000.cntrl1);
 
 		if (!op) { /* read */
-			t->sec  = tod->second1     * 10 + tod->second2;
-			t->min  = tod->minute1     * 10 + tod->minute2;
-			t->hour = (tod->hour1 & 3) * 10 + tod->hour2;
-			t->day  = tod->day1        * 10 + tod->day2;
-			t->wday = tod->weekday;
-			t->mon  = tod->month1      * 10 + tod->month2 - 1;
-			t->year = tod->year1       * 10 + tod->year2;
-			if (t->year <= 69)
-				t->year += 100;
-
-			if (!(tod->cntrl3 & TOD2000_CNTRL3_24HMODE)){
-				if (!(tod->hour1 & TOD2000_HOUR1_PM) && t->hour == 12)
-					t->hour = 0;
-				else if ((tod->hour1 & TOD2000_HOUR1_PM) && t->hour != 12)
-					t->hour += 12;
+			t->tm_sec  = tod_2000.second1     * 10 + tod_2000.second2;
+			t->tm_min  = tod_2000.minute1     * 10 + tod_2000.minute2;
+			t->tm_hour = (tod_2000.hour1 & 3) * 10 + tod_2000.hour2;
+			t->tm_mday = tod_2000.day1        * 10 + tod_2000.day2;
+			t->tm_wday = tod_2000.weekday;
+			t->tm_mon  = tod_2000.month1      * 10 + tod_2000.month2 - 1;
+			t->tm_year = tod_2000.year1       * 10 + tod_2000.year2;
+			if (t->tm_year <= 69)
+				t->tm_year += 100;
+
+			if (!(tod_2000.cntrl3 & TOD2000_CNTRL3_24HMODE)){
+				if (!(tod_2000.hour1 & TOD2000_HOUR1_PM) && t->tm_hour == 12)
+					t->tm_hour = 0;
+				else if ((tod_2000.hour1 & TOD2000_HOUR1_PM) && t->tm_hour != 12)
+					t->tm_hour += 12;
 			}
 		} else {
-			tod->second1 = t->sec / 10;
-			tod->second2 = t->sec % 10;
-			tod->minute1 = t->min / 10;
-			tod->minute2 = t->min % 10;
-			if (tod->cntrl3 & TOD2000_CNTRL3_24HMODE)
-				tod->hour1 = t->hour / 10;
-			else if (t->hour >= 12)
-				tod->hour1 = TOD2000_HOUR1_PM +
-					(t->hour - 12) / 10;
+			tod_2000.second1 = t->tm_sec / 10;
+			tod_2000.second2 = t->tm_sec % 10;
+			tod_2000.minute1 = t->tm_min / 10;
+			tod_2000.minute2 = t->tm_min % 10;
+			if (tod_2000.cntrl3 & TOD2000_CNTRL3_24HMODE)
+				tod_2000.hour1 = t->tm_hour / 10;
+			else if (t->tm_hour >= 12)
+				tod_2000.hour1 = TOD2000_HOUR1_PM +
+					(t->tm_hour - 12) / 10;
 			else
-				tod->hour1 = t->hour / 10;
-			tod->hour2   = t->hour % 10;
-			tod->day1    = t->day / 10;
-			tod->day2    = t->day % 10;
-			if (t->wday != -1)
-				tod->weekday = t->wday;
-			tod->month1  = (t->mon + 1) / 10;
-			tod->month2  = (t->mon + 1) % 10;
-			if (t->year >= 100)
-				t->year -= 100;
-			tod->year1   = t->year / 10;
-			tod->year2   = t->year % 10;
+				tod_2000.hour1 = t->tm_hour / 10;
+			tod_2000.hour2   = t->tm_hour % 10;
+			tod_2000.day1    = t->tm_mday / 10;
+			tod_2000.day2    = t->tm_mday % 10;
+			if (t->tm_wday != -1)
+				tod_2000.weekday = t->tm_wday;
+			tod_2000.month1  = (t->tm_mon + 1) / 10;
+			tod_2000.month2  = (t->tm_mon + 1) % 10;
+			if (t->tm_year >= 100)
+				t->tm_year -= 100;
+			tod_2000.year1   = t->tm_year / 10;
+			tod_2000.year2   = t->tm_year % 10;
 		}
 
-		tod->cntrl1 &= ~TOD2000_CNTRL1_HOLD;
+		tod_2000.cntrl1 &= ~TOD2000_CNTRL1_HOLD;
 	}
 
 	return 0;
 }
 
-static int amiga_set_clock_mmss (unsigned long nowtime)
+int amiga_set_clock_mmss(unsigned long nowtime)
 {
 	short real_seconds = nowtime % 60, real_minutes = (nowtime / 60) % 60;
 
 	if (AMIGAHW_PRESENT(A3000_CLK)) {
-		volatile struct tod3000 *tod = TOD_3000;
-
-		tod->cntrl1 = TOD3000_CNTRL1_HOLD;
+		tod_3000.cntrl1 = TOD3000_CNTRL1_HOLD;
 
-		tod->second1 = real_seconds / 10;
-		tod->second2 = real_seconds % 10;
-		tod->minute1 = real_minutes / 10;
-		tod->minute2 = real_minutes % 10;
+		tod_3000.second1 = real_seconds / 10;
+		tod_3000.second2 = real_seconds % 10;
+		tod_3000.minute1 = real_minutes / 10;
+		tod_3000.minute2 = real_minutes % 10;
 
-		tod->cntrl1 = TOD3000_CNTRL1_FREE;
+		tod_3000.cntrl1 = TOD3000_CNTRL1_FREE;
 	} else /* if (AMIGAHW_PRESENT(A2000_CLK)) */ {
-		volatile struct tod2000 *tod = TOD_2000;
+		int cnt = 5;
 
-		tod->cntrl1 = TOD2000_CNTRL1_HOLD;
-	
-		while (tod->cntrl1 & TOD2000_CNTRL1_BUSY)
-			;
-
-		tod->second1 = real_seconds / 10;
-		tod->second2 = real_seconds % 10;
-		tod->minute1 = real_minutes / 10;
-		tod->minute2 = real_minutes % 10;
+		tod_2000.cntrl1 |= TOD2000_CNTRL1_HOLD;
 
-		tod->cntrl1 &= ~TOD2000_CNTRL1_HOLD;
-	}
+		while ((tod_2000.cntrl1 & TOD2000_CNTRL1_BUSY) && cnt--) {
+			tod_2000.cntrl1 &= ~TOD2000_CNTRL1_HOLD;
+			udelay(70);
+			tod_2000.cntrl1 |= TOD2000_CNTRL1_HOLD;
+		}
 
-	return 0;
-}
+		if (!cnt)
+			printk(KERN_INFO "set_clock_mmss: timed out waiting for RTC (0x%x)\n", tod_2000.cntrl1);
 
-static NORET_TYPE void amiga_reset( void )
-    ATTRIB_NORET;
+		tod_2000.second1 = real_seconds / 10;
+		tod_2000.second2 = real_seconds % 10;
+		tod_2000.minute1 = real_minutes / 10;
+		tod_2000.minute2 = real_minutes % 10;
 
-static void amiga_reset (void)
-{
-  for (;;);
+		tod_2000.cntrl1 &= ~TOD2000_CNTRL1_HOLD;
+	}
+
+	return 0;
 }
 
 
@@ -841,16 +685,6 @@ static void __init amiga_debug_init(void
 	}
 }
 
-#ifdef CONFIG_HEARTBEAT
-static void amiga_heartbeat(int on)
-{
-    if (on)
-	ciaa.pra &= ~2;
-    else
-	ciaa.pra |= 2;
-}
-#endif
-
     /*
      *  Amiga specific parts of /proc
      */
@@ -943,19 +777,14 @@ int get_hardware_list(char *buffer)
 	u_long mem;
 	int i;
 
-	if (mach_get_model)
-		mach_get_model(model);
-	else
-		strcpy(model, "Unknown PowerPC");
+	amiga_get_model(model);
 
 	len += sprintf(buffer+len, "Model:\t\t%s\n", model);
-	len += get_cpuinfo(buffer+len);
+	//len += get_cpuinfo(buffer+len);
 	for (mem = 0, i = 0; i < m68k_realnum_memory; i++)
 		mem += m68k_memory[i].size;
 	len += sprintf(buffer+len, "System Memory:\t%ldK\n", mem>>10);
-
-	if (mach_get_hardware_list)
-		len += mach_get_hardware_list(buffer+len);
+	len += amiga_get_hardware_list(buffer+len);
 
 	return(len);
 }
Index: linux/arch/ppc/amiga/ints.c
===================================================================
--- linux.orig/arch/ppc/amiga/ints.c	2005-09-23 16:56:37.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,160 +0,0 @@
-/*
- *  arch/ppc/amiga/ints.c
- *
- *  Linux/m68k general interrupt handling code from arch/m68k/kernel/ints.c
- *  Needed to drive the m68k emulating IRQ hardware on the PowerUp boards.
- */
-
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/seq_file.h>
-
-#include <asm/setup.h>
-#include <asm/system.h>
-#include <asm/irq.h>
-#include <asm/traps.h>
-#include <asm/page.h>
-#include <asm/machdep.h>
-
-/* table for system interrupt handlers */
-static irq_handler_t irq_list[SYS_IRQS];
-
-static const char *default_names[SYS_IRQS] = {
-	"spurious int", "int1 handler", "int2 handler", "int3 handler",
-	"int4 handler", "int5 handler", "int6 handler", "int7 handler"
-};
-
-/* The number of spurious interrupts */
-volatile unsigned int num_spurious;
-
-#define NUM_IRQ_NODES 100
-static irq_node_t nodes[NUM_IRQ_NODES];
-
-
-/*
- * void init_IRQ(void)
- *
- * Parameters:	None
- *
- * Returns:	Nothing
- *
- * This function should be called during kernel startup to initialize
- * the IRQ handling routines.
- */
-
-__init
-void m68k_init_IRQ(void)
-{
-	int i;
-
-	for (i = 0; i < SYS_IRQS; i++) {
-		if (mach_default_handler)
-			irq_list[i].handler = (*mach_default_handler)[i];
-		irq_list[i].flags   = 0;
-		irq_list[i].dev_id  = NULL;
-		irq_list[i].devname = default_names[i];
-	}
-
-	for (i = 0; i < NUM_IRQ_NODES; i++)
-		nodes[i].handler = NULL;
-
-	mach_init_IRQ ();
-}
-
-irq_node_t *new_irq_node(void)
-{
-	irq_node_t *node;
-	short i;
-
-	for (node = nodes, i = NUM_IRQ_NODES-1; i >= 0; node++, i--)
-		if (!node->handler)
-			return node;
-
-	printk ("new_irq_node: out of nodes\n");
-	return NULL;
-}
-
-int sys_request_irq(unsigned int irq,
-                    void (*handler)(int, void *, struct pt_regs *),
-                    unsigned long flags, const char *devname, void *dev_id)
-{
-	if (irq < IRQ1 || irq > IRQ7) {
-		printk("%s: Incorrect IRQ %d from %s\n",
-		       __FUNCTION__, irq, devname);
-		return -ENXIO;
-	}
-
-#if 0
-	if (!(irq_list[irq].flags & IRQ_FLG_STD)) {
-		if (irq_list[irq].flags & IRQ_FLG_LOCK) {
-			printk("%s: IRQ %d from %s is not replaceable\n",
-			       __FUNCTION__, irq, irq_list[irq].devname);
-			return -EBUSY;
-		}
-		if (!(flags & IRQ_FLG_REPLACE)) {
-			printk("%s: %s can't replace IRQ %d from %s\n",
-			       __FUNCTION__, devname, irq, irq_list[irq].devname);
-			return -EBUSY;
-		}
-	}
-#endif
-
-	irq_list[irq].handler = handler;
-	irq_list[irq].flags   = flags;
-	irq_list[irq].dev_id  = dev_id;
-	irq_list[irq].devname = devname;
-	return 0;
-}
-
-void sys_free_irq(unsigned int irq, void *dev_id)
-{
-	if (irq < IRQ1 || irq > IRQ7) {
-		printk("%s: Incorrect IRQ %d\n", __FUNCTION__, irq);
-		return;
-	}
-
-	if (irq_list[irq].dev_id != dev_id)
-		printk("%s: Removing probably wrong IRQ %d from %s\n",
-		       __FUNCTION__, irq, irq_list[irq].devname);
-
-	irq_list[irq].handler = (*mach_default_handler)[irq];
-	irq_list[irq].flags   = 0;
-	irq_list[irq].dev_id  = NULL;
-	irq_list[irq].devname = default_names[irq];
-}
-
-asmlinkage void process_int(unsigned long vec, struct pt_regs *fp)
-{
-	if (vec >= VEC_INT1 && vec <= VEC_INT7 && !MACH_IS_BVME6000) {
-		vec -= VEC_SPUR;
-		kstat_cpu(0).irqs[vec]++;
-		irq_list[vec].handler(vec, irq_list[vec].dev_id, fp);
-	} else {
-		if (mach_process_int)
-			mach_process_int(vec, fp);
-		else
-			panic("Can't process interrupt vector %ld\n", vec);
-		return;
-	}
-}
-
-int m68k_get_irq_list(struct seq_file *p, void *v)
-{
-	int i;
-
-	/* autovector interrupts */
-	if (mach_default_handler) {
-		for (i = 0; i < SYS_IRQS; i++) {
-			seq_printf(p, "auto %2d: %10u ", i,
-			               i ? kstat_cpu(0).irqs[i] : num_spurious);
-			seq_puts(p, "  ");
-			seq_printf(p, "%s\n", irq_list[i].devname);
-		}
-	}
-
-	mach_get_irq_list(p, v);
-	return 0;
-}
Index: linux/arch/ppc/amiga/time.c
===================================================================
--- linux.orig/arch/ppc/amiga/time.c	2005-09-23 16:56:37.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,58 +0,0 @@
-#include <linux/config.h> /* CONFIG_HEARTBEAT */
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-
-#include <asm/machdep.h>
-#include <asm/io.h>
-
-#include <linux/timex.h>
-
-unsigned long m68k_get_rtc_time(void)
-{
-	unsigned int year, mon, day, hour, min, sec;
-
-	extern void arch_gettod(int *year, int *mon, int *day, int *hour,
-				int *min, int *sec);
-
-	arch_gettod (&year, &mon, &day, &hour, &min, &sec);
-
-	if ((year += 1900) < 1970)
-		year += 100;
-
-	return mktime(year, mon, day, hour, min, sec);
-}
-
-int m68k_set_rtc_time(unsigned long nowtime)
-{
-  if (mach_set_clock_mmss)
-    return mach_set_clock_mmss (nowtime);
-  return -1;
-}
-
-void apus_heartbeat (void)
-{
-#ifdef CONFIG_HEARTBEAT
-	static unsigned cnt = 0, period = 0, dist = 0;
-
-	if (cnt == 0 || cnt == dist)
-                mach_heartbeat( 1 );
-	else if (cnt == 7 || cnt == dist+7)
-                mach_heartbeat( 0 );
-
-	if (++cnt > period) {
-                cnt = 0;
-                /* The hyperbolic function below modifies the heartbeat period
-                 * length in dependency of the current (5min) load. It goes
-                 * through the points f(0)=126, f(1)=86, f(5)=51,
-                 * f(inf)->30. */
-                period = ((672<<FSHIFT)/(5*avenrun[0]+(7<<FSHIFT))) + 30;
-                dist = period / 4;
-	}
-#endif
-	/* should be made smarter */
-	ppc_md.heartbeat_count = 1;
-}
Index: linux/arch/ppc/mm/init.c
===================================================================
--- linux.orig/arch/ppc/mm/init.c	2005-09-23 16:56:30.000000000 +0200
+++ linux/arch/ppc/mm/init.c	2005-09-24 01:04:26.000000000 +0200
@@ -61,9 +61,6 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_ga
 unsigned long total_memory;
 unsigned long total_lowmem;
 
-unsigned long ppc_memstart;
-unsigned long ppc_memoffset = PAGE_OFFSET;
-
 int mem_init_done;
 int init_bootmem_done;
 int boot_mapsize;
Index: linux/arch/ppc/platforms/apus_setup.c
===================================================================
--- linux.orig/arch/ppc/platforms/apus_setup.c	2005-09-23 16:56:37.000000000 +0200
+++ linux/arch/ppc/platforms/apus_setup.c	2005-09-23 22:32:17.000000000 +0200
@@ -17,11 +17,14 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/initrd.h>
+#include <linux/module.h>
 #include <linux/seq_file.h>
 
 /* Needs INITSERIAL call in head.S! */
-#undef APUS_DEBUG
+#define APUS_DEBUG
 
 #include <asm/bootinfo.h>
 #include <asm/setup.h>
@@ -32,52 +35,25 @@
 #include <asm/dma.h>
 #include <asm/machdep.h>
 #include <asm/time.h>
+#include <asm/tlbflush.h>
 
 unsigned long m68k_machtype;
 char debug_device[6] = "";
 
-extern void amiga_init_IRQ(void);
-
-extern void apus_setup_pci_ptrs(void);
-
-void (*mach_sched_init) (void (*handler)(int, void *, struct pt_regs *)) __initdata = NULL;
-/* machine dependent irq functions */
-void (*mach_init_IRQ) (void) __initdata = NULL;
-void (*(*mach_default_handler)[]) (int, void *, struct pt_regs *) = NULL;
-void (*mach_get_model) (char *model) = NULL;
-int (*mach_get_hardware_list) (char *buffer) = NULL;
-int (*mach_get_irq_list) (struct seq_file *, void *) = NULL;
-void (*mach_process_int) (int, struct pt_regs *) = NULL;
-/* machine dependent timer functions */
-unsigned long (*mach_gettimeoffset) (void);
-void (*mach_gettod) (int*, int*, int*, int*, int*, int*);
-int (*mach_hwclk) (int, struct hwclk_time*) = NULL;
-int (*mach_set_clock_mmss) (unsigned long) = NULL;
-void (*mach_reset)( void );
-long mach_max_dma_address = 0x00ffffff; /* default set to the lower 16MB */
-#if defined(CONFIG_AMIGA_FLOPPY)
-void (*mach_floppy_setup) (char *, int *) __initdata = NULL;
-#endif
-#ifdef CONFIG_HEARTBEAT
-void (*mach_heartbeat) (int) = NULL;
-extern void apus_heartbeat (void);
-#endif
-
-extern unsigned long amiga_model;
-extern unsigned decrementer_count;/* count value for 1e6/HZ microseconds */
-extern unsigned count_period_num; /* 1 decrementer count equals */
-extern unsigned count_period_den; /* count_period_num / count_period_den us */
-
 int num_memory = 0;
 struct mem_info memory[NUM_MEMINFO];/* memory description */
 /* FIXME: Duplicate memory data to avoid conflicts with m68k shared code. */
 int m68k_realnum_memory = 0;
 struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 
-struct mem_info ramdisk;
+unsigned long ppc_memstart;
+unsigned long ppc_pgstart;
+unsigned long ppc_memoffset;
+
+EXPORT_SYMBOL(ppc_memoffset);
+EXPORT_SYMBOL(ppc_pgstart);
 
-extern void amiga_floppy_setup(char *, int *);
-extern void config_amiga(void);
+struct mem_info ramdisk;
 
 static int __60nsram = 0;
 
@@ -92,25 +68,43 @@ static int __speed_test_failed = 0;
  */
 unsigned long apus_get_rtc_time(void)
 {
-#ifdef CONFIG_APUS
-	extern unsigned long m68k_get_rtc_time(void);
+	struct rtc_time t;
 
-	return m68k_get_rtc_time ();
-#else
-	return 0;
-#endif
+	amiga_hwclk(0, &t);
+	t.tm_year += 1900;
+
+	return mktime(t.tm_year, t.tm_mon, t.tm_mday,
+		      t.tm_hour, t.tm_min, t.tm_sec);
 }
 
 int apus_set_rtc_time(unsigned long nowtime)
 {
-#ifdef CONFIG_APUS
-	extern int m68k_set_rtc_time(unsigned long nowtime);
+	return amiga_set_clock_mmss(nowtime);
+}
 
-	return m68k_set_rtc_time (nowtime);
-#else
-	return 0;
-#endif
+#ifdef CONFIG_HEARTBEAT
+static void apus_heartbeat(void)
+{
+	static unsigned cnt = 0, period = 0, dist = 0;
+
+	if (cnt == 0 || cnt == dist)
+		ciaa.pra &= ~2;
+	else if (cnt == 7 || cnt == dist + 7)
+		ciaa.pra |= 2;
+
+	if (++cnt > period) {
+		cnt = 0;
+		/* The hyperbolic function below modifies the heartbeat period
+		 * length in dependency of the current (5min) load. It goes
+		 * through the points f(0)=126, f(1)=86, f(5)=51,
+		 * f(inf)->30. */
+		period = ((672<<FSHIFT) / (5*avenrun[0] + (7<<FSHIFT))) + 30;
+		dist = period / 4;
+	}
+	/* should be made smarter */
+	ppc_md.heartbeat_count = 1;
 }
+#endif
 
 /*********************************************************** SETUP */
 /* From arch/m68k/kernel/setup.c. */
@@ -206,8 +200,8 @@ static void get_current_tb(unsigned long
 
 void apus_calibrate_decr(void)
 {
-#ifdef CONFIG_APUS
 	unsigned long freq;
+	unsigned int tmp;
 
 	/* This algorithm for determining the bus speed was
            contributed by Ralph Schmidt. */
@@ -239,15 +233,34 @@ void apus_calibrate_decr(void)
 		freq = 15000000;
 	} else if ((bus_speed >= 63) && (bus_speed < 69)) {
 		bus_speed = 67;
-		freq = 16666667;
+		freq = 16500000;
 	} else {
 		printk ("APUS: Unable to determine bus speed (%d). "
-			"Defaulting to 50MHz", bus_speed);
+			"Defaulting to 50MHz\n", bus_speed);
 		bus_speed = 50;
 		freq = 12500000;
 		speed_test_failed = 1;
 	}
 
+	ciab.cra = (ciab.cra & 0xc0) | 0x08;
+	ciab.icr;
+	wmb();
+	ciab.talo = 0;
+	wmb();
+	ciab.tahi = 0x80;
+	wmb();
+
+	get_current_tb(&start);
+	while (!(ciab.icr & 1))
+		barrier();
+	get_current_tb(&stop);
+
+	tmp = stop - start;
+	start = tmp * amiga_eclock;
+	stop = mulhwu(tmp, amiga_eclock);
+	start += stop << 32;
+	freq = start / 0x8000;
+
 	/* Ease diagnostics... */
 	{
 		extern int __map_without_bats;
@@ -285,36 +298,8 @@ void apus_calibrate_decr(void)
 
 	__bus_speed = bus_speed;
 	__speed_test_failed = speed_test_failed;
-#endif
-}
-
-void arch_gettod(int *year, int *mon, int *day, int *hour,
-		 int *min, int *sec)
-{
-#ifdef CONFIG_APUS
-	if (mach_gettod)
-		mach_gettod(year, mon, day, hour, min, sec);
-	else
-		*year = *mon = *day = *hour = *min = *sec = 0;
-#endif
 }
 
-/* for "kbd-reset" cmdline param */
-__init
-void kbd_reset_setup(char *str, int *ints)
-{
-}
-
-/*********************************************************** FLOPPY */
-#if defined(CONFIG_AMIGA_FLOPPY)
-__init
-void floppy_setup(char *str, int *ints)
-{
-	if (mach_floppy_setup)
-		mach_floppy_setup (str, ints);
-}
-#endif
-
 /*********************************************************** MEMORY */
 #define KMAP_MAX 32
 unsigned long kmap_chunks[KMAP_MAX*3];
@@ -330,26 +315,22 @@ static __inline__ pte_t *my_find_pte(str
 	va &= PAGE_MASK;
 
 	dir = pgd_offset( mm, va );
-	if (dir)
-	{
+	if (dir) {
 		pmd = pmd_offset(dir, va & PAGE_MASK);
 		if (pmd && pmd_present(*pmd))
-		{
-			pte = pte_offset(pmd, va);
-		}
+			pte = pte_offset_kernel(pmd, va);
 	}
 	return pte;
 }
 
 
 /* Again simulating an m68k/mm/kmap.c function. */
-void kernel_set_cachemode( unsigned long address, unsigned long size,
-			   unsigned int cmode )
+void kernel_set_cachemode(unsigned long address, unsigned long size,
+			  unsigned int cmode)
 {
-	unsigned long mask, flags;
+	unsigned long mask, flags, end;
 
-	switch (cmode)
-	{
+	switch (cmode) {
 	case IOMAP_FULL_CACHING:
 		mask = ~(_PAGE_NO_CACHE | _PAGE_GUARDED);
 		flags = 0;
@@ -359,60 +340,29 @@ void kernel_set_cachemode( unsigned long
 		flags = (_PAGE_NO_CACHE | _PAGE_GUARDED);
 		break;
 	default:
-		panic ("kernel_set_cachemode() doesn't support mode %d\n",
-		       cmode);
+		panic("kernel_set_cachemode() doesn't support mode %d\n", cmode);
 		break;
 	}
 
-	size /= PAGE_SIZE;
+	end = address + size;
 	address &= PAGE_MASK;
-	while (size--)
-	{
+	while (address < end) {
 		pte_t *pte;
 
 		pte = my_find_pte(&init_mm, address);
-		if ( !pte )
-		{
+		if (!pte) {
 			printk("pte NULL in kernel_set_cachemode()\n");
 			return;
 		}
 
-                pte_val (*pte) &= mask;
-                pte_val (*pte) |= flags;
+                pte_val(*pte) &= mask;
+                pte_val(*pte) |= flags;
                 flush_tlb_page(find_vma(&init_mm,address),address);
 
 		address += PAGE_SIZE;
 	}
 }
 
-unsigned long mm_ptov (unsigned long paddr)
-{
-	unsigned long ret;
-	if (paddr < 16*1024*1024)
-		ret = ZTWO_VADDR(paddr);
-	else {
-		int i;
-
-		for (i = 0; i < kmap_chunk_count;){
-			unsigned long phys = kmap_chunks[i++];
-			unsigned long size = kmap_chunks[i++];
-			unsigned long virt = kmap_chunks[i++];
-			if (paddr >= phys
-			    && paddr < (phys + size)){
-				ret = virt + paddr - phys;
-				goto exit;
-			}
-		}
-
-		ret = (unsigned long) __va(paddr);
-	}
-exit:
-#ifdef DEBUGPV
-	printk ("PTOV(%lx)=%lx\n", paddr, ret);
-#endif
-	return ret;
-}
-
 int mm_end_of_chunk (unsigned long addr, int len)
 {
 	if (memory[0].addr + memory[0].size == addr + len)
@@ -422,11 +372,10 @@ int mm_end_of_chunk (unsigned long addr,
 
 /*********************************************************** CACHE */
 
-#define L1_CACHE_BYTES 32
 #define MAX_CACHE_SIZE 8192
-void cache_push(__u32 addr, int length)
+void cache_push(u32 paddr, int length)
 {
-	addr = mm_ptov(addr);
+	char *addr = __va(paddr);
 
 	if (MAX_CACHE_SIZE < length)
 		length = MAX_CACHE_SIZE;
@@ -443,12 +392,14 @@ void cache_push(__u32 addr, int length)
 	       : : "r" (addr));
 }
 
-void cache_clear(__u32 addr, int length)
+void cache_clear(u32 paddr, int length)
 {
+	char *addr;
+
 	if (MAX_CACHE_SIZE < length)
 		length = MAX_CACHE_SIZE;
 
-	addr = mm_ptov(addr);
+	addr = __va(paddr);
 
 	__asm ("dcbf 0,%0\n\t"
 	       "sync \n\t"
@@ -518,6 +469,8 @@ int apus_get_irq(struct pt_regs* regs)
 	level = (ipl_emu >> 3) & IPLEMU_IPLMASK;
 	mask = IPLEMU_SETRESET|IPLEMU_DISABLEINT|level;
 	level ^= 7;
+	if (!level)
+		return -1;
 
 	/* Save previous IPL value */
 	if (last_ipl[level])
@@ -535,6 +488,15 @@ int apus_get_irq(struct pt_regs* regs)
 	return level + IRQ_AMIGA_AUTO;
 }
 
+unsigned int apus_startup_irq(unsigned int irq)
+{
+	return 0;
+}
+
+void apus_ack_irq(unsigned int irq)
+{
+}
+
 void apus_end_irq(unsigned int irq)
 {
 	unsigned char ipl_emu;
@@ -646,10 +608,12 @@ void __debug_print_string(char* s)
 	__debug_ser_out('\r');
 }
 
+#ifdef APUS_DEBUG
 static void apus_progress(char *s, unsigned short value)
 {
 	__debug_print_string(s);
 }
+#endif
 
 /****************************************************** init */
 
@@ -664,6 +628,8 @@ extern void amiga_disable_irq(unsigned i
 
 struct hw_interrupt_type amiga_sys_irqctrl = {
 	.typename = "Amiga IPL",
+	.startup = apus_startup_irq,
+	.ack = apus_ack_irq,
 	.end = apus_end_irq,
 };
 
@@ -677,33 +643,32 @@ struct hw_interrupt_type amiga_irqctrl =
 unsigned long __init apus_find_end_of_memory(void)
 {
 	int shadow = 0;
-	unsigned long total;
+	unsigned long total, size;
 
 	/* The memory size reported by ADOS excludes the 512KB
 	   reserved for PPC exception registers and possibly 512KB
 	   containing a shadow of the ADOS ROM. */
-	{
-		unsigned long size = memory[0].size;
-
-		/* If 2MB aligned, size was probably user
-                   specified. We can't tell anything about shadowing
-                   in this case so skip shadow assignment. */
-		if (0 != (size & 0x1fffff)){
-			/* Align to 512KB to ensure correct handling
-			   of both memfile and system specified
-			   sizes. */
-			size = ((size+0x0007ffff) & 0xfff80000);
-			/* If memory is 1MB aligned, assume
-                           shadowing. */
-			shadow = !(size & 0x80000);
-		}
+	size = memory[0].size;
 
-		/* Add the chunk that ADOS does not see. by aligning
-                   the size to the nearest 2MB limit upwards.  */
-		memory[0].size = ((size+0x001fffff) & 0xffe00000);
-	}
+	/* If 2MB aligned, size was probably user
+	   specified. We can't tell anything about shadowing
+	   in this case so skip shadow assignment. */
+	if (size & 0x1fffff){
+		/* Align to 512KB to ensure correct handling
+		   of both memfile and system specified
+		   sizes. */
+		size = ((size+0x0007ffff) & 0xfff80000);
+		/* If memory is 1MB aligned, assume
+		   shadowing. */
+		shadow = !(size & 0x80000);
+	}
+
+	/* Add the chunk that ADOS does not see. by aligning
+	   the size to the nearest 2MB limit upwards.  */
+	memory[0].size = (size + 0x001fffff) & 0xffe00000;
 
 	ppc_memstart = memory[0].addr;
+	ppc_pgstart = memory[0].addr >> PAGE_SHIFT;
 	ppc_memoffset = PAGE_OFFSET - PPC_MEMSTART;
 	total = memory[0].size;
 
Index: linux/include/asm-ppc/amigahw.h
===================================================================
--- linux.orig/include/asm-ppc/amigahw.h	2005-09-23 16:56:37.000000000 +0200
+++ linux/include/asm-ppc/amigahw.h	2005-09-23 22:32:17.000000000 +0200
@@ -1,6 +1,6 @@
-#ifdef __KERNEL__
 #ifndef __ASMPPC_AMIGAHW_H
 #define __ASMPPC_AMIGAHW_H
+#ifdef __KERNEL__
 
 #include <linux/config.h>
 #include <asm-m68k/amigahw.h>
@@ -12,6 +12,13 @@
 #define CHIP_PHYSADDR      (0x004000)
 #endif
 
+struct rtc_time;
+
+extern void amiga_init_IRQ(void);
+extern int amiga_hwclk(int, struct rtc_time *);
+extern int amiga_set_clock_mmss (unsigned long nowtime);
+extern void config_amiga(void);
+extern void apus_setup_pci_ptrs(void);
 
-#endif /* __ASMPPC_AMIGAHW_H */
 #endif /* __KERNEL__ */
+#endif /* __ASMPPC_AMIGAHW_H */
Index: linux/include/asm-ppc/machdep.h
===================================================================
--- linux.orig/include/asm-ppc/machdep.h	2005-09-23 16:56:37.000000000 +0200
+++ linux/include/asm-ppc/machdep.h	2005-09-23 22:32:17.000000000 +0200
@@ -9,10 +9,6 @@
 #include <asm/setup.h>
 #include <asm/page.h>
 
-#ifdef CONFIG_APUS
-#include <asm-m68k/machdep.h>
-#endif
-
 struct pt_regs;
 struct pci_bus;	
 struct pci_dev;
