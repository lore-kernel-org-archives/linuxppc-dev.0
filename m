Message-ID: <3CA4D234.DC3E0CFE@mvista.com>
Date: Fri, 29 Mar 2002 15:44:36 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: ev64260 bi_rec patch
Content-Type: multipart/mixed;
 boundary="------------080463F588BD26BB677394B8"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080463F588BD26BB677394B8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have other things to do so I won't be able to finish today.  In case
someone wants to work on this over the weekend, attached is a patch of
what I have so far.  It implements the example bi_rec's emailed before
for the ev64260 board.  Feel free to use it or do a better job.

Comments:
1) I added 2 new routines to arch/ppc/kernel/setup.c:
- find_bi_rec() searches that level of bi_rec's for the specified tag
(i.e., it does not scan nested ones)
- find_bi_rec_dev() searches that level for a BI_DEVICE bi_rec that has
bi_rec's nested inside it with the specified BI_DEV_TYPE and BI_DEV_ID.
It returns a ptr to the first bi_rec inside that BI_DEVICE bi_rec that
matches.  Is there a better place than setup.c for these routines?

2) Each routine takes a bi_rec as a starting point so you can use the
same routine by simply adding bi_rec->size to your bi_rec ptr that was
returned and call that routine again.

3) I didn't bother changing parse_bootinfo() to use find_bi_rec()
because there was no point.

4) I modified arch/ppc/boot/common/misc-simple.c:decompress_kernel() to
call add_extra_bi_recs().  A stub for that routine is in
arch/ppc/boot/simple/bi_rec-stub.c for all boards excepts ones with
CONFIG_GT64260 defined (in which case, the routine is in
arch/ppc/boot/simple/bi_rec-gt64260.c).  As others want to add bi_rec's
in the linuxppc bootloader, they can make their own version of that
routine.

4) I don't have hardware so none of this code has been tested.

Mark

--------------080463F588BD26BB677394B8
Content-Type: text/plain; charset=us-ascii;
 name="bi_rec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bi_rec.patch"

===== arch/ppc/boot/common/misc-simple.c 1.20 vs edited =====
--- 1.20/arch/ppc/boot/common/misc-simple.c	Tue Mar 12 00:07:28 2002
+++ edited/arch/ppc/boot/common/misc-simple.c	Thu Mar 28 16:36:35 2002
@@ -75,6 +75,7 @@
 	int timer = 0;
 	char *cp, ch;
 	struct bi_record *rec, *birecs;
+	extern struct bi_record *add_extra_bi_recs(struct bi_record *);

 	serial_fixups();
 	com_port = serial_init(0, NULL);
@@ -197,6 +198,7 @@
 	rec->tag = BI_CMD_LINE;
 	memcpy( (char *)rec->data, cmd_line, strlen(cmd_line)+1);
 	rec->size = sizeof(struct bi_record) + strlen(cmd_line) + 1;
+	rec->size = _ALIGN(rec->size, 4); /* Make multiple of 4 */
 	rec = (struct bi_record *)((unsigned long)rec + rec->size);

 	if ( initrd_size ) {
@@ -205,9 +207,12 @@
 		rec->data[1] = initrd_size;
 		rec->size = sizeof(struct bi_record) + 2 *
 			sizeof(unsigned long);
+		rec->size = _ALIGN(rec->size, 4); /* Make multiple of 4 */
 		rec = (struct bi_record *)((unsigned long)rec +
 				rec->size);
 	}
+
+	rec = add_extra_bi_recs(rec);

 	rec->tag = BI_LAST;
 	rec->size = sizeof(struct bi_record);
===== arch/ppc/boot/simple/Makefile 1.3 vs edited =====
--- 1.3/arch/ppc/boot/simple/Makefile	Thu Mar 28 18:26:50 2002
+++ edited/arch/ppc/boot/simple/Makefile	Fri Mar 29 13:29:30 2002
@@ -19,6 +19,11 @@
 # Normally, we use the 'misc-simple.c' file for decompress_kernel and
 # whatnot.  Sometimes we need to override this however.
 MISC				:= ../common/misc-simple.o
+ifeq ($(CONFIG_GT64260),y)
+MISC				+= bi_rec-gt64260.o
+else
+MISC				+= bi_rec-stub.o
+endif
 ifeq ($(CONFIG_TREEBOOT),y)
 ZIMAGE				:= zImage-TREE
 ZIMAGEINITRD			:= zImage.initrd-TREE
