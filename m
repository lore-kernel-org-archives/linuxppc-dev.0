Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418Y1t4z74zF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 00:12:02 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 y2038@lists.linaro.org, Meelis Roos <mroos@linux.ee>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] m68k: remove unused set_clock_mmss() helpers
Date: Mon, 18 Jun 2018 16:05:18 +0200
Message-Id: <20180618140518.2920804-3-arnd@arndb.de>
In-Reply-To: <20180618140518.2920804-1-arnd@arndb.de>
References: <20180618140518.2920804-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 397ac99c6cef ("m68k: remove dead timer code") removed set_rtc_mmss()
because it was unused in 2012. However, this was itself the only user of the
mach_set_clock_mmss() callback and the many implementations of that callback,
which are equally unused.

This removes all of those as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/apollo/config.c       |  8 ------
 arch/m68k/atari/config.c        |  5 ----
 arch/m68k/atari/time.c          | 63 -----------------------------------------
 arch/m68k/bvme6000/config.c     | 45 -----------------------------
 arch/m68k/include/asm/machdep.h |  1 -
 arch/m68k/kernel/setup_mm.c     |  1 -
 arch/m68k/kernel/setup_no.c     |  1 -
 arch/m68k/mac/config.c          |  2 --
 arch/m68k/mac/misc.c            | 16 -----------
 arch/m68k/mvme147/config.c      |  7 -----
 arch/m68k/mvme16x/config.c      |  8 ------
 arch/m68k/q40/config.c          | 30 --------------------
 12 files changed, 187 deletions(-)

diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index b2a6bc63f8cd..aef8d42e078d 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -31,7 +31,6 @@ extern void dn_sched_init(irq_handler_t handler);
 extern void dn_init_IRQ(void);
 extern u32 dn_gettimeoffset(void);
 extern int dn_dummy_hwclk(int, struct rtc_time *);
-extern int dn_dummy_set_clock_mmss(unsigned long);
 extern void dn_dummy_reset(void);
 #ifdef CONFIG_HEARTBEAT
 static void dn_heartbeat(int on);
@@ -156,7 +155,6 @@ void __init config_apollo(void)
 	arch_gettimeoffset   = dn_gettimeoffset;
 	mach_max_dma_address = 0xffffffff;
 	mach_hwclk           = dn_dummy_hwclk; /* */
-	mach_set_clock_mmss  = dn_dummy_set_clock_mmss; /* */
 	mach_reset	     = dn_dummy_reset;  /* */
 #ifdef CONFIG_HEARTBEAT
 	mach_heartbeat = dn_heartbeat;
@@ -240,12 +238,6 @@ int dn_dummy_hwclk(int op, struct rtc_time *t) {
 
 }
 
