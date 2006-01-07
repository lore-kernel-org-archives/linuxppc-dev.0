Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 11:41:02 +1100
Message-Id: <1136594462.4840.174.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH] 3/5 powerpc: Add platform functions interpreter
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the platform function interpreter itself along with the backends
for UniN/U3/U4, mac-io, GPIOs and i2c. It adds the ability to execute
those do-platform-* scripts in the device-tree (at least for most
devices for which a backend is provided). This should replace the clock
spreading hacks properly. It might also have an impact on all sort of
machines since some of the scripts marked "at init" will now be executed
on boot (or some other on sleep/wakeup), those will possibly do things
that the kernel didn't do at all, like setting some values into some i2c
devices (changing thermal sensor calibration or conversion rate) etc...
Thus regression testing is MUCH welcome. Also loook for errors in dmesg.
That's also why I've left rather verbose debugging enabled in this
version of the patch.

(I do expect some Windtunnel G4s to show some errors as they have an i2c
clock chip on the PMU bus that uses some primitives that the i2c backend
doesn't implement yet. I really need users that have one of those
machine to come back to me so we can get that done right, though the
errors themselves should be harmless, I suspect the machine might not
run at full speed).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-powerpc/pmac_pfunc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/include/asm-powerpc/pmac_pfunc.h	2006-01-07 10:54:03.000000000 +1100
@@ -0,0 +1,253 @@
+#ifndef __PMAC_PFUNC_H__
+#define __PMAC_PFUNC_H__
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+/* Flags in command lists */
+#define PMF_FLAGS_ON_INIT		0x80000000u
+#define PMF_FLGAS_ON_TERM		0x40000000u
+#define PMF_FLAGS_ON_SLEEP		0x20000000u
+#define PMF_FLAGS_ON_WAKE		0x10000000u
+#define PMF_FLAGS_ON_DEMAND		0x08000000u
+#define PMF_FLAGS_INT_GEN		0x04000000u
+#define PMF_FLAGS_HIGH_SPEED		0x02000000u
+#define PMF_FLAGS_LOW_SPEED		0x01000000u
+#define PMF_FLAGS_SIDE_EFFECTS		0x00800000u
+
+/*
+ * Arguments to a platform function call.
+ *
+ * NOTE: By convention, pointer arguments point to an u32
+ */
+struct pmf_args {
+	union {
+		u32 v;
+		u32 *p;
+	} u[4];
+	unsigned int count;
+};
+
+/*
+ * A driver capable of interpreting commands provides a handlers
+ * structure filled with whatever handlers are implemented by this
+ * driver. Non implemented handlers are left NULL.
+ *
+ * PMF_STD_ARGS are the same arguments that are passed to the parser
+ * and that gets passed back to the various handlers.
+ *
+ * Interpreting a given function always start with a begin() call which
+ * returns an instance data to be passed around subsequent calls, and
+ * ends with an end() call. This allows the low level driver to implement
+ * locking policy or per-function instance data.
+ *
+ * For interrupt capable functions, irq_enable() is called when a client
+ * registers, and irq_disable() is called when the last client unregisters
+ * Note that irq_enable & irq_disable are called within a semaphore held
+ * by the core, thus you should not try to register yourself to some other
+ * pmf interrupt during those calls.
+ */
+
+#define PMF_STD_ARGS	struct pmf_function *func, void *instdata, \
+		        struct pmf_args *args
+
+struct pmf_function;
+
+struct pmf_handlers {
+	void * (*begin)(struct pmf_function *func, struct pmf_args *args);
+	void (*end)(struct pmf_function *func, void *instdata);
+
+	int (*irq_enable)(struct pmf_function *func);
+	int (*irq_disable)(struct pmf_function *func);
+
+	int (*write_gpio)(PMF_STD_ARGS, u8 value, u8 mask);
+	int (*read_gpio)(PMF_STD_ARGS, u8 mask, int rshift, u8 xor);
+
+	int (*write_reg32)(PMF_STD_ARGS, u32 offset, u32 value, u32 mask);
+	int (*read_reg32)(PMF_STD_ARGS, u32 offset);
+	int (*write_reg16)(PMF_STD_ARGS, u32 offset, u16 value, u16 mask);
+	int (*read_reg16)(PMF_STD_ARGS, u32 offset);
+	int (*write_reg8)(PMF_STD_ARGS, u32 offset, u8 value, u8 mask);
+	int (*read_reg8)(PMF_STD_ARGS, u32 offset);
+
+	int (*delay)(PMF_STD_ARGS, u32 duration);
+
+	int (*wait_reg32)(PMF_STD_ARGS, u32 offset, u32 value, u32 mask);
+	int (*wait_reg16)(PMF_STD_ARGS, u32 offset, u16 value, u16 mask);
+	int (*wait_reg8)(PMF_STD_ARGS, u32 offset, u8 value, u8 mask);
+
+	int (*read_i2c)(PMF_STD_ARGS, u32 len);
+	int (*write_i2c)(PMF_STD_ARGS, u32 len, const u8 *data);
+	int (*rmw_i2c)(PMF_STD_ARGS, u32 masklen, u32 valuelen, u32 totallen,
+		       const u8 *maskdata, const u8 *valuedata);
+
+	int (*read_cfg)(PMF_STD_ARGS, u32 offset, u32 len);
+	int (*write_cfg)(PMF_STD_ARGS, u32 offset, u32 len, const u8 *data);
+	int (*rmw_cfg)(PMF_STD_ARGS, u32 offset, u32 masklen, u32 valuelen,
+		       u32 totallen, const u8 *maskdata, const u8 *valuedata);
+
+	int (*read_i2c_sub)(PMF_STD_ARGS, u8 subaddr, u32 len);
+	int (*write_i2c_sub)(PMF_STD_ARGS, u8 subaddr, u32 len, const u8 *data);
+	int (*set_i2c_mode)(PMF_STD_ARGS, int mode);
+	int (*rmw_i2c_sub)(PMF_STD_ARGS, u8 subaddr, u32 masklen, u32 valuelen,
+			   u32 totallen, const u8 *maskdata,
+			   const u8 *valuedata);
+
+	int (*read_reg32_msrx)(PMF_STD_ARGS, u32 offset, u32 mask, u32 shift,
+			       u32 xor);
+	int (*read_reg16_msrx)(PMF_STD_ARGS, u32 offset, u32 mask, u32 shift,
+			       u32 xor);
+	int (*read_reg8_msrx)(PMF_STD_ARGS, u32 offset, u32 mask, u32 shift,
+			      u32 xor);
+
+	int (*write_reg32_slm)(PMF_STD_ARGS, u32 offset, u32 shift, u32 mask);
+	int (*write_reg16_slm)(PMF_STD_ARGS, u32 offset, u32 shift, u32 mask);
+	int (*write_reg8_slm)(PMF_STD_ARGS, u32 offset, u32 shift, u32 mask);
+
+	int (*mask_and_compare)(PMF_STD_ARGS, u32 len, const u8 *maskdata,
+				const u8 *valuedata);
+
+	struct module *owner;
+};
+
+
+/*
+ * Drivers who expose platform functions register at init time, this
+ * causes the platform functions for that device node to be parsed in
+ * advance and associated with the device. The data structures are
+ * partially public so a driver can walk the list of platform functions
+ * and eventually inspect the flags
+ */
+struct pmf_device;
+
+struct pmf_function {
+	/* All functions for a given driver are linked */
+	struct list_head	link;
+
+	/* Function node & driver data */
+	struct device_node	*node;
+	void			*driver_data;
+
+	/* For internal use by core */
+	struct pmf_device	*dev;
+
+	/* The name is the "xxx" in "platform-do-xxx", this is how
+	 * platform functions are identified by this code. Some functions
+	 * only operate for a given target, in which case the phandle is
+	 * here (or 0 if the filter doesn't apply)
+	 */
+	const char		*name;
+	u32			phandle;
+
+	/* The flags for that function. You can have several functions
+	 * with the same name and different flag
+	 */
+	u32			flags;
+
+	/* The actual tokenized function blob */
+	const void		*data;
+	unsigned int		length;
+
+	/* Interrupt clients */
+	struct list_head	irq_clients;
+
+	/* Refcounting */
+	struct kref		ref;
+};
+
+/*
+ * For platform functions that are interrupts, one can register
+ * irq_client structures. You canNOT use the same structure twice
+ * as it contains a link member. Also, the callback is called with
+ * a spinlock held, you must not call back into any of the pmf_* functions
+ * from within that callback
+ */
+struct pmf_irq_client {
+	void			(*handler)(void *data);
+	void			*data;
+	struct module		*owner;
+	struct list_head	link;
+};
+
+
+/*
+ * Register/Unregister a function-capable driver and its handlers
+ */
+extern int pmf_register_driver(struct device_node *np,
+			      struct pmf_handlers *handlers,
+			      void *driverdata);
+
+extern void pmf_unregister_driver(struct device_node *np);
+
+
+/*
+ * Register/Unregister interrupt clients
+ */
+extern int pmf_register_irq_client(struct device_node *np,
+				   const char *name,
+				   struct pmf_irq_client *client);
+
+extern void pmf_unregister_irq_client(struct device_node *np,
+				      const char *name,
+				      struct pmf_irq_client *client);
+
+/*
+ * Called by the handlers when an irq happens
+ */
+extern void pmf_do_irq(struct pmf_function *func);
+
+
+/*
+ * Low level call to platform functions.
+ *
+ * The phandle can filter on the target object for functions that have
+ * multiple targets, the flags allow you to restrict the call to a given
+ * combination of flags.
+ *
+ * The args array contains as many arguments as is required by the function,
+ * this is dependent on the function you are calling, unfortunately Apple
+ * mecanism provides no way to encode that so you have to get it right at
+ * the call site. Some functions require no args, in which case, you can
+ * pass NULL.
+ *
+ * You can also pass NULL to the name. This will match any function that has
+ * the appropriate combination of flags & phandle or you can pass 0 to the
+ * phandle to match any
+ */
+extern int pmf_do_functions(struct device_node *np, const char *name,
+			    u32 phandle, u32 flags, struct pmf_args *args);
+
+
+
+/*
+ * High level call to a platform function.
+ *
+ * This one looks for the platform-xxx first so you should call it to the
+ * actual target if any. It will fallback to platform-do-xxx if it can't
+ * find one. It will also exclusively target functions that have
+ * the "OnDemand" flag.
+ */
+
+extern int pmf_call_function(struct device_node *target, const char *name,
+			     struct pmf_args *args);
+
+
+/*
+ * For low latency interrupt usage, you can lookup for on-demand functions
+ * using the functions below
+ */
+
+extern struct pmf_function *pmf_find_function(struct device_node *target,
+					      const char *name);
+
+extern struct pmf_function * pmf_get_function(struct pmf_function *func);
+extern void pmf_put_function(struct pmf_function *func);
+
+extern int pmf_call_one(struct pmf_function *func, struct pmf_args *args);
+
+
+/* Suspend/resume code called by via-pmu directly for now */
+extern void pmac_pfunc_base_suspend(void);
+extern void pmac_pfunc_base_resume(void);
+
+#endif /* __PMAC_PFUNC_H__ */
Index: linux-work/arch/powerpc/platforms/powermac/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/Makefile	2006-01-07 10:53:21.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/Makefile	2006-01-07 10:54:03.000000000 +1100
@@ -1,7 +1,8 @@
 CFLAGS_bootx_init.o  		+= -fPIC
 
 obj-y				+= pic.o setup.o time.o feature.o pci.o \
