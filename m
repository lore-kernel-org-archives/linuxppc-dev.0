Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 59C8F2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 09:37:24 +1000 (EST)
Date: Mon, 4 Oct 2004 16:37:19 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20041004163719.C13777@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Add U-Boot support to Ocotea/440GX port
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Adds support for booting the same Ocotea kernel from either the
default PIBS f/w or U-Boot.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile	2004-10-04 16:31:26 -07:00
+++ b/arch/ppc/boot/simple/Makefile	2004-10-04 16:31:26 -07:00
@@ -64,6 +64,7 @@
 zimageinitrd-$(CONFIG_OCOTEA)		:= zImage.initrd-TREE
          end-$(CONFIG_OCOTEA)		:= ocotea
   entrypoint-$(CONFIG_OCOTEA)		:= 0x01000000
+     extra.o-$(CONFIG_OCOTEA)		:= pibs.o 
 
      extra.o-$(CONFIG_EV64260)		:= direct.o misc-ev64260.o
          end-$(CONFIG_EV64260)		:= ev64260
diff -Nru a/arch/ppc/boot/simple/pibs.c b/arch/ppc/boot/simple/pibs.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/boot/simple/pibs.c	2004-10-04 16:31:26 -07:00
@@ -0,0 +1,101 @@
+/*
+ * 2004 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/config.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <asm/ppcboot.h>
+#include <platforms/4xx/ocotea.h>
+
+extern unsigned long decompress_kernel(unsigned long load_addr, int num_words,
+				       unsigned long cksum);
+
+/* We need to make sure that this is before the images to ensure
+ * that it's in a mapped location. - Tom */
+bd_t hold_resid_buf __attribute__ ((__section__ (".data.boot")));
+bd_t *hold_residual = &hold_resid_buf;
+
+/* String functions lifted from lib/vsprintf.c and lib/ctype.c */
+unsigned char _ctype[] = {
+_C,_C,_C,_C,_C,_C,_C,_C,			/* 0-7 */
+_C,_C|_S,_C|_S,_C|_S,_C|_S,_C|_S,_C,_C,		/* 8-15 */
+_C,_C,_C,_C,_C,_C,_C,_C,			/* 16-23 */
+_C,_C,_C,_C,_C,_C,_C,_C,			/* 24-31 */
+_S|_SP,_P,_P,_P,_P,_P,_P,_P,			/* 32-39 */
+_P,_P,_P,_P,_P,_P,_P,_P,			/* 40-47 */
+_D,_D,_D,_D,_D,_D,_D,_D,			/* 48-55 */
+_D,_D,_P,_P,_P,_P,_P,_P,			/* 56-63 */
+_P,_U|_X,_U|_X,_U|_X,_U|_X,_U|_X,_U|_X,_U,	/* 64-71 */
+_U,_U,_U,_U,_U,_U,_U,_U,			/* 72-79 */
+_U,_U,_U,_U,_U,_U,_U,_U,			/* 80-87 */
+_U,_U,_U,_P,_P,_P,_P,_P,			/* 88-95 */
+_P,_L|_X,_L|_X,_L|_X,_L|_X,_L|_X,_L|_X,_L,	/* 96-103 */
+_L,_L,_L,_L,_L,_L,_L,_L,			/* 104-111 */
+_L,_L,_L,_L,_L,_L,_L,_L,			/* 112-119 */
+_L,_L,_L,_P,_P,_P,_P,_C,			/* 120-127 */
+0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,		/* 128-143 */
+0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,		/* 144-159 */
+_S|_SP,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,   /* 160-175 */
+_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,       /* 176-191 */
+_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,       /* 192-207 */
+_U,_U,_U,_U,_U,_U,_U,_P,_U,_U,_U,_U,_U,_U,_U,_L,       /* 208-223 */
+_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,       /* 224-239 */
+_L,_L,_L,_L,_L,_L,_L,_P,_L,_L,_L,_L,_L,_L,_L,_L};      /* 240-255 */
+
+/**
+ * simple_strtoull - convert a string to an unsigned long long
+ * @cp: The start of the string
+ * @endp: A pointer to the end of the parsed string will be placed here
+ * @base: The number base to use
+ */
+unsigned long long simple_strtoull(const char *cp,char **endp,unsigned int base)
+{
+	unsigned long long result = 0,value;
+
+	if (!base) {
+		base = 10;
+		if (*cp == '0') {
+			base = 8;
+			cp++;
+			if ((toupper(*cp) == 'X') && isxdigit(cp[1])) {
+				cp++;
+				base = 16;
+			}
+		}
+	} else if (base == 16) {
+		if (cp[0] == '0' && toupper(cp[1]) == 'X')
+			cp += 2;
+	}
+	while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' : (islower(*cp)
+	    ? toupper(*cp) : *cp)-'A'+10) < base) {
+		result = result*base + value;
+		cp++;
+	}
+	if (endp)
+		*endp = (char *)cp;
+	return result;
+}
+
+void *
+load_kernel(unsigned long load_addr, int num_words, unsigned long cksum,
+		void *ign1, void *ign2)
+{
+	unsigned long long mac64;
+
+	decompress_kernel(load_addr, num_words, cksum);
+
+	mac64 = simple_strtoull((char *)OCOTEA_PIBS_MAC_BASE, 0, 16);
+	memcpy(hold_residual->bi_enetaddr, (char *)&mac64+2, 6);
+	mac64 = simple_strtoull((char *)(OCOTEA_PIBS_MAC_BASE+OCOTEA_PIBS_MAC_OFFSET), 0, 16);
+	memcpy(hold_residual->bi_enet1addr, (char *)&mac64+2, 6);
+	mac64 = simple_strtoull((char *)(OCOTEA_PIBS_MAC_BASE+OCOTEA_PIBS_MAC_OFFSET*2), 0, 16);
+	memcpy(hold_residual->bi_enet2addr, (char *)&mac64+2, 6);
+	mac64 = simple_strtoull((char *)(OCOTEA_PIBS_MAC_BASE+OCOTEA_PIBS_MAC_OFFSET*3), 0, 16);
+	memcpy(hold_residual->bi_enet3addr, (char *)&mac64+2, 6);
+	return (void *)hold_residual;
+}
diff -Nru a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
--- a/arch/ppc/platforms/4xx/ocotea.c	2004-10-04 16:31:26 -07:00
+++ b/arch/ppc/platforms/4xx/ocotea.c	2004-10-04 16:31:26 -07:00
@@ -47,6 +47,7 @@
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
+#include <asm/ppcboot.h>
 
 #include <syslib/ibm440gx_common.h>
 