===== arch/ppc/boot/simple/bi_rec-gt64260.c 1.1 vs edited =====
--- 1.1/arch/ppc/boot/simple/bi_rec-gt64260.c	Fri Mar 29 15:35:44 2002
+++ edited/arch/ppc/boot/simple/bi_rec-gt64260.c	Fri Mar 29 15:35:57 2002
@@ -0,0 +1,173 @@
+/*
+ * arch/ppc/boot/simple/bi_rec-gt64260.c
+ *
+ * Author: Michael Sokolov <msokolov@ivan.Harhan.org>
+ * Modified by:	Mark A. Greer <mgreer@mvista.com>
+ *
+ * Copyright 2002 Michael Sokolov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/*
+ * Generates extra bi_recs for GT-64260 and its devices
+ * (GT-64260 base address and Ethernet info).
+ */
+
+#include <linux/types.h>
+#include <asm/bootinfo.h>
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
+	default:
+		return 0;
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
+add_extra_bi_recs(struct bi_record *rec)
+{
+	struct bi_record	*nested_rec;
+	extern ulong		gt64260_base;
+
+	/* XXXX Add in BI_MEMSIZE here */
+
+	rec->tag = BI_GT64260_BASE;
+	rec->size = sizeof(struct bi_record) + 4;
+	rec->data[0] = gt64260_base;
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	/* Nested bi_rec for embedded enet ctlr 0 */
+	nested_rec = rec;
+	rec->tag = BI_DEVICE;
+	rec = (struct bi_record *)((ulong)rec + sizeof(struct bi_record));
+
+	rec->tag = BI_DEV_TYPE;
+	rec->size = sizeof(struct bi_record) + 4;
+	rec->data[0] = BI_DEV_TYPE_GT_ETH;
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	rec->tag = BI_DEV_ID;
+	rec->size = sizeof(struct bi_record) + 4;
+	rec->data[0] = 0;
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	rec->tag = BI_MAC_ADDR;
+	rec->size = sizeof(struct bi_record) + 8; /* round up to mult of 4 */
+	eth_str2mac(CONFIG_GT64260_ETH_0_MACADDR, (unchar *)&rec->data[0]);
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	rec->tag = BI_LAST;
+	rec->size = sizeof(struct bi_record);
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	/* get size of nested bi_rec */
+	nested_rec->size = (ulong)rec - (ulong)nested_rec;
+
+	/* Nested bi_rec for embedded enet ctlr 1 */
+	nested_rec = rec;
+	rec->tag = BI_DEVICE;
+	rec = (struct bi_record *)((ulong)rec + sizeof(struct bi_record));
+
+	rec->tag = BI_DEV_TYPE;
+	rec->size = sizeof(struct bi_record) + 4;
+	rec->data[0] = BI_DEV_TYPE_GT_ETH;
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	rec->tag = BI_DEV_ID;
+	rec->size = sizeof(struct bi_record) + 4;
+	rec->data[0] = 1;
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	rec->tag = BI_MAC_ADDR;
+	rec->size = sizeof(struct bi_record) + 8; /* round up to mult of 4 */
+	eth_str2mac(CONFIG_GT64260_ETH_1_MACADDR, (unchar *)&rec->data[0]);
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	rec->tag = BI_LAST;
+	rec->size = sizeof(struct bi_record);
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	nested_rec->size = (ulong)rec - (ulong)nested_rec;
+
+	/* Nested bi_rec for embedded enet ctlr 2 */
+	nested_rec = rec;
+	rec->tag = BI_DEVICE;
+	rec = (struct bi_record *)((ulong)rec + sizeof(struct bi_record));
+
+	rec->tag = BI_DEV_TYPE;
+	rec->size = sizeof(struct bi_record) + 4;
+	rec->data[0] = BI_DEV_TYPE_GT_ETH;
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	rec->tag = BI_DEV_ID;
+	rec->size = sizeof(struct bi_record) + 4;
+	rec->data[0] = 2;
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	rec->tag = BI_MAC_ADDR;
+	rec->size = sizeof(struct bi_record) + 8; /* round up to mult of 4 */
+	eth_str2mac(CONFIG_GT64260_ETH_2_MACADDR, (unchar *)&rec->data[0]);
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	rec->tag = BI_LAST;
+	rec->size = sizeof(struct bi_record);
+	rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	nested_rec->size = (ulong)rec - (ulong)nested_rec;
+
+	return rec;
+}
===== arch/ppc/boot/simple/bi_rec-stub.c 1.1 vs edited =====
--- 1.1/arch/ppc/boot/simple/bi_rec-stub.c	Fri Mar 29 15:35:33 2002
+++ edited/arch/ppc/boot/simple/bi_rec-stub.c	Fri Mar 29 15:36:04 2002
@@ -0,0 +1,20 @@
+/*
+ * arch/ppc/boot/simple/bi_rec-stub.c
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * Copyright 2002 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/types.h>
+#include <asm/bootinfo.h>
+
+struct bi_record *
+add_extra_bi_recs(struct bi_record *rec)
+{
+	return rec;
+}
===== arch/ppc/boot/simple/misc-ev64260.S 1.5 vs edited =====
--- 1.5/arch/ppc/boot/simple/misc-ev64260.S	Fri Dec 21 03:51:01 2001
+++ edited/arch/ppc/boot/simple/misc-ev64260.S	Thu Mar 28 16:31:11 2002
@@ -60,4 +60,11 @@
         stwbrx  r26,0,(r25)
 	sync

+        addis	r25,0,EV64260_BRIDGE_REG_BASE@h
+	lis	r24,gt64260_base@h
+	ori	r24,r24,gt64260_base@l
+	stw	r25,0(r24)
+
         blr
+
+	.comm	gt64260_base,4,4
===== arch/ppc/kernel/gt64260_common.c 1.11 vs edited =====
--- 1.11/arch/ppc/kernel/gt64260_common.c	Wed Feb  6 11:54:30 2002
+++ edited/arch/ppc/kernel/gt64260_common.c	Fri Mar 29 10:09:50 2002
@@ -55,9 +55,11 @@
 #include <asm/pci-bridge.h>
 #include <asm/gt64260.h>
 #include <asm/delay.h>
+#include <asm/bootinfo.h>


 u32	gt64260_base; /* Virtual base address of 64260's regs */