-				   sleep.o low_i2c.o cache.o
+				   sleep.o low_i2c.o cache.o pfunc_core.o \
+				   pfunc_base.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= backlight.o
 obj-$(CONFIG_CPU_FREQ_PMAC)	+= cpufreq_32.o
 obj-$(CONFIG_CPU_FREQ_PMAC64)	+= cpufreq_64.o
Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2006-01-07 10:53:21.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2006-01-07 10:54:03.000000000 +1100
@@ -58,12 +58,11 @@ extern int powersave_lowspeed;
 extern int powersave_nap;
 extern struct device_node *k2_skiplist[2];
 
-
 /*
  * We use a single global lock to protect accesses. Each driver has
  * to take care of its own locking
  */
-static DEFINE_SPINLOCK(feature_lock);
+DEFINE_SPINLOCK(feature_lock);
 
 #define LOCK(flags)	spin_lock_irqsave(&feature_lock, flags);
 #define UNLOCK(flags)	spin_unlock_irqrestore(&feature_lock, flags);
@@ -106,22 +105,12 @@ static const char *macio_names[] =
 };
 
 
+struct device_node *uninorth_node;
+u32 __iomem *uninorth_base;
 
-/*
- * Uninorth reg. access. Note that Uni-N regs are big endian
- */
-
-#define UN_REG(r)	(uninorth_base + ((r) >> 2))
-#define UN_IN(r)	(in_be32(UN_REG(r)))
-#define UN_OUT(r,v)	(out_be32(UN_REG(r), (v)))
-#define UN_BIS(r,v)	(UN_OUT((r), UN_IN(r) | (v)))
-#define UN_BIC(r,v)	(UN_OUT((r), UN_IN(r) & ~(v)))
-
-static struct device_node *uninorth_node;
-static u32 __iomem *uninorth_base;
 static u32 uninorth_rev;
 static int uninorth_maj;
