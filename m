Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 4E5F367A67
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 09:06:25 +1100 (EST)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA09987
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jan 2005 13:10:01 -0800
Message-ID: <41EC29A8.1040703@mvista.com>
Date: Mon, 17 Jan 2005 14:10:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------070205010403000106090302"
Subject: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------070205010403000106090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

All,

I have a platform with an i2c rtc chip.  Since much of the code for an 
rtc driver is already in drivers/char/genrtc.c, I would like to reuse 
that code and directly implement get_rtc_time(), et. al. in the rtc 
driver.  The problem is that include/asm-ppc/rtc.h assumes that 
get_rtc_time(), et. al. should be mapped to ppc_md.get_rtc_time() et. 
al.  To work around this, I made an option to turn off that assumption.  
The patch is included.

There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. interfaces:
1) They are called before the i2c driver is initialized and even loaded 
if its a module.
2) Its ppc-specific.  Implementing get_rtc_time() et. al. directly makes 
it generic across all architectures.

Is there a better way to do this?

Comments welcome.

Mark

--------------070205010403000106090302
Content-Type: text/plain;
 name="rtc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc.patch"

===== drivers/char/Kconfig 1.60 vs edited =====
--- 1.60/drivers/char/Kconfig	2005-01-15 15:31:07 -07:00
+++ edited/drivers/char/Kconfig	2005-01-17 13:49:52 -07:00
@@ -777,6 +777,17 @@
 	  Provides an emulation for RTC_UIE which is required by some programs
 	  and may improve precision of the generic RTC support in some cases.
 
+config GEN_RTC_DISABLE_RTC_MAPPING
+	bool "Disable mapping genrtc interface to ppc-specific calls"
+	depends on GEN_RTC && PPC32
+	default n
+	help
+	  PPC systems typically map genrtc calls to PPC specific routines.
+	  However, this needs to be disabled when using an RTC chip whose
+	  driver implements the genrtc calls.
+
+	  To disable the mapping to PPC specific routines, chose Y here.
+
 config EFI_RTC
 	bool "EFI Real Time Clock Services"
 	depends on IA64
===== include/asm-ppc/rtc.h 1.7 vs edited =====
--- 1.7/include/asm-ppc/rtc.h	2003-09-12 09:26:56 -07:00
+++ edited/include/asm-ppc/rtc.h	2005-01-17 13:52:52 -07:00
@@ -42,6 +42,7 @@
 #define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
 
+#if !defined(CONFIG_GEN_RTC_DISABLE_RTC_MAPPING)
 static inline unsigned int get_rtc_time(struct rtc_time *time)
 {
 	if (ppc_md.get_rtc_time) {
@@ -91,5 +92,12 @@
 	return -EINVAL;
 }
 
+#else
+extern unsigned int get_rtc_time(struct rtc_time *time);
+extern int set_rtc_time(struct rtc_time *time);
+extern unsigned int get_rtc_ss(void);
+extern int get_rtc_pll(struct rtc_pll_info *pll);
+extern int set_rtc_pll(struct rtc_pll_info *pll);
+#endif
 #endif /* __KERNEL__ */
 #endif /* __ASM_RTC_H__ */

--------------070205010403000106090302--
