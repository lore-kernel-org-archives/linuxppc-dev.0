From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 18 Jun 2004 13:04:14 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: MPC52xx lite5200 support for booting from dBUG
Message-ID: <20040618200414.GA25461@zenos.farnsworth.org>
References: <20040603090635.B7347@home.com> <20040603164245.B24A9C109F@atlas.denx.de> <20040603113302.A24468@home.com> <20040603185053.GN15195@smtp.west.cox.net> <40BF87BB.4020808@246tNt.com> <20040603134804.B24468@home.com> <40C8BB6C.4040709@246tNt.com> <20040618192046.GA22607@zenos.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040618192046.GA22607@zenos.farnsworth.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch allows Sylvain's 2.6 support for the lite5200 to boot
from dBUG as well as U-Boot.

When the arch/ppc/boot/simple bootwrapper is used, it computes the
values that U-boot would have supplied and stores them in __res.
That works for all needed fields except __res.bi_baudrate, which
can't be determined from the environment.  So, I added
CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD to supply the default baud rate.
The value of CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD is ignored if the
bootloader (U-boot) supplies the baudrate.

-Dale Farnsworth


===== arch/ppc/boot/common/misc-common.c 1.11 vs edited =====
--- 1.11/arch/ppc/boot/common/misc-common.c	2003-09-12 09:26:51 -07:00
+++ edited/arch/ppc/boot/common/misc-common.c	2004-06-11 17:29:30 -07:00
@@ -59,7 +59,7 @@
 void _vprintk(void(*putc)(const char), const char *fmt0, va_list ap);
 unsigned char *ISA_io = NULL;

-#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_CORE_CONSOLE)
 extern unsigned long com_port;

 extern int serial_tstc(unsigned long com_port);