-static void __iomem *u3_ht;
+static void __iomem *u3_ht_base;
 
 /*
  * For each motherboard family, we have a table of functions pointers
@@ -1560,8 +1549,10 @@ void g5_phy_disable_cpu1(void)
 
 #ifndef CONFIG_POWER4
 
-static void
-keylargo_shutdown(struct macio_chip *macio, int sleep_mode)
+
+#ifdef CONFIG_PM
+
+static void keylargo_shutdown(struct macio_chip *macio, int sleep_mode)
 {
 	u32 temp;
 
@@ -1614,8 +1605,7 @@ keylargo_shutdown(struct macio_chip *mac
 	(void)MACIO_IN32(KEYLARGO_FCR0); mdelay(1);
 }
 
-static void
-pangea_shutdown(struct macio_chip *macio, int sleep_mode)
+static void pangea_shutdown(struct macio_chip *macio, int sleep_mode)
 {
 	u32 temp;
 
@@ -1648,8 +1638,7 @@ pangea_shutdown(struct macio_chip *macio
 	(void)MACIO_IN32(KEYLARGO_FCR0); mdelay(1);
 }
 
-static void
-intrepid_shutdown(struct macio_chip *macio, int sleep_mode)
+static void intrepid_shutdown(struct macio_chip *macio, int sleep_mode)
 {
 	u32 temp;
 
@@ -1833,6 +1822,8 @@ core99_wake_up(void)
 	return 0;
 }
 
+#endif /* CONFIG_PM */
+
 static long
 core99_sleep_state(struct device_node *node, long param, long value)
 {
@@ -1854,10 +1845,13 @@ core99_sleep_state(struct device_node *n
 	if ((pmac_mb.board_flags & PMAC_MB_CAN_SLEEP) == 0)
 		return -EPERM;
 
+#ifdef CONFIG_PM
 	if (value == 1)
 		return core99_sleep();
 	else if (value == 0)
 		return core99_wake_up();
+
+#endif /* CONFIG_PM */
 	return 0;
 }
 
@@ -1981,7 +1975,9 @@ static struct feature_table_entry core99
 	{ PMAC_FTR_USB_ENABLE,		core99_usb_enable },
 	{ PMAC_FTR_1394_ENABLE,		core99_firewire_enable },
 	{ PMAC_FTR_1394_CABLE_POWER,	core99_firewire_cable_power },
+#ifdef CONFIG_PM
 	{ PMAC_FTR_SLEEP_STATE,		core99_sleep_state },
+#endif
 #ifdef CONFIG_SMP
 	{ PMAC_FTR_RESET_CPU,		core99_reset_cpu },
 #endif /* CONFIG_SMP */
@@ -2572,7 +2568,7 @@ static void __init probe_uninorth(void)
 	uninorth_base = ioremap(address, 0x40000);
 	uninorth_rev = in_be32(UN_REG(UNI_N_VERSION));
 	if (uninorth_maj == 3 || uninorth_maj == 4)
-		u3_ht = ioremap(address + U3_HT_CONFIG_BASE, 0x1000);
+		u3_ht_base = ioremap(address + U3_HT_CONFIG_BASE, 0x1000);
 
 	printk(KERN_INFO "Found %s memory controller & host bridge"
 	       " @ 0x%08x revision: 0x%02x\n", uninorth_maj == 3 ? "U3" :
@@ -2921,9 +2917,9 @@ void __init pmac_check_ht_link(void)
 	u8	px_bus, px_devfn;
 	struct pci_controller *px_hose;
 
-	(void)in_be32(u3_ht + U3_HT_LINK_COMMAND);
-	ucfg = cfg = in_be32(u3_ht + U3_HT_LINK_CONFIG);
-	ufreq = freq = in_be32(u3_ht + U3_HT_LINK_FREQ);
+	(void)in_be32(u3_ht_base + U3_HT_LINK_COMMAND);
+	ucfg = cfg = in_be32(u3_ht_base + U3_HT_LINK_CONFIG);
+	ufreq = freq = in_be32(u3_ht_base + U3_HT_LINK_FREQ);
 	dump_HT_speeds("U3 HyperTransport", cfg, freq);
 
 	pcix_node = of_find_compatible_node(NULL, "pci", "pci-x");
Index: linux-work/arch/powerpc/platforms/powermac/pfunc_base.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/platforms/powermac/pfunc_base.c	2006-01-07 10:54:03.000000000 +1100
@@ -0,0 +1,405 @@
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+#include <asm/pmac_feature.h>
+#include <asm/pmac_pfunc.h>
+
+#define DBG(fmt...)	printk(fmt)
+
+static irqreturn_t macio_gpio_irq(int irq, void *data, struct pt_regs *regs)
+{
+	pmf_do_irq(data);
+
+	return IRQ_HANDLED;
+}
+
+static int macio_do_gpio_irq_enable(struct pmf_function *func)
+{
+	if (func->node->n_intrs < 1)
+		return -EINVAL;
+
+	return request_irq(func->node->intrs[0].line, macio_gpio_irq, 0,
+			   func->node->name, func);
+}
+
+static int macio_do_gpio_irq_disable(struct pmf_function *func)
+{
+	if (func->node->n_intrs < 1)
+		return -EINVAL;
+
+	free_irq(func->node->intrs[0].line, func);
+	return 0;
+}
+
+static int macio_do_gpio_write(PMF_STD_ARGS, u8 value, u8 mask)
+{
+	u8 __iomem *addr = (u8 __iomem *)func->driver_data;
+	unsigned long flags;
+	u8 tmp;
+
+	/* Check polarity */
+	if (args && args->count && !args->u[0].v)
+		value = ~value;
+
+	/* Toggle the GPIO */
+	spin_lock_irqsave(&feature_lock, flags);
+	tmp = readb(addr);
+	tmp = (tmp & ~mask) | (value & mask);
+	DBG("Do write 0x%02x to GPIO %s (%p)\n",
+	    tmp, func->node->full_name, addr);
+	writeb(tmp, addr);
+	spin_unlock_irqrestore(&feature_lock, flags);
+
+	return 0;
+}
+
+static int macio_do_gpio_read(PMF_STD_ARGS, u8 mask, int rshift, u8 xor)
+{
+	u8 __iomem *addr = (u8 __iomem *)func->driver_data;
+	u32 value;
+
+	/* Check if we have room for reply */
+	if (args == NULL || args->count == 0 || args->u[0].p == NULL)
+		return -EINVAL;
+
+	value = readb(addr);
+	*args->u[0].p = ((value & mask) >> rshift) ^ xor;
+
+	return 0;
+}
+
+static int macio_do_delay(PMF_STD_ARGS, u32 duration)
+{
+	/* assume we can sleep ! */
+	msleep((duration + 999) / 1000);
+	return 0;
+}
+
+static struct pmf_handlers macio_gpio_handlers = {
+	.irq_enable	= macio_do_gpio_irq_enable,
+	.irq_disable	= macio_do_gpio_irq_disable,
+	.write_gpio	= macio_do_gpio_write,
+	.read_gpio	= macio_do_gpio_read,
+	.delay		= macio_do_delay,
+};
+
+static void macio_gpio_init_one(struct macio_chip *macio)
+{
+	struct device_node *gparent, *gp;
+
+	/*
+	 * Find the "gpio" parent node
+	 */
+
+	for (gparent = NULL;
+	     (gparent = of_get_next_child(macio->of_node, gparent)) != NULL;)
+		if (strcmp(gparent->name, "gpio") == 0)
+			break;
+	if (gparent == NULL)
+		return;
+
+	DBG("Installing GPIO functions for macio %s\n",
+	    macio->of_node->full_name);
+
+	/*
+	 * Ok, got one, we dont need anything special to track them down, so
+	 * we just create them all
+	 */
+	for (gp = NULL; (gp = of_get_next_child(gparent, gp)) != NULL;) {
+		u32 *reg = (u32 *)get_property(gp, "reg", NULL);
+		unsigned long offset;
+		if (reg == NULL)
+			continue;
+		offset = *reg;
+		/* Deal with old style device-tree. We can safely hard code the
+		 * offset for now too even if it's a bit gross ...
+		 */
+		if (offset < 0x50)
+			offset += 0x50;
+		offset += (unsigned long)macio->base;
+		pmf_register_driver(gp, &macio_gpio_handlers, (void *)offset);
+	}
+
+	DBG("Calling initial GPIO functions for macio %s\n",
+	    macio->of_node->full_name);
+
+	/* And now we run all the init ones */
+	for (gp = NULL; (gp = of_get_next_child(gparent, gp)) != NULL;)
+		pmf_do_functions(gp, NULL, 0, PMF_FLAGS_ON_INIT, NULL);
+
+	/* Note: We do not at this point implement the "at sleep" or "at wake"
+	 * functions. I yet to find any for GPIOs anyway
+	 */
+}
+
+static int macio_do_write_reg32(PMF_STD_ARGS, u32 offset, u32 value, u32 mask)
+{
+	struct macio_chip *macio = func->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&feature_lock, flags);
+	MACIO_OUT32(offset, (MACIO_IN32(offset) & ~mask) | (value & mask));
+	spin_unlock_irqrestore(&feature_lock, flags);
+	return 0;
+}
+
+static int macio_do_read_reg32(PMF_STD_ARGS, u32 offset)
+{
+	struct macio_chip *macio = func->driver_data;
+
+	/* Check if we have room for reply */
+	if (args == NULL || args->count == 0 || args->u[0].p == NULL)
+		return -EINVAL;
+
+	*args->u[0].p = MACIO_IN32(offset);
+	return 0;
+}
+
+static int macio_do_write_reg8(PMF_STD_ARGS, u32 offset, u8 value, u8 mask)
+{
+	struct macio_chip *macio = func->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&feature_lock, flags);
+	MACIO_OUT8(offset, (MACIO_IN8(offset) & ~mask) | (value & mask));
+	spin_unlock_irqrestore(&feature_lock, flags);
+	return 0;
+}
+
+static int macio_do_read_reg8(PMF_STD_ARGS, u32 offset)
+{
+	struct macio_chip *macio = func->driver_data;
+
+	/* Check if we have room for reply */
+	if (args == NULL || args->count == 0 || args->u[0].p == NULL)
+		return -EINVAL;
+
+	*((u8 *)(args->u[0].p)) = MACIO_IN8(offset);
+	return 0;
+}
+
+static int macio_do_read_reg32_msrx(PMF_STD_ARGS, u32 offset, u32 mask,
+				    u32 shift, u32 xor)
+{
+	struct macio_chip *macio = func->driver_data;
+
+	/* Check if we have room for reply */
+	if (args == NULL || args->count == 0 || args->u[0].p == NULL)
+		return -EINVAL;
+
+	*args->u[0].p = ((MACIO_IN32(offset) & mask) >> shift) ^ xor;
+	return 0;
+}
+
+static int macio_do_read_reg8_msrx(PMF_STD_ARGS, u32 offset, u32 mask,
+				   u32 shift, u32 xor)
+{
+	struct macio_chip *macio = func->driver_data;
+
+	/* Check if we have room for reply */
+	if (args == NULL || args->count == 0 || args->u[0].p == NULL)
+		return -EINVAL;
+
+	*((u8 *)(args->u[0].p)) = ((MACIO_IN8(offset) & mask) >> shift) ^ xor;
+	return 0;
+}
+
+static int macio_do_write_reg32_slm(PMF_STD_ARGS, u32 offset, u32 shift,
+				    u32 mask)
+{
+	struct macio_chip *macio = func->driver_data;
+	unsigned long flags;
+	u32 tmp, val;
+
+	/* Check args */
+	if (args == NULL || args->count == 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&feature_lock, flags);
+	tmp = MACIO_IN32(offset);
+	val = args->u[0].v << shift;
+	tmp = (tmp & ~mask) | (val & mask);
+	MACIO_OUT32(offset, tmp);
+	spin_unlock_irqrestore(&feature_lock, flags);
+	return 0;
+}
+
+static int macio_do_write_reg8_slm(PMF_STD_ARGS, u32 offset, u32 shift,
+				   u32 mask)
+{
+	struct macio_chip *macio = func->driver_data;
+	unsigned long flags;
+	u32 tmp, val;
+
+	/* Check args */
+	if (args == NULL || args->count == 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&feature_lock, flags);
+	tmp = MACIO_IN8(offset);
+	val = args->u[0].v << shift;
+	tmp = (tmp & ~mask) | (val & mask);
+	MACIO_OUT8(offset, tmp);
+	spin_unlock_irqrestore(&feature_lock, flags);
+	return 0;
+}
+
+static struct pmf_handlers macio_mmio_handlers = {
+	.write_reg32		= macio_do_write_reg32,
+	.read_reg32		= macio_do_read_reg32,
+	.write_reg8		= macio_do_write_reg8,
+	.read_reg32		= macio_do_read_reg8,
+	.read_reg32_msrx	= macio_do_read_reg32_msrx,
+	.read_reg8_msrx		= macio_do_read_reg8_msrx,
+	.write_reg32_slm	= macio_do_write_reg32_slm,
+	.write_reg8_slm		= macio_do_write_reg8_slm,
+	.delay			= macio_do_delay,
+};
+
+static void macio_mmio_init_one(struct macio_chip *macio)
+{
+	DBG("Installing MMIO functions for macio %s\n",
+	    macio->of_node->full_name);
+
+	pmf_register_driver(macio->of_node, &macio_mmio_handlers, macio);
+}
+
+static struct device_node *unin_hwclock;
+
+static int unin_do_write_reg32(PMF_STD_ARGS, u32 offset, u32 value, u32 mask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&feature_lock, flags);
+	/* This is fairly bogus in darwin, but it should work for our needs
+	 * implemeted that way:
+	 */
+	UN_OUT(offset, (UN_IN(offset) & ~mask) | (value & mask));
+	spin_unlock_irqrestore(&feature_lock, flags);
+	return 0;
+}
+
+
+static struct pmf_handlers unin_mmio_handlers = {
+	.write_reg32		= unin_do_write_reg32,
+	.delay			= macio_do_delay,
+};
+
+static void uninorth_install_pfunc(void)
+{
+	struct device_node *np;
+
+	DBG("Installing functions for UniN %s\n",
+	    uninorth_node->full_name);
+
+	/*
+	 * Install handlers for the bridge itself
+	 */
+	pmf_register_driver(uninorth_node, &unin_mmio_handlers, NULL);
+	pmf_do_functions(uninorth_node, NULL, 0, PMF_FLAGS_ON_INIT, NULL);
+
+
+	/*
+	 * Install handlers for the hwclock child if any
+	 */
+	for (np = NULL; (np = of_get_next_child(uninorth_node, np)) != NULL;)
+		if (strcmp(np->name, "hw-clock") == 0) {
+			unin_hwclock = np;
+			break;
+		}
+	if (unin_hwclock) {
+		DBG("Installing functions for UniN clock %s\n",
+		    unin_hwclock->full_name);
+		pmf_register_driver(unin_hwclock, &unin_mmio_handlers, NULL);
+		pmf_do_functions(unin_hwclock, NULL, 0, PMF_FLAGS_ON_INIT,
+				 NULL);
+	}
+}
+
+/* We export this as the SMP code might init us early */
+int __init pmac_pfunc_base_install(void)
+{
+	static int pfbase_inited;
+	int i;
+
+	if (pfbase_inited)
+		return 0;
+	pfbase_inited = 1;
+
+
+	DBG("Installing base platform functions...\n");
+
+	/*
+	 * Locate mac-io chips and install handlers
+	 */
+	for (i = 0 ; i < MAX_MACIO_CHIPS; i++) {
+		if (macio_chips[i].of_node) {
+			macio_mmio_init_one(&macio_chips[i]);
+			macio_gpio_init_one(&macio_chips[i]);
+		}
+	}
+
+	/*
+	 * Install handlers for northbridge and direct mapped hwclock
+	 * if any. We do not implement the config space access callback
+	 * which is only ever used for functions that we do not call in
+	 * the current driver (enabling/disabling cells in U2, mostly used
+	 * to restore the PCI settings, we do that differently)
+	 */
+	if (uninorth_node && uninorth_base)
+		uninorth_install_pfunc();
+
+	DBG("All base functions installed\n");
+
+	return 0;
+}
+
+arch_initcall(pmac_pfunc_base_install);
+
+#ifdef CONFIG_PM
+
+/* Those can be called by pmac_feature. Ultimately, I should use a sysdev
+ * or a device, but for now, that's good enough until I sort out some
+ * ordering issues. Also, we do not bother with GPIOs, as so far I yet have
+ * to see a case where a GPIO function has the on-suspend or on-resume bit
+ */
+void pmac_pfunc_base_suspend(void)
+{
+	int i;
+
+	for (i = 0 ; i < MAX_MACIO_CHIPS; i++) {
+		if (macio_chips[i].of_node)
+			pmf_do_functions(macio_chips[i].of_node, NULL, 0,
+					 PMF_FLAGS_ON_SLEEP, NULL);
+	}
+	if (uninorth_node)
+		pmf_do_functions(uninorth_node, NULL, 0,
+				 PMF_FLAGS_ON_SLEEP, NULL);
+	if (unin_hwclock)
+		pmf_do_functions(unin_hwclock, NULL, 0,
+				 PMF_FLAGS_ON_SLEEP, NULL);
+}
+
+void pmac_pfunc_base_resume(void)
+{
+	int i;
+
+	if (unin_hwclock)
+		pmf_do_functions(unin_hwclock, NULL, 0,
+				 PMF_FLAGS_ON_WAKE, NULL);
+	if (uninorth_node)
+		pmf_do_functions(uninorth_node, NULL, 0,
+				 PMF_FLAGS_ON_WAKE, NULL);
+	for (i = 0 ; i < MAX_MACIO_CHIPS; i++) {
+		if (macio_chips[i].of_node)
+			pmf_do_functions(macio_chips[i].of_node, NULL, 0,
+					 PMF_FLAGS_ON_WAKE, NULL);
+	}
+}
+
+#endif /* CONFIG_PM */
Index: linux-work/arch/powerpc/platforms/powermac/pfunc_core.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/platforms/powermac/pfunc_core.c	2006-01-07 10:54:03.000000000 +1100
@@ -0,0 +1,989 @@
+/*
+ *
+ * FIXME: Properly make this race free with refcounting etc...
+ *
+ * FIXME: LOCKING !!!
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+
+#include <asm/semaphore.h>
+#include <asm/prom.h>
+#include <asm/pmac_pfunc.h>
+
+/* Debug */
+#define LOG_PARSE(fmt...)
+#define LOG_ERROR(fmt...)	printk(fmt)
+#define LOG_BLOB(t,b,c)
+#define DBG(fmt...)		printk(fmt)
+
+/* Command numbers */
+#define PMF_CMD_LIST			0
+#define PMF_CMD_WRITE_GPIO		1
+#define PMF_CMD_READ_GPIO		2
+#define PMF_CMD_WRITE_REG32		3
+#define PMF_CMD_READ_REG32		4
+#define PMF_CMD_WRITE_REG16		5
+#define PMF_CMD_READ_REG16		6
+#define PMF_CMD_WRITE_REG8		7
+#define PMF_CMD_READ_REG8		8
+#define PMF_CMD_DELAY			9
+#define PMF_CMD_WAIT_REG32		10
+#define PMF_CMD_WAIT_REG16		11
+#define PMF_CMD_WAIT_REG8		12
+#define PMF_CMD_READ_I2C		13
+#define PMF_CMD_WRITE_I2C		14
+#define PMF_CMD_RMW_I2C			15
+#define PMF_CMD_GEN_I2C			16
+#define PMF_CMD_SHIFT_BYTES_RIGHT	17
+#define PMF_CMD_SHIFT_BYTES_LEFT	18
+#define PMF_CMD_READ_CFG		19
+#define PMF_CMD_WRITE_CFG		20
+#define PMF_CMD_RMW_CFG			21
+#define PMF_CMD_READ_I2C_SUBADDR	22
+#define PMF_CMD_WRITE_I2C_SUBADDR	23
+#define PMF_CMD_SET_I2C_MODE		24
+#define PMF_CMD_RMW_I2C_SUBADDR		25
+#define PMF_CMD_READ_REG32_MASK_SHR_XOR	26
+#define PMF_CMD_READ_REG16_MASK_SHR_XOR	27
+#define PMF_CMD_READ_REG8_MASK_SHR_XOR	28
+#define PMF_CMD_WRITE_REG32_SHL_MASK	29
+#define PMF_CMD_WRITE_REG16_SHL_MASK	30
+#define PMF_CMD_WRITE_REG8_SHL_MASK	31
+#define PMF_CMD_MASK_AND_COMPARE	32
+#define PMF_CMD_COUNT			33
+
+/* This structure holds the state of the parser while walking through
+ * a function definition
+ */
+struct pmf_cmd {
+	const void		*cmdptr;
+	const void		*cmdend;
+	struct pmf_function	*func;
+	void			*instdata;
+	struct pmf_args		*args;
+	int			error;
+};
+
+#if 0
+/* Debug output */
+static void print_blob(const char *title, const void *blob, int bytes)
+{
+	printk("%s", title);
+	while(bytes--) {
+		printk("%02x ", *((u8 *)blob));
+		blob += 1;
+	}
+	printk("\n");
+}
+#endif
+
+/*
+ * Parser helpers
+ */
+
+static u32 pmf_next32(struct pmf_cmd *cmd)
+{
+	u32 value;
+	if ((cmd->cmdend - cmd->cmdptr) < 4) {
+		cmd->error = 1;
+		return 0;
+	}
+	value = *((u32 *)cmd->cmdptr);
+	cmd->cmdptr += 4;
+	return value;
+}
+
+static const void* pmf_next_blob(struct pmf_cmd *cmd, int count)
+{
+	const void *value;
+	if ((cmd->cmdend - cmd->cmdptr) < count) {
+		cmd->error = 1;
+		return NULL;
+	}
+	value = cmd->cmdptr;
+	cmd->cmdptr += count;
+	return value;
+}
+
+/*
+ * Individual command parsers
+ */
+
+#define PMF_PARSE_CALL(name, cmd, handlers, p...) \
+	do { \
+		if (cmd->error) \
+			return -ENXIO; \
+		if (handlers == NULL) \
+			return 0; \
+		if (handlers->name)				      \
+			return handlers->name(cmd->func, cmd->instdata, \
+					      cmd->args, p);	      \
+		return -1; \
+	} while(0) \
+
+
+static int pmf_parser_write_gpio(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u8 value = (u8)pmf_next32(cmd);
+	u8 mask = (u8)pmf_next32(cmd);
+
+	LOG_PARSE("pmf: write_gpio(value: %02x, mask: %02x)\n", value, mask);
+
+	PMF_PARSE_CALL(write_gpio, cmd, h, value, mask);
+}
+
+static int pmf_parser_read_gpio(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u8 mask = (u8)pmf_next32(cmd);
+	int rshift = (int)pmf_next32(cmd);
+	u8 xor = (u8)pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_gpio(mask: %02x, rshift: %d, xor: %02x)\n",
+		  mask, rshift, xor);
+
+	PMF_PARSE_CALL(read_gpio, cmd, h, mask, rshift, xor);
+}
+
+static int pmf_parser_write_reg32(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 value = pmf_next32(cmd);
+	u32 mask = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: write_reg32(offset: %08x, value: %08x, mask: %08x)\n",
+		  offset, value, mask);
+
+	PMF_PARSE_CALL(write_reg32, cmd, h, offset, value, mask);
+}
+
+static int pmf_parser_read_reg32(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_reg32(offset: %08x)\n", offset);
+
+	PMF_PARSE_CALL(read_reg32, cmd, h, offset);
+}
+
+
+static int pmf_parser_write_reg16(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u16 value = (u16)pmf_next32(cmd);
+	u16 mask = (u16)pmf_next32(cmd);
+
+	LOG_PARSE("pmf: write_reg16(offset: %08x, value: %04x, mask: %04x)\n",
+		  offset, value, mask);
+
+	PMF_PARSE_CALL(write_reg16, cmd, h, offset, value, mask);
+}
+
+static int pmf_parser_read_reg16(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_reg16(offset: %08x)\n", offset);
+
+	PMF_PARSE_CALL(read_reg16, cmd, h, offset);
+}
+
+
+static int pmf_parser_write_reg8(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u8 value = (u16)pmf_next32(cmd);
+	u8 mask = (u16)pmf_next32(cmd);
+
+	LOG_PARSE("pmf: write_reg8(offset: %08x, value: %02x, mask: %02x)\n",
+		  offset, value, mask);
+
+	PMF_PARSE_CALL(write_reg8, cmd, h, offset, value, mask);
+}
+
+static int pmf_parser_read_reg8(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_reg8(offset: %08x)\n", offset);
+
+	PMF_PARSE_CALL(read_reg8, cmd, h, offset);
+}
+
+static int pmf_parser_delay(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 duration = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: delay(duration: %d us)\n", duration);
+
+	PMF_PARSE_CALL(delay, cmd, h, duration);
+}
+
+static int pmf_parser_wait_reg32(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 value = pmf_next32(cmd);
+	u32 mask = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: wait_reg32(offset: %08x, comp_value: %08x,mask: %08x)\n",
+		  offset, value, mask);
+
+	PMF_PARSE_CALL(wait_reg32, cmd, h, offset, value, mask);
+}
+
+static int pmf_parser_wait_reg16(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u16 value = (u16)pmf_next32(cmd);
+	u16 mask = (u16)pmf_next32(cmd);
+
+	LOG_PARSE("pmf: wait_reg16(offset: %08x, comp_value: %04x,mask: %04x)\n",
+		  offset, value, mask);
+
+	PMF_PARSE_CALL(wait_reg16, cmd, h, offset, value, mask);
+}
+
+static int pmf_parser_wait_reg8(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u8 value = (u8)pmf_next32(cmd);
+	u8 mask = (u8)pmf_next32(cmd);
+
+	LOG_PARSE("pmf: wait_reg8(offset: %08x, comp_value: %02x,mask: %02x)\n",
+		  offset, value, mask);
+
+	PMF_PARSE_CALL(wait_reg8, cmd, h, offset, value, mask);
+}
+
+static int pmf_parser_read_i2c(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 bytes = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_i2c(bytes: %ud)\n", bytes);
+
+	PMF_PARSE_CALL(read_i2c, cmd, h, bytes);
+}
+
+static int pmf_parser_write_i2c(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 bytes = pmf_next32(cmd);
+	const void *blob = pmf_next_blob(cmd, bytes);
+
+	LOG_PARSE("pmf: write_i2c(bytes: %ud) ...\n", bytes);
+	LOG_BLOB("pmf:   data: \n", blob, bytes);
+
+	PMF_PARSE_CALL(write_i2c, cmd, h, bytes, blob);
+}
+
+
+static int pmf_parser_rmw_i2c(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 maskbytes = pmf_next32(cmd);
+	u32 valuesbytes = pmf_next32(cmd);
+	u32 totalbytes = pmf_next32(cmd);
+	const void *maskblob = pmf_next_blob(cmd, maskbytes);
+	const void *valuesblob = pmf_next_blob(cmd, valuesbytes);
+
+	LOG_PARSE("pmf: rmw_i2c(maskbytes: %ud, valuebytes: %ud, "
+		  "totalbytes: %d) ...\n",
+		  maskbytes, valuesbytes, totalbytes);
+	LOG_BLOB("pmf:   mask data: \n", maskblob, maskbytes);
+	LOG_BLOB("pmf:   values data: \n", valuesblob, valuesbytes);
+
+	PMF_PARSE_CALL(rmw_i2c, cmd, h, maskbytes, valuesbytes, totalbytes,
+		       maskblob, valuesblob);
+}
+
+static int pmf_parser_read_cfg(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 bytes = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_cfg(offset: %x, bytes: %ud)\n", offset, bytes);
+
+	PMF_PARSE_CALL(read_cfg, cmd, h, offset, bytes);
+}
+
+
+static int pmf_parser_write_cfg(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 bytes = pmf_next32(cmd);
+	const void *blob = pmf_next_blob(cmd, bytes);
+
+	LOG_PARSE("pmf: write_cfg(offset: %x, bytes: %ud)\n", offset, bytes);
+	LOG_BLOB("pmf:   data: \n", blob, bytes);
+
+	PMF_PARSE_CALL(write_cfg, cmd, h, offset, bytes, blob);
+}
+
+static int pmf_parser_rmw_cfg(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 maskbytes = pmf_next32(cmd);
+	u32 valuesbytes = pmf_next32(cmd);
+	u32 totalbytes = pmf_next32(cmd);
+	const void *maskblob = pmf_next_blob(cmd, maskbytes);
+	const void *valuesblob = pmf_next_blob(cmd, valuesbytes);
+
+	LOG_PARSE("pmf: rmw_cfg(maskbytes: %ud, valuebytes: %ud,"
+		  " totalbytes: %d) ...\n",
+		  maskbytes, valuesbytes, totalbytes);
+	LOG_BLOB("pmf:   mask data: \n", maskblob, maskbytes);
+	LOG_BLOB("pmf:   values data: \n", valuesblob, valuesbytes);
+
+	PMF_PARSE_CALL(rmw_cfg, cmd, h, offset, maskbytes, valuesbytes,
+		       totalbytes, maskblob, valuesblob);
+}
+
+
+static int pmf_parser_read_i2c_sub(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u8 subaddr = (u8)pmf_next32(cmd);
+	u32 bytes = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_i2c_sub(subaddr: %x, bytes: %ud)\n",
+		  subaddr, bytes);
+
+	PMF_PARSE_CALL(read_i2c_sub, cmd, h, subaddr, bytes);
+}
+
+static int pmf_parser_write_i2c_sub(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u8 subaddr = (u8)pmf_next32(cmd);
+	u32 bytes = pmf_next32(cmd);
+	const void *blob = pmf_next_blob(cmd, bytes);
+
+	LOG_PARSE("pmf: write_i2c_sub(subaddr: %x, bytes: %ud) ...\n",
+		  subaddr, bytes);
+	LOG_BLOB("pmf:   data: \n", blob, bytes);
+
+	PMF_PARSE_CALL(write_i2c_sub, cmd, h, subaddr, bytes, blob);
+}
+
+static int pmf_parser_set_i2c_mode(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u32 mode = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: set_i2c_mode(mode: %d)\n", mode);
+
+	PMF_PARSE_CALL(set_i2c_mode, cmd, h, mode);
+}
+
+
+static int pmf_parser_rmw_i2c_sub(struct pmf_cmd *cmd, struct pmf_handlers *h)
+{
+	u8 subaddr = (u8)pmf_next32(cmd);
+	u32 maskbytes = pmf_next32(cmd);
+	u32 valuesbytes = pmf_next32(cmd);
+	u32 totalbytes = pmf_next32(cmd);
+	const void *maskblob = pmf_next_blob(cmd, maskbytes);
+	const void *valuesblob = pmf_next_blob(cmd, valuesbytes);
+
+	LOG_PARSE("pmf: rmw_i2c_sub(subaddr: %x, maskbytes: %ud, valuebytes: %ud"
+		  ", totalbytes: %d) ...\n",
+		  subaddr, maskbytes, valuesbytes, totalbytes);
+	LOG_BLOB("pmf:   mask data: \n", maskblob, maskbytes);
+	LOG_BLOB("pmf:   values data: \n", valuesblob, valuesbytes);
+
+	PMF_PARSE_CALL(rmw_i2c_sub, cmd, h, subaddr, maskbytes, valuesbytes,
+		       totalbytes, maskblob, valuesblob);
+}
+
+static int pmf_parser_read_reg32_msrx(struct pmf_cmd *cmd,
+				      struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 mask = pmf_next32(cmd);
+	u32 shift = pmf_next32(cmd);
+	u32 xor = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_reg32_msrx(offset: %x, mask: %x, shift: %x,"
+		  " xor: %x\n", offset, mask, shift, xor);
+
+	PMF_PARSE_CALL(read_reg32_msrx, cmd, h, offset, mask, shift, xor);
+}
+
+static int pmf_parser_read_reg16_msrx(struct pmf_cmd *cmd,
+				      struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 mask = pmf_next32(cmd);
+	u32 shift = pmf_next32(cmd);
+	u32 xor = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_reg16_msrx(offset: %x, mask: %x, shift: %x,"
+		  " xor: %x\n", offset, mask, shift, xor);
+
+	PMF_PARSE_CALL(read_reg16_msrx, cmd, h, offset, mask, shift, xor);
+}
+static int pmf_parser_read_reg8_msrx(struct pmf_cmd *cmd,
+				     struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 mask = pmf_next32(cmd);
+	u32 shift = pmf_next32(cmd);
+	u32 xor = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: read_reg8_msrx(offset: %x, mask: %x, shift: %x,"
+		  " xor: %x\n", offset, mask, shift, xor);
+
+	PMF_PARSE_CALL(read_reg8_msrx, cmd, h, offset, mask, shift, xor);
+}
+
+static int pmf_parser_write_reg32_slm(struct pmf_cmd *cmd,
+				      struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 shift = pmf_next32(cmd);
+	u32 mask = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: write_reg32_slm(offset: %x, shift: %x, mask: %x\n",
+		  offset, shift, mask);
+
+	PMF_PARSE_CALL(write_reg32_slm, cmd, h, offset, shift, mask);
+}
+
+static int pmf_parser_write_reg16_slm(struct pmf_cmd *cmd,
+				      struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 shift = pmf_next32(cmd);
+	u32 mask = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: write_reg16_slm(offset: %x, shift: %x, mask: %x\n",
+		  offset, shift, mask);
+
+	PMF_PARSE_CALL(write_reg16_slm, cmd, h, offset, shift, mask);
+}
+
+static int pmf_parser_write_reg8_slm(struct pmf_cmd *cmd,
+				     struct pmf_handlers *h)
+{
+	u32 offset = pmf_next32(cmd);
+	u32 shift = pmf_next32(cmd);
+	u32 mask = pmf_next32(cmd);
+
+	LOG_PARSE("pmf: write_reg8_slm(offset: %x, shift: %x, mask: %x\n",
+		  offset, shift, mask);
+
+	PMF_PARSE_CALL(write_reg8_slm, cmd, h, offset, shift, mask);
+}
+
+static int pmf_parser_mask_and_compare(struct pmf_cmd *cmd,
+				       struct pmf_handlers *h)
+{
+	u32 bytes = pmf_next32(cmd);
+	const void *maskblob = pmf_next_blob(cmd, bytes);
+	const void *valuesblob = pmf_next_blob(cmd, bytes);
+
+	LOG_PARSE("pmf: mask_and_compare(length: %ud ...\n", bytes);
+	LOG_BLOB("pmf:   mask data: \n", maskblob, bytes);
+	LOG_BLOB("pmf:   values data: \n", valuesblob, bytes);
+
+	PMF_PARSE_CALL(mask_and_compare, cmd, h,
+		       bytes, maskblob, valuesblob);
+}
+
+
+typedef int (*pmf_cmd_parser_t)(struct pmf_cmd *cmd, struct pmf_handlers *h);
+
+static pmf_cmd_parser_t pmf_parsers[PMF_CMD_COUNT] =
+{
+	NULL,
+	pmf_parser_write_gpio,
+	pmf_parser_read_gpio,
+	pmf_parser_write_reg32,
+	pmf_parser_read_reg32,
+	pmf_parser_write_reg16,
+	pmf_parser_read_reg16,
+	pmf_parser_write_reg8,
+	pmf_parser_read_reg8,
+	pmf_parser_delay,
+	pmf_parser_wait_reg32,
+	pmf_parser_wait_reg16,
+	pmf_parser_wait_reg8,
+	pmf_parser_read_i2c,
+	pmf_parser_write_i2c,
+	pmf_parser_rmw_i2c,
+	NULL, /* Bogus command */
+	NULL, /* Shift bytes right: NYI */
+	NULL, /* Shift bytes left: NYI */
+	pmf_parser_read_cfg,
+	pmf_parser_write_cfg,
+	pmf_parser_rmw_cfg,
+	pmf_parser_read_i2c_sub,
+	pmf_parser_write_i2c_sub,
+	pmf_parser_set_i2c_mode,
+	pmf_parser_rmw_i2c_sub,
+	pmf_parser_read_reg32_msrx,
+	pmf_parser_read_reg16_msrx,
+	pmf_parser_read_reg8_msrx,
+	pmf_parser_write_reg32_slm,
+	pmf_parser_write_reg16_slm,
+	pmf_parser_write_reg8_slm,
+	pmf_parser_mask_and_compare,
+};
+
+struct pmf_device {
+	struct list_head	link;
+	struct device_node	*node;
+	struct pmf_handlers	*handlers;
+	struct list_head	functions;
+	struct kref		ref;
+};
+
+static LIST_HEAD(pmf_devices);
+static spinlock_t pmf_lock = SPIN_LOCK_UNLOCKED;
+
+static void pmf_release_device(struct kref *kref)
+{
+	struct pmf_device *dev = container_of(kref, struct pmf_device, ref);
+	kfree(dev);
+}
+
+static inline void pmf_put_device(struct pmf_device *dev)
+{
+	kref_put(&dev->ref, pmf_release_device);
+}
+
+static inline struct pmf_device *pmf_get_device(struct pmf_device *dev)
+{
+	kref_get(&dev->ref);
+	return dev;
+}
+
+static inline struct pmf_device *pmf_find_device(struct device_node *np)
+{
+	struct pmf_device *dev;
+
+	list_for_each_entry(dev, &pmf_devices, link) {
+		if (dev->node == np)
+			return pmf_get_device(dev);
+	}
+	return NULL;
+}
+
+static int pmf_parse_one(struct pmf_function *func,
+			 struct pmf_handlers *handlers,
+			 void *instdata, struct pmf_args *args)
+{
+	struct pmf_cmd cmd;
+	u32 ccode;
+	int count, rc;
+
+	cmd.cmdptr		= func->data;
+	cmd.cmdend		= func->data + func->length;
+	cmd.func       		= func;
+	cmd.instdata		= instdata;
+	cmd.args		= args;
+	cmd.error		= 0;
+
+	LOG_PARSE("pmf: func %s, %d bytes, %s...\n",
+		  func->name, func->length,
+		  handlers ? "executing" : "parsing");
+
+	/* One subcommand to parse for now */
+	count = 1;
+
+	while(count-- && cmd.cmdptr < cmd.cmdend) {
+		/* Get opcode */
+		ccode = pmf_next32(&cmd);
+		/* Check if we are hitting a command list, fetch new count */
+		if (ccode == 0) {
+			count = pmf_next32(&cmd) - 1;
+			ccode = pmf_next32(&cmd);
+		}
+		if (cmd.error) {
+			LOG_ERROR("pmf: parse error, not enough data\n");
+			return -ENXIO;
+		}
+		if (ccode >= PMF_CMD_COUNT) {
+			LOG_ERROR("pmf: command code %d unknown !\n", ccode);
+			return -ENXIO;
+		}
+		if (pmf_parsers[ccode] == NULL) {
+			LOG_ERROR("pmf: no parser for command %d !\n", ccode);
+			return -ENXIO;
+		}
+		rc = pmf_parsers[ccode](&cmd, handlers);
+		if (rc != 0) {
+			LOG_ERROR("pmf: parser for command %d returned"
+				  " error %d\n", ccode, rc);
+			return rc;
+		}
+	}
+
+	/* We are doing an initial parse pass, we need to adjust the size */
+	if (handlers == NULL)
+		func->length = cmd.cmdptr - func->data;
+
+	return 0;
+}
+
+static int pmf_add_function_prop(struct pmf_device *dev, void *driverdata,
+				 const char *name, u32 *data,
+				 unsigned int length)
+{
+	int count = 0;
+	struct pmf_function *func = NULL;
+
+	DBG("pmf: Adding functions for platform-do-%s\n", name);
+
+	while (length >= 12) {
+		/* Allocate a structure */
+		func = kzalloc(sizeof(struct pmf_function), GFP_KERNEL);
+		if (func == NULL)
+			goto bail;
+		kref_init(&func->ref);
+		INIT_LIST_HEAD(&func->irq_clients);
+		func->node = dev->node;
+		func->driver_data = driverdata;
+		func->name = name;
+		func->phandle = data[0];
+		func->flags = data[1];
+		data += 2;
+		length -= 8;
+		func->data = data;
+		func->length = length;
+		func->dev = dev;
+		DBG("pmf: idx %d: flags=%08x, phandle=%08x "
+		    " %d bytes remaining, parsing...\n",
+		    count+1, func->flags, func->phandle, length);
+		if (pmf_parse_one(func, NULL, NULL, NULL)) {
+			kfree(func);
+			goto bail;
+		}
+		length -= func->length;
+		data = (u32 *)(((u8 *)data) + func->length);
+		list_add(&func->link, &dev->functions);
+		pmf_get_device(dev);
+		count++;
+	}
+ bail:
+	DBG("pmf: Added %d functions\n", count);
+
+	return count;
+}
+
+static int pmf_add_functions(struct pmf_device *dev, void *driverdata)
+{
+	struct property *pp;
+#define PP_PREFIX "platform-do-"
+	const int plen = strlen(PP_PREFIX);
+	int count = 0;
+
+	for (pp = dev->node->properties; pp != 0; pp = pp->next) {
+		char *name;
+		if (strncmp(pp->name, PP_PREFIX, plen) != 0)
+			continue;
+		name = pp->name + plen;
+		if (strlen(name) && pp->length >= 12)
+			count += pmf_add_function_prop(dev, driverdata, name,
+						       (u32 *)pp->value,
+						       pp->length);
+	}
+	return count;
+}
+
+
+int pmf_register_driver(struct device_node *np,
+			struct pmf_handlers *handlers,
+			void *driverdata)
+{
+	struct pmf_device *dev;
+	unsigned long flags;
+	int rc = 0;
+
+	if (handlers == NULL)
+		return -EINVAL;
+
+	DBG("pmf: registering driver for node %s\n", np->full_name);
+
+	spin_lock_irqsave(&pmf_lock, flags);
+	dev = pmf_find_device(np);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+	if (dev != NULL) {
+		DBG("pmf: already there !\n");
+		pmf_put_device(dev);
+		return -EBUSY;
+	}
+
+	dev = kzalloc(sizeof(struct pmf_device), GFP_KERNEL);
+	if (dev == NULL) {
+		DBG("pmf: no memory !\n");
+		return -ENOMEM;
+	}
+	kref_init(&dev->ref);
+	dev->node = of_node_get(np);
+	dev->handlers = handlers;
+	INIT_LIST_HEAD(&dev->functions);
+
+	rc = pmf_add_functions(dev, driverdata);
+	if (rc == 0) {
+		DBG("pmf: no functions, disposing.. \n");
+		of_node_put(np);
+		kfree(dev);
+		return -ENODEV;
+	}
+
+	spin_lock_irqsave(&pmf_lock, flags);
+	list_add(&dev->link, &pmf_devices);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pmf_register_driver);
+
+struct pmf_function *pmf_get_function(struct pmf_function *func)
+{
+	if (!try_module_get(func->dev->handlers->owner))
+		return NULL;
+	kref_get(&func->ref);
+	return func;
+}
+EXPORT_SYMBOL_GPL(pmf_get_function);
+
+static void pmf_release_function(struct kref *kref)
+{
+	struct pmf_function *func =
+		container_of(kref, struct pmf_function, ref);
+	pmf_put_device(func->dev);
+	kfree(func);
+}
+
+static inline void __pmf_put_function(struct pmf_function *func)
+{
+	kref_put(&func->ref, pmf_release_function);
+}
+
+void pmf_put_function(struct pmf_function *func)
+{
+	if (func == NULL)
+		return;
+	module_put(func->dev->handlers->owner);
+	__pmf_put_function(func);
+}
+EXPORT_SYMBOL_GPL(pmf_put_function);
+
+void pmf_unregister_driver(struct device_node *np)
+{
+	struct pmf_device *dev;
+	unsigned long flags;
+
+	DBG("pmf: unregistering driver for node %s\n", np->full_name);
+
+	spin_lock_irqsave(&pmf_lock, flags);
+	dev = pmf_find_device(np);
+	if (dev == NULL) {
+		DBG("pmf: not such driver !\n");
+		spin_unlock_irqrestore(&pmf_lock, flags);
+		return;
+	}
+	list_del(&dev->link);
+
+	while(!list_empty(&dev->functions)) {
+		struct pmf_function *func =
+			list_entry(dev->functions.next, typeof(*func), link);
+		list_del(&func->link);
+		__pmf_put_function(func);
+	}
+
+	pmf_put_device(dev);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+}
+EXPORT_SYMBOL_GPL(pmf_unregister_driver);
+
+struct pmf_function *__pmf_find_function(struct device_node *target,
+					 const char *name, u32 flags)
+{
+	struct device_node *actor = of_node_get(target);
+	struct pmf_device *dev;
+	struct pmf_function *func, *result = NULL;
+	char fname[64];
+	u32 *prop, ph;
+
+	/*
+	 * Look for a "platform-*" function reference. If we can't find
+	 * one, then we fallback to a direct call attempt
+	 */
+	snprintf(fname, 63, "platform-%s", name);
+	prop = (u32 *)get_property(target, fname, NULL);
+	if (prop == NULL)
+		goto find_it;
+	ph = *prop;
+	if (ph == 0)
+		goto find_it;
+
+	/*
+	 * Ok, now try to find the actor. If we can't find it, we fail,
+	 * there is no point in falling back there
+	 */
+	of_node_put(actor);
+	actor = of_find_node_by_phandle(ph);
+	if (actor == NULL)
+		return NULL;
+ find_it:
+	dev = pmf_find_device(actor);
+	if (dev == NULL)
+		return NULL;
+
+	list_for_each_entry(func, &dev->functions, link) {
+		if (name && strcmp(name, func->name))
+			continue;
+		if (func->phandle && target->node != func->phandle)
+			continue;
+		if ((func->flags & flags) == 0)
+			continue;
+		result = func;
+		break;
+	}
+	of_node_put(actor);
+	pmf_put_device(dev);
+	return result;
+}
+
+
+int pmf_register_irq_client(struct device_node *target,
+			    const char *name,
+			    struct pmf_irq_client *client)
+{
+	struct pmf_function *func;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmf_lock, flags);
+	func = __pmf_find_function(target, name, PMF_FLAGS_INT_GEN);
+	if (func == NULL) {
+		spin_unlock_irqrestore(&pmf_lock, flags);
+		return -ENODEV;
+	}
+	list_add(&client->link, &func->irq_clients);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pmf_register_irq_client);
+
+void pmf_unregister_irq_client(struct device_node *np,
+			      const char *name,
+			      struct pmf_irq_client *client)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmf_lock, flags);
+	list_del(&client->link);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+}
+EXPORT_SYMBOL_GPL(pmf_unregister_irq_client);
+
+
+void pmf_do_irq(struct pmf_function *func)
+{
+	unsigned long flags;
+	struct pmf_irq_client *client;
+
+	/* For now, using a spinlock over the whole function. Can be made
+	 * to drop the lock using 2 lists if necessary
+	 */
+	spin_lock_irqsave(&pmf_lock, flags);
+	list_for_each_entry(client, &func->irq_clients, link) {
+		if (!try_module_get(client->owner))
+			continue;
+		client->handler(client->data);
+		module_put(client->owner);
+	}
+	spin_unlock_irqrestore(&pmf_lock, flags);
+}
+EXPORT_SYMBOL_GPL(pmf_do_irq);
+
+
+int pmf_call_one(struct pmf_function *func, struct pmf_args *args)
+{
+	struct pmf_device *dev = func->dev;
+	void *instdata = NULL;
+	int rc = 0;
+
+	DBG(" ** pmf_call_one(%s/%s) **\n", dev->node->full_name, func->name);
+
+	if (dev->handlers->begin)
+		instdata = dev->handlers->begin(func, args);
+	rc = pmf_parse_one(func, dev->handlers, instdata, args);
+	if (dev->handlers->end)
+		dev->handlers->end(func, instdata);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pmf_call_one);
+
+int pmf_do_functions(struct device_node *np, const char *name,
+		     u32 phandle, u32 fflags, struct pmf_args *args)
+{
+	struct pmf_device *dev;
+	struct pmf_function *func, *tmp;
+	unsigned long flags;
+	int rc = -ENODEV;
+
+	spin_lock_irqsave(&pmf_lock, flags);
+
+	dev = pmf_find_device(np);
+	if (dev == NULL) {
+		spin_unlock_irqrestore(&pmf_lock, flags);
+		return -ENODEV;
+	}
+	list_for_each_entry_safe(func, tmp, &dev->functions, link) {
+		if (name && strcmp(name, func->name))
+			continue;
+		if (phandle && func->phandle && phandle != func->phandle)
+			continue;
+		if ((func->flags & fflags) == 0)
+			continue;
+		if (pmf_get_function(func) == NULL)
+			continue;
+		spin_unlock_irqrestore(&pmf_lock, flags);
+		rc = pmf_call_one(func, args);
+		pmf_put_function(func);
+		spin_lock_irqsave(&pmf_lock, flags);
+	}
+	pmf_put_device(dev);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pmf_do_functions);
+
+
+struct pmf_function *pmf_find_function(struct device_node *target,
+				       const char *name)
+{
+	struct pmf_function *func;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmf_lock, flags);
+	func = __pmf_find_function(target, name, PMF_FLAGS_ON_DEMAND);
+	if (func)
+		func = pmf_get_function(func);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+	return func;
+}
+EXPORT_SYMBOL_GPL(pmf_find_function);
+
+int pmf_call_function(struct device_node *target, const char *name,
+		      struct pmf_args *args)
+{
+	struct pmf_function *func = pmf_find_function(target, name);
+	int rc;
+
+	if (func == NULL)
+		return -ENODEV;
+
+	rc = pmf_call_one(func, args);
+	pmf_put_function(func);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pmf_call_function);
+
Index: linux-work/include/asm-powerpc/pmac_feature.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pmac_feature.h	2006-01-07 10:53:21.000000000 +1100
+++ linux-work/include/asm-powerpc/pmac_feature.h	2006-01-07 10:54:03.000000000 +1100
@@ -374,5 +374,24 @@ extern struct macio_chip* macio_find(str
 #define MACIO_IN8(r)		(in_8(MACIO_FCR8(macio,r)))
 #define MACIO_OUT8(r,v)		(out_8(MACIO_FCR8(macio,r), (v)))
 
+/*
+ * Those are exported by pmac feature for internal use by arch code
+ * only like the platform function callbacks, do not use directly in drivers
+ */
+extern spinlock_t feature_lock;
+extern struct device_node *uninorth_node;
+extern u32 __iomem *uninorth_base;
+
+/*
+ * Uninorth reg. access. Note that Uni-N regs are big endian
+ */
+
+#define UN_REG(r)	(uninorth_base + ((r) >> 2))
+#define UN_IN(r)	(in_be32(UN_REG(r)))
+#define UN_OUT(r,v)	(out_be32(UN_REG(r), (v)))
+#define UN_BIS(r,v)	(UN_OUT((r), UN_IN(r) | (v)))
+#define UN_BIC(r,v)	(UN_OUT((r), UN_IN(r) & ~(v)))
+
+
 #endif /* __PPC_ASM_PMAC_FEATURE_H */
 #endif /* __KERNEL__ */
Index: linux-work/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/smp.c	2006-01-07 10:53:21.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/smp.c	2006-01-07 10:54:03.000000000 +1100
@@ -52,8 +52,9 @@
 #include <asm/cacheflush.h>
 #include <asm/keylargo.h>
 #include <asm/pmac_low_i2c.h>
+#include <asm/pmac_pfunc.h>
 
-#undef DEBUG
+#define DEBUG
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -62,6 +63,7 @@
 #endif
 
 extern void __secondary_start_pmac_0(void);
+extern int pmac_pfunc_base_install(void);
 
 #ifdef CONFIG_PPC32
 
@@ -602,11 +604,29 @@ static void __init smp_core99_setup_i2c_
 	pmac_tb_clock_chip_host = NULL;
 }
 
