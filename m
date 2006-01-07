Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 11:30:44 +1100
Message-Id: <1136593845.4840.161.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH] 1/5 powerpc: Rework PowerMac i2c part 1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the first part of a rework of the PowerMac i2c code. It
completely reworks the "low_i2c" layer. It is now more flexible,
supports KeyWest, SMU and PMU i2c busses, and provides functions to
match device nodes to i2c busses and adapters.

This patch also extends & fix some bugs in the SMU driver related to i2c
support and removes the clock spreading hacks from the pmac feature code
rather than adapting them to the new API since they'll be replaced by
the platform function code completely in patch 3/5

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2006-01-07 11:25:16.000000000 +1100
@@ -1677,124 +1677,6 @@ intrepid_shutdown(struct macio_chip *mac
 }
 
 
-void pmac_tweak_clock_spreading(int enable)
-{
-	struct macio_chip *macio = &macio_chips[0];
-
-	/* Hack for doing clock spreading on some machines PowerBooks and
-	 * iBooks. This implements the "platform-do-clockspreading" OF
-	 * property as decoded manually on various models. For safety, we also
-	 * check the product ID in the device-tree in cases we'll whack the i2c
-	 * chip to make reasonably sure we won't set wrong values in there
-	 *
-	 * Of course, ultimately, we have to implement a real parser for
-	 * the platform-do-* stuff...
-	 */
-
-	if (macio->type == macio_intrepid) {
-		struct device_node *clock =
-			of_find_node_by_path("/uni-n@f8000000/hw-clock");
-		if (clock && get_property(clock, "platform-do-clockspreading",
-					  NULL)) {
-			printk(KERN_INFO "%sabling clock spreading on Intrepid"
-			       " ASIC\n", enable ? "En" : "Dis");
-			if (enable)
-				UN_OUT(UNI_N_CLOCK_SPREADING, 2);
-			else
-				UN_OUT(UNI_N_CLOCK_SPREADING, 0);
-			mdelay(40);
-		}
-		of_node_put(clock);
-	}
-
-	while (machine_is_compatible("PowerBook5,2") ||
-	       machine_is_compatible("PowerBook5,3") ||
-	       machine_is_compatible("PowerBook6,2") ||
-	       machine_is_compatible("PowerBook6,3")) {
-		struct device_node *ui2c = of_find_node_by_type(NULL, "i2c");
-		struct device_node *dt = of_find_node_by_name(NULL, "device-tree");
-		u8 buffer[9];
-		u32 *productID;
-		int i, rc, changed = 0;
-
-		if (dt == NULL)
-			break;
-		productID = (u32 *)get_property(dt, "pid#", NULL);
-		if (productID == NULL)
-			break;
-		while(ui2c) {
-			struct device_node *p = of_get_parent(ui2c);
-			if (p && !strcmp(p->name, "uni-n"))
-				break;
-			ui2c = of_find_node_by_type(ui2c, "i2c");
-		}
-		if (ui2c == NULL)
-			break;
-		DBG("Trying to bump clock speed for PID: %08x...\n", *productID);
-		rc = pmac_low_i2c_open(ui2c, 1);
-		if (rc != 0)
-			break;
-		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_combined);
-		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_read, 0x80, buffer, 9);
-		DBG("read result: %d,", rc);
-		if (rc != 0) {
-			pmac_low_i2c_close(ui2c);
-			break;
-		}
-		for (i=0; i<9; i++)
-			DBG(" %02x", buffer[i]);
-		DBG("\n");
-
-		switch(*productID) {
-		case 0x1182:	/* AlBook 12" rev 2 */
-		case 0x1183:	/* iBook G4 12" */
-			buffer[0] = (buffer[0] & 0x8f) | 0x70;
-			buffer[2] = (buffer[2] & 0x7f) | 0x00;
-			buffer[5] = (buffer[5] & 0x80) | 0x31;
-			buffer[6] = (buffer[6] & 0x40) | 0xb0;
-			buffer[7] = (buffer[7] & 0x00) | (enable ? 0xc0 : 0xba);
-			buffer[8] = (buffer[8] & 0x00) | 0x30;
-			changed = 1;
-			break;
-		case 0x3142:	/* AlBook 15" (ATI M10) */
-		case 0x3143:	/* AlBook 17" (ATI M10) */
-			buffer[0] = (buffer[0] & 0xaf) | 0x50;
-			buffer[2] = (buffer[2] & 0x7f) | 0x00;
-			buffer[5] = (buffer[5] & 0x80) | 0x31;
-			buffer[6] = (buffer[6] & 0x40) | 0xb0;
-			buffer[7] = (buffer[7] & 0x00) | (enable ? 0xd0 : 0xc0);
-			buffer[8] = (buffer[8] & 0x00) | 0x30;
-			changed = 1;
-			break;
-		default:
-			DBG("i2c-hwclock: Machine model not handled\n");
-			break;
-		}
-		if (!changed) {
-			pmac_low_i2c_close(ui2c);
-			break;
-		}
-		printk(KERN_INFO "%sabling clock spreading on i2c clock chip\n",
-		       enable ? "En" : "Dis");
-
-		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_stdsub);
-		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_write, 0x80, buffer, 9);
-		DBG("write result: %d,", rc);
-		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_combined);
-		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_read, 0x80, buffer, 9);
-		DBG("read result: %d,", rc);
-		if (rc != 0) {
-			pmac_low_i2c_close(ui2c);
-			break;
-		}
-		for (i=0; i<9; i++)
-			DBG(" %02x", buffer[i]);
-		pmac_low_i2c_close(ui2c);
-		break;
-	}
-}
-
-
 static int
 core99_sleep(void)
 {
@@ -2980,12 +2862,6 @@ set_initial_features(void)
 		MACIO_BIC(HEATHROW_FCR, HRW_SOUND_POWER_N);
 	}
 
-	/* Some machine models need the clock chip to be properly setup for
-	 * clock spreading now. This should be a platform function but we
-	 * don't do these at the moment
-	 */
-	pmac_tweak_clock_spreading(1);
-
 #endif /* CONFIG_POWER4 */
 
 	/* On all machines, switch modem & serial ports off */
@@ -3013,9 +2889,6 @@ pmac_feature_init(void)
 		return;
 	}
 
-	/* Setup low-level i2c stuffs */
-	pmac_init_low_i2c();
-
 	/* Probe machine type */
 	if (probe_motherboard())
 		printk(KERN_WARNING "Unknown PowerMac !\n");
Index: linux-work/arch/powerpc/platforms/powermac/low_i2c.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/low_i2c.c	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/low_i2c.c	2006-01-07 11:25:18.000000000 +1100
@@ -1,22 +1,34 @@
 /*
- *  arch/ppc/platforms/pmac_low_i2c.c
+ * arch/powerpc/platforms/powermac/low_i2c.c
  *
- *  Copyright (C) 2003 Ben. Herrenschmidt (benh@kernel.crashing.org)
+ *  Copyright (C) 2003-2005 Ben. Herrenschmidt (benh@kernel.crashing.org)
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
  *
- *  This file contains some low-level i2c access routines that
- *  need to be used by various bits of the PowerMac platform code
- *  at times where the real asynchronous & interrupt driven driver
- *  cannot be used. The API borrows some semantics from the darwin
- *  driver in order to ease the implementation of the platform
- *  properties parser
+ * The linux i2c layer isn't completely suitable for our needs for various
+ * reasons ranging from too late initialisation to semantics not perfectly
+ * matching some requirements of the apple platform functions etc...
+ *
+ * This file thus provides a simple low level unified i2c interface for
+ * powermac that covers the various types of i2c busses used in Apple machines.
+ * For now, keywest, PMU and SMU, though we could add Cuda, or other bit
+ * banging busses found on older chipstes in earlier machines if we ever need
+ * one of them.
+ *
+ * The drivers in this file are synchronous/blocking. In addition, the
+ * keywest one is fairly slow due to the use of msleep instead of interrupts
+ * as the interrupt is currently used by i2c-keywest. In the long run, we
+ * might want to get rid of those high-level interfaces to linux i2c layer
+ * either completely (converting all drivers) or replacing them all with a
+ * single stub driver on top of this one. Once done, the interrupt will be
+ * available for our use.
  */
 
 #undef DEBUG
+#undef DEBUG_LOW
 
 #include <linux/config.h>
 #include <linux/types.h>
@@ -25,15 +37,16 @@
 #include <linux/module.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
+#include <linux/delay.h>
+#include <linux/completion.h>
 #include <asm/keylargo.h>
 #include <asm/uninorth.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
+#include <asm/smu.h>
 #include <asm/pmac_low_i2c.h>
 
-#define MAX_LOW_I2C_HOST	4
-
 #ifdef DEBUG
 #define DBG(x...) do {\
 		printk(KERN_DEBUG "low_i2c:" x);	\
@@ -42,49 +55,54 @@
 #define DBG(x...)
 #endif
 
-struct low_i2c_host;
-
-typedef int (*low_i2c_func_t)(struct low_i2c_host *host, u8 addr, u8 sub, u8 *data, int len);
-
-struct low_i2c_host
-{
-	struct device_node	*np;		/* OF device node */
-	struct semaphore	mutex;		/* Access mutex for use by i2c-keywest */
-	low_i2c_func_t		func;		/* Access function */
-	unsigned int		is_open : 1;	/* Poor man's access control */
-	int			mode;		/* Current mode */
-	int			channel;	/* Current channel */
-	int			num_channels;	/* Number of channels */
-	void __iomem		*base;		/* For keywest-i2c, base address */
-	int			bsteps;		/* And register stepping */
-	int			speed;		/* And speed */
-};
-
-static struct low_i2c_host	low_i2c_hosts[MAX_LOW_I2C_HOST];
+#ifdef DEBUG_LOW
+#define DBG_LOW(x...) do {\
+		printk(KERN_DEBUG "low_i2c:" x);	\
+	} while(0)
+#else
+#define DBG_LOW(x...)
+#endif
 
