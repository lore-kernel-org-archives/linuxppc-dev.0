Return-Path: <marcelo.tosatti@cyclades.com>
Date: Mon, 14 Nov 2005 10:45:38 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	linux-ppc-dev <linuxppc-dev@ozlabs.org>
Message-ID: <20051114124538.GB28633@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PLEASE REVIEW] ppc32 8xx: core PRxK board family support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The following patch adds support for Cyclades's PRxK boards (based on
the 855T processor). These boards are used to build dedicated HW such as
console servers and KVM managers. There are about 15 board configurations
supported.

We would like to merge the support in to the mainline kernel. This would
facilitate our maintenance burden and also allow users to compile their
own kernels more easily.

Any comments (including coding style ones) are welcome.


diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/Kconfig linux-2.6.14-rc4/arch/ppc/Kconfig
--- linux-2.6.14-rc4.orig/arch/ppc/Kconfig	2005-10-18 16:59:34.000000000 -0500
+++ linux-2.6.14-rc4/arch/ppc/Kconfig	2005-10-24 12:45:43.000000000 -0500
@@ -455,6 +455,12 @@ config TQM860L
 	  <http://www.denx.de/PDF/STK8xxLHWM201.pdf>, and an image at
 	  <http://www.denx.de/embedded-ppc-en.html>.
 
+config PRxK
+	bool "PRxK"
+	help
+	  Say Y here to support Cyclades embedded PowerPC family: console
+	  servers, kvm managers, routers, etc.
+
 config FPS850L
 	bool "FPS850L"
 
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/boot/include/cyc_banner.h linux-2.6.14-rc4/arch/ppc/boot/include/cyc_banner.h
--- linux-2.6.14-rc4.orig/arch/ppc/boot/include/cyc_banner.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4/arch/ppc/boot/include/cyc_banner.h	2005-10-25 07:01:57.000000000 -0500
@@ -0,0 +1,74 @@
+static char PROD_LINE0[] = "Cyclades";
+static char PROD_NAME0[] = " TS";
+
+static char PROD_LINE1[] = "AlterPath";
+static char PROD_NAME1[] = " CS";
+
+#define PROD_LINE3			PROD_LINE1
+static char PROD_NAME3[] = " ACS";
+
+#define PROD_LINE2			PROD_LINE1
+static char PROD_NAME2[] = " SM";
+
+#define PROD_LINE4			PROD_LINE1
+static char PROD_NAME4[] = " KVM";
+
+#define PROD_LINE5			PROD_LINE1
+static char PROD_NAME5[] = " KVM/net";
+
+#define PROD_LINE6          PROD_LINE1
+static char PROD_NAME6[] = " ONS";
+
+#define PROD_LINE7                      PROD_LINE1
+static char PROD_NAME7[] = " KVM/net Plus";
+
+static char CYCLADES_TXT[] = "Cyclades";
+static char CYCLADES_BANNER[] = "Linux ";
+static char CYCLADES_WHAT[] = "@(#)V_2.6.0m (Sep/05/2005) #70";
+
+#define CYCLADES_VERSION	(CYCLADES_WHAT+4)
+
+static char machine_txt[36][8] = {
+	"PR3000",
+	"PR+000",
+	"PR=000",
+	"PR1000",
+	"TS1000",
+	"TS2000",
+	"TS400",
+	"TS800",
+	"TS3000",
+	"Tx1000",
+	"Tx2000",
+	"PL1000",
+	"TS100",
+	"NL1000",
+	"ACS16",
+	"ACS32",
+	"SM100",
+	"PR3500",
+	"TS110",
+	"ACS48",
+	"ACS4",
+	"ACS8",
+	"ACS1",
+	"PR3000",
+	"KVM16",
+	"KVM32",
+	"KVMN16",
+	"KVMN32",
+    "ONS441",
+    "ONS481",
+    "ONS841",
+    "ONS881",
+    "ONS442",
+    "ONS482",
+    "ONS842",
+    "ONS882"
+};
+
+static char onsite_str[] = "OnSite";
+static char acs_str[] = "ACS";
+static char kvm_str[] = "KVM";
+static char kvmnet_str[] = "KVM/NET";
+static char kvmplus_str[] = "KVM/PLUS";
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/boot/include/cyc_config.h linux-2.6.14-rc4/arch/ppc/boot/include/cyc_config.h
--- linux-2.6.14-rc4.orig/arch/ppc/boot/include/cyc_config.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4/arch/ppc/boot/include/cyc_config.h	2005-10-25 12:19:43.000000000 -0500
@@ -0,0 +1,66 @@
+/*
+ *	Copyright (C) 1996 - CYCLADES Corporation.
+ *
+ *	V_1.0.0 08/25/00 Edson A. Seabra   Module creation.            
+ */
+
+#define IP_ALEN	4
+#define EP_ALEN	6
+#define PATH_LEN 40
+#define FLASH_SIGN_SIZE 8
+
+//XXX: remove? Its unused.
+#if 0
+struct type0000 {
+    unsigned char	flash_sign[FLASH_SIGN_SIZE];    /* mark initialized CMOS */
+    unsigned char	version;            /* Configure vector version */
+    unsigned char	routing_protocol;   /* RIP, OSPF, etc */
+    unsigned char	save_sw;            /* TRUE : the RTBOOT must be saved into flash */
+};
+#endif
+
+struct hw_setup {
+    unsigned char boot_option;
+    unsigned char tftp_path[PATH_LEN];  /* path and filename for tftp boot */
+    unsigned char enable_wdt;           
+    unsigned char op_code_crc;
+    unsigned char mem_test;
+    //[GB]May/06/05  Ethernet Receive Rate Limit
+    // unsigned char    reserved1[4];
+    unsigned int ibytesec;  
+/* maximum allowable bytes per second, when checking enabled */
+    unsigned short max_int_work;
+    unsigned char physical_addr[EP_ALEN];
+    unsigned char itf_ip_addr[IP_ALEN];
+    unsigned char itf_subnet_mask[IP_ALEN];
+    unsigned char console_speed;
+    unsigned char lcd_reboot;
+    unsigned char cpu_utilization;
+    unsigned char mii_operation;
+};
+
+struct boot_mask {
+    unsigned char boot_type;    /* It can assume Bootp, TFTP or Both */
+    unsigned char intfc;        /* Interface where the boot will happen */
+    unsigned char bootserver[IP_ALEN];    /* Server IP address */
+};
+
+struct om_info {
+	unsigned char mac_addr[6];
+	unsigned char banner[100];
+	unsigned char reserved[140];
+};
+
+#define TYPE0000    0
+#define TYPE0015    15
+#define TYPE0068    68
+#define TYPE9000    9000
+
+//[RK]Jun/14/05 - back port from 2.4 kernel
+#define OM_ADDRESS	(1024 - 6 - sizeof(struct om_info))
+
+#define OM_ADDRESS1	(0x10000L - 1024 + OM_ADDRESS)
+#define OM_ADDRESS2	(0x20000L - 1024 + OM_ADDRESS)
+
+#define CNF_ADDRESS1	0x30000
+#define CNF_ADDRESS2	0x20000
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/boot/simple/embed_config.c linux-2.6.14-rc4/arch/ppc/boot/simple/embed_config.c
--- linux-2.6.14-rc4.orig/arch/ppc/boot/simple/embed_config.c	2005-10-18 16:59:34.000000000 -0500
+++ linux-2.6.14-rc4/arch/ppc/boot/simple/embed_config.c	2005-10-25 13:55:04.000000000 -0500
@@ -334,6 +334,298 @@ embed_config(bd_t **bdp)
 }
 #endif /* RPXLITE || RPXCLASSIC */
 