-#endif /* CONFIG_PPC64 */
 
 
 /*
- * SMP G4 and newer G5 use a GPIO to enable/disable the timebase.
+ * Newer G5s uses a platform function
+ */
+
+static void smp_core99_pfunc_tb_freeze(int freeze)
+{
+	struct device_node *cpus;
+	struct pmf_args args;
+
+	cpus = of_find_node_by_path("/cpus");
+	BUG_ON(cpus == NULL);
+	args.count = 1;
+	args.u[0].v = !freeze;
+	pmf_call_function(cpus, "cpu-timebase", &args);
+	of_node_put(cpus);
+}
+
+#else /* CONFIG_PPC64 */
+
+/*
+ * SMP G4 use a GPIO to enable/disable the timebase.
  */
 
 static unsigned int core99_tb_gpio;	/* Timebase freeze GPIO */
@@ -620,6 +640,9 @@ static void smp_core99_gpio_tb_freeze(in
 	pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, core99_tb_gpio, 0);
 }
 
+
+#endif /* !CONFIG_PPC64 */
+
 /* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
 volatile static long int core99_l2_cache;
 volatile static long int core99_l3_cache;
@@ -665,19 +688,15 @@ static void __init smp_core99_setup(int 
 	    machine_is_compatible("RackMac3,1"))
 		smp_core99_setup_i2c_hwsync(ncpus);
 
-	/* GPIO based HW sync on recent G5s */
+	/* pfunc based HW sync on recent G5s */
 	if (pmac_tb_freeze == NULL) {
-		struct device_node *np =
-			of_find_node_by_name(NULL, "timebase-enable");
-		u32 *reg = (u32 *)get_property(np, "reg", NULL);
-
-		if (np && reg && !strcmp(np->type, "gpio")) {
-			core99_tb_gpio = *reg;
-			if (core99_tb_gpio < 0x50)
-				core99_tb_gpio += 0x50;
-			pmac_tb_freeze = smp_core99_gpio_tb_freeze;
+		struct device_node *cpus =
+			of_find_node_by_path("/cpus");
+		if (cpus &&
+		    get_property(cpus, "platform-cpu-timebase", NULL)) {
+			pmac_tb_freeze = smp_core99_pfunc_tb_freeze;
 			printk(KERN_INFO "Processor timebase sync using"
-			       " GPIO 0x%02x\n", core99_tb_gpio);
+			       " platform function\n");
 		}
 	}
 