-int dn_dummy_set_clock_mmss(unsigned long nowtime)
-{
-	pr_info("set_clock_mmss\n");
-	return 0;
-}
-
 void dn_dummy_reset(void) {
 
   dn_serial_print("The end !\n");
diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index 565c6f06ab0b..bd96702a1ad0 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -81,9 +81,6 @@ extern void atari_sched_init(irq_handler_t);
 extern u32 atari_gettimeoffset(void);
 extern int atari_mste_hwclk (int, struct rtc_time *);
 extern int atari_tt_hwclk (int, struct rtc_time *);
-extern int atari_mste_set_clock_mmss (unsigned long);
-extern int atari_tt_set_clock_mmss (unsigned long);
-
 
 /* ++roman: This is a more elaborate test for an SCC chip, since the plain
  * Medusa board generates DTACK at the SCC's standard addresses, but a SCC
@@ -362,13 +359,11 @@ void __init config_atari(void)
 		ATARIHW_SET(TT_CLK);
 		pr_cont(" TT_CLK");
 		mach_hwclk = atari_tt_hwclk;
-		mach_set_clock_mmss = atari_tt_set_clock_mmss;
 	}
 	if (hwreg_present(&mste_rtc.sec_ones)) {
 		ATARIHW_SET(MSTE_CLK);
 		pr_cont(" MSTE_CLK");
 		mach_hwclk = atari_mste_hwclk;
-		mach_set_clock_mmss = atari_mste_set_clock_mmss;
 	}
 	if (!MACH_IS_MEDUSA && hwreg_present(&dma_wd.fdc_speed) &&
 	    hwreg_write(&dma_wd.fdc_speed, 0)) {
diff --git a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
index c549b48174ec..9cca64286464 100644
--- a/arch/m68k/atari/time.c
+++ b/arch/m68k/atari/time.c
@@ -285,69 +285,6 @@ int atari_tt_hwclk( int op, struct rtc_time *t )
     return( 0 );
 }
 
-
-int atari_mste_set_clock_mmss (unsigned long nowtime)
-{
-    short real_seconds = nowtime % 60, real_minutes = (nowtime / 60) % 60;
-    struct MSTE_RTC val;
-    unsigned char rtc_minutes;
-
-    mste_read(&val);
-    rtc_minutes= val.min_ones + val.min_tens * 10;
-    if ((rtc_minutes < real_minutes
-         ? real_minutes - rtc_minutes
-         : rtc_minutes - real_minutes) < 30)
-    {
-        val.sec_ones = real_seconds % 10;
-        val.sec_tens = real_seconds / 10;
-        val.min_ones = real_minutes % 10;
-        val.min_tens = real_minutes / 10;
-        mste_write(&val);
-    }
-    else
-        return -1;
-    return 0;
-}
-
-int atari_tt_set_clock_mmss (unsigned long nowtime)
-{
-    int retval = 0;
-    short real_seconds = nowtime % 60, real_minutes = (nowtime / 60) % 60;
-    unsigned char save_control, save_freq_select, rtc_minutes;
-
-    save_control = RTC_READ (RTC_CONTROL); /* tell the clock it's being set */
-    RTC_WRITE (RTC_CONTROL, save_control | RTC_SET);
-
-    save_freq_select = RTC_READ (RTC_FREQ_SELECT); /* stop and reset prescaler */
-    RTC_WRITE (RTC_FREQ_SELECT, save_freq_select | RTC_DIV_RESET2);
-
-    rtc_minutes = RTC_READ (RTC_MINUTES);
-    if (!(save_control & RTC_DM_BINARY))
-	rtc_minutes = bcd2bin(rtc_minutes);
-
-    /* Since we're only adjusting minutes and seconds, don't interfere
-       with hour overflow.  This avoids messing with unknown time zones
-       but requires your RTC not to be off by more than 30 minutes.  */
-    if ((rtc_minutes < real_minutes
-         ? real_minutes - rtc_minutes
-         : rtc_minutes - real_minutes) < 30)
-        {
-            if (!(save_control & RTC_DM_BINARY))
-                {
-		    real_seconds = bin2bcd(real_seconds);
-		    real_minutes = bin2bcd(real_minutes);
-                }
-            RTC_WRITE (RTC_SECONDS, real_seconds);
-            RTC_WRITE (RTC_MINUTES, real_minutes);
-        }
-    else
-        retval = -1;
-
-    RTC_WRITE (RTC_FREQ_SELECT, save_freq_select);
-    RTC_WRITE (RTC_CONTROL, save_control);
-    return retval;
-}
-
 /*
  * Local variables:
  *  c-indent-level: 4
diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 2cfff4765040..143ee9fa3893 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -41,7 +41,6 @@ static void bvme6000_get_model(char *model);
 extern void bvme6000_sched_init(irq_handler_t handler);
 extern u32 bvme6000_gettimeoffset(void);
 extern int bvme6000_hwclk (int, struct rtc_time *);
-extern int bvme6000_set_clock_mmss (unsigned long);
 extern void bvme6000_reset (void);
 void bvme6000_set_vectors (void);
 
@@ -113,7 +112,6 @@ void __init config_bvme6000(void)
     mach_init_IRQ        = bvme6000_init_IRQ;
     arch_gettimeoffset   = bvme6000_gettimeoffset;
     mach_hwclk           = bvme6000_hwclk;
-    mach_set_clock_mmss	 = bvme6000_set_clock_mmss;
     mach_reset		 = bvme6000_reset;
     mach_get_model       = bvme6000_get_model;
 
@@ -305,46 +303,3 @@ int bvme6000_hwclk(int op, struct rtc_time *t)
 
 	return 0;
 }
-
-/*
- * Set the minutes and seconds from seconds value 'nowtime'.  Fail if
- * clock is out by > 30 minutes.  Logic lifted from atari code.
- * Algorithm is to wait for the 10ms register to change, and then to
- * wait a short while, and then set it.
- */
-
-int bvme6000_set_clock_mmss (unsigned long nowtime)
-{
-	int retval = 0;
-	short real_seconds = nowtime % 60, real_minutes = (nowtime / 60) % 60;
-	unsigned char rtc_minutes, rtc_tenms;
-	volatile RtcPtr_t rtc = (RtcPtr_t)BVME_RTC_BASE;
-	unsigned char msr = rtc->msr & 0xc0;
-	unsigned long flags;
-	volatile int i;
-
-	rtc->msr = 0;		/* Ensure clock accessible */
-	rtc_minutes = bcd2bin (rtc->bcd_min);
-
-	if ((rtc_minutes < real_minutes
-		? real_minutes - rtc_minutes
-			: rtc_minutes - real_minutes) < 30)
-	{
-		local_irq_save(flags);
-		rtc_tenms = rtc->bcd_tenms;
-		while (rtc_tenms == rtc->bcd_tenms)
-			;
-		for (i = 0; i < 1000; i++)
-			;
-		rtc->bcd_min = bin2bcd(real_minutes);
-		rtc->bcd_sec = bin2bcd(real_seconds);
-		local_irq_restore(flags);
-	}
-	else
-		retval = -1;
-
-	rtc->msr = msr;
-
-	return retval;
-}
-
diff --git a/arch/m68k/include/asm/machdep.h b/arch/m68k/include/asm/machdep.h
index 1605da48ebf2..49bd3266b4b1 100644
--- a/arch/m68k/include/asm/machdep.h
+++ b/arch/m68k/include/asm/machdep.h
@@ -22,7 +22,6 @@ extern int (*mach_hwclk)(int, struct rtc_time*);
 extern unsigned int (*mach_get_ss)(void);
 extern int (*mach_get_rtc_pll)(struct rtc_pll_info *);
 extern int (*mach_set_rtc_pll)(struct rtc_pll_info *);