+#ifdef CONFIG_PRxK
+
+/* Build a board information structure for the PRXK.
+ */
+
+#include <asm/uaccess.h>
+#include <asm/commproc.h>
+#include <platforms/cyc_flash.h>
+#include "cyc_banner.h"
+#include "cyc_config.h"
+#include "nonstdio.h"
+
+static void reset_ports(int board)
+{
+	volatile immap_t	*pm = (volatile immap_t *)IMAP_ADDR;
+
+	if (board == BOARD_ACS48 ||
+		board == BOARD_ACS32 ||
+		board == BOARD_ACS16 ||
+		board == BOARD_ACS8 ||
+		board == BOARD_ACS4) {
+		pm->im_ioport.iop_padir |=  0xAFFF;
+		pm->im_ioport.iop_papar &= ~0xEFFF;
+		pm->im_ioport.iop_paodr &= ~0xEFFF;
+		pm->im_ioport.iop_padat &= ~0xEFFF;
+
+		pm->im_cpm.cp_pbdir &=  0x11F00;
+		pm->im_cpm.cp_pbodr &= ~0x11F00;
+		pm->im_cpm.cp_pbpar &= ~0x11F00;
+
+		pm->im_ioport.iop_pcdir &=  0x07F8;
+		pm->im_ioport.iop_pcpar &= ~0x07F8;
+		pm->im_ioport.iop_pcdat &= ~0x07F8;
+		return;
+	}
+
+	if (board == BOARD_ACS1 || board == BOARD_KVM16 || 
+		board == BOARD_KVM32) {
+		pm->im_ioport.iop_padir |= 0xAFFC;
+		pm->im_ioport.iop_papar &= ~0xEFFC;
+		pm->im_ioport.iop_paodr &= ~0xEFFC;
+		pm->im_ioport.iop_padat &= ~0xEFFC;
+
+		pm->im_cpm.cp_pbdir |= 0x17F30;
+		pm->im_cpm.cp_pbodr |= 0x7C30;
+		pm->im_cpm.cp_pbpar |= 0x1030;
+		pm->im_cpm.cp_pbdat |= 0x0001;
+		pm->im_cpm.cp_pbdat &= ~0x1800;
+
+		pm->im_ioport.iop_pcdir |=  0x07C8;
+		pm->im_ioport.iop_pcpar &= ~0x0230;
+		pm->im_ioport.iop_pcso |= 0x0030;
+		return;
+	}
+
+	pm->im_ioport.iop_padir |= 0xAFFF;
+	pm->im_ioport.iop_papar &= ~0xAFFF;
+	pm->im_ioport.iop_paodr &= ~0xAFFF;
+	pm->im_ioport.iop_padat &= ~0xAFFF;
+
+	pm->im_cpm.cp_pbdir &= ~0x1C3E;
+	pm->im_cpm.cp_pbodr &= ~0x1C3E;
+	pm->im_cpm.cp_pbpar &= ~0x1C3E;
+
+	pm->im_ioport.iop_pcdir &= ~0x0728;
+	pm->im_ioport.iop_pcpar &= ~0x0728;
+	pm->im_ioport.iop_pcdat &= ~0x0728;
+	
+	return;
+}
+
+static unsigned short calc_crc(unsigned long byte_n, unsigned short crc, char *buffer)
+{
+	int j;
+
+	while (byte_n--) {
+		crc = (((crc >> 8) ^ *buffer++) << 8) | (0xFF & crc) ;
+		for(j = 0; j < 8; j++) {
+			if (crc & 0x8000)  {
+				crc <<= 1;
+				crc ^= 0x1021;
+			} else {
+				crc <<= 1;
+			}
+		}
+	}
+	return(crc);
+}
+
+static unsigned char *get_config_vector(unsigned char *pflash, int type, int tries)
+{
+	struct flash_config_vector_header *p;
+	int cnt = 0;
+
+	while(cnt++ < tries) {
+		p = (struct flash_config_vector_header *)pflash;
+
+		if (p->type == 9999) {
+			break;
+		}
+		if ((p->type > 200 && p->type != 9000) || p->size > 10000) {
+			break;
+		}
+		if (p->crc != calc_crc(p->size, 0, p->data)) {
+			break;
+		}
+		if (p->type == type) {
+			return(p->data);
+		}
+		pflash += p->size + 6;
+	}
+	return(NULL);
+}
+
+struct cyc_board_info {
+	int board_id;
+	char *prod_line;
+	char *prod_name;
+	char *card_name;
+	unsigned short num_portsS;
+	unsigned short num_portsK;
+	unsigned short num_portsA;
+	unsigned short num_portsM;
+};
+
+static struct cyc_board_info cyc_boards[] = {
+/* ACS series */
+{ .board_id = BOARD_ACS1, .prod_line = PROD_LINE3, .prod_name = PROD_NAME3,
+  .card_name = acs_str, .num_portsS = 1, .num_portsM = 2 }, 
+{ .board_id = BOARD_ACS4, .prod_line = PROD_LINE3, .prod_name = PROD_NAME3,
+  .card_name = acs_str, .num_portsS = 4, .num_portsM = 2 }, 
+{ .board_id = BOARD_ACS8, .prod_line = PROD_LINE3, .prod_name = PROD_NAME3,
+  .card_name = acs_str, .num_portsS = 8, .num_portsM = 2 }, 
+{ .board_id = BOARD_ACS16, .prod_line = PROD_LINE3, .prod_name = PROD_NAME3,
+  .card_name = acs_str, .num_portsS = 16, .num_portsM = 2 }, 
+{ .board_id = BOARD_ACS32, .prod_line = PROD_LINE3, .prod_name = PROD_NAME3,
+  .card_name = acs_str, .num_portsS = 32, .num_portsM = 2 }, 
+/* OnSite series */
+{ .board_id = BOARD_ONS441, .prod_line = PROD_LINE6, .prod_name = PROD_NAME6,
+  .card_name = onsite_str, .num_portsS = 4, .num_portsM = 2, .num_portsK = 4,
+  .num_portsA = 3},
+{ .board_id = BOARD_ONS442, .prod_line = PROD_LINE6, .prod_name = PROD_NAME6,
+  .card_name = onsite_str, .num_portsS = 4, .num_portsM = 2, .num_portsK = 4,
+  .num_portsA = 3},
+{ .board_id = BOARD_ONS481, .prod_line = PROD_LINE6, .prod_name = PROD_NAME6,
+  .card_name = onsite_str, .num_portsS = 4, .num_portsM = 2, .num_portsK = 8,
+  .num_portsA = 3},
+{ .board_id = BOARD_ONS482, .prod_line = PROD_LINE6, .prod_name = PROD_NAME6,
+  .card_name = onsite_str, .num_portsS = 4, .num_portsM = 2, .num_portsK = 8,
+  .num_portsA = 3},
+{ .board_id = BOARD_ONS841, .prod_line = PROD_LINE6, .prod_name = PROD_NAME6,
+  .card_name = onsite_str, .num_portsS = 8, .num_portsM = 2, .num_portsK = 4,
+  .num_portsA = 3},
+{ .board_id = BOARD_ONS842, .prod_line = PROD_LINE6, .prod_name = PROD_NAME6,
+  .card_name = onsite_str, .num_portsS = 8, .num_portsM = 2, .num_portsK = 4,
+  .num_portsA = 3},
+{ .board_id = BOARD_ONS881, .prod_line = PROD_LINE6, .prod_name = PROD_NAME6,
+  .card_name = onsite_str, .num_portsS = 8, .num_portsM = 2, .num_portsK = 8,
+  .num_portsA = 3},
+{ .board_id = BOARD_ONS882, .prod_line = PROD_LINE6, .prod_name = PROD_NAME6,
+  .card_name = onsite_str, .num_portsS = 8, .num_portsM = 2, .num_portsK = 8,
+  .num_portsA = 3},
+/* KVM series */
+{ .board_id = BOARD_KVM16, .prod_line = PROD_LINE4, .prod_name = PROD_NAME4,
+  .card_name = kvm_str, .num_portsA = 1 }, 
+{ .board_id = BOARD_KVM32, .prod_line = PROD_LINE4, .prod_name = PROD_NAME4,
+  .card_name = kvm_str, .num_portsA = 1 },
+/* KVM/NET series */
+{ .board_id = BOARD_KVMNET16,.prod_line = PROD_LINE5,.prod_name = PROD_NAME5, 
+  .card_name = kvmnet_str, .num_portsA = 1 },
+{ .board_id = BOARD_KVMNET32,.prod_line = PROD_LINE5,.prod_name = PROD_NAME5, 
+.card_name = kvmnet_str, .num_portsA = 1 },
+/* KVM/PLUS series */
+{ .board_id = BOARD_KVMP16,.prod_line = PROD_LINE5,.prod_name = PROD_NAME5, 
+  .card_name = kvmnet_str, .num_portsA = 1 },
+{ .board_id = BOARD_KVMP32,.prod_line = PROD_LINE5,.prod_name = PROD_NAME5, 
+  .card_name = kvmnet_str, .num_portsM = 2, .num_portsK = 16, .num_portsA = 2 }
+};
+
+static struct cyc_board_info *cget_board_info(int board_id) 
+{
+	struct cyc_board_info *board = NULL;
+	int i;
+	
+	for (i=0; i<ARRAY_SIZE(cyc_boards); i++) {
+		if (cyc_boards[i].board_id == board_id) {
+			board = &cyc_boards[i];
+			break;
+		}
+	}
+
+	if (board == NULL)
+		puts("PRxK: board_id does not match any known entry!");
+
+	return board;
+}
+
+/* Build a board information structure for the PRXK.
+ */
+void
+embed_config(bd_t **bdp)
+{
+	unsigned char *pflash, *pf;
+	struct prxk_boot_info *p = (struct prxk_boot_info *)0x00002000;
+	car8xx_t *pcar = &(((immap_t *)IMAP_ADDR)->im_clkrst);
+	struct hw_setup *pcnf;
+	struct om_info *p_om;
+	int speed[6] = {4800, 9600, 19200, 38400, 57600, 115200};
+	bd_t	*bd;
+	struct cyc_board_info *cinfo;
+
+	bd = &bdinfo;
+	*bdp = bd;
+
+	memcpy(&bd->hw_info, p, sizeof(struct prxk_boot_info));
+
+	bd->bi_busfreq = ((pcar->car_plprcr >> 20) + 1) * 4;  // 4 MHz crystal
+	bd->bi_intfreq = bd->bi_busfreq *= 1000000;
+
+	bd->bi_memsize = p->memory_detected;
+
+	pflash = (unsigned char *)FLASH_ADDR + CNF_ADDRESS1;
+	pf = (unsigned char *)OM_ADDRESS2 + FLASH_ADDR;
+
+	if ((pcnf = (struct hw_setup *)get_config_vector(pflash, TYPE0068, 1000))) {
+		bd->bi_baudrate = speed[pcnf->console_speed];
+		memcpy(bd->bi_enetaddr, pcnf->physical_addr, EP_ALEN);
+		bd->mii_operation = pcnf->mii_operation;
+		bd->max_int_work = pcnf->max_int_work;
+		//[GB]May/06/096 - Ethernet Receive Rate Limit
+		bd->ibytesec = pcnf->ibytesec;
+	} else {
+		bd->mii_operation = 0;
+		bd->bi_baudrate = 9600;
+	}
+
+	/* a value of 2 means WDT inactive */
+	switch (bd->hw_info.wdt_config) {
+		case 0:
+		case 1:
+			bd->wdt = 1;
+			break;
+		default: 
+			bd->wdt = 0;
+			break;
+	}
+
+	p_om = (struct om_info *)get_config_vector(pf, TYPE9000, 1);
+
+	if (!bd->bi_enetaddr[1] && !bd->bi_enetaddr[2] && p_om) {
+		memcpy(bd->bi_enetaddr, p_om->mac_addr, EP_ALEN);
+	}
+
+	if (!bd->bi_enetaddr[1] && !bd->bi_enetaddr[2]) {
+		bd->bi_enetaddr[0] = 0x00;
+		bd->bi_enetaddr[1] = 0x60;
+		bd->bi_enetaddr[2] = 0x2e;
+		bd->bi_enetaddr[3] = 0x00;
+		bd->bi_enetaddr[4] = 0x00;
+		bd->bi_enetaddr[5] = 0x01;
+	}
+	cinfo = cget_board_info(p->board_type);
+	if (!cinfo)
+		puts("Cyclades: unknown board id");
+
+	memcpy(bd->cyc_version, CYCLADES_VERSION, sizeof(bd->cyc_version));
+	memcpy(bd->board_name, machine_txt[p->board_type], sizeof(bd->board_name));
+	memcpy(bd->card_name, "UNKNOWN", sizeof(bd->card_name));
+
+	memcpy(bd->prod_line, cinfo->prod_line, sizeof(bd->prod_line));
+	memcpy(bd->prod_name, cinfo->prod_name, sizeof(bd->prod_name));
+	memcpy(bd->vendor_name, CYCLADES_TXT, sizeof(bd->vendor_name));
+
+	bd->num_portsS = cinfo->num_portsS;
+	bd->num_portsA = cinfo->num_portsA;
+	bd->num_portsK = cinfo->num_portsK;
+	bd->num_portsM = cinfo->num_portsM;
+
+	switch(p->board_type) {
+	case BOARD_KVMNET16:
+	case BOARD_KVMNET32:
+		if (p->async_config == 1 || p->async_config == 2)
+			bd->num_portsK = 7;
+		else
+			bd->num_portsK = 6;
+	}
+
+	reset_ports(p->board_type);
+}
+
+#endif /* CONFIG_PRxK */
+
 #ifdef CONFIG_BSEIP
 /* Build a board information structure for the BSE ip-Engine.
  * There is more to come since we will add some environment
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/boot/simple/head.S linux-2.6.14-rc4/arch/ppc/boot/simple/head.S
--- linux-2.6.14-rc4.orig/arch/ppc/boot/simple/head.S	2005-10-18 16:59:34.000000000 -0500
+++ linux-2.6.14-rc4/arch/ppc/boot/simple/head.S	2005-10-24 12:39:28.000000000 -0500
@@ -32,6 +32,17 @@
  *
  */
 
