Date: Thu, 12 Dec 2002 14:54:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Move 405LP RTC support from beech.c into ibm405lp.c
Message-ID: <20021212035459.GF4631@zax.zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The RTC support (written by Todd Poynor) for the Beech is actually in
the 405LP chip itself, not just on the Beech board.  This patch moves
the code into ibm405lp.c so that it's more easily accessible for
non-Beech 405LP boards (there aren't any of these in the tree at the
moment, but I expect to commit one within the week).

If there are no objections, I will commit this to linuxppc_2_4_devel.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/beech.c linux-bartholomew/arch/ppc/platforms/beech.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/beech.c	2002-12-04 10:44:50.000000000 +1100
+++ linux-bartholomew/arch/ppc/platforms/beech.c	2002-12-12 14:21:55.000000000 +1100
@@ -45,10 +45,6 @@
 static void beech_ebc_setup(void);
 static void beech_fpga_setup(void);

-static long __init beech_time_init(void);
-static ulong beech_get_rtc_time(void);
-static int beech_set_rtc_time(unsigned long nowtime);
-
 unsigned long isa_io_base;
 unsigned long isa_mem_base;
 volatile u8 *beech_fpga_reg_0 = NULL;
@@ -133,9 +129,9 @@
 void __init
 board_init(void)
 {
-	ppc_md.time_init = beech_time_init;
-	ppc_md.set_rtc_time = beech_set_rtc_time;
-	ppc_md.get_rtc_time = beech_get_rtc_time;
+	ppc_md.time_init = ibm405lp_time_init;
+	ppc_md.set_rtc_time = ibm405lp_set_rtc_time;
+	ppc_md.get_rtc_time = ibm405lp_get_rtc_time;

 	/* Disable the LCD controller, which may have been left on by the
 	   BIOS.  Then do initialization of the EBC. */
@@ -259,119 +255,6 @@
 	*beech_fpga_reg_2 |= FPGA_REG_2_DEFAULT_UART1_N;
 }

