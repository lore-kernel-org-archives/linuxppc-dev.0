Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp14.mail.mci.yahoo.co.jp (ybbsmtp14.mail.mci.yahoo.co.jp
	[210.80.241.188]) by ozlabs.org (Postfix) with SMTP id 1F61367A7A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Mar 2005 06:15:28 +1100 (EST)
Message-ID: <422B56CD.9020708@ybb.ne.jp>
Date: Mon, 07 Mar 2005 04:15:25 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
References: <4226FF62.30007@jp.fujitsu.com>	<c56d8feba0d803d74d77ab20f54287e9@freescale.com>	<42272B69.8000303@ybb.ne.jp>	<20050303101146.A8869@cox.net>	<42282C83.9040707@jp.fujitsu.com>	<1109982868.1479.22.camel@jdub.homelinux.org>
	<422969B9.6040303@ybb.ne.jp>
In-Reply-To: <422969B9.6040303@ybb.ne.jp>
Content-Type: multipart/mixed; boundary="------------000306010209010501050902"
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] WDT Driver for Book-E [2/2] Device driver part.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000306010209010501050902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Josh:

Takeharu KATO wrote:
>>
>>
>> Most of this is in include/asm-ppc/reg_booke.h.  Could you use that
>> instead of redefining most of it?
>>
> To tell the truth, this matter has been examined, but I forgot this.
> Thank you for making it recall(^^
> 
I performed minor fixes which you pointed out.
But I leaves WDT_WP[0123] on purpose.
The interpretation of this value is different between PPC4xx and e500.
To unite them, I leaves this.

>>
>> In include/linux/device.h there are dev_printk and dev_dbg macros that
>> do pretty much the same thing.  Could you use those instead?
>>
> I did not know such thing.
> I'll try to use them.
> 
On second thought, I found that it is not so good idea.
If I change this according to what you said, it is not
easy to find which driver outputs messages when we can
use multiple WDT in a system.

Macros in include/linux/device.h will use name member in miscdevice 
struct as driver's name, and this is commonly named as "watchdog".

FYI, I show the difference with the patch submitted last time.


Regards,I'll test this driver today, just in case, before I post the 
revised edition of this driver.

Regards,

-- 
Takeharu KATO

--------------000306010209010501050902
Content-Type: text/plain;
 name="inter-booke_wdt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inter-booke_wdt.diff"

--- linux-2.6.11-booke-wdt/drivers/char/watchdog/booke_wdt.c    2005-03-04 16:38:58.000000000 +0900
+++ linux-2.6.11-wdt/drivers/char/watchdog/booke_wdt.c	2005-03-07 03:35:34.000000000 +0900
@@ -76,86 +76,43 @@
 /*  Panic notifier  */
 extern struct notifier_block *panic_notifier_list;
 /*
- *  External linkage functions
- */
-void booke_wdt_heartbeat(void);
-void booke_wdt_setup_options(char *cmd_line);
-void booke_wdt_exception(struct pt_regs *regs);
-/*
- * Internal linkage functions
- */
-static __inline__ void __booke_wdt_setup_val(int period,int reset);
-static __inline__ void __booke_wdt_enable(void);
-static __inline__ void __booke_wdt_disable(void);
-static __inline__ int  __booke_wdt_is_enabled(void);
-static __inline__ void __booke_wdt_clear_int_stat(void);
-static __inline__ void __booke_wdt_set_timeout(int t);
-static __inline__ void booke_wdt_init_device(void);
-static __inline__ int  booke_wdt_is_enabled(void);
-static __inline__ int  booke_wdt_start(void);
-static __inline__ int  booke_wdt_stop(void);
-static __inline__ int  booke_wdt_ping(void);
-static __inline__ int  booke_wdt_set_timeout(int t);
-static __inline__ int  booke_wdt_get_status(int *status);
-static ssize_t booke_wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos);
-static int booke_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,unsigned long arg);
-static int booke_wdt_open(struct inode *inode, struct file *file);
-static int booke_wdt_release(struct inode *inode, struct file *file);
-static int booke_wdt_notify_sys(struct notifier_block *this, unsigned long code,void *unused);
-static int __init booke_wdt_init(void);
-static void __exit booke_wdt_exit(void);
-
-/*
  *    Watchdog operations on PPC4xx/e500 MPU
  */