+#ifdef CONFIG_PRxK
+	.globl  start1
+start1: .long   0x00002120
+	.ascii  "Entry Point\x00"
+	.long   0x00000000
+	.long   0x00000000
+	.long   0x00000000
+	.long   0x00000000
+#endif
+
+
 	.globl	start
 start:
 	bl	start_
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/configs/prxk_defconfig linux-2.6.14-rc4/arch/ppc/configs/prxk_defconfig
--- linux-2.6.14-rc4.orig/arch/ppc/configs/prxk_defconfig	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4/arch/ppc/configs/prxk_defconfig	2005-10-24 15:12:54.000000000 -0500
@@ -0,0 +1,756 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.9-rc1
+# Fri Sep  3 00:54:16 2004
+#
+CONFIG_MMU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_HOTPLUG=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+# CONFIG_MODULE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+CONFIG_MODVERSIONS=y
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+CONFIG_8xx=y
+# CONFIG_E500 is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_EMBEDDEDBOOT=y
+CONFIG_NOT_COHERENT_CACHE=y
+
+#
+# Platform options
+#
+# CONFIG_RPXLITE is not set
+# CONFIG_RPXCLASSIC is not set
+CONFIG_PRxK=y
+# CONFIG_BSEIP is not set
+# CONFIG_FADS is not set
+# CONFIG_TQM823L is not set
+# CONFIG_TQM850L is not set
+# CONFIG_TQM855L is not set
+# CONFIG_TQM860L is not set
+# CONFIG_FPS850L is not set
+# CONFIG_SPD823TS is not set
+# CONFIG_IVMS8 is not set
+# CONFIG_IVML24 is not set
+# CONFIG_SM850 is not set
+# CONFIG_HERMES_PRO is not set
+# CONFIG_IP860 is not set
+# CONFIG_LWMON is not set
+# CONFIG_PCU_E is not set
+# CONFIG_CCM is not set
+# CONFIG_LANTEC is not set
+# CONFIG_MBX is not set
+# CONFIG_WINCEPT is not set
+CONFIG_TSxK=y
+# CONFIG_TS1H is not set
+CONFIG_SERIAL_CONSOLE=y
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_KERNEL_ELF=y
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+
+#
+# Bus options
+#
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_QSPAN is not set
+
+#
+# PCMCIA/CardBus support
+#
+CONFIG_PCMCIA=m
+# CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_TCIC is not set
+
+#
+# Advanced setup
+#
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_HIGHMEM_START=0xfe000000
+# CONFIG_LOWMEM_SIZE_BOOL is not set
+CONFIG_LOWMEM_SIZE=0x30000000
+# CONFIG_KERNEL_START_BOOL is not set
+CONFIG_KERNEL_START=0xc0000000
+# CONFIG_TASK_SIZE_BOOL is not set
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START_BOOL=y
+CONFIG_CONSISTENT_START=0xa0000000
+# CONFIG_CONSISTENT_SIZE_BOOL is not set
+CONFIG_CONSISTENT_SIZE=0x00200000
+# CONFIG_BOOT_LOAD_BOOL is not set
+CONFIG_BOOT_LOAD=0x00400000
+# CONFIG_PIN_TLB is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=20480
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_LBD is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+# CONFIG_IP_MULTIPLE_TABLES is not set
+# CONFIG_IP_ROUTE_MULTIPATH is not set
+# CONFIG_IP_ROUTE_TOS is not set
+# CONFIG_IP_ROUTE_VERBOSE is not set
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_IP_NF_CONNTRACK=y
+CONFIG_IP_NF_FTP=y
+# CONFIG_IP_NF_IRC is not set
+# CONFIG_IP_NF_TFTP is not set
+# CONFIG_IP_NF_AMANDA is not set
+# CONFIG_IP_NF_QUEUE is not set
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_MATCH_LIMIT=y
+# CONFIG_IP_NF_MATCH_IPRANGE is not set
+CONFIG_IP_NF_MATCH_MAC=y
+# CONFIG_IP_NF_MATCH_PKTTYPE is not set
+CONFIG_IP_NF_MATCH_MARK=y
+CONFIG_IP_NF_MATCH_MULTIPORT=y
+CONFIG_IP_NF_MATCH_TOS=y
+# CONFIG_IP_NF_MATCH_RECENT is not set
+# CONFIG_IP_NF_MATCH_ECN is not set
+# CONFIG_IP_NF_MATCH_DSCP is not set
+# CONFIG_IP_NF_MATCH_AH_ESP is not set
+CONFIG_IP_NF_MATCH_LENGTH=y
+CONFIG_IP_NF_MATCH_TTL=y
+CONFIG_IP_NF_MATCH_TCPMSS=y
+# CONFIG_IP_NF_MATCH_HELPER is not set
+CONFIG_IP_NF_MATCH_STATE=y
+# CONFIG_IP_NF_MATCH_CONNTRACK is not set
+CONFIG_IP_NF_MATCH_OWNER=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_REJECT=y
+CONFIG_IP_NF_NAT=y
+CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_IP_NF_TARGET_MASQUERADE=y
+CONFIG_IP_NF_TARGET_REDIRECT=y
+# CONFIG_IP_NF_TARGET_NETMAP is not set
+# CONFIG_IP_NF_TARGET_SAME is not set
+# CONFIG_IP_NF_NAT_LOCAL is not set
+# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
+CONFIG_IP_NF_NAT_FTP=y
+CONFIG_IP_NF_MANGLE=y
+CONFIG_IP_NF_TARGET_TOS=y
+# CONFIG_IP_NF_TARGET_ECN is not set
+# CONFIG_IP_NF_TARGET_DSCP is not set
+CONFIG_IP_NF_TARGET_MARK=y
+# CONFIG_IP_NF_TARGET_CLASSIFY is not set
+CONFIG_IP_NF_TARGET_LOG=y
+# CONFIG_IP_NF_TARGET_ULOG is not set
+CONFIG_IP_NF_TARGET_TCPMSS=y
+# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_IP_NF_RAW is not set
+# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
+# CONFIG_IP_NF_MATCH_REALM is not set
+# CONFIG_IP_NF_CT_ACCT is not set
+# CONFIG_IP_NF_MATCH_SCTP is not set
+# CONFIG_IP_NF_CT_PROTO_SCTP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
+
+#
+# Wireless LAN (non-hamradio)
+#
+CONFIG_NET_RADIO=y
+
+#
+# Obsolete Wireless cards support (pre-802.11)
+#
+# CONFIG_STRIP is not set
+# CONFIG_PCMCIA_WAVELAN is not set
+# CONFIG_PCMCIA_NETWAVE is not set
+
+#
+# Wireless 802.11 Frequency Hopping cards support
+#
+# CONFIG_PCMCIA_RAYCS is not set
+
+#
+# Wireless 802.11b ISA/PCI cards support
+#
+CONFIG_HERMES=m
+# CONFIG_ATMEL is not set
+
+#
+# Wireless 802.11b Pcmcia/Cardbus cards support
+#
+CONFIG_PCMCIA_HERMES=m
+# CONFIG_AIRO_CS is not set
+# CONFIG_PCMCIA_WL3501 is not set
+CONFIG_NET_WIRELESS=y
+
+#
+# PCMCIA network device support
+#
+CONFIG_NET_PCMCIA=y
+CONFIG_PCMCIA_3C589=m
+# CONFIG_PCMCIA_3C574 is not set
+# CONFIG_PCMCIA_FMVJ18X is not set
+CONFIG_PCMCIA_PCNET=m
+# CONFIG_PCMCIA_NMCLAN is not set
+# CONFIG_PCMCIA_SMC91C92 is not set
+CONFIG_PCMCIA_XIRC2PS=m
+CONFIG_PCMCIA_AXNET=m
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+CONFIG_PPP=m
+CONFIG_PPP_MULTILINK=y
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+# CONFIG_PPP_DEFLATE is not set
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPPOE is not set
+CONFIG_SLIP=m
+CONFIG_SLIP_COMPRESSED=y
+# CONFIG_SLIP_SMART is not set
+# CONFIG_SLIP_MODE_SLIP6 is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+CONFIG_ISDN=m
+
+#
+# Old ISDN4Linux
+#
+# CONFIG_ISDN_I4L is not set
+
+#
+# CAPI subsystem
+#
+# CONFIG_ISDN_CAPI is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_CT82C710 is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_CPM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_QIC02_TAPE is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_MDA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=m
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+CONFIG_CYC_FS=y
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+# CONFIG_EXPORTFS is not set
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=m
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+CONFIG_NLS_CODEPAGE_850=m
+CONFIG_NLS_CODEPAGE_852=m
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=m
+CONFIG_NLS_ISO8859_2=m
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+CONFIG_NLS_ISO8859_15=m
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# MPC8xx CPM Options
+#
+# CONFIG_SCC_ENET is not set
+# CONFIG_FEC_ENET is not set
+CONFIG_ENET_BIG_BUFFERS=y
+# CONFIG_8xx_UART is not set
+
+#
+# Generic MPC8xx Options
+#
+CONFIG_8xx_COPYBACK=y
+CONFIG_8xx_CPU6=y
+CONFIG_UCODE_PATCH=y
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=m
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_DEBUG_KERNEL is not set
+
+#
+# Security options
+#
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/platforms/Makefile linux-2.6.14-rc4/arch/ppc/platforms/Makefile
--- linux-2.6.14-rc4.orig/arch/ppc/platforms/Makefile	2005-10-18 16:59:34.000000000 -0500
+++ linux-2.6.14-rc4/arch/ppc/platforms/Makefile	2005-10-24 16:45:24.000000000 -0500
@@ -42,6 +42,7 @@ obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
 obj-$(CONFIG_LITE5200)		+= lite5200.o
 obj-$(CONFIG_EV64360)		+= ev64360.o