-extern int (*mach_set_clock_mmss)(unsigned long);
 extern void (*mach_reset)( void );
 extern void (*mach_halt)( void );
 extern void (*mach_power_off)( void );
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index f35e3ebd6331..07244732eb41 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -88,7 +88,6 @@ void (*mach_get_hardware_list) (struct seq_file *m);
 /* machine dependent timer functions */
 int (*mach_hwclk) (int, struct rtc_time*);
 EXPORT_SYMBOL(mach_hwclk);
-int (*mach_set_clock_mmss) (unsigned long);
 unsigned int (*mach_get_ss)(void);
 int (*mach_get_rtc_pll)(struct rtc_pll_info *);
 int (*mach_set_rtc_pll)(struct rtc_pll_info *);
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index a98af1018201..3c53e4c366ac 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -51,7 +51,6 @@ char __initdata command_line[COMMAND_LINE_SIZE];
 
 /* machine dependent timer functions */
 void (*mach_sched_init)(irq_handler_t handler) __initdata = NULL;
-int (*mach_set_clock_mmss)(unsigned long);
 int (*mach_hwclk) (int, struct rtc_time*);
 
 /* machine dependent reboot functions */
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index e522307db47c..da1aeb966474 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -57,7 +57,6 @@ static unsigned long mac_orig_videoaddr;
 /* Mac specific timer functions */
 extern u32 mac_gettimeoffset(void);
 extern int mac_hwclk(int, struct rtc_time *);
-extern int mac_set_clock_mmss(unsigned long);
 extern void iop_preinit(void);
 extern void iop_init(void);
 extern void via_init(void);
@@ -158,7 +157,6 @@ void __init config_mac(void)
 	mach_get_model = mac_get_model;
 	arch_gettimeoffset = mac_gettimeoffset;
 	mach_hwclk = mac_hwclk;
-	mach_set_clock_mmss = mac_set_clock_mmss;
 	mach_reset = mac_reset;
 	mach_halt = mac_poweroff;
 	mach_power_off = mac_poweroff;
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index b399a0809e18..b0dda5cb9e48 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -735,19 +735,3 @@ int mac_hwclk(int op, struct rtc_time *t)
 	}
 	return 0;
 }
-
-/*
- * Set minutes/seconds in the hardware clock
- */
-
-int mac_set_clock_mmss (unsigned long nowtime)
-{
-	struct rtc_time now;
-
-	mac_hwclk(0, &now);
-	now.tm_sec = nowtime % 60;
-	now.tm_min = (nowtime / 60) % 60;
-	mac_hwclk(1, &now);
-
-	return 0;
-}
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index f8a710fd84cd..adea549d240e 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -40,7 +40,6 @@ static void mvme147_get_model(char *model);
 extern void mvme147_sched_init(irq_handler_t handler);
 extern u32 mvme147_gettimeoffset(void);
 extern int mvme147_hwclk (int, struct rtc_time *);