@@ -58,13 +59,25 @@
 #include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
 
 extern void abort(void);
+bd_t __res;
+
+static struct ibm44x_clocks clocks;
+
+static int __init
+ocotea_get_dec_freq(void)
+{
+	if (mfspr(SPRN_CCR1) & CCR1_TCS)
+		return OCOTEA_TMR_CLK;
+	else
+		return clocks.cpu;
+}
 
 static void __init
 ocotea_calibrate_decr(void)
 {
 	unsigned int freq;
 
-	freq = OCOTEA_SYSCLK;
+	freq = ocotea_get_dec_freq();
 
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
@@ -107,6 +120,46 @@
 	return PCI_IRQ_TABLE_LOOKUP;
 }
 
+static void __init ocotea_set_emacdata(void)
+{
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+	int i;
+
+	/*
+	 * Note: Current rev. board only operates in Group 4a
+	 * mode, so we always set EMAC0-1 for SMII and EMAC2-3
+	 * for RGMII (though these could run in RTBI just the same).
+	 *
+	 * The FPGA reg 3 information isn't even suitable for
+	 * determining the phy_mode, so if the board becomes
+	 * usable in !4a, it will be necessary to parse an environment
+	 * variable from the firmware or similar to properly configure
+	 * the phy_map/phy_mode.
+	 */
+	/* Set phy_map, phy_mode, and mac_addr for each EMAC */
+	for (i=0; i<4; i++) {
+		def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, i);
+		emacdata = def->additions;
+		if (i < 2) {
+			emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+			emacdata->phy_mode = PHY_MODE_SMII;
+		}
+		else {
+			emacdata->phy_map = 0x0000ffff; /* Skip 0x00-0x0f */
+			emacdata->phy_mode = PHY_MODE_RGMII;
+		}
+		if (i == 0)
+			memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+		else if (i == 1)
+			memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+		else if (i == 2)
+			memcpy(emacdata->mac_addr, __res.bi_enet2addr, 6);
+		else if (i == 3)
+			memcpy(emacdata->mac_addr, __res.bi_enet3addr, 6);
+	}
+}
+
 #define PCIX_READW(offset) \
 	(readw((u32)pcix_reg_base+offset))
 
