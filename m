Date: Thu, 14 Mar 02 22:11:39 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203150611.AA26053@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] My GT-64260 enhancements
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

The patch below contains my promised enhancements to the GT-64260 and EV-64260
code in linuxppc_2_4_devel. Its main features are:

* The interface to vmlinux is bi_recs. Two new bi_recs have been added by me:
  BI_GT64260_BASE and BI_GT64260_ETH_CFG.

* Core GT-64260 code enhancements:
  - added gt64260_phys_base variable to hold the physical address of the
    GT-64260 registers, set by parse_bootinfo (and can be set by others too).
  - "GT64260 Options" goo removed from arch/ppc/config.in. See below for how is
    everything configured properly.

* GT-64260 Ethernet driver enhancements:
  - The driver is an option in drivers/net/Config.in where it belongs. Not
    buildable as a module yet, but we'll get there eventually.
  - Ethernet station addresses (aka MAC addresses) are taken from
    BI_GT64260_ETH_CFG records (always). No more compiled-in MAC addresses,
    PPCBoot #ifdefs, or mucking with bd_t.
  - Other Ethernet information, specifically MII vs. RMII and PHY address, is
    also passed at run time via BI_GT64260_ETH_CFG records. There are no more
    #ifdefs in the GT-64260 Ethernet driver.

* EV-64260-BP port enhancements:
  - A pointer to bi_recs is expected in R3 just like on SBS K2 and Adirondack
    instead of the screwy find_bootinfo(). Just like on SBS K2 this works with
    both ppc-linux-boot and the arch/ppc/boot wrapper.
  - The arch/ppc/boot wrapper is still supported. There are options in
    arch/ppc/config.in to set compiled-in MAC addresses, but now they are
    strictly optional, appear only for the EV-64260-BP port, and affect only
    the zImage wrapper. The latter uses them to generate BI_GT64260_ETH_CFG
    records for the EVB (that's where the hard-coded knowledge of EVB's quad
    RMII PHY now lives).
  - BI_GT64260_BASE is honored if present but not required, as prior to calling
    parse_bootinfo() gt64260_phys_base is set to the old hard-coded value.

* Miscellaneous:
  - A correction for arch/ppc/config.in: CONFIG_SERIAL_TEXT_DEBUG should be
    conditionalised on CONFIG_EV64260 (and other boards in the future if
    applicable) rather than on CONFIG_GT64260, because there is no guarantee
    that every board port in the future will support it.

So having thus introduced it, I hereby submit this patch for integration into
linuxppc_2_4_devel:

diff -Nru a/arch/ppc/boot/common/misc-simple.c b/arch/ppc/boot/common/misc-simple.c
--- a/arch/ppc/boot/common/misc-simple.c	Thu Mar 14 21:31:15 2002
+++ b/arch/ppc/boot/common/misc-simple.c	Thu Mar 14 21:31:15 2002
@@ -69,6 +69,10 @@
 extern void gunzip(void *, int, unsigned char *, int *);
 extern void serial_fixups(void);

+#ifdef CONFIG_EV64260
+extern struct bi_record *add_extra_bi_recs(struct bi_record *bp);
+#endif
+
 struct bi_record *
 decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum)
 {
@@ -208,6 +212,10 @@
 		rec = (struct bi_record *)((unsigned long)rec +
 				rec->size);
 	}
+
+#ifdef CONFIG_EV64260
+	rec = add_extra_bi_recs(rec);
+#endif

 	rec->tag = BI_LAST;
 	rec->size = sizeof(struct bi_record);
diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile	Thu Mar 14 21:31:15 2002
+++ b/arch/ppc/boot/simple/Makefile	Thu Mar 14 21:31:15 2002
@@ -34,7 +34,7 @@
 ifeq ($(CONFIG_EV64260),y)
 ZIMAGE				:= zImage-EV64260
 ZIMAGEINITRD			:= zImage.initrd-EV64260
-HEADHELP			:= direct.o misc-ev64260.o
+HEADHELP			:= direct.o misc-ev64260.o ev64260-birecs.o
 TFTPIMAGE			:= /tftpboot/zImage.ev64260
 endif
 ifeq ($(CONFIG_GEMINI),y)