+u32	gt64260_phys_base; /* Physical base address of 64260's regs */
 u32	gt64260_revision; /* Revision of the chip */
 u8	gt64260_pci_exclude_bridge = TRUE;

@@ -1666,6 +1668,26 @@

 	return total;
 } /* gt64260_get_mem_size() */
+
+/*
+ * gt64260_parse_bootinfo()
+ *
+ * Parse gt64260-specific bi_recs passed in to kernel.
+ */
+void __init
+gt64260_parse_bootinfo(struct bi_record *rec)
+{
+	if ((rec = find_bi_rec(rec, BI_GT64260_BASE)) != NULL) {
+		gt64260_phys_base = (u32)rec->data[0];
+	}
+	else {
+		printk("Missing BI_GT64260_BASE bi_rec, assuming 0x%x\n",
+			GT64260_INTERNAL_SPACE_DEFAULT_ADDR);
+		gt64260_phys_base = GT64260_INTERNAL_SPACE_DEFAULT_ADDR;
+	}
+
+	return;
+}

 #if defined(CONFIG_SERIAL_TEXT_DEBUG)
 /*
===== arch/ppc/kernel/setup.c 1.100 vs edited =====
--- 1.100/arch/ppc/kernel/setup.c	Wed Mar 20 13:07:32 2002
+++ edited/arch/ppc/kernel/setup.c	Fri Mar 29 15:37:10 2002
@@ -462,6 +462,49 @@
 	return rec;
 }

+struct bi_record *
+find_bi_rec(struct bi_record *rec, unsigned long tag)
+{
+	if ((rec == NULL) || (rec->tag == BI_LAST)) {
+		return NULL;
+	}
+
+	while ((rec->tag != BI_LAST) && (rec->tag != tag)) {
+		rec = (struct bi_record *)((ulong)rec + rec->size);
+	}
+
+	if (rec->tag != tag) {
+		rec = NULL;
+	}
+
+	return rec;
+}
+
+struct bi_record *
+find_bi_rec_dev(struct bi_record *rec, unsigned long dev_type,
+		unsigned long dev_id)
+{
+	struct bi_record	*nest_rec, *trec;
+
+	while ((rec = find_bi_rec(rec, BI_DEVICE)) != NULL) {
+		nest_rec = (struct bi_record *)((ulong)rec +
+						sizeof(struct bi_record));
+
+		if (((trec = find_bi_rec(nest_rec, BI_DEV_TYPE)) != NULL) &&
+			(trec->data[0] == dev_type) &&
+			((trec = find_bi_rec(nest_rec, BI_DEV_ID)) != NULL) &&
+			(trec->data[0] == dev_id)) {
+
+			rec = nest_rec;
+			break;
+		}
+
+		rec = (struct bi_record *)((ulong)rec + rec->size);
+	}
+
+	return rec;
+}
+
 void parse_bootinfo(struct bi_record *rec)
 {
 	if (rec == NULL || rec->tag != BI_FIRST)
===== arch/ppc/platforms/ev64260_setup.c 1.14 vs edited =====
--- 1.14/arch/ppc/platforms/ev64260_setup.c	Wed Feb 13 18:04:19 2002
+++ edited/arch/ppc/platforms/ev64260_setup.c	Thu Mar 28 17:22:35 2002
@@ -100,12 +100,11 @@
 ev64260_setup_bridge(void)
 {
 	gt64260_bridge_info_t		info;
-	int				window;

 	GT64260_BRIDGE_INFO_DEFAULT(&info, ev64260_find_end_of_memory());

 	/* Lookup PCI host bridges */
