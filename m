Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 41AAE67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 15:27:14 +1100 (EST)
Date: Wed, 2 Mar 2005 22:26:56 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0503022222360.28697@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Add support for the Dallas 1553 RTC/NVRAM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

This patch adds support for the Dallas 1553 RTC/NVRAM.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/syslib/todc_time.c b/arch/ppc/syslib/todc_time.c
--- a/arch/ppc/syslib/todc_time.c	2005-03-02 22:05:08 -06:00
+++ b/arch/ppc/syslib/todc_time.c	2005-03-02 22:05:08 -06:00
@@ -287,6 +287,7 @@
 		limit = 1;
 
 		switch (todc_info->rtc_type) {
+			case TODC_TYPE_DS1553:
 			case TODC_TYPE_DS1557:
 			case TODC_TYPE_DS1743:
 			case TODC_TYPE_DS1746:	/* XXXX BAD HACK -> FIX */
@@ -322,6 +323,7 @@
 
 	if (todc_info->rtc_type != TODC_TYPE_MC146818) {
 		switch (todc_info->rtc_type) {
+			case TODC_TYPE_DS1553:
 			case TODC_TYPE_DS1557:
 			case TODC_TYPE_DS1743:
 			case TODC_TYPE_DS1746:	/* XXXX BAD HACK -> FIX */
@@ -418,6 +420,7 @@
 	unsigned char save_control = 0, val;
 
 	switch (todc_info->rtc_type) {
+		case TODC_TYPE_DS1553:
 		case TODC_TYPE_DS1557:
 		case TODC_TYPE_DS1746:	/* XXXX BAD HACK -> FIX */
 		case TODC_TYPE_DS1747:
@@ -432,6 +435,7 @@
 	val = todc_read_val(addr);
 
 	switch (todc_info->rtc_type) {
+		case TODC_TYPE_DS1553:
 		case TODC_TYPE_DS1557:
 		case TODC_TYPE_DS1746:	/* XXXX BAD HACK -> FIX */
 		case TODC_TYPE_DS1747:
diff -Nru a/include/asm-ppc/todc.h b/include/asm-ppc/todc.h
--- a/include/asm-ppc/todc.h	2005-03-02 22:05:08 -06:00
+++ b/include/asm-ppc/todc.h	2005-03-02 22:05:08 -06:00
@@ -98,6 +98,7 @@
 #define TODC_TYPE_PC97307		10	/* PC97307 internal RTC */
 #define TODC_TYPE_DS1557		11	/* Dallas DS1557 RTC */
 #define TODC_TYPE_DS17285		12	/* Dallas DS17285 RTC */
+#define TODC_TYPE_DS1553		13	/* Dallas DS1553 RTC */
 #define	TODC_TYPE_MC146818		100	/* Leave room for m48txx's */
 
 /*
@@ -207,6 +208,28 @@
 #define	TODC_TYPE_DS1501_FLAGS		(TODC_TYPE_DS1501_NVRAM_SIZE + 0xff)
 #define	TODC_TYPE_DS1501_NVRAM_ADDR_REG	0x10
 #define	TODC_TYPE_DS1501_NVRAM_DATA_REG	0x13
+
+#define	TODC_TYPE_DS1553_NVRAM_SIZE		0x1ff0
+#define	TODC_TYPE_DS1553_SW_FLAGS		0
+#define	TODC_TYPE_DS1553_YEAR			0x1fff
+#define	TODC_TYPE_DS1553_MONTH			0x1ffe
+#define	TODC_TYPE_DS1553_DOM			0x1ffd	/* Day of Month */
+#define	TODC_TYPE_DS1553_DOW			0x1ffc	/* Day of Week */
+#define	TODC_TYPE_DS1553_HOURS			0x1ffb
+#define	TODC_TYPE_DS1553_MINUTES		0x1ffa
+#define	TODC_TYPE_DS1553_SECONDS		0x1ff9
+#define	TODC_TYPE_DS1553_CNTL_B			0x1ff9
+#define	TODC_TYPE_DS1553_CNTL_A			0x1ff8	/* control_a R/W regs */
+#define	TODC_TYPE_DS1553_WATCHDOG		0x1ff7
+#define	TODC_TYPE_DS1553_INTERRUPTS		0x1ff6
+#define	TODC_TYPE_DS1553_ALARM_DATE		0x1ff5
+#define	TODC_TYPE_DS1553_ALARM_HOUR		0x1ff4
+#define	TODC_TYPE_DS1553_ALARM_MINUTES		0x1ff3
+#define	TODC_TYPE_DS1553_ALARM_SECONDS		0x1ff2
+#define	TODC_TYPE_DS1553_CENTURY		0x1ff8
+#define	TODC_TYPE_DS1553_FLAGS			0x1ff0
+#define	TODC_TYPE_DS1553_NVRAM_ADDR_REG		0
+#define	TODC_TYPE_DS1553_NVRAM_DATA_REG		0
 
 #define	TODC_TYPE_DS1557_NVRAM_SIZE		0x7fff0
 #define	TODC_TYPE_DS1557_SW_FLAGS		0