diff -Nru a/arch/ppc/boot/simple/ev64260-birecs.c b/arch/ppc/boot/simple/ev64260-birecs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/boot/simple/ev64260-birecs.c	Thu Mar 14 21:31:17 2002
@@ -0,0 +1,118 @@
+/*
+ * arch/ppc/boot/simple/ev64260-birecs.c
+ *
+ * Generates extra bi_recs for EV-64260-BP port (GT-64260 base address and
+ * Ethernet info).
+ *
+ * Author: Michael Sokolov <msokolov@ivan.Harhan.ORG>
+ */
+
+#include <linux/types.h>
+#include <linux/elf.h>
+#include <linux/config.h>
+#include <linux/pci.h>
+
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/mmu.h>
+#include <asm/bootinfo.h>
+#include <asm/gt64260.h>
+#include <platforms/ev64260.h>
+
+static unsigned char
+hexdigit(char ch)
+{
+	switch (ch) {
+	case '0':
+		return 0;
+	case '1':
+		return 1;
+	case '2':
+		return 2;
+	case '3':
+		return 3;
+	case '4':
+		return 4;
+	case '5':
+		return 5;
+	case '6':
+		return 6;
+	case '7':
+		return 7;
+	case '8':
+		return 8;
+	case '9':
+		return 9;
+	case 'A':
+	case 'a':
+		return 10;
+	case 'B':
+	case 'b':
+		return 11;
+	case 'C':
+	case 'c':
+		return 12;
+	case 'D':
+	case 'd':
+		return 13;
+	case 'E':
+	case 'e':
+		return 14;
+	case 'F':
+	case 'f':
+		return 15;
+	}
+}
+
+static void
+eth_str2mac(char *str, unsigned char *mac)
+{
+	int i;
+
+	for (i = 0; i < 12; i += 2)
+		mac[i / 2] = (hexdigit(str[i]) << 4) |
+			      hexdigit(str[i + 1]);
+}
+
+struct bi_record *
+add_extra_bi_recs(struct bi_record *bp)
+{
+	struct gt64260_eth_config *eis;
+
+	bp->tag = BI_GT64260_BASE;
+	bp->size = sizeof(struct bi_record) + 4;
+	bp->data[0] = EV64260_BRIDGE_REG_BASE;
+	bp = (struct bi_record *) ((caddr_t) bp + bp->size);
+
+	bp->tag = BI_GT64260_ETH_CFG;
+	bp->size = sizeof(struct bi_record) + 4 +
+					sizeof(struct gt64260_eth_config);
+	bp->data[0] = 0;
+	eis = (struct gt64260_eth_bootinfo *) &bp->data[1];
+	eth_str2mac(CONFIG_EV64260_ETH_0_MACADDR, eis->eth_stat_addr);
+	eis->is_rmii = 1;
+	eis->phy_addr = 4;
+	bp = (struct bi_record *) ((caddr_t) bp + bp->size);
+
+	bp->tag = BI_GT64260_ETH_CFG;
+	bp->size = sizeof(struct bi_record) + 4 +
+					sizeof(struct gt64260_eth_config);
+	bp->data[0] = 1;
+	eis = (struct gt64260_eth_bootinfo *) &bp->data[1];
+	eth_str2mac(CONFIG_EV64260_ETH_1_MACADDR, eis->eth_stat_addr);
+	eis->is_rmii = 1;
+	eis->phy_addr = 5;
+	bp = (struct bi_record *) ((caddr_t) bp + bp->size);
+
+	bp->tag = BI_GT64260_ETH_CFG;
+	bp->size = sizeof(struct bi_record) + 4 +
+					sizeof(struct gt64260_eth_config);
+	bp->data[0] = 2;
+	eis = (struct gt64260_eth_bootinfo *) &bp->data[1];
+	eth_str2mac(CONFIG_EV64260_ETH_2_MACADDR, eis->eth_stat_addr);
+	eis->is_rmii = 1;
+	eis->phy_addr = 6;
+	bp = (struct bi_record *) ((caddr_t) bp + bp->size);
+
+	return(bp);
+}
diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
--- a/arch/ppc/config.in	Thu Mar 14 21:31:15 2002
+++ b/arch/ppc/config.in	Thu Mar 14 21:31:15 2002
@@ -151,32 +151,17 @@
   bool 'Enable MPC10x store gathering' CONFIG_MPC10X_STORE_GATHERING
 fi

 if [ "$CONFIG_EV64260" = "y" ]; then
   define_bool CONFIG_GT64260 y
   define_int CONFIG_SERIAL_CONSOLE_BAUD 115200
 fi

