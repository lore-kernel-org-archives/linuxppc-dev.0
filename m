Date: Sun, 12 Jan 2003 12:29:10 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Generic RTC driver in 2.4.x (fwd)
Message-ID: <Pine.GSO.4.21.0301121228560.18673-200000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="Boundary-00=_WWHI+IE+7Hhk3eF"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary-00=_WWHI+IE+7Hhk3eF
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.21.0301121228562.18673@vervain.sonytel.be>
Content-Disposition: INLINE


FYI...

---------- Forwarded message ----------
Date: Sat, 11 Jan 2003 20:50:46 +0100
From: Helge Deller <deller@gmx.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
     Alan Cox <alan@lxorguk.ukuu.org.uk>, parisc-linux@parisc-linux.org
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Generic RTC driver in 2.4.x

On Friday 10 January 2003 21:05, Geert Uytterhoeven wrote:
> Unfortunately I didn't receive any feedback from the pa-risc and ppc people
> after my previous posting last Sunday.

Hi Geert,

It took me some time, but here are the PA-RISC specific patches vs. your
latest genrtc driver.

Please consider applying,
Helge

ChangeLog:
- small indenting fixes,
- new driver version number
- more "static" functions
- C99 named initializers
- added RTC_BATT_BAD capatibility flag (for the procfs-interface),
- get_rtc_time() now returns the "capatibilities" value (e.g. RTC_BATT_BAD | RTC_24H)
[this means, the m86k get_rtc_time() function has to return a value too.


--Boundary-00=_WWHI+IE+7Hhk3eF
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; NAME="genrtc.patch"
Content-ID: <Pine.GSO.4.21.0301121228563.18673@vervain.sonytel.be>
Content-Description: 
Content-Disposition: INLINE; FILENAME="genrtc.patch"

--- ./drivers/char/genrtc.c.geert	Sat Jan 11 18:14:50 2003
+++ ./drivers/char/genrtc.c	Sat Jan 11 20:36:28 2003
@@ -1,5 +1,8 @@
 /*
- *	Real Time Clock interface for q40 and other m68k machines
+ *	Real Time Clock interface for
+ *		- q40 and other m68k machines,
+ *		- HP PARISC machines
+ *		- PowerPC machines
  *      emulate some RTC irq capabilities in software
  *
  *      Copyright (C) 1999 Richard Zidlicky
@@ -13,7 +16,7 @@
  *	pseudo-file for status information.
  *
  *	The ioctls can be used to set the interrupt behaviour where
- *  supported.
+ *	supported.
  *
  *	The /dev/rtc interface will block on reads until an interrupt
  *	has been received. If a RTC interrupt has already happened,
@@ -34,9 +37,10 @@
  *      1.04 removed useless timer code       rz@linux-m68k.org
  *      1.05 portable RTC_UIE emulation       rz@linux-m68k.org
  *      1.06 set_rtc_time can return an error trini@kernel.crashing.org
+ *      1.07 ported to HP PARISC (hppa)	      Helge Deller <deller@gmx.de>
  */

-#define RTC_VERSION	"1.06"
+#define RTC_VERSION	"1.07"

 #include <linux/module.h>
 #include <linux/config.h>
@@ -71,11 +75,11 @@

 #define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/

-unsigned char gen_rtc_status;		/* bitmapped status byte.	*/
-unsigned long gen_rtc_irq_data;		/* our output to the world	*/
+static unsigned char gen_rtc_status;	/* bitmapped status byte.	*/
+static unsigned long gen_rtc_irq_data;	/* our output to the world	*/

 /* months start at 0 now */
-unsigned char days_in_mo[] =
+static unsigned char days_in_mo[] =
 {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

 static int irq_active;
@@ -88,7 +92,7 @@
 static int lostint;
 static int tt_exp;

-void gen_rtc_timer(unsigned long data);
+static void gen_rtc_timer(unsigned long data);

 static volatile int stask_active;              /* schedule_task */
 static volatile int ttask_active;              /* timer_task */
@@ -99,7 +103,7 @@
  * Routine to poll RTC seconds field for change as often as posible,
  * after first RTC_UIE use timer to reduce polling
  */
-void genrtc_troutine(void *data)
+static void genrtc_troutine(void *data)
 {
 	unsigned int tmp = get_rtc_ss();

@@ -123,7 +127,7 @@
 		stask_active = 0;
 }

-void gen_rtc_timer(unsigned long data)
+static void gen_rtc_timer(unsigned long data)
 {
 	lostint = get_rtc_ss() - oldsecs ;
 	if (lostint<0)
@@ -144,7 +148,7 @@
  * from some routine that periodically (eg 100HZ) monitors
  * whether RTC_SECS changed
  */
-void gen_rtc_interrupt(unsigned long arg)
+static void gen_rtc_interrupt(unsigned long arg)
 {
 	/*  We store the status in the low byte and the number of
 	 *	interrupts received since the last read in the remainder
@@ -384,24 +388,24 @@
  */

 static struct file_operations gen_rtc_fops = {
-	owner:		THIS_MODULE,
+	.owner		= THIS_MODULE,
 #ifdef CONFIG_GEN_RTC_X
-	read:		gen_rtc_read,
-	poll:		gen_rtc_poll,
+	.read		= gen_rtc_read,
+	.poll		= gen_rtc_poll,
 #endif
-	ioctl:		gen_rtc_ioctl,
-	open:		gen_rtc_open,
-	release:	gen_rtc_release
+	.ioctl		= gen_rtc_ioctl,
+	.open		= gen_rtc_open,
+	.release	= gen_rtc_release,
 };

 static struct miscdevice rtc_gen_dev =
 {
-	RTC_MINOR,
-	"rtc",
-	&gen_rtc_fops
+	.minor		= RTC_MINOR,
+	.name		= "rtc",
+	.fops		= &gen_rtc_fops,
 };

-int __init rtc_generic_init(void)
+static int __init rtc_generic_init(void)
 {
 	int retval;

@@ -436,16 +440,18 @@
  *	Info exported via "/proc/rtc".
  */

-int gen_rtc_proc_output(char *buf)
+#ifdef CONFIG_PROC_FS
+
+static int gen_rtc_proc_output(char *buf)
 {
 	char *p;
 	struct rtc_time tm;
-	unsigned tmp;
+	unsigned flags;
 	struct rtc_pll_info pll;

 	p = buf;

-	get_rtc_time(&tm);
+	flags = get_rtc_time(&tm);

 	p += sprintf(p,
 		     "rtc_time\t: %02d:%02d:%02d\n"
@@ -454,7 +460,7 @@
 		     tm.tm_hour, tm.tm_min, tm.tm_sec,
 		     tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, 1900);

-	tm.tm_hour=0;tm.tm_min=0;tm.tm_sec=0;
+	tm.tm_hour = tm.tm_min = tm.tm_sec = 0;

 	p += sprintf(p, "alarm\t\t: ");
 	if (tm.tm_hour <= 24)
@@ -472,7 +478,6 @@
 	else
 		p += sprintf(p, "**\n");

-	tmp= RTC_24H ;
 	p += sprintf(p,
 		     "DST_enable\t: %s\n"
 		     "BCD\t\t: %s\n"
@@ -483,15 +488,15 @@
 		     "periodic_IRQ\t: %s\n"
 		     "periodic_freq\t: %ld\n"
 		     "batt_status\t: %s\n",
-		     (tmp & RTC_DST_EN) ? "yes" : "no",
-		     (tmp & RTC_DM_BINARY) ? "no" : "yes",
-		     (tmp & RTC_24H) ? "yes" : "no",
-		     (tmp & RTC_SQWE) ? "yes" : "no",
-		     (tmp & RTC_AIE) ? "yes" : "no",
+		     (flags & RTC_DST_EN) ? "yes" : "no",
+		     (flags & RTC_DM_BINARY) ? "no" : "yes",
+		     (flags & RTC_24H) ? "yes" : "no",
+		     (flags & RTC_SQWE) ? "yes" : "no",
+		     (flags & RTC_AIE) ? "yes" : "no",
 		     irq_active ? "yes" : "no",
-		     (tmp & RTC_PIE) ? "yes" : "no",
+		     (flags & RTC_PIE) ? "yes" : "no",
 		     0L /* freq */,
-		     "okay" );
+		     (flags & RTC_BATT_BAD) ? "bad" : "okay");
 	if (!get_rtc_pll(&pll))
 	    p += sprintf(p,
 			 "PLL adjustment\t: %d\n"
@@ -506,7 +511,7 @@
 			 pll.pll_posmult,
 			 pll.pll_negmult,
 			 pll.pll_clock);
-	return  p - buf;
+	return p - buf;
 }

 static int gen_rtc_read_proc(char *page, char **start, off_t off,
@@ -521,6 +526,8 @@
 	return len;
 }

+#endif /* CONFIG_PROC_FS */
+

 MODULE_AUTHOR("Richard Zidlicky");
 MODULE_LICENSE("GPL");
--- ./include/asm-parisc/rtc.h.geert	Sat Jan 11 18:21:25 2003
+++ ./include/asm-parisc/rtc.h	Sat Jan 11 20:40:41 2003
@@ -0,0 +1,131 @@
+/* include/asm-parisc/rtc.h */
+
+#ifndef _ASM_RTC_H
+#define _ASM_RTC_H
+
+#ifdef __KERNEL__
+
+#include <linux/rtc.h>
+#include <asm/errno.h>
+
+#define RTC_PIE 0x40		/* periodic interrupt enable */
+#define RTC_AIE 0x20		/* alarm interrupt enable */
+#define RTC_UIE 0x10		/* update-finished interrupt enable */
+
+/* some dummy definitions */
+#define RTC_BATT_BAD 0x10	/* battery bad */
+#define RTC_SQWE 0x08		/* enable square-wave output */
+#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
+#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
+#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
+
+
+/* constants for calculation */
+#define SECS_PER_HOUR   (60 * 60)
+#define SECS_PER_DAY    (SECS_PER_HOUR * 24)
+
+#define __isleap(year) \
+  ((year) % 4 == 0 && ((year) % 100 != 0 || (year) % 400 == 0))
+
+
+/* How many days come before each month (0-12).  */
+static const unsigned short int __mon_yday[2][13] =
+{
+	/* Normal years.  */
+	{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365 },
+	/* Leap years.  */
+	{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
+};
+
+static inline unsigned get_rtc_time(struct rtc_time *wtime)
+{
+	/*
+	 * Only the values that we read from the RTC are set. We leave
+	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
+	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
+	 * by the RTC when initially set to a non-zero value.
+	 */
+
+	struct pdc_tod tod_data;
+	long int days, rem, y;
+	const unsigned short int *ip;
+
+	if (pdc_tod_read(&tod_data) < 0)
+		return (RTC_24H | RTC_BATT_BAD);
+
+
+	// most of the remainder of this function is:
+	//	Copyright (C) 1991, 1993, 1997, 1998 Free Software Foundation, Inc.
+	//	This was originally a part of the GNU C Library.
+	//      It is distributed under the GPL, and was swiped from offtime.c
+
+
+	days = tod_data.tod_sec / SECS_PER_DAY;
+	rem = tod_data.tod_sec % SECS_PER_DAY;
+
+	wtime->tm_hour = rem / SECS_PER_HOUR;
+	rem %= SECS_PER_HOUR;
+	wtime->tm_min = rem / 60;
+	wtime->tm_sec = rem % 60;
+
+	y = 1970;
+
+#define DIV(a, b) ((a) / (b) - ((a) % (b) < 0))
+#define LEAPS_THRU_END_OF(y) (DIV (y, 4) - DIV (y, 100) + DIV (y, 400))
+
+	while (days < 0 || days >= (__isleap (y) ? 366 : 365))
+	{
+		/* Guess a corrected year, assuming 365 days per year.  */
+		long int yg = y + days / 365 - (days % 365 < 0);
+
+		/* Adjust DAYS and Y to match the guessed year.  */
+		days -= ((yg - y) * 365
+			 + LEAPS_THRU_END_OF (yg - 1)
+			 - LEAPS_THRU_END_OF (y - 1));
+		y = yg;
+	}
+	wtime->tm_year = y - 1900;
+#undef DIV
+#undef LEAPS_THRU_END_OF
+
+	ip = __mon_yday[__isleap(y)];
+	for (y = 11; days < (long int) ip[y]; --y)
+		continue;
+	days -= ip[y];
+	wtime->tm_mon = y;
+	wtime->tm_mday = days + 1;
+
+	return (RTC_24H);
+}
+
+static inline int set_rtc_time(struct rtc_time *wtime)
+{
+	u_int32_t secs;
+
+	secs = mktime(wtime->tm_year + 1900, wtime->tm_mon + 1, wtime->tm_mday,
+		      wtime->tm_hour, wtime->tm_min, wtime->tm_sec);
+
+	if (pdc_tod_set(secs, 0) < 0)
+		return -EINVAL;
+	else
+		return 0;
+}
+
+static inline unsigned int get_rtc_ss(void)
+{
+	return -EINVAL;
+}
+
+static inline int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+static inline int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM__RTC_H */
+

--Boundary-00=_WWHI+IE+7Hhk3eF--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