@@ -80,7 +80,7 @@

 int tstc(void)
 {
-#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_CORE_CONSOLE)
 	if(keyb_present)
 		return (CRT_tstc() || serial_tstc(com_port));
 	else
@@ -93,7 +93,7 @@
 int getc(void)
 {
 	while (1) {
-#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_CORE_CONSOLE)
 		if (serial_tstc(com_port))
 			return (serial_getc(com_port));
 #endif /* serial console */
@@ -108,7 +108,7 @@
 {
 	int x,y;

-#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_CORE_CONSOLE)
 	serial_putc(com_port, c);
 	if ( c == '\n' )
 		serial_putc(com_port, '\r');
@@ -155,7 +155,7 @@
 	y = orig_y;

 	while ( ( c = *s++ ) != '\0' ) {
-#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_CORE_CONSOLE)
 	        serial_putc(com_port, c);
 	        if ( c == '\n' ) serial_putc(com_port, '\r');
 #endif /* serial console */
===== arch/ppc/boot/simple/Makefile 1.30 vs edited =====
--- 1.30/arch/ppc/boot/simple/Makefile	2004-05-27 01:26:54 -07:00
+++ edited/arch/ppc/boot/simple/Makefile	2004-06-11 16:25:53 -07:00
@@ -113,6 +113,12 @@
   entrypoint-$(CONFIG_SPRUCE)		:= 0x00800000
         misc-$(CONFIG_SPRUCE)		+= misc-spruce.o

+      zimage-$(CONFIG_LITE5200)		:= zImage-STRIPELF
+zimageinitrd-$(CONFIG_LITE5200)		:= zImage.initrd-STRIPELF
+         end-$(CONFIG_LITE5200)		:= lite5200
+   cacheflag-$(CONFIG_LITE5200)		:= -include $(clear_L2_L3)
+
+
 # SMP images should have a '.smp' suffix.
          end-$(CONFIG_SMP)             := $(end-y).smp

@@ -143,6 +149,9 @@
 boot-$(CONFIG_8xx)		+= m8xx_tty.o
 boot-$(CONFIG_8260)		+= m8260_tty.o
 boot-$(CONFIG_GT64260_CONSOLE)	+= gt64260_tty.o
+endif
+ifeq ($(CONFIG_SERIAL_CORE_CONSOLE),y)
+boot-$(CONFIG_SERIAL_MPC52xx_CONSOLE) += mpc52xx_tty.o
 endif

 LIBS				:= $(common)/lib.a $(bootlib)/lib.a
===== arch/ppc/platforms/lite5200.c 1.1 vs edited =====
--- 1.1/arch/ppc/platforms/lite5200.c	2004-06-11 14:50:24 -07:00
+++ edited/arch/ppc/platforms/lite5200.c	2004-06-17 14:38:17 -07:00
@@ -72,28 +72,34 @@
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
               unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo(find_bootinfo());

 	/* Generic MPC52xx platform initialization */
 	/* TODO Create one and move a max of stuff in it.
 	   Put this init in the syslib */

-	/* Load the bd_t board info structure */
-	if (r3)
-		memcpy((void*)&__res,(void*)(r3+KERNELBASE), sizeof(bd_t));
+	struct bi_record *bootinfo = find_bootinfo();
+
+	if (bootinfo)
+		parse_bootinfo(bootinfo);
+	else {
+		/* Load the bd_t board info structure */
+		if (r3)
+			memcpy((void*)&__res,(void*)(r3+KERNELBASE),
+					sizeof(bd_t));

 #ifdef CONFIG_BLK_DEV_INITRD
-	/* Load the initrd */
-	if (r4) {
-		initrd_start = r4 + KERNELBASE;
-		initrd_end = r5 + KERNELBASE;
-	}
+		/* Load the initrd */
+		if (r4) {
+			initrd_start = r4 + KERNELBASE;
+			initrd_end = r5 + KERNELBASE;
+		}
 #endif

-	/* Load the command line */
-	if (r6) {
-		*(char *)(r7+KERNELBASE) = 0;
-		strcpy(cmd_line, (char *)(r6+KERNELBASE));
+		/* Load the command line */
+		if (r6) {
+			*(char *)(r7+KERNELBASE) = 0;
+			strcpy(cmd_line, (char *)(r6+KERNELBASE));
+		}
 	}

 	/* BAT setup */
===== arch/ppc/syslib/mpc52xx_setup.c 1.1 vs edited =====
--- 1.1/arch/ppc/syslib/mpc52xx_setup.c	2004-06-11 14:50:26 -07:00
+++ edited/arch/ppc/syslib/mpc52xx_setup.c	2004-06-17 15:14:53 -07:00
@@ -32,6 +32,14 @@
 #include <asm/mpc52xx_psc.h>
 #include <asm/ppcboot.h>

+extern bd_t __res;
+
+static int cpu_52xx[] = {
+	0,  0,  0,  10, 20, 20, 25, 45,
+	30, 55, 40, 50, 0,  60, 35, 0,
+	30, 25, 65, 10, 70, 20, 75, 45,
+	0,  55, 40, 50, 80, 60, 35, 0
+};

 void
 mpc52xx_restart(char *cmd)
@@ -110,8 +118,25 @@
 unsigned long __init
 mpc52xx_find_end_of_memory(void)
 {
-	/* We just read uBoot. We don't support anything else right now */
-	return __res.bi_memsize;
+	u32 ramsize = __res.bi_memsize;
+
+	/*
+	 * if bootloader passed a memsize, just use it
+	 * else get size from sdram config registers
+	 */
+	if (ramsize == 0) {
+		u32 sdram_config_0 = in_be32((u32 *)MPC52xx_SDRAM_CONFIG_0);
+		u32 sdram_config_1 = in_be32((u32 *)MPC52xx_SDRAM_CONFIG_1);
+
+		if ((sdram_config_0 & 0x1f) >= 0x13)
+			ramsize = 1 << ((sdram_config_0 & 0xf) + 17);
+
+		if (((sdram_config_1 & 0x1f) >= 0x13) &&
+				((sdram_config_1 & 0xfff00000) == ramsize))
+			ramsize += 1 << ((sdram_config_1 & 0xf) + 17);
+	}
+
+	return ramsize;
 }

 void __init
@@ -125,12 +150,46 @@
 mpc52xx_calibrate_decr(void)
 {
 	int freq, divisor;
-
+	struct mpc52xx_rtc *rtc = (struct mpc52xx_rtc*)MPC52xx_RTC;
+	struct mpc52xx_cdm *cdm = (struct mpc52xx_cdm*)MPC52xx_CDM;
+	int current_time, previous_time;
+	int tbl_start, tbl_end;
+	int cpufreq, ipbfreq, pcifreq;
+
 	freq = __res.bi_busfreq;
+	/* if bootloader didn't pass bus frequencies, calculate them */
+	if (freq == 0) {
+		previous_time = in_be32(&rtc->time);
+		while ((current_time = in_be32(&rtc->time)) == previous_time) ;
+		tbl_start = get_tbl();
+		previous_time = current_time;
+		while ((current_time = in_be32(&rtc->time)) == previous_time) ;
+		tbl_end = get_tbl();
+
+		freq = (tbl_end - tbl_start) * 4;
+
+		cpufreq = freq / 10 * cpu_52xx[in_be32(&cdm->rstcfg) & 0x1f];
+		ipbfreq = (in_8(&cdm->ipb_clk_sel) & 1) ?
+					freq / 2 : freq;
+		switch (in_8(&cdm->pci_clk_sel) & 3) {
+		case 0:
+			pcifreq = ipbfreq;
+			break;
+		case 1:
+			pcifreq = ipbfreq / 2;
+			break;
+		default:
+			pcifreq = ipbfreq / 4;
+			break;
+		}
+		__res.bi_busfreq = freq;
+		__res.bi_intfreq = cpufreq;
+		__res.bi_ipbfreq = ipbfreq;
+		__res.bi_pcifreq = pcifreq;
+	}

 	divisor = 4;

 	tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
 }
-
===== drivers/serial/Kconfig 1.32 vs edited =====
--- 1.32/drivers/serial/Kconfig	2004-06-11 14:50:23 -07:00
+++ edited/drivers/serial/Kconfig	2004-06-17 15:02:12 -07:00
@@ -633,6 +633,15 @@
 	help
 	  Select this options if you'd like to use one of the PSC serial port
 	  of the Freescale MPC52xx family as a console.
+
+config SERIAL_MPC52xx_CONSOLE_BAUD
+	int "Freescale MPC52xx family PSC serial port baud"
+	depends on SERIAL_MPC52xx_CONSOLE=y
+	default "9600"
+	help
+	  Select the MPC52xx console baud rate.
+	  This value is only used if the bootloader doesn't pass in the
+	  console baudrate

 endmenu

===== drivers/serial/mpc52xx_uart.c 1.1 vs edited =====
--- 1.1/drivers/serial/mpc52xx_uart.c	2004-06-11 14:50:26 -07:00
+++ edited/drivers/serial/mpc52xx_uart.c	2004-06-17 15:28:36 -07:00
@@ -562,9 +565,11 @@
 	out_8(&psc->command,MPC52xx_PSC_SEL_MODE_REG_1);
 	mr1 = in_8(&psc->mode);

-	/* Parse them */
-	*baud = __res.bi_baudrate;	/* CT{U,L}R are write-only ! */
+	/* CT{U,L}R are write-only ! */
+	*baud = __res.bi_baudrate ?
+		__res.bi_baudrate : CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;

+	/* Parse them */
 	switch (mr1 & MPC52xx_PSC_MODE_BITS_MASK) {
 		case MPC52xx_PSC_MODE_5_BITS:	*bits = 5; break;
 		case MPC52xx_PSC_MODE_6_BITS:	*bits = 6; break;
===== include/asm-ppc/mpc52xx.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/mpc52xx.h	2004-06-11 14:50:27 -07:00
+++ edited/include/asm-ppc/mpc52xx.h	2004-06-17 15:09:58 -07:00
@@ -68,6 +68,7 @@
 #define MPC52xx_SFTRST_BIT	0x01000000
 #define MPC52xx_INTR		(MPC52xx_MBAR + 0x0500)
 #define MPC52xx_GPT		(MPC52xx_MBAR + 0x0600)
+#define MPC52xx_RTC		(MPC52xx_MBAR + 0x0800)
 #define MPC52xx_MSCAN1		(MPC52xx_MBAR + 0x0900)
 #define MPC52xx_MSCAN2		(MPC52xx_MBAR + 0x0980)
 #define MPC52xx_GPIO		(MPC52xx_MBAR + 0x0b00)
@@ -280,6 +281,18 @@
 	volatile u32		EU37;		/* SDMA + 0xfc */
 };

+struct mpc52xx_rtc {
+	volatile u32 time_set;          /* RTC + 0x00 */
+	volatile u32 date_set;          /* RTC + 0x04 */
+	volatile u32 stopwatch;         /* RTC + 0x08 */
+	volatile u32 int_enable;        /* RTC + 0x0c */
+	volatile u32 time;              /* RTC + 0x10 */
+	volatile u32 date;              /* RTC + 0x14 */
+	volatile u32 stopwatch_intr;    /* RTC + 0x18 */
+	volatile u32 bus_error;         /* RTC + 0x1c */
+	volatile u32 dividers;          /* RTC + 0x20 */
+};
+
 /* GPIO */
 struct mpc52xx_gpio {
 	volatile u32		port_config;	/* GPIO + 0x00 */
@@ -312,6 +325,10 @@
 	volatile u8		reserved10;	/* GPIO + 0x3f */
 };

+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITHOUT_CD	4
+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITH_CD	5
+#define MPC52xx_GPIO_PCI_DIS			(1<<15)
+
 /* XLB Bus control */
 struct mpc52xx_xlb {
 	volatile u8  reserved[0x40];

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