@@ -746,6 +765,7 @@ static int __init smp_core99_probe(void)
 	/* We need to perform some early initialisations before we can start
 	 * setting up SMP as we are running before initcalls
 	 */
+	pmac_pfunc_base_install();
 	pmac_i2c_init();
 
 	/* Setup various bits like timebase sync method, ability to nap, ... */
Index: linux-work/arch/powerpc/platforms/powermac/low_i2c.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/low_i2c.c	2006-01-07 10:53:21.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/low_i2c.c	2006-01-07 10:54:03.000000000 +1100
@@ -49,6 +49,7 @@
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/smu.h>
+#include <asm/pmac_pfunc.h>
 #include <asm/pmac_low_i2c.h>
 
 #ifdef DEBUG
@@ -1162,9 +1163,291 @@ int pmac_i2c_xfer(struct pmac_i2c_bus *b
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_xfer);
 
+/* some quirks for platform function decoding */
+enum {
+	pmac_i2c_quirk_invmask = 0x00000001u,
+};
+
+static void pmac_i2c_devscan(void (*callback)(struct device_node *dev,
+					      int quirks))
+{
+	struct pmac_i2c_bus *bus;
+	struct device_node *np;
+	static struct whitelist_ent {
+		char *name;
+		char *compatible;
+		int quirks;
+	} whitelist[] = {
+		/* XXX Study device-tree's & apple drivers are get the quirks
+		 * right !
+		 */
+		{ "i2c-hwclock", NULL, pmac_i2c_quirk_invmask },
+		{ "i2c-cpu-voltage", NULL, 0},
+		{  "temp-monitor", NULL, 0 },
+		{  "supply-monitor", NULL, 0 },
+		{ NULL, NULL, 0 },
+	};
+
+	/* Only some devices need to have platform functions instanciated
+	 * here. For now, we have a table. Others, like 9554 i2c GPIOs used
+	 * on Xserve, if we ever do a driver for them, will use their own
+	 * platform function instance
+	 */
+	list_for_each_entry(bus, &pmac_i2c_busses, link) {
+		for (np = NULL;
+		     (np = of_get_next_child(bus->busnode, np)) != NULL;) {
+			struct whitelist_ent *p;
+			/* If multibus, check if device is on that bus */
+			if (bus->flags & pmac_i2c_multibus)
+				if (bus != pmac_i2c_find_bus(np))
+					continue;
+			for (p = whitelist; p->name != NULL; p++) {
+				if (strcmp(np->name, p->name))
+					continue;
+				if (p->compatible &&
+				    !device_is_compatible(np, p->compatible))
+					continue;
+				callback(np, p->quirks);
+				break;
+			}
+		}
+	}
+}
+
+#define MAX_I2C_DATA	64
+
+struct pmac_i2c_pf_inst
+{
+	struct pmac_i2c_bus	*bus;
+	u8			addr;
+	u8			buffer[MAX_I2C_DATA];
+	u8			scratch[MAX_I2C_DATA];
+	int			bytes;
+	int			quirks;
+};
+
+static void* pmac_i2c_do_begin(struct pmf_function *func, struct pmf_args *args)
+{
+	struct pmac_i2c_pf_inst *inst;
+	struct pmac_i2c_bus	*bus;
+
+	bus = pmac_i2c_find_bus(func->node);
+	if (bus == NULL) {
+		printk(KERN_ERR "low_i2c: Can't find bus for %s (pfunc)\n",
+		       func->node->full_name);
+		return NULL;
+	}
+	if (pmac_i2c_open(bus, 0)) {
+		printk(KERN_ERR "low_i2c: Can't open i2c bus for %s (pfunc)\n",
+		       func->node->full_name);
+		return NULL;
+	}
+
+	/* XXX might need GFP_ATOMIC when called during the suspend process,
+	 * but then, there are already lots of issues with suspending when
+	 * near OOM that need to be resolved, the allocator itself should
+	 * probably make GFP_NOIO implicit during suspend
+	 */
+	inst = kzalloc(sizeof(struct pmac_i2c_pf_inst), GFP_KERNEL);
+	if (inst == NULL) {
+		pmac_i2c_close(bus);
+		return NULL;
+	}
+	inst->bus = bus;
+	inst->addr = pmac_i2c_get_dev_addr(func->node);
+	inst->quirks = (int)(long)func->driver_data;
+	return inst;
+}
+
+static void pmac_i2c_do_end(struct pmf_function *func, void *instdata)
+{
+	struct pmac_i2c_pf_inst *inst = instdata;
+
+	if (inst == NULL)
+		return;
+	pmac_i2c_close(inst->bus);
+	if (inst)
+		kfree(inst);
+}
+
+static int pmac_i2c_do_read(PMF_STD_ARGS, u32 len)
+{
+	struct pmac_i2c_pf_inst *inst = instdata;
+
+	inst->bytes = len;
+	return pmac_i2c_xfer(inst->bus, inst->addr | pmac_i2c_read, 0, 0,
+			     inst->buffer, len);
+}
+
+static int pmac_i2c_do_write(PMF_STD_ARGS, u32 len, const u8 *data)
+{
+	struct pmac_i2c_pf_inst *inst = instdata;
+
+	return pmac_i2c_xfer(inst->bus, inst->addr | pmac_i2c_write, 0, 0,
+			     (u8 *)data, len);
+}
+
+/* This function is used to do the masking & OR'ing for the "rmw" type
+ * callbacks. Ze should apply the mask and OR in the values in the
+ * buffer before writing back. The problem is that it seems that
+ * various darwin drivers implement the mask/or differently, thus
+ * we need to check the quirks first
+ */
+static void pmac_i2c_do_apply_rmw(struct pmac_i2c_pf_inst *inst,
+				  u32 len, const u8 *mask, const u8 *val)
+{
+	int i;
+
+	if (inst->quirks & pmac_i2c_quirk_invmask) {
+		for (i = 0; i < len; i ++)
+			inst->scratch[i] = (inst->buffer[i] & mask[i]) | val[i];
+	} else {
+		for (i = 0; i < len; i ++)
+			inst->scratch[i] = (inst->buffer[i] & ~mask[i])
+				| (val[i] & mask[i]);
+	}
+}
+
+static int pmac_i2c_do_rmw(PMF_STD_ARGS, u32 masklen, u32 valuelen,
+			   u32 totallen, const u8 *maskdata,
+			   const u8 *valuedata)
+{
+	struct pmac_i2c_pf_inst *inst = instdata;
+
+	if (masklen > inst->bytes || valuelen > inst->bytes ||
+	    totallen > inst->bytes || valuelen > masklen)
+		return -EINVAL;
+
+	pmac_i2c_do_apply_rmw(inst, masklen, maskdata, valuedata);
+
+	return pmac_i2c_xfer(inst->bus, inst->addr | pmac_i2c_write, 0, 0,
+			     inst->scratch, totallen);
+}
+
+static int pmac_i2c_do_read_sub(PMF_STD_ARGS, u8 subaddr, u32 len)
+{
+	struct pmac_i2c_pf_inst *inst = instdata;
+
+	inst->bytes = len;
+	return pmac_i2c_xfer(inst->bus, inst->addr | pmac_i2c_read, 1, subaddr,
+			     inst->buffer, len);
+}
+
+static int pmac_i2c_do_write_sub(PMF_STD_ARGS, u8 subaddr, u32 len,
+				     const u8 *data)
+{
+	struct pmac_i2c_pf_inst *inst = instdata;
+
+	return pmac_i2c_xfer(inst->bus, inst->addr | pmac_i2c_write, 1,
+			     subaddr, (u8 *)data, len);
+}
+
+static int pmac_i2c_do_set_mode(PMF_STD_ARGS, int mode)
+{
+	struct pmac_i2c_pf_inst *inst = instdata;
+
+	return pmac_i2c_setmode(inst->bus, mode);
+}
+
+static int pmac_i2c_do_rmw_sub(PMF_STD_ARGS, u8 subaddr, u32 masklen,
+			       u32 valuelen, u32 totallen, const u8 *maskdata,
+			       const u8 *valuedata)
+{
+	struct pmac_i2c_pf_inst *inst = instdata;
+
+	if (masklen > inst->bytes || valuelen > inst->bytes ||
+	    totallen > inst->bytes || valuelen > masklen)
+		return -EINVAL;
+
+	pmac_i2c_do_apply_rmw(inst, masklen, maskdata, valuedata);
+
+	return pmac_i2c_xfer(inst->bus, inst->addr | pmac_i2c_write, 1,
+			     subaddr, inst->scratch, totallen);
+}
+
+static int pmac_i2c_do_mask_and_comp(PMF_STD_ARGS, u32 len,
+				     const u8 *maskdata,
+				     const u8 *valuedata)
+{
+	struct pmac_i2c_pf_inst *inst = instdata;
+	int i, match;
+
+	/* Get return value pointer, it's assumed to be a u32 */
+	if (!args || !args->count || !args->u[0].p)
+		return -EINVAL;
+
+	/* Check buffer */
+	if (len > inst->bytes)
+		return -EINVAL;
+
+	for (i = 0, match = 1; match && i < len; i ++)
+		if ((inst->buffer[i] & maskdata[i]) != valuedata[i])
+			match = 0;
+	*args->u[0].p = match;
+	return 0;
+}
+
+static int pmac_i2c_do_delay(PMF_STD_ARGS, u32 duration)
+{
+	msleep((duration + 999) / 1000);
+	return 0;
+}
+
+
+static struct pmf_handlers pmac_i2c_pfunc_handlers = {
+	.begin			= pmac_i2c_do_begin,
+	.end			= pmac_i2c_do_end,
+	.read_i2c		= pmac_i2c_do_read,
+	.write_i2c		= pmac_i2c_do_write,
+	.rmw_i2c		= pmac_i2c_do_rmw,
+	.read_i2c_sub		= pmac_i2c_do_read_sub,
+	.write_i2c_sub		= pmac_i2c_do_write_sub,
+	.rmw_i2c_sub		= pmac_i2c_do_rmw_sub,
+	.set_i2c_mode		= pmac_i2c_do_set_mode,
+	.mask_and_compare	= pmac_i2c_do_mask_and_comp,
+	.delay			= pmac_i2c_do_delay,
+};
+
+static void __init pmac_i2c_dev_create(struct device_node *np, int quirks)
+{
+	DBG("dev_create(%s)\n", np->full_name);
+
+	pmf_register_driver(np, &pmac_i2c_pfunc_handlers,
+			    (void *)(long)quirks);
+}
+
+static void __init pmac_i2c_dev_init(struct device_node *np, int quirks)
+{
+	DBG("dev_create(%s)\n", np->full_name);
+
+	pmf_do_functions(np, NULL, 0, PMF_FLAGS_ON_INIT, NULL);
+}
+
+static void pmac_i2c_dev_suspend(struct device_node *np, int quirks)
+{
+	DBG("dev_suspend(%s)\n", np->full_name);
+	pmf_do_functions(np, NULL, 0, PMF_FLAGS_ON_SLEEP, NULL);
+}
+
+static void pmac_i2c_dev_resume(struct device_node *np, int quirks)
+{
+	DBG("dev_resume(%s)\n", np->full_name);
+	pmf_do_functions(np, NULL, 0, PMF_FLAGS_ON_WAKE, NULL);
+}
+
+void pmac_pfunc_i2c_suspend(void)
+{
+	pmac_i2c_devscan(pmac_i2c_dev_suspend);
+}
+
+void pmac_pfunc_i2c_resume(void)
+{
+	pmac_i2c_devscan(pmac_i2c_dev_resume);
+}
+
 /*
- * Initialize us: probe all i2c busses on the machine and instantiate
- * busses.
+ * Initialize us: probe all i2c busses on the machine, instantiate
+ * busses and platform functions as needed.
  */
 /* This is non-static as it might be called early by smp code */
 int __init pmac_i2c_init(void)