-	if (gt64260_find_bridges(EV64260_BRIDGE_REG_BASE,
+	if (gt64260_find_bridges(gt64260_phys_base,
 				 &info,
 				 ev64260_map_irq)) {
 		printk("Bridge initialization failed.\n");
@@ -322,7 +321,7 @@

 	if (mem_size == 0) {
 		/* Next 2 lines are a kludge for gt64260_get_mem_size() */
-		gt64260_base = EV64260_BRIDGE_REG_BASE;
+		gt64260_base = gt64260_phys_base;
 		ev64260_set_bat();
 		mem_size = gt64260_get_mem_size();
 	}
@@ -498,7 +497,11 @@
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo(find_bootinfo());
+	struct bi_record	*rec;
+
+	rec = find_bootinfo();
+	parse_bootinfo(rec);
+	gt64260_parse_bootinfo(rec);

 	isa_mem_base = 0;

@@ -530,7 +533,7 @@
 #ifdef	CONFIG_SERIAL_TEXT_DEBUG
 	ev64260_set_bat();
 #ifdef	CONFIG_GT64260_CONSOLE
-	gt64260_base = EV64260_BRIDGE_REG_BASE;
+	gt64260_base = gt64260_phys_base;
 	ppc_md.progress = gt64260_mpsc_progress; /* embedded UART */
 #else
 	ppc_md.progress = ev64260_16550_progress; /* Dev module DUART */
===== drivers/net/gt64260_eth.c 1.8 vs edited =====
--- 1.8/drivers/net/gt64260_eth.c	Mon Jan  7 15:48:46 2002
+++ edited/drivers/net/gt64260_eth.c	Fri Mar 29 15:29:28 2002
@@ -40,6 +40,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/ppcboot.h>
+#include <asm/bootinfo.h>

 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -490,22 +491,6 @@
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
@@ -518,7 +503,9 @@
 #ifdef  CONFIG_GT64260_ETH_0
 	static u32 gt64260_eth0_initialized = 0;
 #endif
-	priv64260 *private;
+	struct bi_record	*rec;
+	priv64260		*private;
+	extern char 		*bcopy(char *, char *, int);

 	ether_setup(dev);	/* auto assign some of the fields by kernel */
 	dev = init_etherdev(dev, sizeof (priv64260));
@@ -544,23 +531,6 @@
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
 	if (dev->base_addr == 0 || dev->base_addr == 2) {
 		/* FIXME: find who else is modifying this * (other than ev64260_pci.c)
 		 * Maybe MPSC? - NTL */
@@ -588,20 +558,17 @@
 #ifdef CONFIG_GT64260_ETH_0	/* XXX_MIKE - broken logic? */
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
+			if (((rec = find_bi_rec_dev(find_bootinfo(),
+					BI_DEV_TYPE_GT_ETH, 0)) != NULL) &&
+			    ((rec = find_bi_rec(rec, BI_MAC_ADDR)) != NULL)) {
+
+				bcopy((char *)&rec->data[0], dev->dev_addr, 6);
 			}
-#endif
+			else {
+				printk("No bi_rec for gt64260 enet 0\n");
+				return -ENODEV;
+			}
+
 			private->port = 0;
 			gt_write(GT64260_ENET_E0SDCR, (2 << 12) | (1 << 9) | (0xf << 2));	// 0000.203c

@@ -629,20 +596,17 @@
 #ifdef CONFIG_GT64260_ETH_1	/* XXX_MIKE - broken logic? */
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
+			if (((rec = find_bi_rec_dev(find_bootinfo(),
+					BI_DEV_TYPE_GT_ETH, 1)) != NULL) &&
+			    ((rec = find_bi_rec(rec, BI_MAC_ADDR)) != NULL)) {
+
+				bcopy((char *)&rec->data[0], dev->dev_addr, 6);
 			}
-#endif
+			else {
+				printk("No bi_rec for gt64260 enet 1\n");
+				return -ENODEV;
+			}
+
 			private->port = 1;
 			gt_write(GT64260_ENET_E1SDCR, 0x0000203c);

@@ -666,20 +630,17 @@
 #ifdef CONFIG_GT64260_ETH_2
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
+			if (((rec = find_bi_rec_dev(find_bootinfo(),
+					BI_DEV_TYPE_GT_ETH, 2)) != NULL) &&
+			    ((rec = find_bi_rec(rec, BI_MAC_ADDR)) != NULL)) {
+
+				bcopy((char *)&rec->data[0], dev->dev_addr, 6);
 			}
-#endif
+			else {
+				printk("No bi_rec for gt64260 enet 2\n");
+				return -ENODEV;
+			}
+
 			private->port = 2;
 			gt_write(GT64260_ENET_E2SDCR, 0x0000203c);

===== include/asm-ppc/bootinfo.h 1.13 vs edited =====
--- 1.13/include/asm-ppc/bootinfo.h	Mon Nov  5 06:26:23 2001
+++ edited/include/asm-ppc/bootinfo.h	Fri Mar 29 14:41:28 2002
@@ -33,7 +33,21 @@
 #define BI_MACHTYPE		0x1016
 #define BI_MEMSIZE		0x1017

+/* BI_DEVICE is a bi_rec that contains nested bi_recs for that device */
+#define BI_DEVICE		0x1018	/* Nest device bi_rec */
+#define BI_DEV_TYPE		0x1019	/* Type of device */
+#define BI_DEV_TYPE_TULIP	0x0001	/* Device is a Dec/Intel 21x4x */
+#define BI_DEV_TYPE_8255x	0x0002	/* Device is an Intel 8255x */
+#define BI_DEV_TYPE_GT_ETH	0x0003	/* Device is a GT64260 enet ctlr */
+#define BI_DEV_ID		0x101a	/* ID of device (device-specific) */
+#define BI_MAC_ADDR		0x101b	/* MAC addr of network device */
+
+#define	BI_GT64260_BASE		0x101c	/* Base addr of GT-64260 host bridge */
+
 extern struct bi_record *find_bootinfo(void);
+extern struct bi_record *find_bi_rec(struct bi_record *rec, unsigned long tag);
+extern struct bi_record *find_bi_rec_dev(struct bi_record *rec,
+		unsigned long dev_type, unsigned long dev_id);
 extern void parse_bootinfo(struct bi_record *rec);

 #endif /* CONFIG_APUS */
===== include/asm-ppc/gt64260.h 1.12 vs edited =====
--- 1.12/include/asm-ppc/gt64260.h	Wed Feb  6 12:45:40 2002
+++ edited/include/asm-ppc/gt64260.h	Fri Mar 29 14:41:28 2002
@@ -26,10 +26,12 @@
 #include <asm/uaccess.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
+#include <asm/bootinfo.h>
 #include <asm/gt64260_defs.h>


 extern u32     gt64260_base;
+extern u32     gt64260_phys_base;
 extern u32     gt64260_irq_base;     /* We handle the next 96 IRQs from here */
 extern u32     gt64260_revision;
 extern u8      gt64260_pci_exclude_bridge;
@@ -329,6 +331,8 @@
 int gt64260_get_base(u32 *base);
 int gt64260_pci_exclude_device(u8 bus, u8 devfn);
 ulong gt64260_get_mem_size(void);
+void gt64260_parse_bootinfo(struct bi_record *rec);
+

 void gt64260_init_irq(void);
 int gt64260_get_irq(struct pt_regs *regs);

--------------080463F588BD26BB677394B8--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