-/* No locking is necessary on allocation, we are running way before
- * anything can race with us
+/*
+ * A bus structure. Each bus in the system has such a structure associated.
  */
-static struct low_i2c_host *find_low_i2c_host(struct device_node *np)
+struct pmac_i2c_bus
 {
-	int i;
+	struct list_head	link;
+	struct device_node	*controller;
+	struct device_node	*busnode;
+	int			type;
+	int			flags;
+	struct i2c_adapter	*adapter;
+	void			*hostdata;
+	int			channel;	/* some hosts have multiple */
+	int			mode;		/* current mode */
+	struct semaphore	sem;
+	int			opened;
+	int			polled;		/* open mode */
+
+	/* ops */
+	int (*open)(struct pmac_i2c_bus *bus);
+	void (*close)(struct pmac_i2c_bus *bus);
+	int (*xfer)(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
+		    u32 subaddr, u8 *data, int len);
+};
 
-	for (i = 0; i < MAX_LOW_I2C_HOST; i++)
-		if (low_i2c_hosts[i].np == np)
-			return &low_i2c_hosts[i];
-	return NULL;
-}
+static LIST_HEAD(pmac_i2c_busses);
 
 /*
- *
- * i2c-keywest implementation (UniNorth, U2, U3, Keylargo's)
- *
+ * Keywest implementation
  */
 
-/*
- * Keywest i2c definitions borrowed from drivers/i2c/i2c-keywest.h,
- * should be moved somewhere in include/asm-ppc/
- */
+struct pmac_i2c_host_kw
+{
+	struct semaphore	mutex;		/* Access mutex for use by
+						 * i2c-keywest */
+	void __iomem		*base;		/* register base address */
+	int			bsteps;		/* register stepping */
+	int			speed;		/* speed */
+};
+
 /* Register indices */
 typedef enum {
 	reg_mode = 0,
@@ -153,52 +171,56 @@ static const char *__kw_state_names[] = 
 	"state_dead"
 };
 
-static inline u8 __kw_read_reg(struct low_i2c_host *host, reg_t reg)
+static inline u8 __kw_read_reg(struct pmac_i2c_bus *bus, reg_t reg)
 {
+	struct pmac_i2c_host_kw *host = bus->hostdata;
 	return readb(host->base + (((unsigned int)reg) << host->bsteps));
 }
 
-static inline void __kw_write_reg(struct low_i2c_host *host, reg_t reg, u8 val)
+static inline void __kw_write_reg(struct pmac_i2c_bus *bus, reg_t reg, u8 val)
 {
+	struct pmac_i2c_host_kw *host = bus->hostdata;
 	writeb(val, host->base + (((unsigned)reg) << host->bsteps));
-	(void)__kw_read_reg(host, reg_subaddr);
+	(void)__kw_read_reg(bus, reg_subaddr);
 }
 
-#define kw_write_reg(reg, val)	__kw_write_reg(host, reg, val) 
-#define kw_read_reg(reg)	__kw_read_reg(host, reg) 
+#define kw_write_reg(reg, val)	__kw_write_reg(bus, reg, val)
+#define kw_read_reg(reg)	__kw_read_reg(bus, reg)
 