-if [ "$CONFIG_GT64260" = "y" ]; then
+if [ "$CONFIG_EV64260" = "y" ]; then
    mainmenu_option next_comment
-   comment 'Galileo GT64260 Options'
-   bool 'GT64260 Ethernet Ports' CONFIG_GT64260_ETH
-   if [ "$CONFIG_GT64260_ETH" = "y" ]; then
-     bool ' EVB64260 - Ethernet Port 0' CONFIG_GT64260_ETH_0
-     string '  MAC Address' CONFIG_GT64260_ETH_0_MACADDR "feffff000000"
-     bool ' EVB64260 - Ethernet Port 1' CONFIG_GT64260_ETH_1
-     string '  MAC Address' CONFIG_GT64260_ETH_1_MACADDR "feffff000001"
-     bool ' EVB64260 - Ethernet Port 2' CONFIG_GT64260_ETH_2
-     string '  MAC Address' CONFIG_GT64260_ETH_2_MACADDR "feffff000002"
-   fi
-   bool 'GT64260 MPSC Serial Ports' CONFIG_GT64260_MPSC
-   if [ "$CONFIG_GT64260_MPSC" = "y" ]; then
-     bool ' MPSC Port 0' CONFIG_GT64260_MPSC_0
-     bool ' MPSC Port 1' CONFIG_GT64260_MPSC_1
-     bool ' MPSC Port 0 as system console' CONFIG_GT64260_CONSOLE
-   fi
-   if [ "$CONFIG_GT64260_CONSOLE" = "y" ]; then
-     define_bool CONFIG_SERIAL_CONSOLE y
-   fi
+   comment 'EV-64260-BP zImage Wrapper Options'
+   string 'Ethernet 0 MAC Address' CONFIG_EV64260_ETH_0_MACADDR "feffff000000"
+   string 'Ethernet 1 MAC Address' CONFIG_EV64260_ETH_1_MACADDR "feffff000001"
+   string 'Ethernet 2 MAC Address' CONFIG_EV64260_ETH_2_MACADDR "feffff000002"
    endmenu
 fi

@@ -690,7 +675,7 @@
 fi
 if [ "$CONFIG_MCPN765" = "y" -o "$CONFIG_SANDPOINT" = "y" \
 	-o "$CONFIG_ZX4500" = "y" -o "$CONFIG_PRPMC800" = "y" \
-	-o "$CONFIG_4xx" = "y" -o "$CONFIG_GT64260" = "y" ]; then
+	-o "$CONFIG_4xx" = "y" -o "$CONFIG_EV64260" = "y" ]; then
   bool 'Support for early boot texts over serial port' CONFIG_SERIAL_TEXT_DEBUG
 fi
 endmenu
diff -Nru a/arch/ppc/kernel/gt64260_common.c b/arch/ppc/kernel/gt64260_common.c
--- a/arch/ppc/kernel/gt64260_common.c	Thu Mar 14 21:31:16 2002
+++ b/arch/ppc/kernel/gt64260_common.c	Thu Mar 14 21:31:16 2002
@@ -58,6 +58,7 @@


 u32	gt64260_base; /* Virtual base address of 64260's regs */
+u32	gt64260_phys_base; /* Physical base address of 64260's regs */
 u32	gt64260_revision; /* Revision of the chip */
 u8	gt64260_pci_exclude_bridge = TRUE;

diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c	Thu Mar 14 21:31:15 2002
+++ b/arch/ppc/kernel/setup.c	Thu Mar 14 21:31:15 2002
@@ -40,6 +40,10 @@
 #include <asm/kgdb.h>
 #endif

+#ifdef CONFIG_GT64260
+#include <asm/gt64260.h>
+#endif /* CONFIG_GT64260 */
+
 extern void platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7);
 extern void bootx_init(unsigned long r4, unsigned long phys);
@@ -491,6 +495,18 @@
 		case BI_MEMSIZE:
 			boot_mem_size = data[0];
 			break;
+#ifdef CONFIG_GT64260
+		case BI_GT64260_BASE:
+			gt64260_phys_base = data[0];
+			break;
+#ifdef CONFIG_GT64260_ETH
+		case BI_GT64260_ETH_CFG:
+			gt64260_eth_enable |= 1 << data[0];
+			bcopy(&data[1], &gt64260_eth_config[data[0]],
+			      sizeof(struct gt64260_eth_config));
+			break;
+#endif /* CONFIG_GT64260_ETH */
+#endif /* CONFIG_GT64260 */
 		}
 		rec = (struct bi_record *)((ulong)rec + rec->size);
 	}