-
 /**
  *      __booke_wdt_setup_val
  *      Enable Watchdog, sets up passed in values for TCR[WP],
  *      TCR[WRC]
  *
  *    @period:    Input Watchdog Period - TCR[WP]
- *                      0 = 217 clocks
- *                      1 = 221 clocks
- *                      2 = 225 clocks
- *                      3 = 229 clocks
- *      @reset:         Watchdog reset control - TCR[WRC]
+ *                      0...2^17(PPC405) or 2^21(PPC440/e500) clocks
+ *                      1...2^21(PPC405) or 2^25(PPC440/e500) clocks
+ *                      2...2^25(PPC405) or 2^29(PPC440/e500) clocks
+ *                      3...2^25(PPC405) or 2^29(PPC440/e500) clocks
+ *    @reset:         Watchdog reset control - TCR[WRC]
  *                      0 = No reset
  *                      1 = PPC Core reset only
  *                      2 = PPC Chip reset
  *                      3 = System reset
- *     Note: The meaning of period number is differ PPC440GP from PPC440GX.
+ *     Note: The meaning of period number is differ PPC405 from PPC440.
+ *           Current version assume that this function called with 
+ *           WRC_NONE as reset, if someone who want to remove this 
+ *           constraint, please note that when we disable WDT, we should
+ *           set WRC with WRC_NONE and s/he should also  modify 
+ *           disable/enable_wdt function. 
+ *           
  */
-#if defined(CONFIG_4xx)
 static __inline__ void
 __booke_wdt_setup_val(int period,int reset)
 {
   unsigned long val;
 
   /*  Set up TCR  */
-  val=((period)<<WDT_TCR_WP_SHIFT|(reset)<<WDT_TCR_WRC_SHIFT)|mfspr(SPRN_TCR);
-  /*  Disable WDT  */
-  val &= ~(WDT_TCR_WDT_ENABLE);
-
-  mtspr(SPRN_TCR,val);
-}
-#else
-/*  e500  */
-static __inline__ void
-__booke_wdt_setup_val(int period,int reset)
-{
-  unsigned long val;
-  /*  Set up TCR  */
-
-  val=(((period)&(WDT_TCR_WP_BITMSK)) << WDT_TCR_WP_SHIFT|
-       ( ( (period) >> 2 )&(WDT_TCR_WPEXT_BITMSK)) << WDT_TCR_WPEXT_SHIFT|
-       (reset)<<WDT_TCR_WRC_SHIFT)|mfspr(SPRN_TCR);
+  val=wdt_calculate_tcr(period,reset)| mfspr(SPRN_TCR);
   /*  Disable WDT  */
-  val &= ~(WDT_TCR_WDT_ENABLE);
+  val &= ~(TCR_WIE);
 
   mtspr(SPRN_TCR,val);
 }