-/****************************************************************************
- * TODC
- ****************************************************************************/
-
-/*
- * The 405LP includes an MC146818-equivalent core accessed via a DCR
- * wrapper.  The 405LP does not implement the NVRAM.
- */
-
-static long __init
-beech_time_init(void)
-{
-	static u_char	not_initialized = 1;
-
-	/* Make sure clocks are running */
-	if (not_initialized) {
-
-		/* Reset the core and ensure it's enabled.  We assume
-		   only that the BIOS has set the correct frequency. */
-
-		mtdcr(DCRN_RTC0_WRAP, 0);
-		mtdcr(DCRN_RTC0_WRAP, 3);
-		mtdcr(DCRN_RTC0_CR1, mfdcr(DCRN_RTC0_CR1) & 0x7f);
-		not_initialized = 0;
-	}
-
-	return 0;
-}
-
-static ulong
-beech_get_rtc_time(void)
-{
-	uint	year, mon, day, hour, min, sec;
-	uint	i;
-	u_char	save_control, uip;
-
-	spin_lock(&rtc_lock);
-	save_control = mfdcr(DCRN_RTC0_CR1);
-
-	for (i=0; i<100000000; i++) {
-		uip = mfdcr(DCRN_RTC0_CR0);
-		sec = mfdcr(DCRN_RTC0_SEC) & 0x7f;
-		min = mfdcr(DCRN_RTC0_MIN) & 0x7f;
-		hour = mfdcr(DCRN_RTC0_HR) & 0x3f;
-		day = mfdcr(DCRN_RTC0_DOM) & 0x3f;
-		mon = mfdcr(DCRN_RTC0_MONTH) & 0x1f;
-		year = mfdcr(DCRN_RTC0_YEAR) & 0xff;
-
-		uip |= mfdcr(DCRN_RTC0_CR0);
-		if ((uip & RTC_UIP) == 0) break;
-	}
-
-	spin_unlock(&rtc_lock);
-
-	if (((save_control & RTC_DM_BINARY) == 0) ||
-	    RTC_ALWAYS_BCD) {
-
-		BCD_TO_BIN(sec);
-		BCD_TO_BIN(min);
-		BCD_TO_BIN(hour);
-		BCD_TO_BIN(day);
-		BCD_TO_BIN(mon);
-		BCD_TO_BIN(year);
-	}
-
-	year = year + 1900;
-	if (year < 1970) {
-		year += 100;
-	}
-
-	return mktime(year, mon, day, hour, min, sec);
-}
-
-static int
-beech_set_rtc_time(unsigned long nowtime)
-{
-	struct rtc_time	tm;
-	u_char		save_control, save_freq_select;
-
-	spin_lock(&rtc_lock);
-	to_tm(nowtime, &tm);
-
-	save_control = mfdcr(DCRN_RTC0_CR1);
-	save_freq_select = mfdcr(DCRN_RTC0_CR0);
-	mtdcr(DCRN_RTC0_CR0, save_freq_select | RTC_DIV_RESET2);
-
-        tm.tm_year = (tm.tm_year - 1900) % 100;
-
-	if (((save_control & RTC_DM_BINARY) == 0) ||
-	    RTC_ALWAYS_BCD) {
-
-		BIN_TO_BCD(tm.tm_sec);
-		BIN_TO_BCD(tm.tm_min);
-		BIN_TO_BCD(tm.tm_hour);
-		BIN_TO_BCD(tm.tm_mon);
-		BIN_TO_BCD(tm.tm_mday);
-		BIN_TO_BCD(tm.tm_year);
-	}
-
-	mtdcr(DCRN_RTC0_SEC,   tm.tm_sec);
-	mtdcr(DCRN_RTC0_MIN,   tm.tm_min);
-	mtdcr(DCRN_RTC0_HR,    tm.tm_hour);
-	mtdcr(DCRN_RTC0_MONTH, tm.tm_mon);
-	mtdcr(DCRN_RTC0_DOM,   tm.tm_mday);
-	mtdcr(DCRN_RTC0_YEAR,  tm.tm_year);
-	mtdcr(DCRN_RTC0_WRAP, 0); /* Reset divider chain */
-	mtdcr(DCRN_RTC0_WRAP, 3);
-	mtdcr(DCRN_RTC0_CR0, save_freq_select);
-
-	spin_unlock(&rtc_lock);
-	return 0;
-}
-
 void __init
 beech_calibrate_decr(void)
 {
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405lp.c linux-bartholomew/arch/ppc/platforms/ibm405lp.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405lp.c	2002-08-29 09:59:52.000000000 +1000
+++ linux-bartholomew/arch/ppc/platforms/ibm405lp.c	2002-12-12 14:24:33.000000000 +1100
@@ -265,3 +265,114 @@
 		return 0;
 	}
 }