-
-/* Don't schedule, the g5 fan controller is too
- * timing sensitive
- */
-static u8 kw_wait_interrupt(struct low_i2c_host* host)
+static u8 kw_i2c_wait_interrupt(struct pmac_i2c_bus* bus)
 {
 	int i, j;
 	u8 isr;
 	
-	for (i = 0; i < 100000; i++) {
+	for (i = 0; i < 1000; i++) {
 		isr = kw_read_reg(reg_isr) & KW_I2C_IRQ_MASK;
 		if (isr != 0)
 			return isr;
 
 		/* This code is used with the timebase frozen, we cannot rely
-		 * on udelay ! For now, just use a bogus loop
+		 * on udelay nor schedule when in polled mode !
+		 * For now, just use a bogus loop....
 		 */
-		for (j = 1; j < 10000; j++)
-			mb();
+		if (bus->polled) {
+			for (j = 1; j < 1000000; j++)
+				mb();
+		} else
+			msleep(1);
 	}
 	return isr;
 }
 
-static int kw_handle_interrupt(struct low_i2c_host *host, int state, int rw, int *rc, u8 **data, int *len, u8 isr)
+static int kw_i2c_handle_interrupt(struct pmac_i2c_bus *bus, int state, int rw,
+				   int *rc, u8 **data, int *len, u8 isr)
 {
 	u8 ack;
 
-	DBG("kw_handle_interrupt(%s, isr: %x)\n", __kw_state_names[state], isr);
+	DBG_LOW("kw_handle_interrupt(%s, isr: %x)\n",
+		__kw_state_names[state], isr);
 
 	if (isr == 0) {
 		if (state != state_stop) {
-			DBG("KW: Timeout !\n");
+			DBG_LOW("KW: Timeout !\n");
 			*rc = -EIO;
 			goto stop;
 		}
@@ -220,15 +242,16 @@ static int kw_handle_interrupt(struct lo
 			*rc = -EIO;
 			goto stop;
 		}
-		if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {			
+		if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
 			*rc = -ENODEV;
-			DBG("KW: NAK on address\n");
+			DBG_LOW("KW: NAK on address\n");
 			return state_stop;		     
 		} else {
 			if (rw) {
 				state = state_read;
 				if (*len > 1)
-					kw_write_reg(reg_control, KW_I2C_CTL_AAK);
+					kw_write_reg(reg_control,
+						     KW_I2C_CTL_AAK);
 			} else {
 				state = state_write;
 				kw_write_reg(reg_data, **data);
@@ -250,7 +273,7 @@ static int kw_handle_interrupt(struct lo
 		} else if (state == state_write) {
 			ack = kw_read_reg(reg_status);
 			if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
-				DBG("KW: nack on data write\n");
+				DBG_LOW("KW: nack on data write\n");
 				*rc = -EIO;
 				goto stop;
 			} else if (*len) {
@@ -291,35 +314,57 @@ static int kw_handle_interrupt(struct lo
 	return state_stop;
 }
 
-static int keywest_low_i2c_func(struct low_i2c_host *host, u8 addr, u8 subaddr, u8 *data, int len)
+static int kw_i2c_open(struct pmac_i2c_bus *bus)
+{
+	struct pmac_i2c_host_kw *host = bus->hostdata;
+	down(&host->mutex);
+	return 0;
+}
+
+static void kw_i2c_close(struct pmac_i2c_bus *bus)
 {
+	struct pmac_i2c_host_kw *host = bus->hostdata;
+	up(&host->mutex);
+}
+
+static int kw_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
+		       u32 subaddr, u8 *data, int len)
+{
+	struct pmac_i2c_host_kw *host = bus->hostdata;
 	u8 mode_reg = host->speed;
 	int state = state_addr;
 	int rc = 0;
 
 	/* Setup mode & subaddress if any */
-	switch(host->mode) {
-	case pmac_low_i2c_mode_dumb:
-		printk(KERN_ERR "low_i2c: Dumb mode not supported !\n");
+	switch(bus->mode) {
+	case pmac_i2c_mode_dumb:
 		return -EINVAL;
-	case pmac_low_i2c_mode_std:
+	case pmac_i2c_mode_std:
 		mode_reg |= KW_I2C_MODE_STANDARD;
+		if (subsize != 0)
+			return -EINVAL;
 		break;
-	case pmac_low_i2c_mode_stdsub:
+	case pmac_i2c_mode_stdsub:
 		mode_reg |= KW_I2C_MODE_STANDARDSUB;
+		if (subsize != 1)
+			return -EINVAL;
 		break;
-	case pmac_low_i2c_mode_combined:
+	case pmac_i2c_mode_combined:
 		mode_reg |= KW_I2C_MODE_COMBINED;
+		if (subsize != 1)
+			return -EINVAL;
 		break;
 	}
 
 	/* Setup channel & clear pending irqs */
 	kw_write_reg(reg_isr, kw_read_reg(reg_isr));
-	kw_write_reg(reg_mode, mode_reg | (host->channel << 4));
+	kw_write_reg(reg_mode, mode_reg | (bus->channel << 4));
 	kw_write_reg(reg_status, 0);
 
-	/* Set up address and r/w bit */
-	kw_write_reg(reg_addr, addr);
+	/* Set up address and r/w bit, strip possible stale bus number from
+	 * address top bits
+	 */
+	kw_write_reg(reg_addr, addrdir & 0xff);
 
 	/* Set up the sub address */
 	if ((mode_reg & KW_I2C_MODE_MODE_MASK) == KW_I2C_MODE_STANDARDSUB
@@ -330,27 +375,27 @@ static int keywest_low_i2c_func(struct l
 	kw_write_reg(reg_ier, 0 /*KW_I2C_IRQ_MASK*/);
 	kw_write_reg(reg_control, KW_I2C_CTL_XADDR);
 
-	/* State machine, to turn into an interrupt handler */
+	/* State machine, to turn into an interrupt handler in the future */
 	while(state != state_idle) {
-		u8 isr = kw_wait_interrupt(host);
-		state = kw_handle_interrupt(host, state, addr & 1, &rc, &data, &len, isr);
+		u8 isr = kw_i2c_wait_interrupt(bus);
+		state = kw_i2c_handle_interrupt(bus, state, addrdir & 1, &rc,
+						&data, &len, isr);
 	}
 
 	return rc;
 }
 
-static void keywest_low_i2c_add(struct device_node *np)
+static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 {
-	struct low_i2c_host	*host = find_low_i2c_host(NULL);
+	struct pmac_i2c_host_kw *host;
 	u32			*psteps, *prate, *addrp, steps;
-	struct device_node	*parent;
 
+	host = kzalloc(sizeof(struct pmac_i2c_host_kw), GFP_KERNEL);
 	if (host == NULL) {
 		printk(KERN_ERR "low_i2c: Can't allocate host for %s\n",
 		       np->full_name);
-		return;
+		return NULL;
 	}
-	memset(host, 0, sizeof(*host));
 
 	/* Apple is kind enough to provide a valid AAPL,address property
 	 * on all i2c keywest nodes so far ... we would have to fallback
@@ -360,18 +405,14 @@ static void keywest_low_i2c_add(struct d
 	if (addrp == NULL) {
 		printk(KERN_ERR "low_i2c: Can't find address for %s\n",
 		       np->full_name);
-		return;
+		kfree(host);
+		return NULL;
 	}
 	init_MUTEX(&host->mutex);
-	host->np = of_node_get(np);	
 	psteps = (u32 *)get_property(np, "AAPL,address-step", NULL);
 	steps = psteps ? (*psteps) : 0x10;
 	for (host->bsteps = 0; (steps & 0x01) == 0; host->bsteps++)
 		steps >>= 1;
-	parent = of_get_parent(np);
-	host->num_channels = 1;
-	if (parent && parent->name[0] == 'u')
-		host->num_channels = 2;
 	/* Select interface rate */
 	host->speed = KW_I2C_MODE_25KHZ;
 	prate = (u32 *)get_property(np, "AAPL,i2c-rate", NULL);
@@ -387,148 +428,620 @@ static void keywest_low_i2c_add(struct d
 		break;
 	}	
 
-	printk(KERN_INFO "low_i2c: Bus %s found at 0x%08x, %d channels,"
-	       " speed = %d KHz\n",
-	       np->full_name, *addrp, host->num_channels, prate ? *prate : 25);
-
-	host->mode = pmac_low_i2c_mode_std;
+	printk(KERN_INFO "KeyWest i2c @0x%08x %s\n", *addrp, np->full_name);
 	host->base = ioremap((*addrp), 0x1000);
-	host->func = keywest_low_i2c_func;
+
+	return host;
+}
+
+
+static void __init kw_i2c_add(struct pmac_i2c_host_kw *host,
+			      struct device_node *controller,
+			      struct device_node *busnode,
+			      int channel)
+{
+	struct pmac_i2c_bus *bus;
+
+	bus = kzalloc(sizeof(struct pmac_i2c_bus), GFP_KERNEL);
+	if (bus == NULL)
+		return;
+
+	bus->controller = of_node_get(controller);
+	bus->busnode = of_node_get(busnode);
+	bus->type = pmac_i2c_bus_keywest;
+	bus->hostdata = host;
+	bus->channel = channel;
+	bus->mode = pmac_i2c_mode_std;
+	bus->open = kw_i2c_open;
+	bus->close = kw_i2c_close;
+	bus->xfer = kw_i2c_xfer;
+	init_MUTEX(&bus->sem);
+	if (controller == busnode)
+		bus->flags = pmac_i2c_multibus;
+	list_add(&bus->link, &pmac_i2c_busses);
+
+	printk(KERN_INFO " channel %d bus %s\n", channel,
+	       (controller == busnode) ? "<multibus>" : busnode->full_name);
+}
+
+static void __init kw_i2c_probe(void)
+{
+	struct device_node *np, *child, *parent;
+
+	/* Probe keywest-i2c busses */
+	for (np = NULL;
+	     (np = of_find_compatible_node(np, "i2c","keywest-i2c")) != NULL;){
+		struct pmac_i2c_host_kw *host;
+		int multibus, chans, i;
+
+		/* Found one, init a host structure */
+		host = kw_i2c_host_init(np);
+		if (host == NULL)
+			continue;
+
+		/* Now check if we have a multibus setup (old style) or if we
+		 * have proper bus nodes. Note that the "new" way (proper bus
+		 * nodes) might cause us to not create some busses that are
+		 * kept hidden in the device-tree. In the future, we might
+		 * want to work around that by creating busses without a node
+		 * but not for now
+		 */
+		child = of_get_next_child(np, NULL);
+		multibus = !child || strcmp(child->name, "i2c-bus");
+		of_node_put(child);
+
+		/* For a multibus setup, we get the bus count based on the
+		 * parent type
+		 */
+		if (multibus) {
+			parent = of_get_parent(np);
+			if (parent == NULL)
+				continue;
+			chans = parent->name[0] == 'u' ? 2 : 1;
+			for (i = 0; i < chans; i++)
+				kw_i2c_add(host, np, np, i);
+		} else {
+			for (child = NULL;
+			     (child = of_get_next_child(np, child)) != NULL;) {
+				u32 *reg =
+					(u32 *)get_property(child, "reg", NULL);
+				if (reg == NULL)
+					continue;
+				kw_i2c_add(host, np, child, *reg);
+			}
+		}
+	}
 }
 
+
 /*
  *
  * PMU implementation
  *
  */
 
-
 #ifdef CONFIG_ADB_PMU
 
-static int pmu_low_i2c_func(struct low_i2c_host *host, u8 addr, u8 sub, u8 *data, int len)
+/*
+ * i2c command block to the PMU
+ */
+struct pmu_i2c_hdr {
+	u8	bus;
+	u8	mode;
+	u8	bus2;
+	u8	address;
+	u8	sub_addr;
+	u8	comb_addr;
+	u8	count;
+	u8	data[];
+};
+
+static void pmu_i2c_complete(struct adb_request *req)
 {
-	// TODO
-	return -ENODEV;
+	complete(req->arg);
 }
 
-static void pmu_low_i2c_add(struct device_node *np)
+static int pmu_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
+			u32 subaddr, u8 *data, int len)
 {
-	struct low_i2c_host	*host = find_low_i2c_host(NULL);
+	struct adb_request *req = bus->hostdata;
+	struct pmu_i2c_hdr *hdr = (struct pmu_i2c_hdr *)&req->data[1];
+	struct completion comp;
+	int read = addrdir & 1;
+	int retry;
+	int rc = 0;
 
-	if (host == NULL) {
-		printk(KERN_ERR "low_i2c: Can't allocate host for %s\n",
-		       np->full_name);
-		return;
+	/* For now, limit ourselves to 16 bytes transfers */
+	if (len > 16)
+		return -EINVAL;
+
+	init_completion(&comp);
+
+	for (retry = 0; retry < 16; retry++) {
+		memset(req, 0, sizeof(struct adb_request));
+		hdr->bus = bus->channel;
+		hdr->count = len;
+
+		switch(bus->mode) {
+		case pmac_i2c_mode_std:
+			if (subsize != 0)
+				return -EINVAL;
+			hdr->address = addrdir;
+			hdr->mode = PMU_I2C_MODE_SIMPLE;
+			break;
+		case pmac_i2c_mode_stdsub:
+		case pmac_i2c_mode_combined:
+			if (subsize != 1)
+				return -EINVAL;
+			hdr->address = addrdir & 0xfe;
+			hdr->comb_addr = addrdir;
+			hdr->sub_addr = subaddr;
+			if (bus->mode == pmac_i2c_mode_stdsub)
+				hdr->mode = PMU_I2C_MODE_STDSUB;
+			else
+				hdr->mode = PMU_I2C_MODE_COMBINED;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		INIT_COMPLETION(comp);
+		req->data[0] = PMU_I2C_CMD;
+		req->reply[0] = 0xff;
+		req->nbytes = sizeof(struct pmu_i2c_hdr) + 1;
+		req->done = pmu_i2c_complete;
+		req->arg = &comp;
+		if (!read) {
+			memcpy(hdr->data, data, len);
+			req->nbytes += len;
+		}
+		rc = pmu_queue_request(req);
+		if (rc)
+			return rc;
+		wait_for_completion(&comp);
+		if (req->reply[0] == PMU_I2C_STATUS_OK)
+			break;
+		msleep(15);
 	}
-	memset(host, 0, sizeof(*host));
+	if (req->reply[0] != PMU_I2C_STATUS_OK)
+		return -EIO;
 
-	init_MUTEX(&host->mutex);
-	host->np = of_node_get(np);	
-	host->num_channels = 3;
-	host->mode = pmac_low_i2c_mode_std;
-	host->func = pmu_low_i2c_func;
+	for (retry = 0; retry < 16; retry++) {
+		memset(req, 0, sizeof(struct adb_request));
+
+		/* I know that looks like a lot, slow as hell, but darwin
+		 * does it so let's be on the safe side for now
+		 */
+		msleep(15);
+
+		hdr->bus = PMU_I2C_BUS_STATUS;
+
+		INIT_COMPLETION(comp);
+		req->data[0] = PMU_I2C_CMD;
+		req->reply[0] = 0xff;
+		req->nbytes = 2;
+		req->done = pmu_i2c_complete;
+		req->arg = &comp;
+		rc = pmu_queue_request(req);
+		if (rc)
+			return rc;
+		wait_for_completion(&comp);
+
+		if (req->reply[0] == PMU_I2C_STATUS_OK && !read)
+			return 0;
+		if (req->reply[0] == PMU_I2C_STATUS_DATAREAD && read) {
+			int rlen = req->reply_len - 1;
+
+			if (rlen != len) {
+				printk(KERN_WARNING "low_i2c: PMU returned %d"
+				       " bytes, expected %d !\n", rlen, len);
+				return -EIO;
+			}
+			memcpy(data, &req->reply[1], len);
+			return 0;
+		}
+	}
+	return -EIO;
+}
+
+static void __init pmu_i2c_probe(void)
+{
+	struct pmac_i2c_bus *bus;
+	struct device_node *busnode;
+	int channel, sz;
+
+	if (!pmu_present())
+		return;
+
+	/* There might or might not be a "pmu-i2c" node, we use that
+	 * or via-pmu itself, whatever we find. I haven't seen a machine
+	 * with separate bus nodes, so we assume a multibus setup
+	 */
+	busnode = of_find_node_by_name(NULL, "pmu-i2c");
+	if (busnode == NULL)
+		busnode = of_find_node_by_name(NULL, "via-pmu");
+	if (busnode == NULL)
+		return;
+
+	printk(KERN_INFO "PMU i2c %s\n", busnode->full_name);
+
+	/*
+	 * We add bus 1 and 2 only for now, bus 0 is "special"
+	 */
+	for (channel = 1; channel <= 2; channel++) {
+		sz = sizeof(struct pmac_i2c_bus) + sizeof(struct adb_request);
+		bus = kzalloc(sz, GFP_KERNEL);
+		if (bus == NULL)
+			return;
+
+		bus->controller = busnode;
+		bus->busnode = busnode;
+		bus->type = pmac_i2c_bus_pmu;
+		bus->channel = channel;
+		bus->mode = pmac_i2c_mode_std;
+		bus->hostdata = bus + 1;
+		bus->xfer = pmu_i2c_xfer;
+		init_MUTEX(&bus->sem);
+		bus->flags = pmac_i2c_multibus;
+		list_add(&bus->link, &pmac_i2c_busses);
+
+		printk(KERN_INFO " channel %d bus <multibus>\n", channel);
+	}
 }
 
 #endif /* CONFIG_ADB_PMU */
 
-void __init pmac_init_low_i2c(void)
+
+/*
+ *
+ * SMU implementation
+ *
+ */
+
+#ifdef CONFIG_PMAC_SMU
+
+static void smu_i2c_complete(struct smu_i2c_cmd *cmd, void *misc)
 {
-	struct device_node *np;
+	complete(misc);
+}
 
-	/* Probe keywest-i2c busses */
-	np = of_find_compatible_node(NULL, "i2c", "keywest-i2c");
-	while(np) {
-		keywest_low_i2c_add(np);
-		np = of_find_compatible_node(np, "i2c", "keywest-i2c");
+static int smu_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
+			u32 subaddr, u8 *data, int len)
+{
+	struct smu_i2c_cmd *cmd = bus->hostdata;
+	struct completion comp;
+	int read = addrdir & 1;
+	int rc = 0;
+
+	memset(cmd, 0, sizeof(struct smu_i2c_cmd));
+	cmd->info.bus = bus->channel;
+	cmd->info.devaddr = addrdir;
+	cmd->info.datalen = len;
+
+	switch(bus->mode) {
+	case pmac_i2c_mode_std:
+		if (subsize != 0)
+			return -EINVAL;
+		cmd->info.type = SMU_I2C_TRANSFER_SIMPLE;
+		break;
+	case pmac_i2c_mode_stdsub:
+	case pmac_i2c_mode_combined:
+		if (subsize > 3 || subsize < 1)
+			return -EINVAL;
+		cmd->info.sublen = subsize;
+		/* that's big-endian only but heh ! */
+		memcpy(&cmd->info.subaddr, ((char *)&subaddr) + (4 - subsize),
+		       subsize);
+		if (bus->mode == pmac_i2c_mode_stdsub)
+			cmd->info.type = SMU_I2C_TRANSFER_STDSUB;
+		else
+			cmd->info.type = SMU_I2C_TRANSFER_COMBINED;
+		break;
+	default:
+		return -EINVAL;
 	}
+	if (!read)
+		memcpy(cmd->info.data, data, len);
 
-#ifdef CONFIG_ADB_PMU
-	/* Probe PMU busses */
-	np = of_find_node_by_name(NULL, "via-pmu");
-	if (np)
-		pmu_low_i2c_add(np);
-#endif /* CONFIG_ADB_PMU */
+	init_completion(&comp);
+	cmd->done = smu_i2c_complete;
+	cmd->misc = &comp;
+	rc = smu_queue_i2c(cmd);
+	if (rc < 0)
+		return rc;
+	wait_for_completion(&comp);
+	rc = cmd->status;
+
+	if (read)
+		memcpy(data, cmd->info.data, len);
+	return rc < 0 ? rc : 0;
+}
+
+static void __init smu_i2c_probe(void)
+{
+	struct device_node *controller, *busnode;
+	struct pmac_i2c_bus *bus;
+	u32 *reg;
+	int sz;
+
+	if (!smu_present())
+		return;
+
+	controller = of_find_node_by_name(NULL, "smu_i2c_control");
+	if (controller == NULL)
+		controller = of_find_node_by_name(NULL, "smu");
+	if (controller == NULL)
+		return;
+
+	printk(KERN_INFO "SMU i2c %s\n", controller->full_name);
+
+	/* Look for childs, note that they might not be of the right
+	 * type as older device trees mix i2c busses and other thigns
+	 * at the same level
+	 */
+	for (busnode = NULL;
+	     (busnode = of_get_next_child(controller, busnode)) != NULL;) {
+		if (strcmp(busnode->type, "i2c") &&
+		    strcmp(busnode->type, "i2c-bus"))
+			continue;
+		reg = (u32 *)get_property(busnode, "reg", NULL);
+		if (reg == NULL)
+			continue;
+
+		sz = sizeof(struct pmac_i2c_bus) + sizeof(struct smu_i2c_cmd);
+		bus = kzalloc(sz, GFP_KERNEL);
+		if (bus == NULL)
+			return;
+
+		bus->controller = controller;
+		bus->busnode = of_node_get(busnode);
+		bus->type = pmac_i2c_bus_smu;
+		bus->channel = *reg;
+		bus->mode = pmac_i2c_mode_std;
+		bus->hostdata = bus + 1;
+		bus->xfer = smu_i2c_xfer;
+		init_MUTEX(&bus->sem);
+		bus->flags = 0;
+		list_add(&bus->link, &pmac_i2c_busses);
+
+		printk(KERN_INFO " channel %x bus %s\n",
+		       bus->channel, busnode->full_name);
+	}
+}
+
+#endif /* CONFIG_PMAC_SMU */
+
+/*
+ *
+ * Core code
+ *
+ */
+
+
+struct pmac_i2c_bus *pmac_i2c_find_bus(struct device_node *node)
+{
+	struct device_node *p = of_node_get(node);
+	struct device_node *prev = NULL;
+	struct pmac_i2c_bus *bus;
+
+	while(p) {
+		list_for_each_entry(bus, &pmac_i2c_busses, link) {
+			if (p == bus->busnode) {
+				if (prev && bus->flags & pmac_i2c_multibus) {
+					u32 *reg;
+					reg = (u32 *)get_property(prev, "reg",
+								  NULL);
+					if (!reg)
+						continue;
+					if (((*reg) >> 8) != bus->channel)
+						continue;
+				}
+				of_node_put(p);
+				of_node_put(prev);
+				return bus;
+			}
+		}
+		of_node_put(prev);
+		prev = p;
+		p = of_get_parent(p);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_find_bus);
+
+u8 pmac_i2c_get_dev_addr(struct device_node *device)
+{
+	u32 *reg = (u32 *)get_property(device, "reg", NULL);
+
+	if (reg == NULL)
+		return 0;
+
+	return (*reg) & 0xff;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_get_dev_addr);
+
+struct device_node *pmac_i2c_get_controller(struct pmac_i2c_bus *bus)
+{
+	return bus->controller;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_get_controller);
+
+struct device_node *pmac_i2c_get_bus_node(struct pmac_i2c_bus *bus)
+{
+	return bus->busnode;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_get_bus_node);
+
+int pmac_i2c_get_type(struct pmac_i2c_bus *bus)
+{
+	return bus->type;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_get_type);
+
+int pmac_i2c_get_flags(struct pmac_i2c_bus *bus)
+{
+	return bus->flags;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_get_flags);
+
+void pmac_i2c_attach_adapter(struct pmac_i2c_bus *bus,
+			     struct i2c_adapter *adapter)
+{
+	WARN_ON(bus->adapter != NULL);
+	bus->adapter = adapter;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_attach_adapter);
+
+void pmac_i2c_detach_adapter(struct pmac_i2c_bus *bus,
+			     struct i2c_adapter *adapter)
+{
+	WARN_ON(bus->adapter != adapter);
+	bus->adapter = NULL;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_detach_adapter);
+
+struct i2c_adapter *pmac_i2c_get_adapter(struct pmac_i2c_bus *bus)
+{
+	return bus->adapter;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_get_adapter);
+
+extern int pmac_i2c_match_adapter(struct device_node *dev,
+				  struct i2c_adapter *adapter)
+{
+	struct pmac_i2c_bus *bus = pmac_i2c_find_bus(dev);
 
-	/* TODO: Add CUDA support as well */
+	if (bus == NULL)
+		return 0;
+	return (bus->adapter == adapter);
 }
+EXPORT_SYMBOL_GPL(pmac_i2c_match_adapter);
 
 int pmac_low_i2c_lock(struct device_node *np)
 {
-	struct low_i2c_host *host = find_low_i2c_host(np);
+	struct pmac_i2c_bus *bus, *found = NULL;
 
-	if (!host)
+	list_for_each_entry(bus, &pmac_i2c_busses, link) {
+		if (np == bus->controller) {
+			found = bus;
+			break;
+		}
+	}
+	if (!found)
 		return -ENODEV;
-	down(&host->mutex);
-	return 0;
+	return pmac_i2c_open(bus, 0);
 }
-EXPORT_SYMBOL(pmac_low_i2c_lock);
+EXPORT_SYMBOL_GPL(pmac_low_i2c_lock);
 
 int pmac_low_i2c_unlock(struct device_node *np)
 {
-	struct low_i2c_host *host = find_low_i2c_host(np);
+	struct pmac_i2c_bus *bus, *found = NULL;
 
-	if (!host)
+	list_for_each_entry(bus, &pmac_i2c_busses, link) {
+		if (np == bus->controller) {
+			found = bus;
+			break;
+		}
+	}
+	if (!found)
 		return -ENODEV;
-	up(&host->mutex);
+	pmac_i2c_close(bus);
 	return 0;
 }
-EXPORT_SYMBOL(pmac_low_i2c_unlock);
+EXPORT_SYMBOL_GPL(pmac_low_i2c_unlock);
 
 
-int pmac_low_i2c_open(struct device_node *np, int channel)
+int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled)
 {
-	struct low_i2c_host *host = find_low_i2c_host(np);
-
-	if (!host)
-		return -ENODEV;
-
-	if (channel >= host->num_channels)
-		return -EINVAL;
-
-	down(&host->mutex);
-	host->is_open = 1;
-	host->channel = channel;
+	int rc;
 
+	down(&bus->sem);
+	bus->polled = polled;
+	bus->opened = 1;
+	bus->mode = pmac_i2c_mode_std;
+	if (bus->open && (rc = bus->open(bus)) != 0) {
+		bus->opened = 0;
+		up(&bus->sem);
+		return rc;
+	}
 	return 0;
 }
-EXPORT_SYMBOL(pmac_low_i2c_open);
+EXPORT_SYMBOL_GPL(pmac_i2c_open);
 
-int pmac_low_i2c_close(struct device_node *np)
+void pmac_i2c_close(struct pmac_i2c_bus *bus)
 {
-	struct low_i2c_host *host = find_low_i2c_host(np);
+	WARN_ON(!bus->opened);
+	if (bus->close)
+		bus->close(bus);
+	bus->opened = 0;
+	up(&bus->sem);
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_close);
 
-	if (!host)
-		return -ENODEV;
+int pmac_i2c_setmode(struct pmac_i2c_bus *bus, int mode)
+{
+	WARN_ON(!bus->opened);
 
-	host->is_open = 0;
-	up(&host->mutex);
+	/* Report me if you see the error below as there might be a new
+	 * "combined4" mode that I need to implement for the SMU bus
+	 */
+	if (mode < pmac_i2c_mode_dumb || mode > pmac_i2c_mode_combined) {
+		printk(KERN_ERR "low_i2c: Invalid mode %d requested on"
+		       " bus %s !\n", mode, bus->busnode->full_name);
+		return -EINVAL;
+	}
+	bus->mode = mode;
 
 	return 0;
 }
-EXPORT_SYMBOL(pmac_low_i2c_close);
+EXPORT_SYMBOL_GPL(pmac_i2c_setmode);
 
-int pmac_low_i2c_setmode(struct device_node *np, int mode)
+int pmac_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
+		  u32 subaddr, u8 *data, int len)
 {
-	struct low_i2c_host *host = find_low_i2c_host(np);
+	int rc;
 
-	if (!host)
-		return -ENODEV;
-	WARN_ON(!host->is_open);
-	host->mode = mode;
+	WARN_ON(!bus->opened);
 
-	return 0;
+	DBG("xfer() chan=%d, addrdir=0x%x, mode=%d, subsize=%d, subaddr=0x%x,"
+	    " %d bytes, bus %s\n", bus->channel, addrdir, bus->mode, subsize,
+	    subaddr, len, bus->busnode->full_name);
+
+	rc = bus->xfer(bus, addrdir, subsize, subaddr, data, len);
+
+#ifdef DEBUG
+	if (rc)
+		DBG("xfer error %d\n", rc);
+#endif
+	return rc;
 }
-EXPORT_SYMBOL(pmac_low_i2c_setmode);
+EXPORT_SYMBOL_GPL(pmac_i2c_xfer);
 
-int pmac_low_i2c_xfer(struct device_node *np, u8 addrdir, u8 subaddr, u8 *data, int len)
+/*
+ * Initialize us: probe all i2c busses on the machine and instantiate
+ * busses.
+ */
+/* This is non-static as it might be called early by smp code */
+int __init pmac_i2c_init(void)
 {
-	struct low_i2c_host *host = find_low_i2c_host(np);
+	static int i2c_inited;
 
-	if (!host)
-		return -ENODEV;
-	WARN_ON(!host->is_open);
+	if (i2c_inited)
+		return 0;
+	i2c_inited = 1;
+
+	/* Probe keywest-i2c busses */
+	kw_i2c_probe();
 
-	return host->func(host, addrdir, subaddr, data, len);
+#ifdef CONFIG_ADB_PMU
+	pmu_i2c_probe();
+#endif
+
+#ifdef CONFIG_PMAC_SMU
+	smu_i2c_probe();
+#endif
+
+	return 0;
 }
-EXPORT_SYMBOL(pmac_low_i2c_xfer);
+arch_initcall(pmac_i2c_init);
 
Index: linux-work/include/asm-powerpc/pmac_low_i2c.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pmac_low_i2c.h	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/include/asm-powerpc/pmac_low_i2c.h	2006-01-07 11:25:18.000000000 +1100
@@ -15,30 +15,87 @@
 
 /* i2c mode (based on the platform functions format) */
 enum {
-	pmac_low_i2c_mode_dumb		= 1,
-	pmac_low_i2c_mode_std		= 2,
-	pmac_low_i2c_mode_stdsub	= 3,
-	pmac_low_i2c_mode_combined	= 4,
+	pmac_i2c_mode_dumb	= 1,
+	pmac_i2c_mode_std	= 2,
+	pmac_i2c_mode_stdsub	= 3,
+	pmac_i2c_mode_combined	= 4,
 };
 
 /* RW bit in address */
 enum {
-	pmac_low_i2c_read		= 0x01,
-	pmac_low_i2c_write		= 0x00
+	pmac_i2c_read		= 0x01,
+	pmac_i2c_write		= 0x00
 };
 
+/* i2c bus type */
+enum {
+	pmac_i2c_bus_keywest	= 0,
+	pmac_i2c_bus_pmu	= 1,
+	pmac_i2c_bus_smu	= 2,
+};
+
+/* i2c bus features */
+enum {
+	/* can_largesub : supports >1 byte subaddresses (SMU only) */
+	pmac_i2c_can_largesub	= 0x00000001u,
+
+	/* multibus : device node holds multiple busses, bus number is
+	 * encoded in bits 0xff00 of "reg" of a given device
+	 */
+	pmac_i2c_multibus	= 0x00000002u,
+};
+
+/* i2c busses in the system */
+struct pmac_i2c_bus;
+struct i2c_adapter;
+
 /* Init, called early during boot */
-extern void pmac_init_low_i2c(void);
+extern int pmac_i2c_init(void);
 
-/* Locking functions exposed to i2c-keywest */
-int pmac_low_i2c_lock(struct device_node *np);
-int pmac_low_i2c_unlock(struct device_node *np);
+/* Lookup an i2c bus for a device-node. The node can be either the bus
+ * node itself or a device below it. In the case of a multibus, the bus
+ * node itself is the controller node, else, it's a child of the controller
+ * node
+ */
+extern struct pmac_i2c_bus *pmac_i2c_find_bus(struct device_node *node);
+
+/* Get the address for an i2c device. This strips the bus number if
+ * necessary. The 7 bits address is returned 1 bit right shifted so that the
+ * direction can be directly ored in
+ */
+extern u8 pmac_i2c_get_dev_addr(struct device_node *device);
+
+/* Get infos about a bus */
+extern struct device_node *pmac_i2c_get_controller(struct pmac_i2c_bus *bus);
+extern struct device_node *pmac_i2c_get_bus_node(struct pmac_i2c_bus *bus);
+extern int pmac_i2c_get_type(struct pmac_i2c_bus *bus);
+extern int pmac_i2c_get_flags(struct pmac_i2c_bus *bus);
+
+/* i2c layer adapter attach/detach */
+extern void pmac_i2c_attach_adapter(struct pmac_i2c_bus *bus,
+				    struct i2c_adapter *adapter);
+extern void pmac_i2c_detach_adapter(struct pmac_i2c_bus *bus,
+				    struct i2c_adapter *adapter);
+extern struct i2c_adapter *pmac_i2c_get_adapter(struct pmac_i2c_bus *bus);
+
+/* March a device or bus with an i2c adapter structure, to be used by drivers
+ * to match device-tree nodes with i2c adapters during adapter discovery
+ * callbacks
+ */
+extern int pmac_i2c_match_adapter(struct device_node *dev,
+				  struct i2c_adapter *adapter);
+
+
+/* (legacy) Locking functions exposed to i2c-keywest */
+extern int pmac_low_i2c_lock(struct device_node *np);
+extern int pmac_low_i2c_unlock(struct device_node *np);
 
 /* Access functions for platform code */
-int pmac_low_i2c_open(struct device_node *np, int channel);
-int pmac_low_i2c_close(struct device_node *np);
-int pmac_low_i2c_setmode(struct device_node *np, int mode);
-int pmac_low_i2c_xfer(struct device_node *np, u8 addrdir, u8 subaddr, u8 *data, int len);
+extern int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled);
+extern void pmac_i2c_close(struct pmac_i2c_bus *bus);
+extern int pmac_i2c_setmode(struct pmac_i2c_bus *bus, int mode);
+extern int pmac_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
+			 u32 subaddr, u8 *data,  int len);
 
 
 #endif /* __KERNEL__ */
Index: linux-work/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/smp.c	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/smp.c	2006-01-07 11:25:16.000000000 +1100
@@ -482,7 +482,7 @@ static void __devinit smp_core99_take_ti
 /*
  * G5s enable/disable the timebase via an i2c-connected clock chip.
  */
-static struct device_node *pmac_tb_clock_chip_host;
+static struct pmac_i2c_bus *pmac_tb_clock_chip_host;
 static u8 pmac_tb_pulsar_addr;
 
 static void smp_core99_cypress_tb_freeze(int freeze)
@@ -493,20 +493,20 @@ static void smp_core99_cypress_tb_freeze
 	/* Strangely, the device-tree says address is 0xd2, but darwin
 	 * accesses 0xd0 ...
 	 */
-	pmac_low_i2c_setmode(pmac_tb_clock_chip_host,
-			     pmac_low_i2c_mode_combined);
-	rc = pmac_low_i2c_xfer(pmac_tb_clock_chip_host,
-			       0xd0 | pmac_low_i2c_read,
-			       0x81, &data, 1);
+	pmac_i2c_setmode(pmac_tb_clock_chip_host,
+			 pmac_i2c_mode_combined);
+	rc = pmac_i2c_xfer(pmac_tb_clock_chip_host,
+			   0xd0 | pmac_i2c_read,
+			   1, 0x81, &data, 1);
 	if (rc != 0)
 		goto bail;
 
 	data = (data & 0xf3) | (freeze ? 0x00 : 0x0c);
 
-       	pmac_low_i2c_setmode(pmac_tb_clock_chip_host, pmac_low_i2c_mode_stdsub);
-	rc = pmac_low_i2c_xfer(pmac_tb_clock_chip_host,
-			       0xd0 | pmac_low_i2c_write,
-			       0x81, &data, 1);
+       	pmac_i2c_setmode(pmac_tb_clock_chip_host, pmac_i2c_mode_stdsub);
+	rc = pmac_i2c_xfer(pmac_tb_clock_chip_host,
+			   0xd0 | pmac_i2c_write,
+			   1, 0x81, &data, 1);
 
  bail:
 	if (rc != 0) {
@@ -522,20 +522,20 @@ static void smp_core99_pulsar_tb_freeze(
 	u8 data;
 	int rc;
 
-	pmac_low_i2c_setmode(pmac_tb_clock_chip_host,
-			     pmac_low_i2c_mode_combined);
-	rc = pmac_low_i2c_xfer(pmac_tb_clock_chip_host,
-			       pmac_tb_pulsar_addr | pmac_low_i2c_read,
-			       0x2e, &data, 1);
+	pmac_i2c_setmode(pmac_tb_clock_chip_host,
+			 pmac_i2c_mode_combined);
+	rc = pmac_i2c_xfer(pmac_tb_clock_chip_host,
+			   pmac_tb_pulsar_addr | pmac_i2c_read,
+			   1, 0x2e, &data, 1);
 	if (rc != 0)
 		goto bail;
 
 	data = (data & 0x88) | (freeze ? 0x11 : 0x22);
 
-	pmac_low_i2c_setmode(pmac_tb_clock_chip_host, pmac_low_i2c_mode_stdsub);
-	rc = pmac_low_i2c_xfer(pmac_tb_clock_chip_host,
-			       pmac_tb_pulsar_addr | pmac_low_i2c_write,
-			       0x2e, &data, 1);
+	pmac_i2c_setmode(pmac_tb_clock_chip_host, pmac_i2c_mode_stdsub);
+	rc = pmac_i2c_xfer(pmac_tb_clock_chip_host,
+			   pmac_tb_pulsar_addr | pmac_i2c_write,
+			   1, 0x2e, &data, 1);
  bail:
 	if (rc != 0) {
 		printk(KERN_ERR "Pulsar Timebase %s rc: %d\n",
@@ -560,13 +560,15 @@ static void __init smp_core99_setup_i2c_
 		if (!ok)
 			continue;
 
+		pmac_tb_clock_chip_host = pmac_i2c_find_bus(cc);
+		if (pmac_tb_clock_chip_host == NULL)
+			continue;
 		reg = (u32 *)get_property(cc, "reg", NULL);
 		if (reg == NULL)
 			continue;
-
 		switch (*reg) {
 		case 0xd2:
-			if (device_is_compatible(cc, "pulsar-legacy-slewing")) {
+			if (device_is_compatible(cc,"pulsar-legacy-slewing")) {
 				pmac_tb_freeze = smp_core99_pulsar_tb_freeze;
 				pmac_tb_pulsar_addr = 0xd2;
 				name = "Pulsar";
@@ -585,30 +587,19 @@ static void __init smp_core99_setup_i2c_
 			break;
 	}
 	if (pmac_tb_freeze != NULL) {
-		struct device_node *p = of_get_parent(cc);
-		of_node_put(cc);
-		while(p && strcmp(p->type, "i2c")) {
-			cc = of_get_parent(p);
-			of_node_put(p);
-			p = cc;
-		}
-		if (p == NULL)
-			goto no_i2c_sync;
 		/* Open i2c bus for synchronous access */
-		if (pmac_low_i2c_open(p, 0)) {
-			printk(KERN_ERR "Failed top open i2c bus %s for clock"
-			       " sync, fallback to software sync !\n",
-			       p->full_name);
-			of_node_put(p);
+		if (pmac_i2c_open(pmac_tb_clock_chip_host, 1)) {
+			printk(KERN_ERR "Failed top open i2c bus for clock"
+			       " sync, fallback to software sync !\n");
 			goto no_i2c_sync;
 		}
-		pmac_tb_clock_chip_host = p;
 		printk(KERN_INFO "Processor timebase sync using %s i2c clock\n",
 		       name);
 		return;
 	}
  no_i2c_sync:
 	pmac_tb_freeze = NULL;
+	pmac_tb_clock_chip_host = NULL;
 }
 
 #endif /* CONFIG_PPC64 */
@@ -752,8 +743,18 @@ static int __init smp_core99_probe(void)
 	if (ncpus <= 1)
 		return 1;
 
+	/* We need to perform some early initialisations before we can start
+	 * setting up SMP as we are running before initcalls
+	 */
+	pmac_i2c_init();
+
+	/* Setup various bits like timebase sync method, ability to nap, ... */
 	smp_core99_setup(ncpus);
+
+	/* Install IPIs */
 	mpic_request_ipis();
+
+	/* Collect l2cr and l3cr values from CPU 0 */
 	core99_init_caches(0);
 
 	return ncpus;
@@ -817,7 +818,7 @@ static void __devinit smp_core99_setup_c
 
 		/* Close i2c bus if it was used for tb sync */
 		if (pmac_tb_clock_chip_host) {
-			pmac_low_i2c_close(pmac_tb_clock_chip_host);
+			pmac_i2c_close(pmac_tb_clock_chip_host);
 			pmac_tb_clock_chip_host	= NULL;
 		}
 
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/drivers/macintosh/via-pmu.c	2006-01-07 11:25:16.000000000 +1100
@@ -197,7 +197,6 @@ static int pmu_adb_reset_bus(void);
 #endif /* CONFIG_ADB */
 
 static int init_pmu(void);
-static int pmu_queue_request(struct adb_request *req);
 static void pmu_start(void);
 static irqreturn_t via_pmu_interrupt(int irq, void *arg, struct pt_regs *regs);
 static irqreturn_t gpio1_interrupt(int irq, void *arg, struct pt_regs *regs);
@@ -1802,258 +1801,6 @@ pmu_present(void)
 	return via != 0;
 }
 
-struct pmu_i2c_hdr {
-	u8	bus;
-	u8	mode;
-	u8	bus2;
-	u8	address;
-	u8	sub_addr;
-	u8	comb_addr;
-	u8	count;
-};
-
-int
-pmu_i2c_combined_read(int bus, int addr, int subaddr,  u8* data, int len)
-{
-	struct adb_request	req;
-	struct pmu_i2c_hdr	*hdr = (struct pmu_i2c_hdr *)&req.data[1];
-	int retry;
-	int rc;
-
-	for (retry=0; retry<16; retry++) {
-		memset(&req, 0, sizeof(req));
-
-		hdr->bus = bus;
-		hdr->address = addr & 0xfe;
-		hdr->mode = PMU_I2C_MODE_COMBINED;
-		hdr->bus2 = 0;
-		hdr->sub_addr = subaddr;
-		hdr->comb_addr = addr | 1;
-		hdr->count = len;
-		
-		req.nbytes = sizeof(struct pmu_i2c_hdr) + 1;
-		req.reply_expected = 0;
-		req.reply_len = 0;
-		req.data[0] = PMU_I2C_CMD;
-		req.reply[0] = 0xff;
-		rc = pmu_queue_request(&req);
-		if (rc)
-			return rc;
-		while(!req.complete)
-			pmu_poll();
-		if (req.reply[0] == PMU_I2C_STATUS_OK)
-			break;
-		mdelay(15);
-	}
-	if (req.reply[0] != PMU_I2C_STATUS_OK)
-		return -1;
-
-	for (retry=0; retry<16; retry++) {
-		memset(&req, 0, sizeof(req));
-
-		mdelay(15);
-
-		hdr->bus = PMU_I2C_BUS_STATUS;
-		req.reply[0] = 0xff;
-		
-		req.nbytes = 2;
-		req.reply_expected = 0;
-		req.reply_len = 0;
-		req.data[0] = PMU_I2C_CMD;
-		rc = pmu_queue_request(&req);
-		if (rc)
-			return rc;
-		while(!req.complete)
-			pmu_poll();
-		if (req.reply[0] == PMU_I2C_STATUS_DATAREAD) {
-			memcpy(data, &req.reply[1], req.reply_len - 1);
-			return req.reply_len - 1;
-		}
-	}
-	return -1;
-}
-
-int
-pmu_i2c_stdsub_write(int bus, int addr, int subaddr,  u8* data, int len)
-{
-	struct adb_request	req;
-	struct pmu_i2c_hdr	*hdr = (struct pmu_i2c_hdr *)&req.data[1];
-	int retry;
-	int rc;
-
-	for (retry=0; retry<16; retry++) {
-		memset(&req, 0, sizeof(req));
-
-		hdr->bus = bus;
-		hdr->address = addr & 0xfe;
-		hdr->mode = PMU_I2C_MODE_STDSUB;
-		hdr->bus2 = 0;
-		hdr->sub_addr = subaddr;
-		hdr->comb_addr = addr & 0xfe;
-		hdr->count = len;
-
-		req.data[0] = PMU_I2C_CMD;
-		memcpy(&req.data[sizeof(struct pmu_i2c_hdr) + 1], data, len);
-		req.nbytes = sizeof(struct pmu_i2c_hdr) + len + 1;
-		req.reply_expected = 0;
-		req.reply_len = 0;
-		req.reply[0] = 0xff;
-		rc = pmu_queue_request(&req);
-		if (rc)
-			return rc;
-		while(!req.complete)
-			pmu_poll();
-		if (req.reply[0] == PMU_I2C_STATUS_OK)
-			break;
-		mdelay(15);
-	}
-	if (req.reply[0] != PMU_I2C_STATUS_OK)
-		return -1;
-
-	for (retry=0; retry<16; retry++) {
-		memset(&req, 0, sizeof(req));
-
-		mdelay(15);
-
-		hdr->bus = PMU_I2C_BUS_STATUS;
-		req.reply[0] = 0xff;
-		
-		req.nbytes = 2;
-		req.reply_expected = 0;
-		req.reply_len = 0;
-		req.data[0] = PMU_I2C_CMD;
-		rc = pmu_queue_request(&req);
-		if (rc)
-			return rc;
-		while(!req.complete)
-			pmu_poll();
-		if (req.reply[0] == PMU_I2C_STATUS_OK)
-			return len;
-	}
-	return -1;
-}
-
-int
-pmu_i2c_simple_read(int bus, int addr,  u8* data, int len)
-{
-	struct adb_request	req;
-	struct pmu_i2c_hdr	*hdr = (struct pmu_i2c_hdr *)&req.data[1];
-	int retry;
-	int rc;
-
-	for (retry=0; retry<16; retry++) {
-		memset(&req, 0, sizeof(req));
-
-		hdr->bus = bus;
-		hdr->address = addr | 1;
-		hdr->mode = PMU_I2C_MODE_SIMPLE;
-		hdr->bus2 = 0;
-		hdr->sub_addr = 0;
-		hdr->comb_addr = 0;
-		hdr->count = len;
-
-		req.data[0] = PMU_I2C_CMD;
-		req.nbytes = sizeof(struct pmu_i2c_hdr) + 1;
-		req.reply_expected = 0;
-		req.reply_len = 0;
-		req.reply[0] = 0xff;
-		rc = pmu_queue_request(&req);
-		if (rc)
-			return rc;
-		while(!req.complete)
-			pmu_poll();
-		if (req.reply[0] == PMU_I2C_STATUS_OK)
-			break;
-		mdelay(15);
-	}
-	if (req.reply[0] != PMU_I2C_STATUS_OK)
-		return -1;
-
-	for (retry=0; retry<16; retry++) {
-		memset(&req, 0, sizeof(req));
-
-		mdelay(15);
-
-		hdr->bus = PMU_I2C_BUS_STATUS;
-		req.reply[0] = 0xff;
-		
-		req.nbytes = 2;
-		req.reply_expected = 0;
-		req.reply_len = 0;
-		req.data[0] = PMU_I2C_CMD;
-		rc = pmu_queue_request(&req);
-		if (rc)
-			return rc;
-		while(!req.complete)
-			pmu_poll();
-		if (req.reply[0] == PMU_I2C_STATUS_DATAREAD) {
-			memcpy(data, &req.reply[1], req.reply_len - 1);
-			return req.reply_len - 1;
-		}
-	}
-	return -1;
-}
-
-int
-pmu_i2c_simple_write(int bus, int addr,  u8* data, int len)
-{
-	struct adb_request	req;
-	struct pmu_i2c_hdr	*hdr = (struct pmu_i2c_hdr *)&req.data[1];
-	int retry;
-	int rc;
-
-	for (retry=0; retry<16; retry++) {
-		memset(&req, 0, sizeof(req));
-
-		hdr->bus = bus;
-		hdr->address = addr & 0xfe;
-		hdr->mode = PMU_I2C_MODE_SIMPLE;
-		hdr->bus2 = 0;
-		hdr->sub_addr = 0;
-		hdr->comb_addr = 0;
-		hdr->count = len;
-
-		req.data[0] = PMU_I2C_CMD;
-		memcpy(&req.data[sizeof(struct pmu_i2c_hdr) + 1], data, len);
-		req.nbytes = sizeof(struct pmu_i2c_hdr) + len + 1;
-		req.reply_expected = 0;
-		req.reply_len = 0;
-		req.reply[0] = 0xff;
-		rc = pmu_queue_request(&req);
-		if (rc)
-			return rc;
-		while(!req.complete)
-			pmu_poll();
-		if (req.reply[0] == PMU_I2C_STATUS_OK)
-			break;
-		mdelay(15);
-	}
-	if (req.reply[0] != PMU_I2C_STATUS_OK)
-		return -1;
-
-	for (retry=0; retry<16; retry++) {
-		memset(&req, 0, sizeof(req));
-
-		mdelay(15);
-
-		hdr->bus = PMU_I2C_BUS_STATUS;
-		req.reply[0] = 0xff;
-		
-		req.nbytes = 2;
-		req.reply_expected = 0;
-		req.reply_len = 0;
-		req.data[0] = PMU_I2C_CMD;
-		rc = pmu_queue_request(&req);
-		if (rc)
-			return rc;
-		while(!req.complete)
-			pmu_poll();
-		if (req.reply[0] == PMU_I2C_STATUS_OK)
-			return len;
-	}
-	return -1;
-}
-
 #ifdef CONFIG_PM
 
 static LIST_HEAD(sleep_notifiers);
@@ -2358,9 +2105,6 @@ pmac_suspend_devices(void)
 		return -EBUSY;
 	}
 
-	/* Disable clock spreading on some machines */
-	pmac_tweak_clock_spreading(0);
-
 	/* Stop preemption */
 	preempt_disable();
 
@@ -2431,9 +2175,6 @@ pmac_wakeup_devices(void)
 	mdelay(10);
 	preempt_enable();
 
-	/* Re-enable clock spreading on some machines */
-	pmac_tweak_clock_spreading(1);
-
 	/* Resume devices */
 	device_resume();
 
@@ -3150,16 +2891,13 @@ static int __init init_pmu_sysfs(void)
 subsys_initcall(init_pmu_sysfs);
 
 EXPORT_SYMBOL(pmu_request);
+EXPORT_SYMBOL(pmu_queue_request);
 EXPORT_SYMBOL(pmu_poll);
 EXPORT_SYMBOL(pmu_poll_adb);
 EXPORT_SYMBOL(pmu_wait_complete);
 EXPORT_SYMBOL(pmu_suspend);
 EXPORT_SYMBOL(pmu_resume);
 EXPORT_SYMBOL(pmu_unlock);
-EXPORT_SYMBOL(pmu_i2c_combined_read);
-EXPORT_SYMBOL(pmu_i2c_stdsub_write);
-EXPORT_SYMBOL(pmu_i2c_simple_read);
-EXPORT_SYMBOL(pmu_i2c_simple_write);
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 EXPORT_SYMBOL(pmu_enable_irled);
 EXPORT_SYMBOL(pmu_battery_count);
Index: linux-work/include/asm-powerpc/pmac_feature.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pmac_feature.h	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/include/asm-powerpc/pmac_feature.h	2006-01-07 11:25:16.000000000 +1100
@@ -318,10 +318,6 @@ extern void pmac_register_agp_pm(struct 
 extern void pmac_suspend_agp_for_card(struct pci_dev *dev);
 extern void pmac_resume_agp_for_card(struct pci_dev *dev);
 
-/* Used by the via-pmu driver for suspend/resume
- */
-extern void pmac_tweak_clock_spreading(int enable);
-
 /*
  * The part below is for use by macio_asic.c only, do not rely
  * on the data structures or constants below in a normal driver
Index: linux-work/include/linux/pmu.h
===================================================================
--- linux-work.orig/include/linux/pmu.h	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/include/linux/pmu.h	2006-01-06 19:39:47.000000000 +1100
@@ -140,7 +140,7 @@ extern int find_via_pmu(void);
 
 extern int pmu_request(struct adb_request *req,
 		void (*done)(struct adb_request *), int nbytes, ...);
-
+extern int pmu_queue_request(struct adb_request *req);
 extern void pmu_poll(void);
 extern void pmu_poll_adb(void); /* For use by xmon */
 extern void pmu_wait_complete(struct adb_request *req);
@@ -160,12 +160,6 @@ extern void pmu_unlock(void);
 extern int pmu_present(void);
 extern int pmu_get_model(void);
 
-extern int pmu_i2c_combined_read(int bus, int addr, int subaddr,  u8* data, int len);
-extern int pmu_i2c_stdsub_write(int bus, int addr, int subaddr,  u8* data, int len);
-extern int pmu_i2c_simple_read(int bus, int addr,  u8* data, int len);
-extern int pmu_i2c_simple_write(int bus, int addr,  u8* data, int len);
-
-
 #ifdef CONFIG_PM
 /*
  * Stuff for putting the powerbook to sleep and waking it again.
Index: linux-work/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/setup.c	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/setup.c	2006-01-07 11:25:18.000000000 +1100
@@ -658,27 +658,22 @@ static int __init pmac_declare_of_platfo
 {
 	struct device_node *np, *npp;
 
-	np = find_devices("uni-n");
-	if (np) {
-		for (np = np->child; np != NULL; np = np->sibling)
-			if (strncmp(np->name, "i2c", 3) == 0) {
-				of_platform_device_create(np, "uni-n-i2c",
-							  NULL);
-				break;
-			}
-	}
-	np = find_devices("valkyrie");
+	np = of_find_node_by_name(NULL, "valkyrie");
 	if (np)
 		of_platform_device_create(np, "valkyrie", NULL);
-	np = find_devices("platinum");
+	np = of_find_node_by_name(NULL, "platinum");
 	if (np)
 		of_platform_device_create(np, "platinum", NULL);
-
-	npp = of_find_node_by_name(NULL, "u3");
+	npp = of_find_node_by_name(NULL, "uni-n");
+	if (npp == NULL)
+		npp = of_find_node_by_name(NULL, "u3");
+	if (npp == NULL)
+		npp = of_find_node_by_name(NULL, "u4");
 	if (npp) {
 		for (np = NULL; (np = of_get_next_child(npp, np)) != NULL;) {
 			if (strncmp(np->name, "i2c", 3) == 0) {
-				of_platform_device_create(np, "u3-i2c", NULL);
+				of_platform_device_create(np, "uni-n-i2c",
+							  NULL);
 				of_node_put(np);
 				break;
 			}
Index: linux-work/drivers/i2c/busses/i2c-pmac-smu.c
===================================================================
--- linux-work.orig/drivers/i2c/busses/i2c-pmac-smu.c	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/drivers/i2c/busses/i2c-pmac-smu.c	2006-01-07 11:25:18.000000000 +1100
@@ -103,8 +103,8 @@ static s32 smu_smbus_xfer(	struct i2c_ad
 		cmd.info.subaddr[1] = 0;
 		cmd.info.subaddr[2] = 0;
 		if (!read) {
-			cmd.info.data[0] = data->byte & 0xff;
-			cmd.info.data[1] = (data->byte >> 8) & 0xff;
+			cmd.info.data[0] = data->word & 0xff;
+			cmd.info.data[1] = (data->word >> 8) & 0xff;
 		}
 		break;
 	/* Note that these are broken vs. the expected smbus API where
@@ -116,7 +116,7 @@ static s32 smu_smbus_xfer(	struct i2c_ad
         case I2C_SMBUS_BLOCK_DATA:
 		cmd.info.type = SMU_I2C_TRANSFER_STDSUB;
 		cmd.info.datalen = data->block[0] + 1;
-		if (cmd.info.datalen > 6)
+		if (cmd.info.datalen > (SMU_I2C_WRITE_MAX + 1))
 			return -EINVAL;
 		if (!read)
 			memcpy(cmd.info.data, data->block, cmd.info.datalen);
@@ -273,7 +273,13 @@ static int dispose_iface(struct device *
 static int create_iface_of_platform(struct of_device* dev,
 				    const struct of_device_id *match)
 {
-	return create_iface(dev->node, &dev->dev);
+	struct device_node *node = dev->node;
+
+	if (device_is_compatible(node, "smu-i2c") ||
+	    (node->parent != NULL &&
+	     device_is_compatible(node->parent, "smu-i2c-control")))
+		return create_iface(node, &dev->dev);
+	return -ENODEV;
 }
 
 
@@ -288,6 +294,9 @@ static struct of_device_id i2c_smu_match
 	{
 		.compatible	= "smu-i2c",
 	},
+	{
+		.compatible	= "i2c-bus",
+	},
 	{},
 };
 static struct of_platform_driver i2c_smu_of_platform_driver =
Index: linux-work/drivers/macintosh/smu.c
===================================================================
--- linux-work.orig/drivers/macintosh/smu.c	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/drivers/macintosh/smu.c	2006-01-07 11:25:18.000000000 +1100
@@ -94,6 +94,8 @@ struct smu_device {
 static struct smu_device	*smu;
 static DECLARE_MUTEX(smu_part_access);
 
+static void smu_i2c_retry(unsigned long data);
+
 /*
  * SMU driver low level stuff
  */
@@ -469,7 +471,6 @@ int __init smu_init (void)
 	smu->of_node = np;
 	smu->db_irq = NO_IRQ;
 	smu->msg_irq = NO_IRQ;
-	init_timer(&smu->i2c_timer);
 
 	/* smu_cmdbuf_abs is in the low 2G of RAM, can be converted to a
 	 * 32 bits value safely
@@ -544,6 +545,10 @@ static int smu_late_init(void)
 	if (!smu)
 		return 0;
 
+	init_timer(&smu->i2c_timer);
+	smu->i2c_timer.function = smu_i2c_retry;
+	smu->i2c_timer.data = (unsigned long)smu;
+
 	/*
 	 * Try to request the interrupts
 	 */
@@ -570,28 +575,41 @@ static int smu_late_init(void)
 
 	return 0;
 }
-arch_initcall(smu_late_init);
+/* This has to be before arch_initcall as the low i2c stuff relies on the
+ * above having been done before we reach arch_initcalls
+ */
+core_initcall(smu_late_init);
 
 /*
  * sysfs visibility
  */
 
+static void smu_create_i2c(struct device_node *np)
+{
+	char name[32];
+	u32 *reg = (u32 *)get_property(np, "reg", NULL);
+
+	if (reg != NULL) {
+		sprintf(name, "smu-i2c-%02x", *reg);
+		of_platform_device_create(np, name, &smu->of_dev->dev);
+	}
+}
+
 static void smu_expose_childs(void *unused)
 {
-	struct device_node *np;
+	struct device_node *np, *gp;
 
 	for (np = NULL; (np = of_get_next_child(smu->of_node, np)) != NULL;) {
-		if (device_is_compatible(np, "smu-i2c")) {
-			char name[32];
-			u32 *reg = (u32 *)get_property(np, "reg", NULL);
-
-			if (reg == NULL)
-				continue;
-			sprintf(name, "smu-i2c-%02x", *reg);
-			of_platform_device_create(np, name, &smu->of_dev->dev);
-		}
+		if (device_is_compatible(np, "smu-i2c-control")) {
+			gp = NULL;
+			while ((gp = of_get_next_child(np, gp)) != NULL)
+				if (device_is_compatible(gp, "i2c-bus"))
+					smu_create_i2c(gp);
+		} else if (device_is_compatible(np, "smu-i2c"))
+			smu_create_i2c(np);
 		if (device_is_compatible(np, "smu-sensors"))
-			of_platform_device_create(np, "smu-sensors", &smu->of_dev->dev);
+			of_platform_device_create(np, "smu-sensors",
+						  &smu->of_dev->dev);
 	}
 
 }
@@ -712,13 +730,13 @@ static void smu_i2c_complete_command(str
 
 static void smu_i2c_retry(unsigned long data)
 {
-	struct smu_i2c_cmd	*cmd = (struct smu_i2c_cmd *)data;
+	struct smu_i2c_cmd	*cmd = smu->cmd_i2c_cur;
 
 	DPRINTK("SMU: i2c failure, requeuing...\n");
 
 	/* requeue command simply by resetting reply_len */
 	cmd->pdata[0] = 0xff;
-	cmd->scmd.reply_len = 0x10;
+	cmd->scmd.reply_len = sizeof(cmd->pdata);
 	smu_queue_cmd(&cmd->scmd);
 }
 
@@ -747,10 +765,8 @@ static void smu_i2c_low_completion(struc
 	 */
 	if (fail && --cmd->retries > 0) {
 		DPRINTK("SMU: i2c failure, starting timer...\n");
-		smu->i2c_timer.function = smu_i2c_retry;
-		smu->i2c_timer.data = (unsigned long)cmd;
-		smu->i2c_timer.expires = jiffies + msecs_to_jiffies(5);
-		add_timer(&smu->i2c_timer);
+		BUG_ON(cmd != smu->cmd_i2c_cur);
+		mod_timer(&smu->i2c_timer, jiffies + msecs_to_jiffies(5));
 		return;
 	}
 
@@ -764,7 +780,7 @@ static void smu_i2c_low_completion(struc
 
 	/* Ok, initial command complete, now poll status */
 	scmd->reply_buf = cmd->pdata;
-	scmd->reply_len = 0x10;
+	scmd->reply_len = sizeof(cmd->pdata);
 	scmd->data_buf = cmd->pdata;
 	scmd->data_len = 1;
 	cmd->pdata[0] = 0;
@@ -786,7 +802,7 @@ int smu_queue_i2c(struct smu_i2c_cmd *cm
 	cmd->scmd.done = smu_i2c_low_completion;
 	cmd->scmd.misc = cmd;
 	cmd->scmd.reply_buf = cmd->pdata;
-	cmd->scmd.reply_len = 0x10;
+	cmd->scmd.reply_len = sizeof(cmd->pdata);
 	cmd->scmd.data_buf = (u8 *)(char *)&cmd->info;
 	cmd->scmd.status = 1;
 	cmd->stage = 0;
Index: linux-work/include/asm-powerpc/smu.h
===================================================================
--- linux-work.orig/include/asm-powerpc/smu.h	2006-01-06 19:39:44.000000000 +1100
+++ linux-work/include/asm-powerpc/smu.h	2006-01-07 11:25:37.000000000 +1100
@@ -358,6 +358,9 @@ extern unsigned long smu_cmdbuf_abs;
  * Kenrel asynchronous i2c interface
  */
 
+#define SMU_I2C_READ_MAX	0x1d
+#define SMU_I2C_WRITE_MAX	0x15
+
 /* SMU i2c header, exactly matches i2c header on wire */
 struct smu_i2c_param
 {
@@ -368,12 +371,9 @@ struct smu_i2c_param
 	u8	subaddr[3];	/* subaddress */
 	u8	caddr;		/* combined address, filled by SMU driver */
 	u8	datalen;	/* length of transfer */
-	u8	data[7];	/* data */
+	u8	data[SMU_I2C_READ_MAX];	/* data */
 };
 
-#define SMU_I2C_READ_MAX	0x0d
-#define SMU_I2C_WRITE_MAX	0x05
-
 struct smu_i2c_cmd
 {
 	/* public */
@@ -387,7 +387,7 @@ struct smu_i2c_cmd
 	int			read;
 	int			stage;
 	int			retries;
-	u8			pdata[0x10];
+	u8			pdata[32];
 	struct list_head	link;
 };
 
@@ -519,7 +519,7 @@ struct smu_sdbp_cpupiddata {
  * if not found. The data format is described below
  */
 extern struct smu_sdbp_header *smu_get_sdb_partition(int id,
-						     unsigned int *size);
+					unsigned int *size);
 
 #endif /* __KERNEL__ */
 