-#endif  /*  CONFIG_E500 */
 /**
  *      __booke_wdt_enable
  *      Enable Watchdog
@@ -163,7 +120,7 @@
 static __inline__ void
 __booke_wdt_enable(void)
 {
-  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)|WDT_TCR_WDT_ENABLE));
+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)|TCR_WIE));
 }
 /**
  *      __booke_wdt_disable
@@ -172,7 +129,7 @@
 static __inline__ void
 __booke_wdt_disable(void)
 {
-  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)&(~(WDT_TCR_WDT_ENABLE))));
+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)&(~(TCR_WIE))));
 }
 /**
  *      __booke_wdt_is_enabled
@@ -181,7 +138,7 @@
 static __inline__ int
 __booke_wdt_is_enabled(void)
 {
-  return (mfspr(SPRN_TCR) & WDT_TCR_WDT_ENABLE);
+  return (mfspr(SPRN_TCR) & TCR_WIE);
 }
 /**
  *      __booke_wdt_clear_init_stat
@@ -272,6 +229,7 @@
 void
 booke_wdt_exception(struct pt_regs *regs)
 {
+
   wdt_enable=0;
   __booke_wdt_disable();
   printk("WDT Exception at PC: %lx, MSR: %lx, vector=%lx    %s\n",
@@ -294,6 +252,7 @@
 static __inline__ int
 booke_wdt_start(void)
 {
+
   __booke_wdt_enable();
   return 0;
 }
@@ -306,6 +265,7 @@
 static __inline__ int
 booke_wdt_stop (void)
 {
+
   __booke_wdt_disable();
   return 0;
 }
@@ -318,6 +278,7 @@
 static __inline__ int
 booke_wdt_ping(void)
 {
+
   /* Disable watchdog */
   __booke_wdt_disable();
   /* Write a watchdog value */