@@ -1187,6 +1470,10 @@ int __init pmac_i2c_init(void)
 	/* Probe SMU i2c busses */
 	smu_i2c_probe();
 #endif
+
+	/* Now add plaform functions for some known devices */
+	pmac_i2c_devscan(pmac_i2c_dev_create);
+
 	return 0;
 }
 arch_initcall(pmac_i2c_init);
@@ -1216,6 +1503,9 @@ static int __init pmac_i2c_create_platfo
 		platform_device_add(bus->platform_dev);
 	}
 
+	/* Now call platform "init" functions */
+	pmac_i2c_devscan(pmac_i2c_dev_init);
+
 	return 0;
 }
 subsys_initcall(pmac_i2c_create_platform_devices);
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2006-01-07 10:53:21.000000000 +1100
+++ linux-work/drivers/macintosh/via-pmu.c	2006-01-07 10:54:03.000000000 +1100
@@ -55,6 +55,8 @@
 #include <asm/sections.h>
 #include <asm/irq.h>
 #include <asm/pmac_feature.h>
+#include <asm/pmac_pfunc.h>
+#include <asm/pmac_low_i2c.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/cputable.h>
@@ -2105,6 +2107,10 @@ pmac_suspend_devices(void)
 		return -EBUSY;
 	}
 