@@ -209,7 +262,7 @@
 TODC_ALLOC();
 
 static void __init
-ocotea_early_serial_map(const struct ibm44x_clocks *clks)
+ocotea_early_serial_map(void)
 {
 	struct uart_port port;
 
@@ -217,7 +270,7 @@
 	memset(&port, 0, sizeof(port));
 	port.membase = ioremap64(PPC440GX_UART0_ADDR, 8);
 	port.irq = UART0_INT;
-	port.uartclk = clks->uart0;
+	port.uartclk = clocks.uart0;
 	port.regshift = 0;
 	port.iotype = SERIAL_IO_MEM;
 	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
@@ -229,7 +282,7 @@
 
 	port.membase = ioremap64(PPC440GX_UART1_ADDR, 8);
 	port.irq = UART1_INT;
-	port.uartclk = clks->uart1;
+	port.uartclk = clocks.uart1;
 	port.line = 1;
 
 	if (early_serial_setup(&port) != 0) {
@@ -240,41 +293,7 @@
 static void __init
 ocotea_setup_arch(void)
 {
-	unsigned char *addr;
-	unsigned long long mac64;
-	struct ocp_def *def;
-	struct ocp_func_emac_data *emacdata;
-	int i;
-	struct ibm44x_clocks clocks;
-
-	/*
-	 * Note: Current rev. board only operates in Group 4a
-	 * mode, so we always set EMAC0-1 for SMII and EMAC2-3
-	 * for RGMII (though these could run in RTBI just the same).
-	 *
-	 * The FPGA reg 3 information isn't even suitable for
-	 * determining the phy_mode, so if the board becomes
-	 * usable in !4a, it will be necessary to parse an environment
-	 * variable from the firmware or similar to properly configure
-	 * the phy_map/phy_mode.
-	 */
-	/* Set phy_map, phy_mode, and mac_addr for each EMAC */
-	addr = ioremap64(OCOTEA_MAC_BASE, OCOTEA_MAC_SIZE);
-	for (i=0; i<4; i++) {
-		mac64 = simple_strtoull(addr+OCOTEA_MAC_OFFSET*i, 0, 16);
-		def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, i);
-		emacdata = def->additions;
-		if (i < 2) {
-			emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
-			emacdata->phy_mode = PHY_MODE_SMII;
-		}
-		else {
-			emacdata->phy_map = 0x0000ffff; /* Skip 0x00-0x0f */
-			emacdata->phy_mode = PHY_MODE_RGMII;
-		}
-		memcpy(emacdata->mac_addr, (char *)&mac64+2, 6);
-	}
-	iounmap(addr);
+	ocotea_set_emacdata();
 
 	ibm440gx_tah_enable();
 
@@ -319,7 +338,7 @@
 		ROOT_DEV = Root_HDA1;
 #endif
 
-	ocotea_early_serial_map(&clocks);
+	ocotea_early_serial_map();
 
 	/* Identify the system */
 	printk("IBM Ocotea port (MontaVista Software, Inc. <source@mvista.com>)\n");
@@ -454,19 +473,17 @@
 }
 #endif /* CONFIG_SERIAL_TEXT_DEBUG */
 
-#if 0
-static void __init
-ocotea_map_io(void)
-{
-	io_block_mapping(0xe0000000, 0x0000000140000000,
-			 0x00001000, _PAGE_IO);
-}
-#endif
-
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3)
+		__res = *(bd_t *)(r3 + KERNELBASE);
 
 	/* Disable L2-Cache due to hardware issues */
 	ibm440gx_l2c_disable();