@@ -340,6 +301,7 @@
 static __inline__ int
 booke_wdt_set_timeout(int t)
 {
+
   if ((t < WDT_HEARTBEAT_MIN) || (t > WDT_HEARTBEAT_MAX))
     return -EINVAL;
 
@@ -360,6 +322,7 @@
 static __inline__ int
 booke_wdt_get_status(int *status)
 {
+
   if (wdt_enable)
       *status = WDIOS_ENABLECARD;
   else
@@ -378,11 +341,12 @@
 static void
 booke_wdt_init_device(void)
 {
-        /* Hardware WDT provided by the processor.
+
+    /* Hardware WDT provided by the processor.
      * So, we set firmware version as processor version number.
      */
     ident.firmware_version=mfspr(PVR);
-    __booke_wdt_setup_val(WDT_WP,WDT_RESET_NONE);
+    __booke_wdt_setup_val(WDT_WP,WRC_NONE);
 }
 /**
  *    booke_wdt_write:
@@ -401,22 +365,22 @@
 {
   size_t i;
 
-    if (!nowayout) {
-      /* In case it was set long ago */
-      clear_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+  if (!nowayout) {
+    /* In case it was set long ago */
+    clear_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
 
-      for (i = 0; i < count; i++) {
-    char c;
+    for (i = 0; i < count; i++) {
+      char c;
 
-    if (get_user(c, buf + i))
-      return -EFAULT;
+      if (get_user(c, buf + i))
+	return -EFAULT;
 
-    if (c == 'V') {
-      set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
-    }
+      if (c == 'V') {
+	set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
       }
     }
-    booke_wdt_ping();
+  }
+  booke_wdt_ping();
 
   return count;
 }
@@ -523,12 +487,12 @@
 booke_wdt_release(struct inode *inode, struct file *file)
 {
   if (test_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state)) {
-      booke_wdt_note("WDT device is stopped.\n");
+      booke_wdt_info("WDT device is stopped.\n");
     booke_wdt_stop();
     wdt_enable=0;
   } else {
     if ( (booke_wdt_is_enabled()) && (!nowayout) ) {
-      booke_wdt_note("WDT device may be closed unexpectedly.  WDT will not stop!\n");
+      booke_wdt_info("WDT device may be closed unexpectedly.  WDT will not stop!\n");
       booke_wdt_ping();
     }
   }
--- linux-2.6.11-booke-wdt/drivers/char/watchdog/booke_wdt.h    2005-03-04 16:38:58.000000000 +0900
+++ linux-2.6.11-wdt/drivers/char/watchdog/booke_wdt.h	2005-03-07 04:08:46.702851618 +0900
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
 #include <linux/watchdog.h>
+#include <asm/reg_booke.h>
 
 /*
  *  Driver state flags(bit position)
@@ -32,32 +33,10 @@
  * Configurations
  */
 #define WDT_TIMO           60000    /* Default timeout = 60000 ms(1min) */
-#define WDT_HEARTBEAT_MIN  100          /* Minimum timeout = 100 ms */
-#define WDT_HEARTBEAT_MAX  600000       /* Maximum timeout = 600000ms(1hour) */
+#define WDT_HEARTBEAT_MIN  100      /* Minimum timeout = 100 ms */
+#define WDT_HEARTBEAT_MAX  600000   /* Maximum timeout = 600000ms(1hour) */
 #ifdef __KERNEL__
 //#define BOOKE_WDT_DEBUG                     /*  Debug switch */
-/*
- *  Reset type
- */
-#define WDT_RESET_NONE     0
-#define WDT_RESET_CORE     1
-#define WDT_RESET_CHIP     2
-#define WDT_RESET_SYS      3
-/*
- *   Bit positions in  TCR register on PPC4xx/e500 series.
- */
-#define WDT_TCR_WP_BIT     1   /*  WP  bit in TCR (bit[0..1])   */
-#define WDT_TCR_WRC_BIT    3   /*  WRC bit in TCR (bit[2..3])   */
-#define WDT_TCR_WIE_BIT    4   /*  WIE bit in TCR (bit[4])      */
-/*
- *  TCR[WP] relevant definitions
- */
-#define WDT_TCR_WP_SHIFT       (31 - WDT_TCR_WP_BIT)
-#define WDT_TCR_WRC_SHIFT      (31 - WDT_TCR_WRC_BIT)
-#define WDT_TCR_WIE_SHIFT      (31 - WDT_TCR_WIE_BIT)
-#define WDT_TCR_WDT_ENABLE     (1<<WDT_TCR_WIE_SHIFT)
-/*  MASK value to obatain TCR[WP]  */
-#define WDT_TCR_WP_MASK        (3<<(WDT_TCR_WP_SHIFT))
 
 /*  Watchdog timer periods can be set on PPC 4xx cpus. */
 #if defined(CONFIG_4xx)
@@ -68,6 +47,7 @@
 #define WDT_WP1               1
 #define WDT_WP2               2
 #define WDT_WP3               3
+#define wdt_calculate_tcr(period,reset) ( TCR_WP(period) | TCR_WRC(reset) ) 
 #else
 #if defined(CONFIG_E500)
 /*
@@ -81,9 +61,16 @@
 #define WDT_WP1               25
 #define WDT_WP2               29
 #define WDT_WP3               33
-#define WDT_TCR_WP_BITMSK     0x3  /*  2bit length  */
+#define WDT_TCR_WP_BITLEN      2 /*  2bit length  */
+#define WDT_TCR_WP_BITMSK     ((1<<(WDT_TCR_WP_BITLEN))-1)  /*  mask  */
 #define WDT_TCR_WPEXT_BITMSK  0xf  /*  4bit length  */
-#define WDT_TCR_WPEXT_SHIFT  17
+#define WDT_TCR_WPEXT_SHIFT   17
+#define WDT_WPEXT_VAL(period) (((period)>>WDT_TCR_WP_BITLEN)&    \
+			       (WDT_TCR_WPEXT_BITMSK))
+#define wdt_calculate_tcr(period,reset) \
+                         ( TCR_WP((period)&(WDT_TCR_WP_BITMSK))  |\
+			   TCR_WRC((reset))                      |\
+		   ( WDT_WPEXT_VAL(period) << WDT_TCR_WPEXT_SHIFT))
 #else
 #error "Book E WDT detects invalid configuration(Unknown CPU)"
 #endif  /*  CONFIG_E500  */
@@ -111,8 +98,6 @@
     printk(KERN_NOTICE __BOOKE_WDT_MSG fmt,##arg)
 #define booke_wdt_err(fmt,arg...) \
     printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
-#define booke_wdt_crit(fmt,arg...) \
-    printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
 #if defined(BOOKE_WDT_DEBUG)
 #define booke_wdt_dbg(fmt,arg...) \
     printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)

--------------000306010209010501050902--