-extern int mvme147_set_clock_mmss (unsigned long);
 extern void mvme147_reset (void);
 
 
@@ -92,7 +91,6 @@ void __init config_mvme147(void)
 	mach_init_IRQ		= mvme147_init_IRQ;
 	arch_gettimeoffset	= mvme147_gettimeoffset;
 	mach_hwclk		= mvme147_hwclk;
-	mach_set_clock_mmss	= mvme147_set_clock_mmss;
 	mach_reset		= mvme147_reset;
 	mach_get_model		= mvme147_get_model;
 
@@ -164,8 +162,3 @@ int mvme147_hwclk(int op, struct rtc_time *t)
 	}
 	return 0;
 }
-
-int mvme147_set_clock_mmss (unsigned long nowtime)
-{
-	return 0;
-}
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 4ffd9ef98de4..6ee36a5b528d 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -46,7 +46,6 @@ static void mvme16x_get_model(char *model);
 extern void mvme16x_sched_init(irq_handler_t handler);
 extern u32 mvme16x_gettimeoffset(void);
 extern int mvme16x_hwclk (int, struct rtc_time *);
-extern int mvme16x_set_clock_mmss (unsigned long);
 extern void mvme16x_reset (void);
 
 int bcd2int (unsigned char b);
@@ -280,7 +279,6 @@ void __init config_mvme16x(void)
     mach_init_IRQ        = mvme16x_init_IRQ;
     arch_gettimeoffset   = mvme16x_gettimeoffset;
     mach_hwclk           = mvme16x_hwclk;
-    mach_set_clock_mmss	 = mvme16x_set_clock_mmss;
     mach_reset		 = mvme16x_reset;
     mach_get_model       = mvme16x_get_model;
     mach_get_hardware_list = mvme16x_get_hardware_list;
@@ -411,9 +409,3 @@ int mvme16x_hwclk(int op, struct rtc_time *t)
 	}
 	return 0;
 }
-
-int mvme16x_set_clock_mmss (unsigned long nowtime)
-{
-	return 0;
-}
-
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 71c0867ecf20..96810d91da2b 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -43,7 +43,6 @@ extern void q40_sched_init(irq_handler_t handler);
 static u32 q40_gettimeoffset(void);
 static int q40_hwclk(int, struct rtc_time *);
 static unsigned int q40_get_ss(void);
-static int q40_set_clock_mmss(unsigned long);
 static int q40_get_rtc_pll(struct rtc_pll_info *pll);
 static int q40_set_rtc_pll(struct rtc_pll_info *pll);
 
@@ -175,7 +174,6 @@ void __init config_q40(void)
 	mach_get_ss = q40_get_ss;
 	mach_get_rtc_pll = q40_get_rtc_pll;
 	mach_set_rtc_pll = q40_set_rtc_pll;
-	mach_set_clock_mmss = q40_set_clock_mmss;
 
 	mach_reset = q40_reset;
 	mach_get_model = q40_get_model;
@@ -267,34 +265,6 @@ static unsigned int q40_get_ss(void)
 	return bcd2bin(Q40_RTC_SECS);
 }
 
-/*
- * Set the minutes and seconds from seconds value 'nowtime'.  Fail if
- * clock is out by > 30 minutes.  Logic lifted from atari code.
- */
-
-static int q40_set_clock_mmss(unsigned long nowtime)
-{
-	int retval = 0;
-	short real_seconds = nowtime % 60, real_minutes = (nowtime / 60) % 60;
-
-	int rtc_minutes;
-
-	rtc_minutes = bcd2bin(Q40_RTC_MINS);
-
-	if ((rtc_minutes < real_minutes ?
-	     real_minutes - rtc_minutes :
-	     rtc_minutes - real_minutes) < 30) {
-		Q40_RTC_CTRL |= Q40_RTC_WRITE;
-		Q40_RTC_MINS = bin2bcd(real_minutes);
-		Q40_RTC_SECS = bin2bcd(real_seconds);
-		Q40_RTC_CTRL &= ~(Q40_RTC_WRITE);
-	} else
-		retval = -1;
-
-	return retval;
-}
-
-
 /* get and set PLL calibration of RTC clock */
 #define Q40_RTC_PLL_MASK ((1<<5)-1)
 #define Q40_RTC_PLL_SIGN (1<<5)
-- 
2.9.0
