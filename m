Return-Path: <marcelo.tosatti@cyclades.com>
Received: from www.linux.org.uk (parcelfarce.linux.theplanet.co.uk
	[195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F1C92BDB4
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Oct 2004 03:56:02 +1000 (EST)
Date: Fri, 15 Oct 2004 13:09:41 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>
Message-ID: <20041015160941.GA4054@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-dev <linuxppc-dev@ozlabs.org>,
	"Nei A. Chiaradia" <nei.chiaradia@cyclades.com>,
	Wanda Rosalino <wanda.rosalino@cyclades.com>,
	Regina Kodato <regina.kodato@cyclades.com>
Subject: [PATCH] PRxK sub-architecture
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi PPC folks,

Cyclades manufactures several embedded PowerPC products (based on mpc8xx), serial 
console servers, digital kvm's, etc. that run Linux, and we need certain modifications 
(a group of new sub-sub architectures on arch/ppc/ and some others) for it to work. 

We maintain a v2.4 tree with this modifications in-house.

We would like to merge this code upstream. The following patch is 
the basic structure for getting the system to boot. Its basically 
flash access code (to retrieve bootup information), a different start 
function at a custom address (head.S), and the embed_config() function
to fill the bdinfo structure with the correct board data.

We need to get rid of _bcopy_str() function and use memcpy instead, but 
apart from that it should be clean.

The fec.c change is probably in the main repository already (BTW this fec.c
driver didnt work for our board, we're using ported v2.4's fec.c, but 
thats a later story).

Tom, Dan, can you take a look at the patch and see if you reject anything
for merging to linuxppc-2.5 tree. Its all non-intrusive code based 
on CONFIG_PRxK selection.

Kudos to all Cyclades developers who worked on this.

Once we have this merged, there are other patches we would like
to see in.


diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/8xx_io/fec.c linux-2.6-bkppc/arch/ppc/8xx_io/fec.c
--- linux-2.6-bkppc.orig/arch/ppc/8xx_io/fec.c	2004-09-02 08:52:19.000000000 -0300
+++ linux-2.6-bkppc/arch/ppc/8xx_io/fec.c	2004-09-02 14:33:23.000000000 -0300
@@ -173,7 +173,7 @@
 	uint	phy_status;
 	uint	phy_speed;
 	phy_info_t	*phy;
-	struct tq_struct phy_task;
+	struct work_struct phy_task;
 
 	uint	sequence_done;
 
@@ -1320,18 +1320,18 @@
 {
 	struct fec_enet_private *fep = dev->priv;
 
-	fep->phy_task.routine = (void *)mii_relink;
-	fep->phy_task.data = dev;
-	schedule_task(&fep->phy_task);
+	PREPARE_WORK (&fep->phy_task, mii_relink ,dev);
+
+	schedule_work(&fep->phy_task);
 }
 
 static void mii_queue_config(uint mii_reg, struct net_device *dev)
 {
 	struct fec_enet_private *fep = dev->priv;
 
-	fep->phy_task.routine = (void *)mii_display_config;
-	fep->phy_task.data = dev;
-	schedule_task(&fep->phy_task);
+	PREPARE_WORK (&fep->phy_task, mii_display_config, dev);
+
+	schedule_work(&fep->phy_task);
 }
 
 
@@ -1682,6 +1682,8 @@
 	fep->ph_priv = NULL;
 #endif
 
+	INIT_WORK(&fep->phy_task, NULL, NULL);
+
 	/* Install our interrupt handler.
 	*/
 	if (request_irq(FEC_INTERRUPT, fec_enet_interrupt, 0, "fec", dev) != 0)
diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/boot/cyc_banner.h linux-2.6-bkppc/arch/ppc/boot/cyc_banner.h
--- linux-2.6-bkppc.orig/arch/ppc/boot/cyc_banner.h	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.6-bkppc/arch/ppc/boot/cyc_banner.h	2004-09-02 14:51:50.000000000 -0300
@@ -0,0 +1,50 @@
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
+static char CYCLADES_TXT[] = "Cyclades";
+static char CYCLADES_BANNER[] = "Linux ";
+static char CYCLADES_WHAT[36] = "@(#)V_2.3.0a (Aug/05/04) #25";
+
+#define CYCLADES_VERSION	(CYCLADES_WHAT+4)
+
+static char machine_txt[25][8] = {
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
+	"KVM32"
+};
+
diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/boot/simple/embed_config.c linux-2.6-bkppc/arch/ppc/boot/simple/embed_config.c
--- linux-2.6-bkppc.orig/arch/ppc/boot/simple/embed_config.c	2004-09-02 08:52:19.000000000 -0300
+++ linux-2.6-bkppc/arch/ppc/boot/simple/embed_config.c	2004-09-02 10:17:19.000000000 -0300
@@ -332,8 +332,360 @@
 	bd->bi_baudrate = 9600;
 #endif
 }
+
 #endif /* RPXLITE || RPXCLASSIC */
 
+#ifdef CONFIG_PRxK
+
+/* Build a board information structure for the PRXK.
+ */
+
+#include <asm/uaccess.h>
+#include "../cyc_banner.h"
+#include <asm/commproc.h>
+#include <asm/cyc_config.h>
+#include <asm/flash.h>
+
+char *
+_bcopy_str(char *src, char *dst)
+{
+        while (*src) *dst++ = *src++;
+        *dst = 0;
+        return(dst);
+}
+
+
+static void reset_ports(int board)
+{
+	volatile immap_t	*pm = (volatile immap_t *)IMAP_ADDR;
+
+#ifdef CONFIG_TSxK
+	if (board == BOARD_TS3K) {
+		pm->im_ioport.iop_padir |=  0xAFFF;
+		pm->im_ioport.iop_papar &= ~0xEFFF;
+		pm->im_ioport.iop_paodr &= ~0xEFFF;
+		pm->im_ioport.iop_padat &= ~0xEFFF;
+
+		pm->im_cpm.cp_pbdir &= ~0x1000;
+		pm->im_cpm.cp_pbodr &= ~0x1000;
+		pm->im_cpm.cp_pbpar &= ~0x1000;
+
+		pm->im_ioport.iop_pcdir &= ~0x0700;
+		pm->im_ioport.iop_pcpar &= ~0x0700;
+		pm->im_ioport.iop_pcdat &= ~0x0700;
+		return;
+	}
+	if (board == BOARD_TS1100 ||
+		board == BOARD_TS2100 || 
+		board == BOARD_ACS48 || 
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
+#endif
+
+#if defined(CONFIG_PR1K) || defined(CONFIG_NL1K)
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
+#endif
+
+#ifdef CONFIG_SM100
+	pm->im_ioport.iop_padir &= ~0x0180;
+	pm->im_ioport.iop_padir |= 0xC61E;
+	pm->im_ioport.iop_papar &= ~0xFFFC;
+	pm->im_ioport.iop_paodr &= ~0x2FED;
+	pm->im_ioport.iop_padat &= ~0xFFE4;
+
+	pm->im_cpm.cp_pbdir |= 0xFC30;
+	pm->im_cpm.cp_pbodr |= 0xFC30;
+	pm->im_cpm.cp_pbpar |= 0x1030;
+	pm->im_cpm.cp_pbdat |= 0x0001;
+	pm->im_cpm.cp_pbdat &= ~0x1800;
+
+	pm->im_ioport.iop_pcdir |=  0x07C8;
+	pm->im_ioport.iop_pcpar &= ~0x0030;
+	pm->im_ioport.iop_pcso |= 0x0030;
+#endif
+
+#ifdef CONFIG_TS1H
+	pm->im_ioport.iop_padir |= 0xEF1C;
+	pm->im_ioport.iop_papar &= ~0xEF1C;
+	pm->im_ioport.iop_paodr &= ~0xEF1C;
+	pm->im_ioport.iop_padat &= ~0xEF3C;
+
+	pm->im_cpm.cp_pbdir |=  0xE4FE;
+	pm->im_cpm.cp_pbodr &= ~0xE4FE;
+	pm->im_cpm.cp_pbpar &= ~0xE4FE;
+
+	pm->im_ioport.iop_pcdir |=  0x0F47;
+	pm->im_ioport.iop_pcpar &= ~0x0F47;
+	pm->im_ioport.iop_pcdat &= ~0x0D47;
+#endif
+}
+
+static unsigned short calc_crc(unsigned long byte_n, unsigned short crc, char *buffer)
+{
+        int j;
+
+        while (byte_n--) {
+                crc = (((crc >> 8) ^ *buffer++) << 8) | (0xFF & crc) ;
+                for(j = 0; j < 8; j++) {
+                        if (crc & 0x8000)  {
+                                crc <<= 1;
+                                crc ^= 0x1021;
+                        } else {
+                                crc <<= 1;
+                        }
+        }
+    }
+    return(crc);
+}
+
+static unsigned char *get_config_vector(unsigned char *pflash, int type, int tries)
+{
+	FLASH_CONFIG_VECTOR_HEADER *p;
+	int cnt = 0;
+
+	while(cnt++ < tries) {
+		p = (FLASH_CONFIG_VECTOR_HEADER *)pflash;
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
+/* Build a board information structure for the PRXK.
+ */
+void
+embed_config(bd_t **bdp)
+{
+	unsigned char *pflash, *pf, *aux;
+	struct prxk_boot_info *p = (struct prxk_boot_info *)0x00002000;
+	car8xx_t *pcar = &(((immap_t *)IMAP_ADDR)->im_clkrst);
+	struct HW_SETUP *pcnf;
+	OM_INFO *p_om;
+	int speed[6] = {4800, 9600, 19200, 38400, 57600, 115200};
+	bd_t	*bd;
+
+	bd = &bdinfo;
+	*bdp = bd;
+
+	memcpy(&bd->hw_info, p, sizeof(struct prxk_boot_info));
+
+#ifdef CONFIG_TS1H
+	if (bd->hw_info.clock_freq != 4) {
+		bd->bi_busfreq = ((pcar->car_plprcr >> 20) + 1) * 25; // 25 MHz crystal
+	} else {
+		bd->bi_busfreq = ((pcar->car_plprcr >> 20) + 1) * 4;  // 4 MHz crystal
+	}
+#else
+	bd->bi_busfreq = ((pcar->car_plprcr >> 20) + 1) * 4;  // 4 MHz crystal
+#endif
+	bd->bi_intfreq = bd->bi_busfreq *= 1000000;
+
+	bd->bi_memsize = p->memory_detected;
+
+	if (p->board_type == BOARD_TS3K ||
+		p->board_type == BOARD_TS2100 ||
+		p->board_type == BOARD_TS1100 ||
+		p->board_type == BOARD_ACS48 ||
+		p->board_type == BOARD_ACS8 ||
+		p->board_type == BOARD_ACS4 ||
+		p->board_type == BOARD_ACS1 ||
+		p->board_type == BOARD_KVM16 ||
+		p->board_type == BOARD_KVM32 ||
+		p->board_type == BOARD_TS1H ||
+		p->board_type == BOARD_SM100 ||
+		p->board_type == BOARD_NL1K) {
+		pflash = FLASH_ADDR + 3 * SECTOR_SIZE;
+		pf= OM_ADDRESS1 + FLASH_ADDR;
+	} else {
+		pflash = FLASH_ADDR + 2 * SECTOR_SIZE;
+		pf= OM_ADDRESS2 + FLASH_ADDR;
+	}
+
+	if ((pcnf = (struct HW_SETUP *)get_config_vector(pflash, TYPE0068, 1000))) {
+		bd->bi_baudrate = speed[pcnf->console_speed];
+		memcpy(bd->bi_enetaddr, pcnf->physical_addr, EP_ALEN);
+		bd->mii_operation = pcnf->mii_operation;
+		bd->max_int_work = pcnf->max_int_work;
+	} else {
+		bd->mii_operation = 0;
+		bd->bi_baudrate = 9600;
+	}
+	switch (bd->hw_info.wdt_config) {
+		case 0:
+		case 1:
+			bd->wdt = 1;
+			break;
+		case 2:
+			bd->wdt = 0;
+			break;
+	}
+
+	p_om = (OM_INFO *)get_config_vector(pf, TYPE9000, 1);
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
+
+	_bcopy_str(CYCLADES_VERSION, bd->cyc_version);
+	_bcopy_str(machine_txt[p->board_type], bd->board_name);
+	_bcopy_str("UNKNOWN", bd->card_name);
+	if (p->board_type == BOARD_TS2100 || p->board_type == BOARD_TS1100 || 
+		p->board_type == BOARD_ACS48 || p->board_type == BOARD_ACS4 || 
+		p->board_type == BOARD_ACS8 || p->board_type == BOARD_ACS1) {
+		_bcopy_str(PROD_LINE3, bd->prod_line);
+		_bcopy_str(PROD_NAME3, bd->prod_name);
+	} else if (p->board_type == BOARD_KVM16 || 
+		p->board_type == BOARD_KVM32) {
+		_bcopy_str(PROD_LINE4, bd->prod_line);
+		_bcopy_str(PROD_NAME4, bd->prod_name);
+	} else if (p->board_type == BOARD_SM100) {
+		_bcopy_str(PROD_LINE2, bd->prod_line);
+		_bcopy_str(PROD_NAME2, bd->prod_name);
+	} else {
+		_bcopy_str(PROD_LINE0, bd->prod_line);
+		_bcopy_str(PROD_NAME0, bd->prod_name);
+	}
+	_bcopy_str(CYCLADES_TXT, bd->vendor_name);
+	bd->num_ports = 0;
+
+	if (p_om && p_om->banner[0]) {
+		aux = _bcopy_str(p_om->banner, bd->cyc_banner);
+		*aux++ = '\r';
+		*aux = '\n';
+	} else {
+		aux = _bcopy_str(bd->prod_line, bd->cyc_banner);
+		*aux++ = '-';
+		aux = _bcopy_str(bd->board_name, aux);
+		*aux++ = '-';
+		aux = _bcopy_str(CYCLADES_BANNER, aux);
+		aux = _bcopy_str(CYCLADES_VERSION, aux);
+	}
+
+#if defined(CONFIG_PR1K) || defined(CONFIG_NL1K) || defined(CONFIG_TS1H) || defined(CONFIG_SM100)
+	_bcopy_str("SWAN", bd->card_name);
+	bd->num_ports = 1;
+#endif
+#ifdef CONFIG_TSxK
+	if (p->board_type == BOARD_ACS1 || 
+		p->board_type == BOARD_KVM16 || 
+		p->board_type == BOARD_KVM32) {
+		_bcopy_str("SWAN", bd->card_name);
+	}
+	else {
+	_bcopy_str("CPLD", bd->card_name);
+	}
+	switch(p->board_type) {
+	case BOARD_TS3K:		// TS3000
+	case BOARD_ACS48:		// ACS48
+		bd->num_ports = 48;
+		break;
+	case BOARD_TS1K:		// TS1000
+	case BOARD_TS1100:		// TS1100
+		bd->num_ports = 16;
+		break;
+	case BOARD_TS2K:		// TS2000
+	case BOARD_TS2100:		// TS2100
+		bd->num_ports = 32;
+		break;
+	case BOARD_TS4H:		// TS400
+	case BOARD_ACS4:		// ACS4
+		bd->num_ports = 4;
+		break;
+	case BOARD_TS8H:		// TS800
+	case BOARD_ACS8:		// ACS8
+		bd->num_ports = 8;
+		break;
+	case BOARD_ACS1:		// ACS1
+	case BOARD_KVM16:
+	case BOARD_KVM32:
+		bd->num_ports = 1;
+		break;
+	}
+#endif
+
+	reset_ports(p->board_type);
+
+}
+
+#endif /* CONFIG_PRxK */
+
 #ifdef CONFIG_BSEIP
 /* Build a board information structure for the BSE ip-Engine.
  * There is more to come since we will add some environment
diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/boot/simple/head.S linux-2.6-bkppc/arch/ppc/boot/simple/head.S
--- linux-2.6-bkppc.orig/arch/ppc/boot/simple/head.S	2004-09-02 08:52:19.000000000 -0300
+++ linux-2.6-bkppc/arch/ppc/boot/simple/head.S	2004-09-02 17:30:39.000000000 -0300
@@ -32,6 +32,20 @@
  *
  */
 
+#ifdef CONFIG_PRxK
+        .globl  start1
+start1: .long   0x00002120
+        .ascii  "Entry Point\x00"
+        .long   0x00000000
+        .long   0x00000000
+        .long   0x00000000
+#ifdef CONFIG_TS1H
+        .long   start1
+#else
+        .long   0x00000000
+#endif
+#endif
+
 	.globl	start
 start:
 	bl	start_
diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/configs/prxk_defconfig linux-2.6-bkppc/arch/ppc/configs/prxk_defconfig
--- linux-2.6-bkppc.orig/arch/ppc/configs/prxk_defconfig	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.6-bkppc/arch/ppc/configs/prxk_defconfig	2004-09-03 00:54:49.000000000 -0300
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
+
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
diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/Kconfig linux-2.6-bkppc/arch/ppc/Kconfig
--- linux-2.6-bkppc.orig/arch/ppc/Kconfig	2004-09-02 08:52:19.000000000 -0300
+++ linux-2.6-bkppc/arch/ppc/Kconfig	2004-09-02 10:36:57.000000000 -0300
@@ -354,6 +354,12 @@
 	  LEDs.  Variants with Ethernet ports exist.  Say Y here to support it
 	  directly.
 
+config PRxK
+	bool "PRxK"
+	help
+	The PRxK's are Cyclades embedded PowerPC hardware: serial servers, 
+	kvm managers, routers.
+
 config BSEIP
 	bool "BSE-IP"
 	help
@@ -472,6 +478,22 @@
 endchoice
 
 choice
+        prompt "PRxK Machine Type"
+        depends on PRxK
+        default TSxK
+
+config TSxK
+	bool TSxK
+	help	
+	  Say Y here to support the ACS, KVM families. 
+config TS1H
+	bool TS1H
+	help
+	  Say Y here to support the TS1H family.
+
+endchoice
+
+choice
 	prompt "Machine Type"
 	depends on 6xx || POWER3 || POWER4
 	default PPC_MULTIPLATFORM
 
diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/platforms/prxk.h linux-2.6-bkppc/arch/ppc/platforms/prxk.h
--- linux-2.6-bkppc.orig/arch/ppc/platforms/prxk.h	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.6-bkppc/arch/ppc/platforms/prxk.h	2004-09-02 10:53:35.000000000 -0300
@@ -0,0 +1,118 @@
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
+#define BOARD_TS1100 14
+#define BOARD_TS2100 15
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
+	unsigned short	max_int_work;
+	unsigned short	num_ports;
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
diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/include/asm-ppc/flash.h linux-2.6-bkppc/include/asm-ppc/flash.h
--- linux-2.6-bkppc.orig/include/asm-ppc/flash.h	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.6-bkppc/include/asm-ppc/flash.h	2004-09-02 14:51:22.000000000 -0300
@@ -0,0 +1,72 @@
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
+ *	Complies with Cyclades SW Coding Standard rev 1.2.
+ *-----------------------------------------------------------------------------
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
+/*--------------------------------------------------------------------------
+ *
+ * Constants
+ *
+ *-------------------------------------------------------------------------*/
+
+#ifdef CONFIG_TS1H
+#define SECTOR_SIZE	0x20000L
+#else
+#define SECTOR_SIZE	0x10000L 
+#endif
+
+/* Values used on dealing with the flash */
+/* The values are flipped because the data lines on the PR-3000 were flipped */
+#define UNLOCK_VALUE_A				0xaa
+#define UNLOCK_VALUE_B				0x55
+#define SETUP_VALUE					0x80
+#define	SECTOR_ERASE_VALUE			0x30
+#define	CHIP_ERASE_VALUE			0x10
+#define PROGRAM_VALUE				0xa0
+#define RESET_READ_VALUE			0xf0
+#define AUTO_SELECT_VALUE			0x90
+#define	DQ7							0x80
+#define DQ6							0x40
+#define DQ5							0x20		
+#define DQ3							0x08		
+
+/* Configuration Address */
+#define CFG_ADDR					0x5555
+
+/* values returned by the data_polling procedure */
+#define PASS			0x01
+#define FAIL			0x00
+#define IN_PROGRESS		0x03
+
+typedef struct flash_config_vector_header {
+    unsigned short type;
+    unsigned short size;
+    unsigned short crc;
+	unsigned char  data[2];
+} FLASH_CONFIG_VECTOR_HEADER;
+
+#define FLASH_ADDR ((unsigned char *)(((immap_t *)IMAP_ADDR)->im_memctl.memc_br0 & 0xffff8000L))
+
+extern unsigned char *cflash_addr, *flash_addr, *flash_boot;
+
diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/include/asm-ppc/mpc8xx.h linux-2.6-bkppc/include/asm-ppc/mpc8xx.h
--- linux-2.6-bkppc.orig/include/asm-ppc/mpc8xx.h	2004-09-02 08:53:02.000000000 -0300
+++ linux-2.6-bkppc/include/asm-ppc/mpc8xx.h	2004-09-02 14:04:50.000000000 -0300
@@ -24,6 +24,10 @@
 #include <platforms/rpxlite.h>
 #endif
 
+#ifdef CONFIG_PRxK
+#include <platforms/prxk.h>
+#endif
+
 #ifdef CONFIG_BSEIP
 #include <platforms/bseip.h>
 #endif
diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/include/asm-ppc/prxk.h linux-2.6-bkppc/include/asm-ppc/prxk.h
--- linux-2.6-bkppc.orig/include/asm-ppc/prxk.h	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.6-bkppc/include/asm-ppc/prxk.h	2004-09-02 08:54:51.000000000 -0300
@@ -0,0 +1,118 @@
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
+#define BOARD_TS1100 14
+#define BOARD_TS2100 15
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
+	unsigned short	max_int_work;
+	unsigned short	num_ports;
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