+obj-$(CONFIG_PRxK)		+= prxk.o cyc_spi.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/platforms/cpld.h linux-2.6.14-rc4/arch/ppc/platforms/cpld.h
--- linux-2.6.14-rc4.orig/arch/ppc/platforms/cpld.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4/arch/ppc/platforms/cpld.h	2005-10-24 15:35:25.000000000 -0500
@@ -0,0 +1,191 @@
+/*-----------------------------------------------------------------------------
+ *	Copyright (C) Cyclades Corporation, 1997.
+ *	All rights reserved
+ *
+ *	TS1000 - RAS
+ *
+ *	This file:	cpld.h
+ *	Description:	This file contains the definitions and prototypes 
+ *			related to the CPLD programming
+ *			
+ *	
+ *	Complies with Cyclades SW Coding Standard rev 1.2.
+ *-----------------------------------------------------------------------------
+ */
+ 
+/*-----------------------------------------------------------------------------
+ *	Change History
+ *-----------------------------------------------------------------------------
+ * Oct/25/2000	V 1.0.0		Edson Seabra
+ *	Initial Implementation
+ *
+ *-----------------------------------------------------------------------------
+ */
+
+#define DB_UART_ADDR_SIZE		0x1000
+#define DB_CPLD_ADDR_SIZE		0x1000
+#define DB_FPGA_ADDR_SIZE		0x1000
+#define DB_FPGA_PC_ADDR_SIZE	0x1000
+#define DB_SYSFPGA_ADDR_SIZE	0x1000
+#define DB_MUXFPGA_ADDR_SIZE	0x1000
+ 
+/* Description of bits in fpga_jp field in the cpld.
+*/
+#define FPGA_JP_PCMCIA          0x02 // bit 6 (Big Endian)
+
+
+/* Description of bits in fpga_pc_ctl field in the cpld.
+   Bits 0-3 for slot A, bits 4-7 for slot B.
+*/
+#define PCMCIA_VCC_33	        0x20
+#define PCMCIA_VCC_50	        0x10
+#define PCMCIA_VPP_12	        0x80
+#define PCMCIA_VPP_VCC	        0x40
+#define PCMCIA_VCC_MASK	        0x30
+#define PCMCIA_VPP_MASK	        0xC0
+
+/* Description of bits in fpga_pc_sts field in the cpld.
+*/
+#define FPGA_PCMCIA_ENABLE	    0x80 // bit 0 
+
+/* CPLD registers */ 
+struct cpld_regs {
+	unsigned char reset_enable1;		// 0x00
+	unsigned char clock_enable1;		// 0x01
+	unsigned char clock_source1;		// 0x02
+	unsigned char cpld_misc;			// 0x03
+	unsigned char intr_enable1;			// 0x04
+	unsigned char intr_enable2;			// 0x05
+	unsigned char intr_enable3;			// 0x06
+	unsigned char intr_enable4;			// 0x07
+	unsigned char intr_status1;			// 0x08
+	unsigned char intr_status2;			// 0x09
+	unsigned char intr_status3;			// 0x0A
+	unsigned char intr_status4;			// 0x0B
+	unsigned char fpga_id;				// 0x0C
+	unsigned char fpga_jp;				// 0x0D
+	unsigned char fpga_cfst;			// 0x0E
+	unsigned char fpga_led_ctl;			// 0x0F
+	unsigned char reset_enable2;		// 0x10
+	unsigned char clock_enable2;		// 0x11
+	unsigned char clock_source2;		// 0x12
+	unsigned char reserve2;				// 0x13
+	unsigned char intr_enable5;			// 0x14
+	unsigned char intr_enable6;			// 0x15
+	unsigned char reserve3[2];			// 0x16
+	unsigned char intr_status5;			// 0x18
+	unsigned char intr_status6;			// 0x19
+	unsigned char reserve4[6];			// 0x1A
+	unsigned char bsmux;				// 0x20
+	unsigned char fpga_pc_ctl;			// 0x21
+	unsigned char fpga_pc_sts;			// 0x22
+	unsigned char reserve5[4];			// 0x23
+	unsigned char id_cpld;				// 0x27
+};
+
+/* Serial Expander UART registers */
+typedef union 
+{
+	struct uart_read  {
+		unsigned char	rhr;
+		unsigned char	space;
+		unsigned char	isr;		// SSE8-V174
+		unsigned char	lcr;
+		unsigned char	mcr;
+		unsigned char	lsr;
+		unsigned char	msr;
+		unsigned char	spr;
+	} r;
+											
+	struct uart_write  {
+		unsigned char	thr;
+		unsigned char	ier;
+		unsigned char	fcr;
+		unsigned char	lcr;
+		unsigned char	mcr;
+		unsigned char	space[2];
+		unsigned char	spr;
+    } w;
+	
+	struct uart_special {
+		unsigned char	dll;
+		unsigned char	dlm;
+		unsigned char	efr;
+		unsigned char	space;
+		unsigned char	xon1;
+		unsigned char	xon2;
+		unsigned char	xoff1;
+		unsigned char	xoff2;
+	} s;
+} UART_REGS;
+
+struct fpga_regs {
+	unsigned char fpga_async;
+	unsigned char fpga_wan_reg1;
+	unsigned char fpga_wan_reg2;
+	unsigned char reserved1;
+	unsigned char fpga_cf;
+	unsigned char reserved2;
+	unsigned char fpga_int;
+	unsigned char fpga_dimm;
+	unsigned char reserved3;
+	unsigned char fpga_led;
+	unsigned char fpga_jpr;
+	unsigned char fpga_id;
+};
+
+/* PCMCIA registers */
+struct fpga_pc_regs {
+	unsigned char fpga_pc_misc;	// Controls PCMCIA IO's window size
+	unsigned char reserved1[7];
+	unsigned char fpga_pc_stat;	// Status - read only
+	unsigned char reserved2[6];
+	unsigned char fpga_pc_id;	// PCMCIA FPGA ID - read only 
+};
+
+/* FPGA MUX register */
+struct muxfpga_regs {
+	unsigned char misc;
+	unsigned char uart_int;
+	unsigned char vid_ctl_1;
+	unsigned char vid_sts_1;
+	unsigned char vid_gain_1;
+	unsigned char vid_eq_1;
+	unsigned char vid_ctl_2;
+	unsigned char vid_sts_2;
+	unsigned char vid_gain_2;
+	unsigned char vid_eq_2;
+	unsigned char kvm_sel_1;
+	unsigned char kvm_sel_2;
+	unsigned char adm_sel;
+	unsigned char osd_1;
+	unsigned char osd_2;
+	unsigned char id;
+	unsigned char hlo_lsb_1;
+	unsigned char hlo_msb_1;
+	unsigned char hhi_lsb_1;
+	unsigned char hhi_msb_1;
+	unsigned char vlo_lsb_1;
+	unsigned char vlo_msb_1;
+	unsigned char vhi_lsb_1;
+	unsigned char vhi_msb_1;
+	unsigned char hlo_lsb_2;
+	unsigned char hlo_msb_2;
+	unsigned char hhi_lsb_2;
+	unsigned char hhi_msb_2;
+	unsigned char vlo_lsb_2;
+	unsigned char vlo_msb_2;
+	unsigned char vhi_lsb_2;
+	unsigned char vhi_msb_2;
+	unsigned char misc_2;
+	unsigned char uart_int_2;
+};
+
+extern volatile struct cpld_regs *cpld;
+
+extern volatile void	*uarts;
+
+extern volatile struct fpga_regs *fpga;
+
+extern volatile struct muxfpga_regs *muxfpga;
+
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/platforms/cyc_flash.h linux-2.6.14-rc4/arch/ppc/platforms/cyc_flash.h
--- linux-2.6.14-rc4.orig/arch/ppc/platforms/cyc_flash.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4/arch/ppc/platforms/cyc_flash.h	2005-10-25 12:16:42.000000000 -0500
@@ -0,0 +1,60 @@
+/*-----------------------------------------------------------------------------
+ *	Copyright (C) Cyclades Corporation, 1997.
+ *	All rights reserved
+ *
+ *	PR-3000 Router
+ *
+ *	This file:	flash.h
+ *	Description:	This file contains the definitions and the prototypes 
+ *			related to the flash module
+ *
+ *  Licensed under the terms of the GNU GPL License version 2 -- see
+ *  COPYING for details.
+ */
+ 
+/*-----------------------------------------------------------------------------
+ *	Change History
+ *-----------------------------------------------------------------------------
+ * 04/25/96	V 1.0.0		Elio Lerner
+ *	First Release
+ * 04/23/96	V 1.0.1		Helio Fujimoto
+ *	Port to PR-3000 for test
+ * 07/28/96	V 1.0.2		Helio Fujimoto
+ *	Port to PR-3000
+ *-----------------------------------------------------------------------------
+ */
+
+/* Values used on dealing with the flash */
+/* The values are flipped because the data lines on the PR-3000 were flipped */
+#define UNLOCK_VALUE_A		0xaa
+#define UNLOCK_VALUE_B		0x55
+#define SETUP_VALUE		0x80
+#define	SECTOR_ERASE_VALUE	0x30
+#define	CHIP_ERASE_VALUE	0x10
+#define PROGRAM_VALUE		0xa0
+#define RESET_READ_VALUE	0xf0
+#define AUTO_SELECT_VALUE	0x90
+#define	DQ7	0x80
+#define DQ6	0x40
+#define DQ5	0x20		
+#define DQ3	0x08		
+
+/* Configuration Address */
+#define CFG_ADDR	0x5555
+
+/* values returned by the data_polling procedure */
+#define PASS		0x01
+#define FAIL		0x00
+#define IN_PROGRESS	0x03
+
+struct flash_config_vector_header {
+	unsigned short	type;
+	unsigned short	size;
+	unsigned short	crc;
+	unsigned char	data[2];
+};
+
+#define FLASH_ADDR ((((immap_t *)IMAP_ADDR)->im_memctl.memc_br0) & 0xffff8000L)
+
+extern unsigned char *cflash_addr, *flash_addr, *flash_boot;
+
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/platforms/cyc_osd.h linux-2.6.14-rc4/arch/ppc/platforms/cyc_osd.h
--- linux-2.6.14-rc4.orig/arch/ppc/platforms/cyc_osd.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4/arch/ppc/platforms/cyc_osd.h	2005-10-24 16:47:11.000000000 -0500
@@ -0,0 +1,39 @@
+#define NUM_OF_OSDS		2
+#define MAX_VIDEO_CHANNELS	6
+
+#define	SPI_FROM_RTC		0
+#define SPI_FROM_OSD1		1
+#define SPI_FROM_OSD2		2
+
+#define OSDGETVIDEO		0
+#define OSDSETVIDEOON		1
+#define	OSDSETVIDEOOFF		2
+#define OSDSETPORT		3
+#define OSDGETPORT		4
+#define OSDGETOSD		5
+#define OSDSETOSDON		6
+#define	OSDSETOSDOFF		7
+#define OSDSETPOLARITY		8
+#define OSDSETBRIGHTNESS   	9
+#define OSDGETBRIGHTNESS   	10
+#define OSDSETCONTRAST     	11
+#define OSDGETCONTRAST     	12
+#define OSDAGCON		13
+#define	OSDAGCOFF		14
+#define	OSDGETAGC		15
+#define OSDSETTRANSPARENTON	16
+#define OSDSETTRANSPARENTOFF	17
+#define OSDSETVIDEOCOLOR	18
+#define OSDGETVERSION		19
+#define OSDGETSCREEN		20
+#define OSDSETLOCAL		21
+#define OSDSETREMOTE		22
+#define OSDSETRAMCHAR		23
+
+#define NUM_RAM_CHARS		8
+
+struct osdreq_ramchar{
+	__u16 index;
+	__u16 data[18];
+};
+
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/platforms/cyc_spi.c linux-2.6.14-rc4/arch/ppc/platforms/cyc_spi.c
--- linux-2.6.14-rc4.orig/arch/ppc/platforms/cyc_spi.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4/arch/ppc/platforms/cyc_spi.c	2005-10-28 13:24:04.000000000 -0500
@@ -0,0 +1,586 @@
+/*
+ *  8/00  -  CPM SPI works, so just use that
+ *
+ *  Copyright (c) 2000  Montavista Software, Inc <source@mvista.com>
+ *  based on the following
+ *
+ */
+
+/*-----------------------------------------------------------------------------
+ *
+ * Copyright (C) Cyclades Corporation, 1997 - 2000
+ * All rights reserved.
+ *
+ * TSx100/NL1000 v1.00 for Linux
+ *
+ * This file :      cyc_spi.c
+ *
+ * Description:     This file contains the routines to access for SPI protocol
+ *
+ * Complies with Cyclades SW coding Standard rev 1.2
+ *-----------------------------------------------------------------------------
+ */
+
+ /*----------------------------------------------------------------------------
+  * Change History
+  *----------------------------------------------------------------------------
+  * 11/8/01   Arnaldo Zimmermann     Initial implementation
+  *----------------------------------------------------------------------------
+  * Aug/09/02 Edson Seabra           Port to linux kernel
+  *----------------------------------------------------------------------------
+  */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/random.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/timex.h>
+#include <linux/time.h>
+
+#include <asm/uaccess.h>
+#include <asm/mpc8xx.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <platforms/prxk.h>
+
+#include <asm/delay.h>
+#include <asm/commproc.h>
+#include <asm/time.h>
+#include <asm/todc.h>
+
+#include <platforms/cyc_osd.h>
+
+#undef DEBUG_READ_SPI
+#undef DEBUG_WRITE_SPI
+
+#define IS_BOARD_KVMANA	(CYC_BOARD_TYPE == BOARD_KVM16 || \
+		CYC_BOARD_TYPE == BOARD_KVM32)
+#define IS_BOARD_KVMNET	(CYC_BOARD_TYPE == BOARD_KVMNET16 || \
+		CYC_BOARD_TYPE == BOARD_KVMNET32)
+#define IS_BOARD_KVMNETP	(CYC_BOARD_TYPE == BOARD_KVMP16 || \
+		CYC_BOARD_TYPE == BOARD_KVMP32)
+#define IS_BOARD_ONS	(CYC_BOARD_TYPE == BOARD_ONS441 || \
+		CYC_BOARD_TYPE == BOARD_ONS481 || \
+		CYC_BOARD_TYPE == BOARD_ONS841 || \
+		CYC_BOARD_TYPE == BOARD_ONS881 || \
+		CYC_BOARD_TYPE == BOARD_ONS442 || \
+		CYC_BOARD_TYPE == BOARD_ONS482 || \
+		CYC_BOARD_TYPE == BOARD_ONS842 || \
+		CYC_BOARD_TYPE == BOARD_ONS882)
+#define IS_BOARD_KVM	(IS_BOARD_KVMANA || IS_BOARD_KVMNET || \
+		IS_BOARD_ONS || IS_BOARD_KVMNETP)
+
+
+/* for the KVM */
+static int spiinuse = 0;
+static int spiopened = 0;
+static int spiinitialized = 0;
+
+unsigned long *tbdf_vaddr = 0;
+unsigned long *rbdf_vaddr = 0;
+
+int cyc_cpm_spi_open(char);
+int cyc_cpm_spi_close(unsigned char);
+
+static void
+msdelay(uint t, uint interv) 
+{
+	uint i;
+	volatile sysconf8xx_t *psiu = &(((immap_t *)IMAP_ADDR)->im_siu_conf);
+
+	/* delay t miliseconds */
+	for (i=0; i<t; i++) {
+		udelay(interv);
+	 	psiu->sc_swsr = 0x556c;
+		psiu->sc_swsr = 0xaa39;
+	}
+}
+
+void __init
+cyc_cpm_spi_init(void)
+{
+	unsigned long	*mem_addr;
+	unsigned int	dp_addr, reloc;
+	cbd_t		*rbdf;
+	cbd_t		*tbdf;
+	volatile cpm8xx_t	*cp;
+	volatile spi_t		*spp;
+	volatile immap_t	*immap;
+
+	if (IS_BOARD_KVM && spiinitialized) {
+		return;
+	}
+
+	cp = cpmp;	/* Get pointer to Communication Processor */
+	immap = (immap_t *)IMAP_ADDR;	/* and to internal registers */
+
+	spp = (spi_t *)&cp->cp_dparam[PROFF_SPI];
+
+	/* Check for and use a microcode relocation patch.
+	*/
+	if ((reloc = spp->spi_rpbase))
+		spp = (spi_t *)&cp->cp_dpmem[spp->spi_rpbase];
+		
+
+	/* Initialize Port B SPI pins.
+	*/
+	cp->cp_pbpar &= ~0x00020000;
+	cp->cp_pbpar |=  0x0000000E;
+	cp->cp_pbdir |=  0x0002000F;
+	cp->cp_pbodr &= ~0x0000000E;
+	cp->cp_pbdat |=  0x00000001;
+	
+	if (IS_BOARD_KVM) {
+        	immap->im_ioport.iop_papar &= ~0x00c0;
+        	immap->im_ioport.iop_padir |= 0x00c0;
+        	immap->im_ioport.iop_padat &= ~0x00c0;
+	}
+
+	/* Initialize the parameter ram.
+	 * We need to make sure many things are initialized to zero,
+	 * especially in the case of a microcode patch.
+	 */
+	spp->spi_rstate = 0;
+	spp->spi_rdp = 0;
+	spp->spi_rbptr = 0;
+	spp->spi_rbc = 0;
+	spp->spi_rxtmp = 0;
+	spp->spi_tstate = 0;
+	spp->spi_tdp = 0;
+	spp->spi_tbptr = 0;
+	spp->spi_tbc = 0;
+	spp->spi_txtmp = 0;
+
+
+	/* Allocate space for one transmit and one receive buffer
+	 * descriptor in the DP ram.
+	 */
+	dp_addr = cpm_dpalloc(sizeof(cbd_t) * 2, 8);
+	if (IS_ERR(&dp_addr)) {
+		panic("Warning! Failed to allocate tx/rx buffer on DP ram for SPI");
+	}
+	/* Set up the SPI parameters in the parameter ram.
+	*/
+	spp->spi_tbase = dp_addr;
+	spp->spi_rbase = dp_addr + sizeof(cbd_t);
+
+	/*
+	 *  manually init if using microcode patch
+	 */
+	if(reloc)
+	{
+		spp->spi_rbptr = spp->spi_rbase;
+		spp->spi_tbptr = spp->spi_tbase;
+	}
+
+	spp->spi_tfcr = 0x18;
+	spp->spi_rfcr = 0x18;
+
+	/* Set maximum receive size.
+	*/
+	spp->spi_mrblr = 32;
+
+	/* Initialize Tx/Rx parameters.
+	*/
+	if (reloc == 0) {
+		cp->cp_cpcr =
+			mk_cr_cmd(CPM_CR_CH_SPI, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+		while (cp->cp_cpcr & CPM_CR_FLG);
+	}
+	/* The notes on the SPI relocation patch indicate the the init rx and 
+	   tx command doesn't work.  It isn't clear if this also includes 
+	   the individual rx and tx init commands, but at any rate it seems 
+	   to work fine if we just skip these commands.
+	*/
+	else {
+		cp->cp_cpcr =
+			mk_cr_cmd(CPM_CR_CH_SPI, CPM_CR_INIT_TX) | CPM_CR_FLG;
+		while (cp->cp_cpcr & CPM_CR_FLG);
+
+		cp->cp_cpcr =
+			mk_cr_cmd(CPM_CR_CH_SPI, CPM_CR_INIT_RX) | CPM_CR_FLG;
+		while (cp->cp_cpcr & CPM_CR_FLG);
+	}
+
+	/* Set the buffer address.
+	*/
+	dp_addr = cpm_dpalloc(32, 4);
+	if (IS_ERR(&dp_addr)) { 
+		panic("Warning! Failed to allocate rx buffer on CPM ram for SPI");
+	}
+//	mem_addr = (unsigned long *)(&cpmp->cp_dpmem[dp_addr]);
+	mem_addr = (unsigned long*)cpm_dpram_addr(dp_addr);
+	memset(mem_addr, 0, 32);
+
+	rbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_rbase];
+	rbdf->cbd_bufaddr = iopa((unsigned long)mem_addr); 
+	rbdf_vaddr = mem_addr;
+
+//	dp_addr = m8xx_cpm_dpalloc(32);
+	dp_addr = cpm_dpalloc(32, 4);
+	if (IS_ERR(&dp_addr)) {
+		panic("Warning! Failed to allocate tx buffer on CPM ram for SPI");
+	}
+//	mem_addr = (unsigned long*)(&cpmp->cp_dpmem[dp_addr]);
+	mem_addr = (unsigned long*)cpm_dpram_addr(dp_addr);
+	memset(mem_addr, 0, 32);
+
+	tbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_tbase];
+	tbdf->cbd_bufaddr = iopa((unsigned long)mem_addr); 
+	tbdf_vaddr = mem_addr;
+
+	/* Clear event
+	*/
+	cp->cp_spie = ~0;
+
+	/* No events 
+	*/
+	cp->cp_spim = 0;
+
+
+	/*
+     *  62.5KHz clock for the A/D
+     *  8 bit 
+     *  The datasheet specs for the ADS7843 indicate that it should work 
+     *  with a clock rate of up to 2MHz, but we don't seem to be able to 
+     *  get reliable touchpanel samples with a clock much faster than 
+     *  62.5KHz.  This translates to a sample time of 768 microseconds 
+     *  to sample both the X and Y coordinates.
+     */
+
+	if (IS_BOARD_KVM) {
+		spiinuse = 0;
+		spiinitialized = 1;
+		spiopened = 0;
+	} else {
+		cp->cp_spmode = SPMODE_CI | SPMODE_CP | SPMODE_REV | 
+			SPMODE_MSTR | SPMODE_DIV16 | ((8-1) << 4) | 0xF | 
+			SPMODE_EN;
+	}
+	printk("SPI init done.\r\n");
+	//last_reboot();
+
+}
+
+
+/* Read from SPI.
+ * This is a two step process.  First, we send the "dummy" write
+ * to set the device offset for the read.  Second, we perform
+ * the read operation.
+ */
+
+ssize_t
+cyc_cpm_spi_read(char *buf, size_t count)
+{
+	volatile spi_t *spp;
+	volatile cbd_t	*tbdf, *rbdf;
+	volatile cpm8xx_t	*cp;
+	unsigned long flags;
+	uint	reloc;
+
+	cp = cpmp;	/* Get pointer to Communication Processor */
+	spp = (spi_t *)&cp->cp_dparam[PROFF_SPI];
+
+	if (IS_BOARD_KVM) {
+		cyc_cpm_spi_open(SPI_FROM_RTC);
+	}
+
+	/* Check for and use a microcode relocation patch.
+	*/
+	if ((reloc = spp->spi_rpbase)) {
+		spp = (spi_t *)&cp->cp_dpmem[spp->spi_rpbase];
+	}
+
+	if (count >= spp->spi_mrblr) {
+		return 0;
+	}
+
+	tbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_tbase];
+	rbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_rbase];
+
+	memset(tbdf_vaddr, 0, count);
+	*(char*)(tbdf_vaddr) &= ~0x80;	/* read command */
+	memset(rbdf_vaddr,0,count);
+
+	tbdf->cbd_datlen = count;
+	tbdf->cbd_sc = BD_SC_READY|BD_SC_WRAP|BD_SC_INTRPT|BD_SC_LAST; 
+
+	rbdf->cbd_datlen = 0;
+	rbdf->cbd_sc = BD_SC_EMPTY|BD_SC_WRAP|BD_SC_INTRPT;
+
+
+	/* Chip bug, set enable here. */
+
+	cp->cp_pbdat &=  ~0x00000001;
+	msdelay(2, 1000);
+
+	local_irq_save(flags);
+
+	cp->cp_spie = ~0;
+	cp->cp_spcom |= 0x80;	/* Start Transmit */
+
+	/* Wait for SPI transfer. */
+
+	while(!(cp->cp_spie & 0x35)) {
+		msdelay(1,10);
+	}
+
+	local_irq_restore(flags);
+
+	cp->cp_pbdat |=   0x00000001;
+
+	if (cp->cp_spie != 0x03) {
+		printk("\r\nSPI error on reading RTC. Status = 0x%04x", 
+			cp->cp_spie);
+		return 0;
+	}
+
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	if (rbdf->cbd_datlen != count) {
+		printk("cyc_cpm_spi_read %d of %d\n", rbdf->cbd_datlen, count);
+	}
+
+	if (rbdf->cbd_sc & BD_SC_EMPTY) {
+		printk("SPI read complete but rbuf empty\n");
+	}
+	
+	memcpy(buf,rbdf_vaddr, count);
+
+#ifdef DEBUG_READ_SPI
+{	size_t i;
+	printk("RTC read: ");
+	for (i = 0; i<count; i++) printk("%02x", (unsigned char)buf[i]);
+	printk("\r\n");
+}
+#endif
+
+	if (IS_BOARD_KVM) {
+		cyc_cpm_spi_close(SPI_FROM_RTC);
+	}
+	return rbdf->cbd_datlen;
+}
+
+
+ssize_t
+cyc_cpm_spi_write(char *buf, size_t count)
+{
+	volatile spi_t *spp;
+	volatile cbd_t	*tbdf, *rbdf;
+	volatile cpm8xx_t	*cp;
+	unsigned long flags;
+	uint	reloc, status;
+
+	cp = cpmp;	/* Get pointer to Communication Processor */
+	spp = (spi_t *)&cp->cp_dparam[PROFF_SPI];
+
+	if (IS_BOARD_KVM) {
+		cyc_cpm_spi_open(SPI_FROM_RTC);
+	}
+
+	/* Check for and use a microcode relocation patch.
+	*/
+	if ((reloc = spp->spi_rpbase) != 0) {
+		spp = (spi_t *)&cp->cp_dpmem[spp->spi_rpbase];
+	}
+
+	if (count >= spp->spi_mrblr) {
+		return 0;
+	}
+
+	tbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_tbase];
+	rbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_rbase];
+
+#ifdef DEBUG_WRITE_SPI
+{	size_t i;
+	printk("RTC write: ");
+	for (i = 0; i<count; i++) printk("%02x", (unsigned char)buf[i]);
+	printk("\r\n");
+}
+#endif
+
+	memset(tbdf_vaddr, 0, count);
+	*(char*)(tbdf_vaddr) |= 0x80;	/* write command */
+	memset(rbdf_vaddr,0,count);
+
+	tbdf->cbd_datlen = count;		/* Length */
+	rbdf->cbd_datlen = 0;			/* Length */
+
+	tbdf->cbd_sc = BD_SC_READY|BD_SC_WRAP|BD_SC_INTRPT|BD_SC_LAST; 
+	rbdf->cbd_sc = BD_SC_EMPTY|BD_SC_WRAP|BD_SC_INTRPT;
+
+	cp->cp_pbdat &=  ~0x00000001;
+	msdelay(2, 1000);
+	
+	local_irq_save(flags);
+	
+	cp->cp_spie = ~0;
+	cp->cp_spcom = 0x80;
+
+	/* Wait for SPI transfer.
+	*/
+	while(!(status = (cp->cp_spie & 0x32))) {
+		msdelay(1,10);
+	}
+
+	local_irq_restore(flags);
+
+	cp->cp_pbdat |=   0x00000001;
+
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	if (status != 0x02) {				// check if TxB is set w/o other errors
+		printk("\r\nSPI error when reading RTC");
+		return 0;
+	}
+
+	if (tbdf->cbd_sc & BD_SC_READY)
+		printk("SPI ra complete but tbuf ready\n");
+
+	if (IS_BOARD_KVM) {
+		cyc_cpm_spi_close(SPI_FROM_RTC);
+	}
+
+	return count;
+}
+
+int 
+cyc_cpm_spi_open(char from)
+{
+#ifdef DEBUG_WRITE_SPI
+	printk("SPI open from = %d, spiinuse = %d, spiopened = %d\n", 
+		from, spiinuse, spiopened);
+#endif
+	if (spiinuse) {
+		if (spiinuse == from + 1) {
+			spiopened ++;
+			return 1;
+		} else {
+			return 0;
+		}
+	}
+	
+	if (from >= 0 && from <= 2) {
+		volatile cpm8xx_t *cp = cpmp;
+		volatile immap_t *immap = (immap_t *)IMAP_ADDR;
+		if (IS_BOARD_KVMNETP) {
+			switch (from) {
+			case 0:
+        			immap->im_ioport.iop_padat &= ~0x00c0;
+				break;
+			case 1:
+        			immap->im_ioport.iop_padat |= 0x0080;
+        			immap->im_ioport.iop_padat &= ~0x0040;
+				break;
+			case 2:
+        			immap->im_ioport.iop_padat |= 0x00c0;
+				break;
+			}
+		} else {
+        		immap->im_ioport.iop_padat &= ~0x00c0;
+        		immap->im_ioport.iop_padat |= 0x0040 * from;
+		}
+		spiinuse = from + 1;
+		spiopened = 1;
+		if (from == 0) {
+			cp->cp_spmode = SPMODE_CI | SPMODE_CP | SPMODE_REV | 
+				SPMODE_MSTR | SPMODE_DIV16 | ((8-1) << 4) | 
+				0xF | SPMODE_EN;
+		} else {
+			cp->cp_spmode = SPMODE_CI | SPMODE_CP |  
+				SPMODE_MSTR | ((16-1) << 4) | 5 | SPMODE_EN;
+		}
+	}
+	return 1;
+}
+
+int 
+cyc_cpm_spi_close(unsigned char from)
+{
+	volatile cpm8xx_t *cp = cpmp;
+	volatile immap_t *immap = (immap_t *)IMAP_ADDR;
+#ifdef DEBUG_WRITE_SPI
+	printk("SPI close from = %d, spiinuse = %d, spiopened = %d\n", 
+		from, spiinuse, spiopened);
+#endif
+	if (!spiopened || (spiinuse && spiinuse != from + 1)) {
+		return 0;
+	}
+	if (--spiopened == 0) {
+		if (IS_BOARD_KVMNETP) {
+       			immap->im_ioport.iop_padat &= ~0x00c0;
+		} else {
+       			immap->im_ioport.iop_padat |= 0x00c0;
+		}
+		spiinuse = 0;
+		cp->cp_spmode = 0;
+	}
+	return 1;
+}
+
+#define INV(x)	(x & 0xff) * 0x100 + (x / 0x100)
+
+ssize_t
+cyc_cpm_spi_osd_write(char from, unsigned short *buffer, int size)
+{
+	volatile spi_t *spp;
+	volatile cbd_t	*tbdf, *rbdf;
+	volatile cpm8xx_t	*cp;
+	uint	reloc, i;
+	
+	if (spiinuse != from + 1) {
+		return 0;
+	}
+
+	cp = cpmp;	/* Get pointer to Communication Processor */
+	spp = (spi_t *)&cp->cp_dparam[PROFF_SPI];
+
+	/* Check for and use a microcode relocation patch.
+	*/
+	if ((reloc = spp->spi_rpbase)) {
+		spp = (spi_t *)&cp->cp_dpmem[spp->spi_rpbase];
+	}
+
+	tbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_tbase];
+	rbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_rbase];
+
+	if (tbdf->cbd_sc & BD_SC_READY) {
+		return 0;
+	}
+	cp->cp_pbdat &=  ~0x00000001;
+
+	udelay(1);
+
+	for (i = 0; i < size; i ++) {
+#ifdef DEBUG_WRITE_SPI
+		printk("SPI write: %04x\r\n", buffer[i]);
+#endif
+
+		*(unsigned short *)(tbdf_vaddr) = INV(buffer[i]);
+		tbdf->cbd_datlen = 2;		/* Length */
+		tbdf->cbd_sc = BD_SC_READY|BD_SC_WRAP|BD_SC_INTRPT|BD_SC_LAST; 
+		rbdf->cbd_sc = BD_SC_EMPTY|BD_SC_WRAP|BD_SC_INTRPT;
+
+		cp->cp_spie = ~0;
+		cp->cp_spcom = 0x80;
+		
+		udelay(10);
+		while (tbdf->cbd_sc & BD_SC_READY) {
+			udelay(2);
+		}
+		
+	}
+	cp->cp_pbdat |=  0x00000001;
+	udelay(2);
+	return 2 * i;
+}
+
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/platforms/prxk.c linux-2.6.14-rc4/arch/ppc/platforms/prxk.c
--- linux-2.6.14-rc4.orig/arch/ppc/platforms/prxk.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4/arch/ppc/platforms/prxk.c	2005-10-28 14:04:15.000000000 -0500
@@ -0,0 +1,307 @@
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/time.h>
+#include <linux/rtc.h>
+#include <asm/io.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/mpc8xx.h>
+#include <asm/8xx_immap.h>
+#include <platforms/prxk.h>
+#include <platforms/cpld.h>
+
+volatile struct fpga_pc_regs *fpga_pc;
+volatile void *uarts;
+volatile struct cpld_regs *cpld;
+volatile struct fpga_pc_regs *fpga_pc;
+volatile struct muxfpga_regs *muxfpga;
+
+void *get_cpld(void *dummy)
+{
+        return (void *)cpld;
+}
+
+EXPORT_SYMBOL(get_cpld);
+
+
+unsigned char *cflash_addr;
+unsigned char *flash_addr;
+
+void __init prxk_init_memory(void)
+{
+	bd_t    *bd = (bd_t *)__res;
+	unsigned int	i_uart, i_cpld;
+	unsigned int	i_cflash, cflash_size;
+	unsigned int	i_flash, flash_size;
+
+	i_cflash = cflash_size = 0;
+
+	switch (CYC_BOARD_TYPE) {
+	case BOARD_ACS48:
+	case BOARD_ACS32:
+	case BOARD_ACS16:
+	case BOARD_ACS8:
+	case BOARD_ACS4:
+	case BOARD_ACS1:
+	case BOARD_KVM16:
+	case BOARD_KVM32:
+	case BOARD_KVMNET16:
+	case BOARD_KVMNET32:
+		i_cflash = (((immap_t *)IMAP_ADDR)->im_memctl.memc_br2 & 
+			0xffff8000L);
+		cflash_size = 0x1000;
+	default:
+		i_cpld = (((immap_t *)IMAP_ADDR)->im_memctl.memc_br3 & 
+			0xffff8000L);
+		i_uart = (((immap_t *)IMAP_ADDR)->im_memctl.memc_br4 & 
+			0xffff8000L);
+	}
+	
+	uarts = (void *)ioremap_nocache(i_uart, DB_UART_ADDR_SIZE);
+	cpld = (struct cpld_regs *)ioremap_nocache(i_cpld, DB_CPLD_ADDR_SIZE);
+
+	switch (CYC_BOARD_TYPE) {
+	case BOARD_ACS48:
+	case BOARD_ACS32:
+	case BOARD_ACS16:
+	case BOARD_ACS8:
+	case BOARD_ACS4:
+	case BOARD_ACS1:
+	case BOARD_KVM16:
+	case BOARD_KVM32:
+	case BOARD_KVMNET16:
+	case BOARD_KVMNET32:
+		cflash_addr = ioremap_nocache(i_cflash, cflash_size);
+		break;
+	}
+
+	switch (CYC_BOARD_TYPE) {
+	case BOARD_ACS32:
+	case BOARD_ACS16:
+	case BOARD_ACS8:
+	case BOARD_ACS4:
+		if (!(cpld->fpga_jp & FPGA_JP_PCMCIA)) {
+			// PCMCIA present
+			unsigned int i_fpga_pc;
+			i_fpga_pc = (((immap_t *)IMAP_ADDR)->im_memctl.memc_br5 
+				& 0xffff8000L);
+			fpga_pc = (struct fpga_pc_regs *)ioremap_nocache(i_fpga_pc,
+					DB_FPGA_PC_ADDR_SIZE);
+		}
+		break;
+	}
+	
+	switch (CYC_BOARD_TYPE) {
+	case BOARD_KVM16:
+	case BOARD_KVM32:
+	case BOARD_KVMNET16:
+	case BOARD_KVMNET32:
+		{
+			unsigned int i_muxfpga;
+			i_muxfpga = (((immap_t *)IMAP_ADDR)->im_memctl.memc_br5
+				& 0xffff8000L);
+			muxfpga = (struct muxfpga_regs *)ioremap_nocache(i_muxfpga,
+					DB_MUXFPGA_ADDR_SIZE);
+		}
+		break;
+	}
+
+	i_flash = (((immap_t *)IMAP_ADDR)->im_memctl.memc_br0 & 0xffff8000L);
+	flash_size = bd->hw_info.flash_size;
+
+	flash_addr = ioremap_nocache(i_flash, flash_size);
+
+	switch (CYC_BOARD_TYPE) {
+	case BOARD_ACS48:
+	case BOARD_ACS16:
+	case BOARD_ACS32:
+	case BOARD_ACS8:
+	case BOARD_ACS4:
+	case BOARD_ACS1:
+	case BOARD_KVM16:
+	case BOARD_KVM32:
+	case BOARD_KVMNET16:
+	case BOARD_KVMNET32:
+		printk("CF+ addr: %x Flash Addr %x, CPLD addr: %x, "
+			"UART Addr: %x\n", (int)cflash_addr, (int)flash_addr, 
+			(int)cpld, (int)uarts);
+		break;
+	default:
+		printk("Flash addr: %x, CPLD addr: %x, UART Addr: %x\n",
+			(int)flash_addr, (int)cpld, (int)uarts);
+		break;
+	}
+
+}
+
+void cyc_8xx_restart(char *cmd)
+{
+        switch (CYC_BOARD_TYPE) {
+        case BOARD_ACS48:
+        case BOARD_ACS16:
+        case BOARD_ACS32:
+        case BOARD_ACS8:
+        case BOARD_ACS4:
+        case BOARD_ACS1:
+        case BOARD_KVM16:
+        case BOARD_KVM32:
+        case BOARD_KVMNET16:
+        case BOARD_KVMNET32:
+        case BOARD_KVMP16:
+        case BOARD_KVMP32:
+                /* RTC chip enable pin set to level 1  - pin PB31*/
+                ((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pbpar &= ~0x0001;
+                ((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pbdat |=  0x0001;
+                ((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pbdir |=  0x0001;
+                mdelay(200);
+                /* RTC chip enable pin set to level 0  - pin PB31*/
+                ((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pbdat &= ~0x0001;
+                mdelay(200);
+        }
+
+	/* reset output set to level 0 - pin PA3 */
+	((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_padat &= ~0x1000;
+	((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_padir |= 0x1000;
+	mdelay(200); 
+	((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_padat |= 0x1000;
+
+}
+
+//the routines to access external real time clock via SPI protocol
+#define RTC_GET_BCD_SEC(x)      ((x & 0x0f) + (((x & 0x70) >> 4) * 10))
+#define RTC_GET_BCD_MIN(x)      ((x & 0x0f) + (((x & 0x70) >> 4) * 10))
+#define RTC_GET_BCD_HR(x)       ((x & 0x0f) + (((x & 0x30) >> 4) * 10))
+#define RTC_GET_BCD_MDAY(x)     ((x & 0x0f) + (((x & 0x30) >> 4) * 10))
+#define RTC_GET_BCD_MONTH(x)    ((x & 0x0f) + (((x & 0x10) >> 4) * 10))
+#define RTC_GET_BCD_YEAR(x)     ((x & 0x0f) + (((x & 0xf0) >> 4) * 10))
+
+#define RTC_PUT_BCD_SEC(x,y)    ((((x % 10) + ((x / 10) << 4)) & 0x7f) | (y & ~0x7f))
+#define RTC_PUT_BCD_MIN(x,y)    ((((x % 10) + ((x / 10) << 4)) & 0x7f) | (y & ~0x7f))
+#define RTC_PUT_BCD_HR(x,y)     ((((x % 10) + ((x / 10) << 4)) & 0x3f) | (y & ~0x3f))
+#define RTC_PUT_BCD_MDAY(x,y)   ((((x % 10) + ((x / 10) << 4)) & 0x3f) | (y & ~0x3f))
+#define RTC_PUT_BCD_MONTH(x,y)  ((((x % 10) + ((x / 10) << 4)) & 0x1f) | (y & ~0x1f))
+#define RTC_PUT_BCD_YEAR(x)     (((x % 10) + ((x / 10) << 4)) & 0xff)
+
+extern ssize_t cyc_cpm_spi_read(char *buf, size_t count);
+extern ssize_t cyc_cpm_spi_write(char *buf, size_t count);
+extern void __init cyc_cpm_spi_init(void);
+
+void last_reboot(void) 
+{
+	struct rtc_time	tm;
+#ifdef CONFIG_UBOOT
+	char    buf[32], buf2[32];
+	memset(buf,0, sizeof(buf));
+
+	buf[0] = 0x00;
+	cyc_cpm_spi_read(buf, 16);
+	tm.tm_sec = RTC_GET_BCD_SEC(buf[2]);
+	tm.tm_min = RTC_GET_BCD_MIN(buf[3]);
+	tm.tm_hour= RTC_GET_BCD_HR(buf[4]);
+	tm.tm_mday = RTC_GET_BCD_MDAY(buf[6]);
+	tm.tm_mon = RTC_GET_BCD_MONTH(buf[7]);
+	tm.tm_year= RTC_GET_BCD_YEAR(buf[8]);
+	/* Clear halt bit */
+	buf2[0] = 0x8c;	
+	buf2[1] = buf[0x0d] & ~0x40;
+	cyc_cpm_spi_write(buf2, 3);
+	/* Clear stop bit */
+	buf2[0] = 0x81;
+	buf2[1] = buf[2] & ~0x80;
+	cyc_cpm_spi_write(buf2, 3);
+	/* Clear TR bit */
+	buf2[0] = 0x84;
+	buf2[1] = buf[5] & ~0x80;
+	cyc_cpm_spi_write(buf2, 3);
+#else
+	bd_t *binfo = (bd_t *)__res;
+
+	tm.tm_sec  = RTC_GET_BCD_SEC(binfo->hw_info.rtc_value[1]);
+	tm.tm_min  = RTC_GET_BCD_MIN(binfo->hw_info.rtc_value[2]);
+	tm.tm_hour = RTC_GET_BCD_HR(binfo->hw_info.rtc_value[3]);
+	tm.tm_mday = RTC_GET_BCD_MDAY(binfo->hw_info.rtc_value[5]);
+	tm.tm_mon  = RTC_GET_BCD_MONTH(binfo->hw_info.rtc_value[6]);
+	tm.tm_year = RTC_GET_BCD_YEAR(binfo->hw_info.rtc_value[7]);
+
+#endif
+	tm.tm_year = tm.tm_year + 1900;
+	if (tm.tm_year < 1970) {
+		tm.tm_year += 100;
+	}
+	printk("Last reboot was on %d/%d/%04d at %02d:%02d:%02d GST\r\n",
+		tm.tm_mon, tm.tm_mday, tm.tm_year, tm.tm_hour, tm.tm_min, tm.tm_sec);
+}
+
+void m8xx_wdt_reset(void);
+long __init cyc_rtc_init(void)
+{
+	cyc_cpm_spi_init();
+	printk("RTC init done");
+	last_reboot();
+	return 0;
+}
+
+unsigned long cyc_get_rtc_time(void)
+{
+	unsigned int	year, mon, day, hour, min, sec;
+	char    buf[32];
+
+	memset(buf,0, sizeof(buf));
+
+	buf[0] = 0x00;	/* first position should have register addr on the RTC */
+	cyc_cpm_spi_read(buf, 16);	/* read 15 bytes + 1 reg addr */
+					/* buf[1-15] are valid returned data */
+	sec = RTC_GET_BCD_SEC(buf[2]);
+	min = RTC_GET_BCD_MIN(buf[3]);
+	hour= RTC_GET_BCD_HR(buf[4]);
+	day = RTC_GET_BCD_MDAY(buf[6]);
+	mon = RTC_GET_BCD_MONTH(buf[7]);
+	year= RTC_GET_BCD_YEAR(buf[8]);
+
+	year = year + 1900;
+	if (year < 1970) {
+		year += 100;
+	}
+
+	return mktime(year, mon, day, hour, min, sec);
+}
+
+int cyc_set_rtc_time(unsigned long nowtime)
+{
+	struct rtc_time	tm;
+	char buf[32];
+
+	to_tm(nowtime, &tm);
+
+	tm.tm_year = (tm.tm_year - 1900) % 100;
+
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 0x00;		/* first position should have register addr on the RTC */
+	cyc_cpm_spi_read(buf, 16);	/* read 15 bytes + 1 red addr */
+
+	buf[2] = RTC_PUT_BCD_SEC(tm.tm_sec, buf[2]);
+	buf[3] = RTC_PUT_BCD_MIN(tm.tm_min, buf[3]);
+	buf[4] = RTC_PUT_BCD_HR(tm.tm_hour, buf[4]);
+	buf[6] = RTC_PUT_BCD_MDAY(tm.tm_mday, buf[6]);
+	buf[7] = RTC_PUT_BCD_MONTH(tm.tm_mon, buf[7]);
+	buf[8] = RTC_PUT_BCD_YEAR(tm.tm_year);
+
+	buf[0] = 0x00;	/* first position should have register addr on the RTC */
+	cyc_cpm_spi_write(buf, 10);
+
+	return 0;
+}
+
+void __init
+board_init(void)
+{
+	ppc_md.time_init = cyc_rtc_init;
+	ppc_md.set_rtc_time = cyc_set_rtc_time;
+	ppc_md.get_rtc_time = cyc_get_rtc_time;
+	ppc_md.restart = cyc_8xx_restart;
+}
+
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/platforms/prxk.h linux-2.6.14-rc4/arch/ppc/platforms/prxk.h
--- linux-2.6.14-rc4.orig/arch/ppc/platforms/prxk.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4/arch/ppc/platforms/prxk.h	2005-10-24 15:54:56.000000000 -0500
@@ -0,0 +1,135 @@
+
+/*
+ * A collection of structures, addresses, and values associated with
+ * the PRxK board.  Copied from the EST8xx stuff.
+ *
+ * Copyright (c) 1998 Dan Malek (dmalek@jlc.net)
+ */
+#ifndef __MACH_PRxK_DEFS
+#define __MACH_PRxK_DEFS
+
+#ifndef __ASSEMBLY__
+#define CYC_BOARD_TYPE (((bd_t *)__res)->hw_info.board_type)
+
+#define BOARD_PR3K 0
+#define BOARD_PR2K 1
+#define BOARD_PR4K 2
+#define BOARD_PR1K 3
+#define BOARD_TS1K 4
+#define BOARD_TS2K 5
+#define BOARD_TS4H 6
+#define BOARD_TS8H 7
+#define BOARD_TS3K 8
+#define BOARD_TX1K 9
+#define BOARD_TX2K 10
+#define BOARD_PL1K 11
+#define BOARD_TS1H 12
+#define BOARD_NL1K 13
+#define BOARD_ACS16 14
+#define BOARD_ACS32 15
+#define BOARD_SM100  16
+#define BOARD_PR3500 17
+#define BOARD_TS110  18
+#define BOARD_ACS48  19
+#define BOARD_ACS4   20
+#define BOARD_ACS8   21
+#define BOARD_ACS1   22
+#define BOARD_KVM16  24
+#define BOARD_KVM32  25
+#define BOARD_KVMNET16  26
+#define BOARD_KVMNET32  27
+#define BOARD_ONS441	28
+#define BOARD_ONS481	29
+#define BOARD_ONS841	30	
+#define BOARD_ONS881	31
+#define BOARD_ONS442	32	
+#define BOARD_ONS482	33	
+#define BOARD_ONS842	34	
+#define BOARD_ONS882	35
+#define BOARD_KVMP16  36
+#define BOARD_KVMP32  37
+
+
+/* PRxB boot code information data,
+ * they come from FPGA and Dip switchs
+*/
+struct	prxk_boot_info {
+	unsigned int	mem_test_result;
+	unsigned int	memory_detected;
+	unsigned char	alt_boot;
+	unsigned char	error_status;
+	unsigned char	reserved;
+	unsigned char	board_type;
+	unsigned int	flash_size;
+	unsigned char	clock_freq;
+	unsigned char	processor;
+	unsigned char	manufactor;
+	unsigned char	eth_links;
+	unsigned char	board_version;
+	unsigned char	save_opcode;
+	unsigned char	code_legacy;
+	unsigned char	flash_chips;
+	unsigned char	serial_itf;
+	unsigned char	power_supply;
+	unsigned char	pcmcia;
+	unsigned char	wdt_config;
+	unsigned char	rtc_value[20];
+	unsigned int	storage_size;	//[RK] compact flash size
+	unsigned char	device_id[16];	//[RK] router id
+	unsigned char	async_config;	// KVMNET USER2 profile
+	unsigned char	fpga_version;	// FPGA version
+	unsigned char	ipboard1;
+	unsigned char	ipboard2;
+	unsigned char	next_available;
+};
+
+/* A Board Information structure that is given to a program when
+ * prom starts it up.
+ */
+typedef struct bd_info {
+	unsigned int	bi_memstart;	/* Memory start address */
+	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
+	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
+	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
+	unsigned char	wdt;
+	unsigned char	mii_operation;
+	unsigned char	bi_enetaddr[6];
+	unsigned int	bi_baudrate;
+	unsigned int 	ibytesec;	//[GB]May/06/06 - Ethernet Receive Rate Limit
+	unsigned short	max_int_work;
+	unsigned short	num_portsS;
+	unsigned short	num_portsA;
+	unsigned short	num_portsM;
+	unsigned short	num_portsK;
+	unsigned char	board_name[32];
+	unsigned char	vendor_name[32];
+	unsigned char	prod_line[32];
+	unsigned char	prod_name[32];
+	unsigned char	card_name[10];
+	unsigned char   cyc_banner[256];
+	unsigned char   cyc_version[32];
+	struct	prxk_boot_info hw_info;
+} bd_t;
+
+/* Memory map is configured by the PROM startup.
+ * We just map a few things we need.
+ */
+#define IMAP_ADDR		((uint)0xff000000)
+#define IMAP_SIZE		((uint)(64 * 1024))
+
+#define _IO_BASE	0xB0000000
+#define _IO_BASE_SIZE	(1024*64)
+
+#endif  //__ASSEMBLY__
+/* We don't use the 8259.
+*/
+#define NR_8259_INTS	0
+
+#define FEC_INTERRUPT   SIU_LEVEL5
+
+
+/* Machine type
+*/
+#define _MACH_8xx (_MACH_PRxK)
+
+#endif
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/arch/ppc/syslib/m8xx_setup.c linux-2.6.14-rc4/arch/ppc/syslib/m8xx_setup.c
--- linux-2.6.14-rc4.orig/arch/ppc/syslib/m8xx_setup.c	2005-10-18 16:59:34.000000000 -0500
+++ linux-2.6.14-rc4/arch/ppc/syslib/m8xx_setup.c	2005-10-24 16:16:41.000000000 -0500
@@ -356,12 +356,14 @@ m8xx_map_io(void)
         io_block_mapping(PCI_ISA_IO_ADDR, PCI_ISA_IO_ADDR, 0x4000, _PAGE_IO);
         io_block_mapping(PCI_IDE_ADDR, PCI_IDE_ADDR, 0x4000, _PAGE_IO);
 #endif
-#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
-	io_block_mapping(RPX_CSR_ADDR, RPX_CSR_ADDR, RPX_CSR_SIZE, _PAGE_IO);
+#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) || defined(CONFIG_PRxK)
 #if !defined(CONFIG_PCI)
 	io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
 #endif
 #endif
+#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
+	io_block_mapping(RPX_CSR_ADDR, RPX_CSR_ADDR, RPX_CSR_SIZE, _PAGE_IO);
+#endif
 #if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
 	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, _PAGE_IO);
 #endif
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/include/asm-ppc/mpc8xx.h linux-2.6.14-rc4/include/asm-ppc/mpc8xx.h
--- linux-2.6.14-rc4.orig/include/asm-ppc/mpc8xx.h	2005-10-18 17:00:09.000000000 -0500
+++ linux-2.6.14-rc4/include/asm-ppc/mpc8xx.h	2005-10-24 15:49:24.000000000 -0500
@@ -68,6 +68,10 @@
 #include <platforms/mpc885ads.h>
 #endif
 
+#if defined (CONFIG_PRxK)
+#include <platforms/prxk.h>
+#endif
+
 /* Currently, all 8xx boards that support a processor to PCI/ISA bridge
  * use the same memory map.
  */