+
+/****************************************************************************
+ * TODC
+ ****************************************************************************/
+
+/*
+ * The 405LP includes an MC146818-equivalent core accessed via a DCR
+ * wrapper.  The 405LP does not implement the NVRAM.
+ */
+
+long __init ibm405lp_time_init(void)
+{
+	static u_char	not_initialized = 1;
+
+	/* Make sure clocks are running */
+	if (not_initialized) {
+
+		/* Reset the core and ensure it's enabled.  We assume
+		   only that the BIOS has set the correct frequency. */
+
+		mtdcr(DCRN_RTC0_WRAP, 0);
+		mtdcr(DCRN_RTC0_WRAP, 3);
+		mtdcr(DCRN_RTC0_CR1, mfdcr(DCRN_RTC0_CR1) & 0x7f);
+		not_initialized = 0;
+	}
+
+	return 0;
+}
+
+unsigned long ibm405lp_get_rtc_time(void)
+{
+	uint	year, mon, day, hour, min, sec;
+	uint	i;
+	u_char	save_control, uip;
+
+	spin_lock(&rtc_lock);
+	save_control = mfdcr(DCRN_RTC0_CR1);
+
+	for (i=0; i<100000000; i++) {
+		uip = mfdcr(DCRN_RTC0_CR0);
+		sec = mfdcr(DCRN_RTC0_SEC) & 0x7f;
+		min = mfdcr(DCRN_RTC0_MIN) & 0x7f;
+		hour = mfdcr(DCRN_RTC0_HR) & 0x3f;
+		day = mfdcr(DCRN_RTC0_DOM) & 0x3f;
+		mon = mfdcr(DCRN_RTC0_MONTH) & 0x1f;
+		year = mfdcr(DCRN_RTC0_YEAR) & 0xff;
+
+		uip |= mfdcr(DCRN_RTC0_CR0);
+		if ((uip & RTC_UIP) == 0) break;
+	}
+
+	spin_unlock(&rtc_lock);
+
+	if (((save_control & RTC_DM_BINARY) == 0) ||
+	    RTC_ALWAYS_BCD) {
+
+		BCD_TO_BIN(sec);
+		BCD_TO_BIN(min);
+		BCD_TO_BIN(hour);
+		BCD_TO_BIN(day);
+		BCD_TO_BIN(mon);
+		BCD_TO_BIN(year);
+	}
+
+	year = year + 1900;
+	if (year < 1970) {
+		year += 100;
+	}
+
+	return mktime(year, mon, day, hour, min, sec);
+}
+
+int ibm405lp_set_rtc_time(unsigned long nowtime)
+{
+	struct rtc_time	tm;
+	u_char		save_control, save_freq_select;
+
+	spin_lock(&rtc_lock);
+	to_tm(nowtime, &tm);
+
+	save_control = mfdcr(DCRN_RTC0_CR1);
+	save_freq_select = mfdcr(DCRN_RTC0_CR0);
+	mtdcr(DCRN_RTC0_CR0, save_freq_select | RTC_DIV_RESET2);
+
+        tm.tm_year = (tm.tm_year - 1900) % 100;
+
+	if (((save_control & RTC_DM_BINARY) == 0) ||
+	    RTC_ALWAYS_BCD) {
+
+		BIN_TO_BCD(tm.tm_sec);
+		BIN_TO_BCD(tm.tm_min);
+		BIN_TO_BCD(tm.tm_hour);
+		BIN_TO_BCD(tm.tm_mon);
+		BIN_TO_BCD(tm.tm_mday);
+		BIN_TO_BCD(tm.tm_year);
+	}
+
+	mtdcr(DCRN_RTC0_SEC,   tm.tm_sec);
+	mtdcr(DCRN_RTC0_MIN,   tm.tm_min);
+	mtdcr(DCRN_RTC0_HR,    tm.tm_hour);
+	mtdcr(DCRN_RTC0_MONTH, tm.tm_mon);
+	mtdcr(DCRN_RTC0_DOM,   tm.tm_mday);
+	mtdcr(DCRN_RTC0_YEAR,  tm.tm_year);
+	mtdcr(DCRN_RTC0_WRAP, 0); /* Reset divider chain */
+	mtdcr(DCRN_RTC0_WRAP, 3);
+	mtdcr(DCRN_RTC0_CR0, save_freq_select);
+
+	spin_unlock(&rtc_lock);
+	return 0;
+}
+
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405lp.h linux-bartholomew/arch/ppc/platforms/ibm405lp.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405lp.h	2002-08-29 09:59:52.000000000 +1000
+++ linux-bartholomew/arch/ppc/platforms/ibm405lp.h	2002-12-12 14:20:38.000000000 +1100
@@ -32,6 +32,12 @@
 #include <linux/config.h>
 #include <asm/ibm4xx.h>

+/* See beech.c for a concise diagram of the Beech physical memory map. */
+
+#define PPC4xx_ONB_IO_PADDR    ((uint)0xef600000)
+#define PPC4xx_ONB_IO_VADDR    PPC4xx_ONB_IO_PADDR
+#define PPC4xx_ONB_IO_SIZE     ((uint)4*1024)
+
 /* Machine-specific register naming for the 4xx processors is a mess. It seems
    that everyone had a different idea on how to prefix/abbreviate/configure the
    DCR numbers and MMIO addresses.  I'm no different! For the 405LP we have
@@ -895,6 +901,10 @@
 extern unsigned last_pixclk_min;
 extern unsigned last_pixclk_max;

+extern long ibm405lp_time_init(void);
+extern unsigned long ibm405lp_get_rtc_time(void);
+extern int ibm405lp_set_rtc_time(unsigned long nowtime);
+
 #endif				/* __ASSEMBLY__ */

 #include <platforms/ibm405.h>


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