diff -Nru a/arch/ppc/platforms/4xx/ocotea.h b/arch/ppc/platforms/4xx/ocotea.h
--- a/arch/ppc/platforms/4xx/ocotea.h	2004-10-04 16:31:26 -07:00
+++ b/arch/ppc/platforms/4xx/ocotea.h	2004-10-04 16:31:26 -07:00
@@ -24,13 +24,14 @@
 /* F/W TLB mapping used in bootloader glue to reset EMAC */
 #define PPC44x_EMAC0_MR0	0xE0000800
 
-/* Location of MAC addresses in firmware */
-#define OCOTEA_MAC_BASE		(OCOTEA_SMALL_FLASH_HIGH+0xb0500)
-#define OCOTEA_MAC_SIZE		0x200
-#define OCOTEA_MAC_OFFSET	0x100
+/* Location of MAC addresses in PIBS image */
+#define OCOTEA_PIBS_FLASH	0xfff00000
+#define OCOTEA_PIBS_MAC_BASE	(OCOTEA_PIBS_FLASH+0xb0500)
+#define OCOTEA_PIBS_MAC_SIZE	0x200
+#define OCOTEA_PIBS_MAC_OFFSET	0x100
 
-/* Default clock rate */
-#define OCOTEA_SYSCLK		25000000
+/* External timer clock frequency */
+#define OCOTEA_TMR_CLK	25000000
 
 /* RTC/NVRAM location */
 #define OCOTEA_RTC_ADDR		0x0000000148000000ULL
diff -Nru a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
--- a/include/asm-ppc/reg_booke.h	2004-10-04 16:31:26 -07:00
+++ b/include/asm-ppc/reg_booke.h	2004-10-04 16:31:26 -07:00
@@ -123,9 +123,10 @@
 #define SPRN_PID2	0x27A	/* Process ID Register 2 */
 #define SPRN_TLB0CFG	0x2B0	/* TLB 0 Config Register */
 #define SPRN_TLB1CFG	0x2B1	/* TLB 1 Config Register */
+#define SPRN_CCR1	0x378	/* Core Configuration Register 1 */
 #define SPRN_ZPR	0x3B0	/* Zone Protection Register (40x) */
 #define SPRN_MMUCR	0x3B2	/* MMU Control Register */
-#define SPRN_CCR0	0x3B3	/* Core Configuration Register */
+#define SPRN_CCR0	0x3B3	/* Core Configuration Register 0 */
 #define SPRN_SGR	0x3B9	/* Storage Guarded Register */
 #define SPRN_DCWR	0x3BA	/* Data Cache Write-thru Register */
 #define SPRN_SLER	0x3BB	/* Little-endian real mode */
@@ -178,6 +179,9 @@
 #define SPRN_CSRR0	SPRN_SRR2 /* Critical Save and Restore Register 0 */
 #define SPRN_CSRR1	SPRN_SRR3 /* Critical Save and Restore Register 1 */
 #endif
+
+/* Bit definitions for CCR1. */
+#define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
 /* Bit definitions for the MCSR. */
 #ifdef CONFIG_440A