diff -Nru a/arch/ppc/platforms/ev64260_setup.c b/arch/ppc/platforms/ev64260_setup.c
--- a/arch/ppc/platforms/ev64260_setup.c	Thu Mar 14 21:31:16 2002
+++ b/arch/ppc/platforms/ev64260_setup.c	Thu Mar 14 21:31:16 2002
@@ -105,7 +105,7 @@
 	GT64260_BRIDGE_INFO_DEFAULT(&info, ev64260_find_end_of_memory());

 	/* Lookup PCI host bridges */
-	if (gt64260_find_bridges(EV64260_BRIDGE_REG_BASE,
+	if (gt64260_find_bridges(gt64260_phys_base,
 				 &info,
 				 ev64260_map_irq)) {
 		printk("Bridge initialization failed.\n");
@@ -322,7 +322,7 @@

 	if (mem_size == 0) {
 		/* Next 2 lines are a kludge for gt64260_get_mem_size() */
-		gt64260_base = EV64260_BRIDGE_REG_BASE;
+		gt64260_base = gt64260_phys_base;
 		ev64260_set_bat();
 		mem_size = gt64260_get_mem_size();
 	}
@@ -498,7 +498,13 @@
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo(find_bootinfo());
+	/*
+	 * The GT-64260 physical base address will normally be passed in a
+	 * bootinfo record, but if there isn't one the default below will
+	 * remain in effect.
+	 */
+	gt64260_phys_base = EV64260_BRIDGE_REG_BASE;
+	parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));

 	isa_mem_base = 0;

@@ -530,7 +536,7 @@
 #ifdef	CONFIG_SERIAL_TEXT_DEBUG
 	ev64260_set_bat();
 #ifdef	CONFIG_GT64260_CONSOLE
-	gt64260_base = EV64260_BRIDGE_REG_BASE;
+	gt64260_base = gt64260_phys_base;
 	ppc_md.progress = gt64260_mpsc_progress; /* embedded UART */
 #else
 	ppc_md.progress = ev64260_16550_progress; /* Dev module DUART */
diff -Nru a/drivers/net/Config.in b/drivers/net/Config.in
--- a/drivers/net/Config.in	Thu Mar 14 21:31:15 2002
+++ b/drivers/net/Config.in	Thu Mar 14 21:31:15 2002
@@ -37,6 +37,7 @@
       fi
       dep_tristate '  BMAC (G3 ethernet) support' CONFIG_BMAC $CONFIG_ALL_PPC
       dep_tristate '  GMAC (G4/iBook ethernet) support' CONFIG_GMAC $CONFIG_ALL_PPC
+      dep_bool '  GT64260 Ethernet Ports' CONFIG_GT64260_ETH $CONFIG_GT64260
       if [ "$CONFIG_4xx" = "y" ]; then
          if [ "$CONFIG_REDWOOD_4" = "y" -o "$CONFIG_403GCX" = "y" ]; then
 	    tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET
diff -Nru a/drivers/net/gt64260_eth.c b/drivers/net/gt64260_eth.c
--- a/drivers/net/gt64260_eth.c	Thu Mar 14 21:31:16 2002
+++ b/drivers/net/gt64260_eth.c	Thu Mar 14 21:31:16 2002
@@ -8,6 +8,8 @@
  *
  * Author: Rabeeh Khoury from Marvell
  * Modified by: Mark A. Greer <mgreer@mvista.com>
+ * Modified by: Michael Sokolov <msokolov@ivan.Harhan.ORG> to configure via
+ *              bootinfo records
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -54,8 +56,12 @@
 #include <asm/gt64260.h>
 #include "gt64260_eth.h"

-extern bd_t ppcboot_bd;
-extern int ppcboot_bd_valid;
+/*
+ * We get configured via bootinfo records.
+ * arch/ppc/kernel/setup.c:parse_bootinfo will fill in these global vars.
+ */
+struct gt64260_eth_config gt64260_eth_config[3];
+u_long gt64260_eth_enable=0;  /* bottom 3 bits correspond to ports, 1=enable */

 unsigned char GT64260_ETH_irq[3] = { 32, 33, 34 };

@@ -154,7 +160,7 @@

    /*** SDMA ***/

-	/* Serialp Port Multiplexed */ SERIAL_PORT_MULTIPLEX_REGISTER_VALUE,
+	/* Serial Port Multiplexed */ 0x1102,

 	/* RCRR route rx clock */ 0x0,
 	/* TCRR route tx clock */ 0x0,
@@ -490,34 +496,12 @@
  *  Input : pointer to network device structure to be filled
  *  Output : -ENONMEM if failed, 0 if success
  */
-void
-gt64260_eth_str2mac(char *str, unsigned char *mac)
-{
-	int i;
-
-	for (i = 0; i < 12; i += 2) {
-		mac[i / 2] = ((isdigit(str[i]) ?
-			       str[i] - '0' :
-			       (toupper(str[i]) - 'A' + 10)) << 4) |
-		    (isdigit(str[i + 1]) ?
-		     str[i + 1] - '0' : (toupper(str[i + 1]) - 'A' + 10));
-	}
-
-	return;
-}
-
 s32
 gt64260_eth_init(struct net_device * dev)
 {
-#ifdef  CONFIG_GT64260_ETH_2
 	static u32 gt64260_eth2_initialized = 0;
-#endif				/* #ifdef GT64260_ETH_P2 */
-#ifdef  CONFIG_GT64260_ETH_1
 	static u32 gt64260_eth1_initialized = 0;
-#endif
-#ifdef  CONFIG_GT64260_ETH_0
 	static u32 gt64260_eth0_initialized = 0;
-#endif
 	priv64260 *private;

 	ether_setup(dev);	/* auto assign some of the fields by kernel */
@@ -544,64 +528,29 @@
 	dev->accept_fastpath = gt64260_eth_accept_fastpath;
 #endif				/* #ifdef CONFIG_NET_FASTROUTE */

-#if 0
-#ifdef CONFIG_PPCBOOT
-	memcpy(dev->dev_addr, boardinfo.bi_enetaddr, 6);
-#else				/* #ifdef CONFIG_PPCBOOT */
-#if 0
-	memcpy(dev->dev_addr, eeprom_param.eth0_mac, 6);
-#else
-	dev->dev_addr[0] = 0x00;
-	dev->dev_addr[1] = 0xa0;
-	dev->dev_addr[2] = 0xf7;
-	dev->dev_addr[3] = 0x33;
-	dev->dev_addr[4] = 0x34;
-	dev->dev_addr[5] = 0x36;
-#endif
-#endif				/* #else #ifdef CONFIG_PPCBOOT */
-#endif
-
-	if (dev->base_addr == 0 || dev->base_addr == 2) {
-		/* FIXME: find who else is modifying this * (other than ev64260_pci.c)
-		 * Maybe MPSC? - NTL */
-#ifdef TWO_ETHERNET_MII_PORTS
-		if (dev->base_addr == 0) {
-			/* connect port 0 to MII */
-			gt_set_bits(GT64260_MPP_SERIAL_PORTS_MULTIPLEX,
-				    (1 << 0));
-			gt_clr_bits(GT64260_MPP_SERIAL_PORTS_MULTIPLEX,
-				    (1 << 1));
-			/* port 1 is RMII/MII */
-			/* nothing */
-		}
-#endif
-#ifdef THREE_ETHERNET_RMII_PORTS
+	if (dev->base_addr == 0 && !gt64260_eth_config[0].is_rmii) {
+		/* connect port 0 to MII */
+		gt_set_bits(GT64260_MPP_SERIAL_PORTS_MULTIPLEX,
+			    (1 << 0));
+		gt_clr_bits(GT64260_MPP_SERIAL_PORTS_MULTIPLEX,
+			    (1 << 1));
+		/* port 1 is RMII/MII */
+		/* nothing */
+	}
+	if (dev->base_addr == 0 || dev->base_addr == 2 &&
+	    gt64260_eth_config[dev->base_addr].is_rmii) {
 		/* connect port 0+2 to RMII */
 		gt_clr_bits(GT64260_MPP_SERIAL_PORTS_MULTIPLEX, (1 << 0));
 		gt_set_bits(GT64260_MPP_SERIAL_PORTS_MULTIPLEX, (1 << 1));
 		/* port 1 is RMII/MII */
 		/* nothing */
-#endif
 	}

 	switch (dev->base_addr) {
-#ifdef CONFIG_GT64260_ETH_0	/* XXX_MIKE - broken logic? */
 	case 0:
 		if (!gt64260_eth0_initialized) {
-#ifdef CONFIG_GT64260_ETH_0_MACADDR
-			gt64260_eth_str2mac(CONFIG_GT64260_ETH_0_MACADDR,
-					    &dev->dev_addr[0]);
-#else
-			if (ppcboot_bd_valid &&
-			    *((unsigned long *) ppcboot_bd.bi_enetaddr) != 0) {
-				memcpy(dev->dev_addr, ppcboot_bd.bi_enetaddr,
-				       6);
-			} else {
-				printk("%s: Couldn't assign MAC address\n",
-				       dev->name);
-				return (-ENODEV);
-			}
-#endif
+			bcopy(gt64260_eth_config[0].eth_stat_addr,
+			      dev->dev_addr, 6);
 			private->port = 0;
 			gt_write(GT64260_ENET_E0SDCR, (2 << 12) | (1 << 9) | (0xf << 2));	// 0000.203c

@@ -614,7 +563,8 @@
 			 * Receive packets in 1536 bit max length and enable DSCP
 			 */
 			gt_write(GT64260_ENET_E0PCXR,
-				 PORT_CONTROL_EXTEND_VALUE);
+			     PORT_CONTROL_EXTEND_VALUE |
+			     (gt64260_eth_config[0].is_rmii ? 0x00100000 : 0));

 			/*
 			 * Initialize address table for hash mode 0 with 1/2K size
@@ -625,24 +575,10 @@
 			return 0;
 		}
 		break;
-#endif				/* #ifdef GT64260_ETH_P0 */
-#ifdef CONFIG_GT64260_ETH_1	/* XXX_MIKE - broken logic? */
 	case 1:
 		if (!gt64260_eth1_initialized) {
-#ifdef CONFIG_GT64260_ETH_1_MACADDR
-			gt64260_eth_str2mac(CONFIG_GT64260_ETH_1_MACADDR,
-					    &dev->dev_addr[0]);
-#else
-			if (ppcboot_bd_valid &&
-			    *((unsigned long *) ppcboot_bd.bi_enet1addr) != 0) {
-				memcpy(dev->dev_addr, ppcboot_bd.bi_enet1addr,
-				       6);
-			} else {
-				printk("%s: Couldn't assign MAC address\n",
-				       dev->name);
-				return (-ENODEV);
-			}
-#endif
+			bcopy(gt64260_eth_config[1].eth_stat_addr,
+			      dev->dev_addr, 6);
 			private->port = 1;
 			gt_write(GT64260_ENET_E1SDCR, 0x0000203c);

@@ -652,7 +588,8 @@
 			gt_clr_bits(GT64260_ENET_E1PCR, (1 << 0));

 			gt_write(GT64260_ENET_E1PCXR,
-				 PORT_CONTROL_EXTEND_VALUE);
+			     PORT_CONTROL_EXTEND_VALUE |
+			     (gt64260_eth_config[1].is_rmii ? 0x00100000 : 0));

 			/*
 			 * Initialize address table for hash mode 0 with 1/2K size
@@ -662,24 +599,10 @@
 			return 0;
 		}
 		break;
-#endif				/* #ifdef GT64260_ETH_P1 */
-#ifdef CONFIG_GT64260_ETH_2
 	case 2:
 		if (!gt64260_eth2_initialized) {
-#ifdef CONFIG_GT64260_ETH_2_MACADDR
-			gt64260_eth_str2mac(CONFIG_GT64260_ETH_2_MACADDR,
-					    &dev->dev_addr[0]);
-#else
-			if (ppcboot_bd_valid &&
-			    *((unsigned long *) ppcboot_bd.bi_enet2addr) != 0) {
-				memcpy(dev->dev_addr, ppcboot_bd.bi_enet2addr,
-				       6);
-			} else {
-				printk("%s: Couldn't assign MAC address\n",
-				       dev->name);
-				return (-ENODEV);
-			}
-#endif
+			bcopy(gt64260_eth_config[2].eth_stat_addr,
+			      dev->dev_addr, 6);
 			private->port = 2;
 			gt_write(GT64260_ENET_E2SDCR, 0x0000203c);

@@ -689,7 +612,8 @@
 			gt_clr_bits(GT64260_ENET_E2PCR, (1 << 0));

 			gt_write(GT64260_ENET_E2PCXR,
-				 PORT_CONTROL_EXTEND_VALUE);
+			     PORT_CONTROL_EXTEND_VALUE |
+			     (gt64260_eth_config[2].is_rmii ? 0x00100000 : 0));

 			/*
 			 * Initialize address table for hash mode 0 with 1/2K size
@@ -699,7 +623,6 @@
 			return 0;
 		}
 		break;
-#endif
 	}

 	return (-ENODEV);	/* Trouble if we haven't returned by this point... */
@@ -1934,13 +1857,7 @@
 	}
 /* not busy */

-/*
-    if(portNumber == 0)
-        phyAddr = PHY_ADD0;
-    else
-        phyAddr = PHY_ADD1;
-*/
-	phyAddr = PHY_ADD0 + portNumber;
+	phyAddr = gt64260_eth_config[portNumber].phy_addr;

 	smiReg = /*smiReg | */ (phyAddr << 16) | (SMI_OP_CODE_BIT_READ << 26) |
 	    (MIIReg << 21) | SMI_OP_CODE_BIT_READ << 26;
@@ -1974,15 +1891,9 @@
 }

 struct net_device gt64260_eth_devs[] = {
-#ifdef	CONFIG_GT64260_ETH_0
-      {init:gt64260_eth_init,},
-#endif
-#ifdef	CONFIG_GT64260_ETH_1
-      {init:gt64260_eth_init,},
-#endif
-#ifdef	CONFIG_GT64260_ETH_2
-      {init:gt64260_eth_init,},
-#endif
+      {init: gt64260_eth_init, base_addr: 0},
+      {init: gt64260_eth_init, base_addr: 1},
+      {init: gt64260_eth_init, base_addr: 2},
 };

 static int __init
@@ -1990,24 +1901,12 @@
 {
 	int cards = 0;

-#ifdef	CONFIG_GT64260_ETH_0
-	gt64260_eth_devs[0].base_addr = 0;
-	if (register_netdev(&gt64260_eth_devs[0]) == 0) {
+	if ((gt64260_eth_enable & 1) && !register_netdev(&gt64260_eth_devs[0]))
 		cards++;
-	}
-#endif
-#ifdef	CONFIG_GT64260_ETH_1
-	gt64260_eth_devs[1].base_addr = 1;
-	if (register_netdev(&gt64260_eth_devs[1]) == 0) {
+	if ((gt64260_eth_enable & 2) && !register_netdev(&gt64260_eth_devs[1]))
 		cards++;
-	}
-#endif
-#ifdef	CONFIG_GT64260_ETH_2
-	gt64260_eth_devs[2].base_addr = 2;
-	if (register_netdev(&gt64260_eth_devs[2]) == 0) {
+	if ((gt64260_eth_enable & 4) && !register_netdev(&gt64260_eth_devs[2]))
 		cards++;
-	}
-#endif

 	return cards > 0 ? 0 : -ENODEV;
 }
diff -Nru a/drivers/net/gt64260_eth.h b/drivers/net/gt64260_eth.h
--- a/drivers/net/gt64260_eth.h	Thu Mar 14 21:31:15 2002
+++ b/drivers/net/gt64260_eth.h	Thu Mar 14 21:31:15 2002
@@ -5,6 +5,8 @@
  *
  * Author: Rabeeh Khoury from Marvell
  * Modified by: Mark A. Greer <mgreer@mvista.com>
+ * Modified by: Michael Sokolov <msokolov@ivan.Harhan.ORG> to configure via
+ *              bootinfo records
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -240,15 +242,6 @@
 #define SMI_BUSY                                1<<28
 #define READ_VALID                              1<<27

-#ifdef CONFIG_ZUMA_V2
-#define PHY_ADD0                                0
-#define PHY_ADD1                                1
-#else
-#define PHY_ADD0                                4
-#define PHY_ADD1                                5
-#define PHY_ADD2                                6
-#endif
-
 /* this macros are used to enable access to ETHERNET_PCXR */
 #define OVERRIDE_RX_PRIORITY                    1<<8
 #define MIB_CLEAR_MODE                          1<<16
@@ -386,14 +379,6 @@
 #ifndef _DRIVER_PACK_H
 #define _DRIVER_PACK_H

-#ifdef CONFIG_ZUMA_V2
-#undef THREE_ETHERNET_RMII_PORTS
-#define TWO_ETHERNET_MII_PORTS
-#else
-#define THREE_ETHERNET_RMII_PORTS
-#undef TWO_ETHERNET_MII_PORTS
-#endif
-
 #define ETHERNET_PORT2                      2
 #define ETHERNET_PORT1                      1
 #define ETHERNET_PORT0                      0
@@ -401,17 +386,12 @@
 #define MAX_NUMBER_OF_MPSC_PORTS                3
 #define MAX_NUMBER_OF_ETHERNET_PORTS            3

-#ifdef THREE_ETHERNET_RMII_PORTS
+#define MRR_REG_VALUE                           0x7ffe38
+
 /********/
 /* RMII */
 /********/

-#define NUMBER_OF_ETHERNET_PORTS                3
-#define NUMBER_OF_MPSC_PORTS                    2
-#define MRR_REG_VALUE                           0x7ffe38
-
-/* connect MPSC0 + 3 ports of RMII */
-#define SERIAL_PORT_MULTIPLEX_REGISTER_VALUE    0x1102
 /* GALILEO value */
 // 0000 0000 0001 0001  20 - RMII
 //                      16 - clear MIB counters
@@ -434,22 +414,12 @@
 //                      10 - disable fc AN
 //                      5:3 - 8pkt high, 1 low (100)
 //                      1 - bpdu trap
-#define PORT_CONTROL_EXTEND_VALUE               0x00304c20
+//#define PORT_CONTROL_EXTEND_VALUE		0x00304c20

-#define ETHERNET_DOWNLOADING_PORT               ETHERNET_PORT2
-
-#else
-
-#ifdef TWO_ETHERNET_MII_PORTS
 /*******/
 /* MII */
 /*******/

-#define NUMBER_OF_ETHERNET_PORTS                2
-#define NUMBER_OF_MPSC_PORTS                    2
-#define MRR_REG_VALUE                           0x7ffe38
-/* connect MPSC0 + 2 ports of MII */
-#define SERIAL_PORT_MULTIPLEX_REGISTER_VALUE    0x1101
 /* GALILEO value */
 // 0000 0000 0000 0001  16 - clear MIB counters
 // 1000 1000 0000 0000  15:14 - 2048 (10)
@@ -470,12 +440,7 @@
 //                      10 - disable fc AN
 //                      5:3 - 8pkt high, 1 low (100)
 //                      1 - bpdu trap
-#define PORT_CONTROL_EXTEND_VALUE               0x00204c20
-
-#define ETHERNET_DOWNLOADING_PORT           ETHERNET_PORT1
-
-#endif
-#endif
+#define PORT_CONTROL_EXTEND_VALUE		0x00204c20

 #define LL_QUEUE_PRIORITY                       1
 #define L_QUEUE_PRIORITY                        2
diff -Nru a/include/asm-ppc/bootinfo.h b/include/asm-ppc/bootinfo.h
--- a/include/asm-ppc/bootinfo.h	Thu Mar 14 21:31:14 2002
+++ b/include/asm-ppc/bootinfo.h	Thu Mar 14 21:31:14 2002
@@ -32,6 +32,9 @@
 #define BI_SYSMAP		0x1015
 #define BI_MACHTYPE		0x1016
 #define BI_MEMSIZE		0x1017
+/* For systems with the GT-64260 system controller */
+#define	BI_GT64260_BASE		0x1018
+#define	BI_GT64260_ETH_CFG	0x1019

 extern struct bi_record *find_bootinfo(void);
 extern void parse_bootinfo(struct bi_record *rec);
diff -Nru a/include/asm-ppc/gt64260.h b/include/asm-ppc/gt64260.h
--- a/include/asm-ppc/gt64260.h	Thu Mar 14 21:31:16 2002
+++ b/include/asm-ppc/gt64260.h	Thu Mar 14 21:31:16 2002
@@ -30,6 +30,7 @@


 extern u32     gt64260_base;
+extern u32     gt64260_phys_base;
 extern u32     gt64260_irq_base;     /* We handle the next 96 IRQs from here */
 extern u32     gt64260_revision;
 extern u8      gt64260_pci_exclude_bridge;
@@ -186,6 +187,14 @@
 	(ip)->pci_1_io_size	  = GT64260_PCI_1_IO_SIZE;		\
 	(ip)->pci_1_io_swap	  = GT64260_CPU_PCI_SWAP_NONE;		\
 }
+
+/* GT64260 Ethernet configuration passed via bootinfo records */
+extern struct gt64260_eth_config {
+	u_char eth_stat_addr[6];
+	u_char is_rmii;
+	u_char phy_addr;
+} gt64260_eth_config[3];
+extern u_long gt64260_eth_enable;

 /*
  *****************************************************************************

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
