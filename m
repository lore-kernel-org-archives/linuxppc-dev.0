Date: Sun, 12 Jan 2003 12:33:45 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Helge Deller <deller@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	parisc-linux@parisc-linux.org,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Generic RTC driver in 2.4.x
In-Reply-To: <200301112050.46194.deller@gmx.de>
Message-ID: <Pine.GSO.4.21.0301121214440.18673-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 11 Jan 2003, Helge Deller wrote:
> On Friday 10 January 2003 21:05, Geert Uytterhoeven wrote:
> > Unfortunately I didn't receive any feedback from the pa-risc and ppc people
> > after my previous posting last Sunday.
>
> It took me some time, but here are the PA-RISC specific patches vs. your
> latest genrtc driver.
>
> Please consider applying,

Thanks! Applied.

I made some more changes afterwards:
  - Remove unnecessary forward declaration of gen_rtc_ioctl()
  - Add forward declaration for gen_rtc_interrupt()
  - Remove obsolete extern declaration for gen_rtc_interrupt() on m68k
  - Change `unsigned' to `unsigned int'
  - Change value of RTC_BATT_BAD to 0x100 (0x10 conflicted with RTC_UIE, and
    0x01 is already used in <linux/mc146818rtc.h>)
  - Update m68k get_rtc_time() to return flags

BTW, perhaps we should move the global RTC_* definitions in <asm/rtc.h> to
<linux/genrtc.h>, or merge them with the ones in <linux/mc146818rtc.h> and move
them to <linux/rtc.h>?

--- linux-genrtc-parisc-2.4.20/drivers/char/genrtc.c	Sun Jan 12 12:01:23 2003
+++ linux-m68k-2.4.20/drivers/char/genrtc.c	Sun Jan 12 12:18:21 2003
@@ -66,8 +66,8 @@

 static DECLARE_WAIT_QUEUE_HEAD(gen_rtc_wait);

-static int gen_rtc_ioctl(struct inode *inode, struct file *file,
-		     unsigned int cmd, unsigned long arg);
+static void gen_rtc_interrupt(unsigned long arg);
+

 /*
  *	Bits in gen_rtc_status.
@@ -446,7 +446,7 @@
 {
 	char *p;
 	struct rtc_time tm;
-	unsigned flags;
+	unsigned int flags;
 	struct rtc_pll_info pll;

 	p = buf;
--- linux-genrtc-parisc-2.4.20/include/asm-parisc/rtc.h	Sun Jan 12 12:01:23 2003
+++ linux-m68k-2.4.20/include/asm-parisc/rtc.h	Sun Jan 12 11:05:53 2003
@@ -12,8 +12,9 @@
 #define RTC_AIE 0x20		/* alarm interrupt enable */
 #define RTC_UIE 0x10		/* update-finished interrupt enable */

+#define RTC_BATT_BAD 0x100	/* battery bad */
+
 /* some dummy definitions */
-#define RTC_BATT_BAD 0x10	/* battery bad */
 #define RTC_SQWE 0x08		/* enable square-wave output */
 #define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
 #define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
@@ -37,7 +38,7 @@
 	{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
 };

-static inline unsigned get_rtc_time(struct rtc_time *wtime)
+static inline unsigned int get_rtc_time(struct rtc_time *wtime)
 {
 	/*
 	 * Only the values that we read from the RTC are set. We leave
--- linux-genrtc-parisc-2.4.20/include/asm-m68k/rtc.h	Fri Jan 10 20:54:25 2003
+++ linux-m68k-2.4.20/include/asm-m68k/rtc.h	Sun Jan 12 12:18:29 2003
@@ -21,15 +21,14 @@
 #define RTC_AIE 0x20		/* alarm interrupt enable */
 #define RTC_UIE 0x10		/* update-finished interrupt enable */

-extern void gen_rtc_interrupt(unsigned long);
-
 /* some dummy definitions */
+#define RTC_BATT_BAD 0x100	/* battery bad */
 #define RTC_SQWE 0x08		/* enable square-wave output */
 #define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
 #define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */

-static inline void get_rtc_time(struct rtc_time *time)
+static inline unsigned int get_rtc_time(struct rtc_time *time)
 {
 	/*
 	 * Only the values that we read from the RTC are set. We leave
@@ -38,6 +37,7 @@
 	 * by the RTC when initially set to a non-zero value.
 	 */
 	mach_hwclk(0, time);
+	return RTC_24H;
 }

 static inline int set_rtc_time(struct rtc_time *time)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