+	/* Call platform functions marked "on sleep" */
+	pmac_pfunc_i2c_suspend();
+	pmac_pfunc_base_suspend();
+
 	/* Stop preemption */
 	preempt_disable();
 
@@ -2175,6 +2181,10 @@ pmac_wakeup_devices(void)
 	mdelay(10);
 	preempt_enable();
 
+	/* Call platform functions marked "on wake" */
+	pmac_pfunc_base_resume();
+	pmac_pfunc_i2c_resume();
+
 	/* Resume devices */
 	device_resume();
 
Index: linux-work/include/asm-powerpc/pmac_low_i2c.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pmac_low_i2c.h	2006-01-07 10:53:21.000000000 +1100
+++ linux-work/include/asm-powerpc/pmac_low_i2c.h	2006-01-07 10:54:03.000000000 +1100
@@ -99,6 +99,9 @@ extern int pmac_i2c_setmode(struct pmac_
 extern int pmac_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
 			 u32 subaddr, u8 *data,  int len);
 
+/* Suspend/resume code called by via-pmu directly for now */
+extern void pmac_pfunc_i2c_suspend(void);
+extern void pmac_pfunc_i2c_resume(void);
 
 #endif /* __KERNEL__ */
 #endif /* __PMAC_LOW_I2C_H__ */
