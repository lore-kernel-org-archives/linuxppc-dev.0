Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E759FB7B74
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 17:45:52 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CFBDDDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 17:45:50 +1000 (EST)
Subject: [RFC/PATCH] Clock binding prototype implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: devicetree-discuss@lists.ozlabs.org
In-Reply-To: <1250569288.19007.15.camel@pasglop>
References: <1250569288.19007.15.camel@pasglop>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 17:45:29 +1000
Message-Id: <1250581529.19007.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc: New implementation of the "clk" API with device-tree binding

This replaces the struct clk_interface, as far as I know only ever
used by the mpc512x platforms, with a new scheme:

struct clk is now an object containing function pointers for all the
base API routines. The implementation of those routines call into
those pointers. struct clk is meant to be embedded in the "real"
structure for a given clock type.

clk_get is hooked via ppc_md. A default implementation is provided
that uses the device-tree binding (still being discussed, a patch
to Documentation/* will come when it's final). It can also create
simple objects (no control, working get_rate()) based on nodes that
have a "clock-frequency" property.

Finally, the mpc512x code is adapted. The adaptation is minimal as
I don't have test gear, so I'm not using nor touching the device-tree
on this one, but instead hooking ppc_md.get_clk() and keeping the
old code mostly intact (just some type changes to embed the new
struct clk into the mpc512x specific variants which gets renamed
to struct mpc512x_clk).

No S-O-B yet as this is totally untested and the binding isn't
final yet neither, but gives an idea of where I'm going.

Ben.

Index: linux-work/arch/powerpc/include/asm/clk_interface.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/clk_interface.h	2009-02-05 16:22:24.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,20 +0,0 @@
-#ifndef __ASM_POWERPC_CLK_INTERFACE_H
-#define __ASM_POWERPC_CLK_INTERFACE_H
-
-#include <linux/clk.h>
-
-struct clk_interface {
-	struct clk*	(*clk_get)	(struct device *dev, const char *id);
-	int		(*clk_enable)	(struct clk *clk);
-	void		(*clk_disable)	(struct clk *clk);
-	unsigned long	(*clk_get_rate)	(struct clk *clk);
-	void		(*clk_put)	(struct clk *clk);
-	long		(*clk_round_rate) (struct clk *clk, unsigned long rate);
-	int 		(*clk_set_rate)	(struct clk *clk, unsigned long rate);
-	int		(*clk_set_parent) (struct clk *clk, struct clk *parent);
-	struct clk*	(*clk_get_parent) (struct clk *clk);
-};
-
-extern struct clk_interface clk_functions;
-
-#endif /* __ASM_POWERPC_CLK_INTERFACE_H */
Index: linux-work/arch/powerpc/kernel/clock.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/clock.c	2009-02-05 16:22:24.000000000 +1100
+++ linux-work/arch/powerpc/kernel/clock.c	2009-08-18 17:38:08.000000000 +1000
@@ -1,82 +1,282 @@
 /*
- * Dummy clk implementations for powerpc.
- * These need to be overridden in platform code.
+ * Clock infrastructure for PowerPC platform
+ *
  */
 
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/module.h>
-#include <asm/clk_interface.h>
+#include <linux/of.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <asm/clk.h>
+#include <asm/machdep.h>
+
+struct clk_provider {
+	struct list_head	link;
+	struct device_node     	*node;
+
+	/* Return NULL if no such clock output, return PTR_ERR for
+	 * other errors
+	 */
+	struct clk *		(*get)(struct device_node *np,
+				       const char *output_id,
+				       void *data);
+	void			*data;
+};
+
+static LIST_HEAD(clk_providers);
+static DEFINE_MUTEX(clk_lock);
+
+int clk_add_provider(struct device_node *np,
+		     struct clk *(*clk_src_get)(struct device_node *np,
+						const char *output_id,
+						void *data),
+		     void *data)
+{
+	struct clk_provider *cp;
 
-struct clk_interface clk_functions;
+	cp = kzalloc(sizeof(struct clk_provider), GFP_KERNEL);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->node = of_node_get(np);
+	cp->data = data;
+	cp->get = clk_src_get;
+
+	mutex_lock(&clk_lock);
+	list_add(&cp->link, &clk_providers);
+	mutex_unlock(&clk_lock);
 
-struct clk *clk_get(struct device *dev, const char *id)
+	return 0;
+}
+
+void clk_del_provider(struct device_node *np,
+		      struct clk *(*clk_src_get)(struct device_node *np,
+						 const char *output_id,
+						 void *data),
+		      void *data)
 {
-	if (clk_functions.clk_get)
-		return clk_functions.clk_get(dev, id);
-	return ERR_PTR(-ENOSYS);
+	struct clk_provider *cp, *tmp;
+
+	mutex_lock(&clk_lock);
+	list_for_each_entry_safe(cp, tmp, &clk_providers, link) {
+		if (cp->node == np && cp->get == clk_src_get && cp->data == data) {
+			list_del(&cp->link);
+			of_node_put(cp->node);
+			kfree(cp);
+			break;
+		}
+	}
+	mutex_unlock(&clk_lock);
 }
-EXPORT_SYMBOL(clk_get);
 
-void clk_put(struct clk *clk)
+static unsigned long clk_simple_get_rate(struct clk *clk)
 {
-	if (clk_functions.clk_put)
-		clk_functions.clk_put(clk);
+	struct clk_simple *cs = to_clk_simple(clk);
+
+	return cs->rate;
 }
-EXPORT_SYMBOL(clk_put);
+
+static void clk_simple_put(struct clk *clk)
+{
+	struct clk_simple *cs = to_clk_simple(clk);
+
+	kfree(cs);
+}
+
+static struct clk *__clk_get_simple(struct device_node *np)
+{
+	const u32 *freq;
+	struct clk_simple *cs;
+
+	freq = of_get_property(np, "clock-frequency", NULL);
+	if (!freq)
+		return ERR_PTR(-ENXIO);
+
+	cs = kzalloc(sizeof(struct clk_simple), GFP_KERNEL);
+	if (!cs)
+		return ERR_PTR(-ENOMEM);
+
+	cs->rate = *freq;
+	cs->clk.get_rate = clk_simple_get_rate;
+	cs->clk.put = clk_simple_put;
+
+	return &cs->clk;
+}
+
+static struct clk *__clk_get_from_provider(struct device_node *np, u32 index)
+{
+	struct clk_provider *provider;
+	const char *names, *id = NULL;
+	int sz, l, i;
+	struct clk *clk = NULL;
+
+	/* Look for "clock-output-names" in the provider's node, if it's missing
+	 * we don't bother looking for a clock provider, though we do fallback
+	 * to the "simple" clock case
+	 */
+	names = of_get_property(np, "clock-output-names", &sz);
+	if (!names)
+		return __clk_get_simple(np);
+
+	/* Lookup index */
+	for (i = 0; sz > 0; i++) {
+		if (index == i) {
+			id = names;
+			break;
+		}
+		l = strlen(names) + 1;
+		sz -= l;
+		names += l;
+	}
+	if (id == NULL)
+		return ERR_PTR(-ENXIO);
+
+	/* Check if we have such a provider in our array */
+	mutex_lock(&clk_lock);
+	list_for_each_entry(provider, &clk_providers, link) {
+		if (provider->node == np)
+			clk = provider->get(np, id, provider->data);
+		if (clk)
+			break;
+	}
+	mutex_unlock(&clk_lock);
+
+	/* Clock not found, return an error */
+	if (clk == NULL)
+		clk = ERR_PTR(-EINVAL);
+
+	return clk;
+}
+
+struct clk *of_clk_get(struct device_node *np, const char *id)
+{
+	int sz, l, index = 0;
+	struct device_node *provnode;
+	const u32 *map;
+	u32 provhandle, provindex;
+	struct clk *clk;
+
+	/* look for an id match in clock-names property */
+	if (id) {
+		const char *names = of_get_property(np, "clock-input-names", &sz);
+
+		/* no such property, fail for now. Maybe in the long run we might
+		 * consider allowing "generic" names such as "bus" for the bus
+		 * clock, effectively routing to the parent node...
+		 */
+		if (!names)
+			return ERR_PTR(-ENXIO);
+		while (sz > 0) {
+			if (strcasecmp(id, names) == 0)
+				break;
+			l = strlen(names) + 1;
+			sz -= l;
+			names += l;
+			index++;
+		}
+		if (sz < 1)
+			return ERR_PTR(-ENOENT);
+	}
+
+	/* now we have an index, lookup in clock-map */
+	map = of_get_property(np, "clock-map", &sz);
+	if (!map)
+		return ERR_PTR(-ENXIO);
+	sz /= sizeof(u32) * 2;
+	if (index >= sz)
+		return ERR_PTR(-EINVAL);
+	provhandle = map[index * 2];
+	provindex = map[index * 2] + 1;
+
+	provnode = of_find_node_by_phandle(provhandle);
+	if (!provnode)
+		return ERR_PTR(-EINVAL);
+
+	clk = __clk_get_from_provider(provnode, provindex);
+	of_node_put(provnode);
+
+	return clk;
+}
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (ppc_md.clk_get)
+		return ppc_md.clk_get(dev, id);
+
+	if (dev->archdata.of_node)
+		return of_clk_get(dev->archdata.of_node, id);
+
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL(clk_get);
+
+/*
+ * clk_* API is just wrappers to the function pointers
+ * inside of struct clk
+ */
 
 int clk_enable(struct clk *clk)
 {
-	if (clk_functions.clk_enable)
-		return clk_functions.clk_enable(clk);
-	return -ENOSYS;
+	if (clk->enable)
+		return clk->enable(clk);
+	return 0;
 }
 EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
-	if (clk_functions.clk_disable)
-		clk_functions.clk_disable(clk);
+	if (clk->disable)
+		clk->disable(clk);
 }
 EXPORT_SYMBOL(clk_disable);
 
 unsigned long clk_get_rate(struct clk *clk)
 {
-	if (clk_functions.clk_get_rate)
-		return clk_functions.clk_get_rate(clk);
+	if (clk->get_rate)
+		return clk->get_rate(clk);
 	return 0;
 }
 EXPORT_SYMBOL(clk_get_rate);
 
+void clk_put(struct clk *clk)
+{
+	if (clk->put)
+		clk->put(clk);
+}
+EXPORT_SYMBOL(clk_put);
+
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	if (clk_functions.clk_round_rate)
-		return clk_functions.clk_round_rate(clk, rate);
+	if (clk->round_rate)
+		return clk->round_rate(clk, rate);
 	return -ENOSYS;
 }
 EXPORT_SYMBOL(clk_round_rate);
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	if (clk_functions.clk_set_rate)
-		return clk_functions.clk_set_rate(clk, rate);
+	if (clk->set_rate)
+		return clk->set_rate(clk, rate);
 	return -ENOSYS;
 }
 EXPORT_SYMBOL(clk_set_rate);
 
-struct clk *clk_get_parent(struct clk *clk)
-{
-	if (clk_functions.clk_get_parent)
-		return clk_functions.clk_get_parent(clk);
-	return ERR_PTR(-ENOSYS);
-}
-EXPORT_SYMBOL(clk_get_parent);
-
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
-	if (clk_functions.clk_set_parent)
-		return clk_functions.clk_set_parent(clk, parent);
+	if (clk->set_parent)
+		return clk->set_parent(clk, parent);
 	return -ENOSYS;
 }
 EXPORT_SYMBOL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	if (clk->get_parent)
+		return clk->get_parent(clk);
+	return ERR_PTR(-ENOSYS);
+}
+EXPORT_SYMBOL(clk_get_parent);
Index: linux-work/arch/powerpc/include/asm/clk.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/clk.h	2009-08-18 17:38:08.000000000 +1000
@@ -0,0 +1,61 @@
+/*
+ * Clock infrastructure for PowerPC platform
+ */
+#ifndef __ASM_POWERPC_CLK_H
+#define __ASM_POWERPC_CLK_H
+
+struct device_node;
+
+/* The definition of struct clk for arch/powerpc is global, it's
+ * expected that clock providers generate "subclasses" embedding
+ * struct clk
+ */
+struct clk {
+	int		(*enable)(struct clk *);
+	void		(*disable)(struct clk *);
+	unsigned long	(*get_rate)(struct clk *);
+	void		(*put)(struct clk *);
+	long		(*round_rate)(struct clk *, unsigned long);
+	int		(*set_rate)(struct clk *, unsigned long);
+	int		(*set_parent)(struct clk *, struct clk *);
+	struct clk*	(*get_parent)(struct clk *);
+};
+
+/* The simple clock is exposed here for implementations that want
+ * to re-use it in case they don't need anything else
+ */
+struct clk_simple {
+	struct clk	clk;
+	unsigned long	rate;
+};
+#define	to_clk_simple(n) container_of(n, struct clk_simple, clk)
+
+
+/**
+ * clk_add_provier - Attach a clock provider to a clock source device node
+ * @node: device node of the clock source
+ * @clk_src_get: function pointer called to obtain a struct clk
+ * @data: arbitrary data passed back to clk_src_get() when called
+ *
+ * This will attach the clk_src_get() function to a given device_node,
+ * that function will then be called whenever a drivers does a clk_get()
+ * and that driver's clock-map references that clock source node.
+ */
+extern int clk_add_provider(struct device_node *np,
+			    struct clk *(*clk_src_get)(struct device_node *np,
+						       const char *output_id,
+						       void *data),
+			    void *data);
+/**
+ * clk_del_provier - Remove a clock provider from a clock source device node
+ * @node: device node of the clock source
+ * @clk_src_get: function pointer used in clk_add_provider()
+ * @data: data used in clk_add_provider()
+ */
+extern void clk_del_provider(struct device_node *np,
+			     struct clk *(*clk_src_get)(struct device_node *np,
+							const char *output_id,
+							void *data),
+			     void *data);
+
+#endif /* __ASM_POWERPC_CLK_H */
Index: linux-work/arch/powerpc/include/asm/machdep.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/machdep.h	2009-08-18 17:36:53.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/machdep.h	2009-08-18 17:38:08.000000000 +1000
@@ -27,6 +27,8 @@ struct iommu_table;
 struct rtc_time;
 struct file;
 struct pci_controller;
+struct clk;
+struct device;
 #ifdef CONFIG_KEXEC
 struct kimage;
 #endif
@@ -266,7 +268,11 @@ struct machdep_calls {
 	 */
 	void (*suspend_disable_irqs)(void);
 	void (*suspend_enable_irqs)(void);
-#endif
+#endif /* CONFIG_SUSPEND */
+
+#ifdef CONFIG_PPC_CLOCK
+	struct clk *(*clk_get)(struct device *dev, const char *id);
+#endif /* CONFIG_PPC_CLOCK */
 };
 
 extern void e500_idle(void);
Index: linux-work/arch/powerpc/platforms/512x/clock.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/512x/clock.c	2009-08-18 17:33:15.000000000 +1000
+++ linux-work/arch/powerpc/platforms/512x/clock.c	2009-08-18 17:38:30.000000000 +1000
@@ -25,7 +25,7 @@
 
 #include <linux/of_platform.h>
 #include <asm/mpc5xxx.h>
-#include <asm/clk_interface.h>
+#include <asm/clk.h>
 
 #undef CLK_DEBUG
 
@@ -34,25 +34,28 @@ static int clocks_initialized;
 #define CLK_HAS_RATE	0x1	/* has rate in MHz */
 #define CLK_HAS_CTRL	0x2	/* has control reg and bit */
 
-struct clk {
+struct mpc512x_clk {
+	struct clk clk;
 	struct list_head node;
 	char name[32];
 	int flags;
 	struct device *dev;
 	unsigned long rate;
 	struct module *owner;
-	void (*calc) (struct clk *);
-	struct clk *parent;
+	void (*calc) (struct mpc512x_clk *);
+	struct mpc512x_clk *parent;
 	int reg, bit;		/* CLK_HAS_CTRL */
 	int div_shift;		/* only used by generic_div_clk_calc */
 };
+#define	to_mpc512x_clk(n) container_of(n, struct mpc512x_clk, clk)
 
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
 static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
 {
-	struct clk *p, *clk = ERR_PTR(-ENOENT);
+	struct clk *clk = ERR_PTR(-ENOENT);
+	struct mpc512x_clk *p;
 	int dev_match = 0;
 	int id_match = 0;
 
@@ -66,7 +69,7 @@ static struct clk *mpc5121_clk_get(struc
 		if (strcmp(id, p->name) == 0)
 			id_match++;
 		if ((dev_match || id_match) && try_module_get(p->owner)) {
-			clk = p;
+			clk = &p->clk;
 			break;
 		}
 	}
@@ -78,7 +81,7 @@ static struct clk *mpc5121_clk_get(struc
 #ifdef CLK_DEBUG
 static void dump_clocks(void)
 {
-	struct clk *p;
+	struct mpc512x_clk *p;
 
 	mutex_lock(&clocks_mutex);
 	printk(KERN_INFO "CLOCKS:\n");
@@ -101,7 +104,9 @@ static void dump_clocks(void)
 
 static void mpc5121_clk_put(struct clk *clk)
 {
-	module_put(clk->owner);
+	struct mpc512x_clk *mpclk = to_mpc512x_clk(clk);
+
+	module_put(mpclk->owner);
 }
 
 #define NRPSC 12
@@ -123,31 +128,35 @@ struct mpc512x_clockctl __iomem *clockct
 
 static int mpc5121_clk_enable(struct clk *clk)
 {
+	struct mpc512x_clk *mpclk = to_mpc512x_clk(clk);
 	unsigned int mask;
 
-	if (clk->flags & CLK_HAS_CTRL) {
-		mask = in_be32(&clockctl->sccr[clk->reg]);
-		mask |= 1 << clk->bit;
-		out_be32(&clockctl->sccr[clk->reg], mask);
+	if (mpclk->flags & CLK_HAS_CTRL) {
+		mask = in_be32(&clockctl->sccr[mpclk->reg]);
+		mask |= 1 << mpclk->bit;
+		out_be32(&clockctl->sccr[mpclk->reg], mask);
 	}
 	return 0;
 }
 
 static void mpc5121_clk_disable(struct clk *clk)
 {
+	struct mpc512x_clk *mpclk = to_mpc512x_clk(clk);
 	unsigned int mask;
 
-	if (clk->flags & CLK_HAS_CTRL) {
-		mask = in_be32(&clockctl->sccr[clk->reg]);
-		mask &= ~(1 << clk->bit);
-		out_be32(&clockctl->sccr[clk->reg], mask);
+	if (mpclk->flags & CLK_HAS_CTRL) {
+		mask = in_be32(&clockctl->sccr[mpclk->reg]);
+		mask &= ~(1 << mpclk->bit);
+		out_be32(&clockctl->sccr[mpclk->reg], mask);
 	}
 }
 
 static unsigned long mpc5121_clk_get_rate(struct clk *clk)
 {
-	if (clk->flags & CLK_HAS_RATE)
-		return clk->rate;
+	struct mpc512x_clk *mpclk = to_mpc512x_clk(clk);
+
+	if (mpclk->flags & CLK_HAS_RATE)
+		return mpclk->rate;
 	else
 		return 0;
 }
@@ -162,11 +171,21 @@ static int mpc5121_clk_set_rate(struct c
 	return 0;
 }
 
-static int clk_register(struct clk *clk)
+static int clk_register(struct mpc512x_clk *mpclk)
 {
+	mpclk.clk.enable	= mpc5121_clk_enable;
+	mpclk.clk.disable	= mpc5121_clk_disable;
+	mpclk.clk.get_rate	= mpc5121_clk_get_rate;
+	mpclk.clk.put		= mpc5121_clk_put;
+	mpclk.clk.round_rate	= mpc5121_clk_round_rate;
+	mpclk.clk.set_rate	= mpc5121_clk_set_rate;
+	mpclk.clk.set_paqrent	= NULL;
+	mpclk.clk.get_parent	= NULL;
+
 	mutex_lock(&clocks_mutex);
-	list_add(&clk->node, &clocks);
+	list_add(&mpclk->node, &clocks);
 	mutex_unlock(&clocks_mutex);
+
 	return 0;
 }
 
@@ -250,7 +269,7 @@ static unsigned long devtree_getfreq(cha
 	return val;
 }
 
-static void ref_clk_calc(struct clk *clk)
+static void ref_clk_calc(struct mpc512x_clk *mpclk)
 {
 	unsigned long rate;
 
@@ -260,26 +279,26 @@ static void ref_clk_calc(struct clk *clk
 		clk->rate = 0;
 		return;
 	}
-	clk->rate = ips_to_ref(rate);
+	mpclk->rate = ips_to_ref(rate);
 }
 
-static struct clk ref_clk = {
+static struct mpc512x_clk ref_clk = {
 	.name = "ref_clk",
 	.calc = ref_clk_calc,
 };
 
 
-static void sys_clk_calc(struct clk *clk)
+static void sys_clk_calc(struct mpc512x_clk *clk)
 {
 	clk->rate = ref_to_sys(ref_clk.rate);
 }
 
-static struct clk sys_clk = {
+static struct mpc512x_clk sys_clk = {
 	.name = "sys_clk",
 	.calc = sys_clk_calc,
 };
 
-static void diu_clk_calc(struct clk *clk)
+static void diu_clk_calc(struct mpc512x_clk *clk)
 {
 	int diudiv_x_2 = clockctl->scfr1 & 0xff;
 	unsigned long rate;
@@ -292,30 +311,30 @@ static void diu_clk_calc(struct clk *clk
 	clk->rate = rate;
 }
 
-static void half_clk_calc(struct clk *clk)
+static void half_clk_calc(struct mpc512x_clk *clk)
 {
 	clk->rate = clk->parent->rate / 2;
 }
 
-static void generic_div_clk_calc(struct clk *clk)
+static void generic_div_clk_calc(struct mpc512x_clk *clk)
 {
 	int div = (clockctl->scfr1 >> clk->div_shift) & 0x7;
 
 	clk->rate = clk->parent->rate / div;
 }
 
-static void unity_clk_calc(struct clk *clk)
+static void unity_clk_calc(struct mpc512x_clk *clk)
 {
 	clk->rate = clk->parent->rate;
 }
 
-static struct clk csb_clk = {
+static struct mpc512x_clk csb_clk = {
 	.name = "csb_clk",
 	.calc = half_clk_calc,
 	.parent = &sys_clk,
 };
 
-static void e300_clk_calc(struct clk *clk)
+static void e300_clk_calc(struct mpc512x_clk *clk)
 {
 	int spmf = (clockctl->spmr >> 16) & 0xf;
 	int ratex2 = clk->parent->rate * spmf;
@@ -323,13 +342,13 @@ static void e300_clk_calc(struct clk *cl
 	clk->rate = ratex2 / 2;
 }
 
-static struct clk e300_clk = {
+static struct mpc512x_clk e300_clk = {
 	.name = "e300_clk",
 	.calc = e300_clk_calc,
 	.parent = &csb_clk,
 };
 
-static struct clk ips_clk = {
+static struct mpc512x_clk ips_clk = {
 	.name = "ips_clk",
 	.calc = generic_div_clk_calc,
 	.parent = &csb_clk,
@@ -339,7 +358,7 @@ static struct clk ips_clk = {
 /*
  * Clocks controlled by SCCR1 (.reg = 0)
  */
-static struct clk lpc_clk = {
+static struct mpc512x_clk lpc_clk = {
 	.name = "lpc_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 0,
@@ -349,7 +368,7 @@ static struct clk lpc_clk = {
 	.div_shift = 11,
 };
 
-static struct clk nfc_clk = {
+static struct mpc512x_clk nfc_clk = {
 	.name = "nfc_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 0,
@@ -359,7 +378,7 @@ static struct clk nfc_clk = {
 	.div_shift = 8,
 };
 
-static struct clk pata_clk = {
+static struct mpc512x_clk pata_clk = {
 	.name = "pata_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 0,
@@ -373,7 +392,7 @@ static struct clk pata_clk = {
  * are setup elsewhere
  */
 
-static struct clk sata_clk = {
+static struct mpc512x_clk sata_clk = {
 	.name = "sata_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 0,
@@ -382,7 +401,7 @@ static struct clk sata_clk = {
 	.parent = &ips_clk,
 };
 
-static struct clk fec_clk = {
+static struct mpc512x_clk fec_clk = {
 	.name = "fec_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 0,
@@ -391,7 +410,7 @@ static struct clk fec_clk = {
 	.parent = &ips_clk,
 };
 
-static struct clk pci_clk = {
+static struct mpc512x_clk pci_clk = {
 	.name = "pci_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 0,
@@ -404,7 +423,7 @@ static struct clk pci_clk = {
 /*
  * Clocks controlled by SCCR2 (.reg = 1)
  */
-static struct clk diu_clk = {
+static struct mpc512x_clk diu_clk = {
 	.name = "diu_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -412,7 +431,7 @@ static struct clk diu_clk = {
 	.calc = diu_clk_calc,
 };
 
-static struct clk axe_clk = {
+static struct mpc512x_clk axe_clk = {
 	.name = "axe_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -421,7 +440,7 @@ static struct clk axe_clk = {
 	.parent = &csb_clk,
 };
 
-static struct clk usb1_clk = {
+static struct mpc512x_clk usb1_clk = {
 	.name = "usb1_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -430,7 +449,7 @@ static struct clk usb1_clk = {
 	.parent = &csb_clk,
 };
 
-static struct clk usb2_clk = {
+static struct mpc512x_clk usb2_clk = {
 	.name = "usb2_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -439,7 +458,7 @@ static struct clk usb2_clk = {
 	.parent = &csb_clk,
 };
 
-static struct clk i2c_clk = {
+static struct mpc512x_clk i2c_clk = {
 	.name = "i2c_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -448,7 +467,7 @@ static struct clk i2c_clk = {
 	.parent = &ips_clk,
 };
 
-static struct clk mscan_clk = {
+static struct mpc512x_clk mscan_clk = {
 	.name = "mscan_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -457,7 +476,7 @@ static struct clk mscan_clk = {
 	.parent = &ips_clk,
 };
 
-static struct clk sdhc_clk = {
+static struct mpc512x_clk sdhc_clk = {
 	.name = "sdhc_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -466,7 +485,7 @@ static struct clk sdhc_clk = {
 	.parent = &ips_clk,
 };
 
-static struct clk mbx_bus_clk = {
+static struct mpc512x_clk mbx_bus_clk = {
 	.name = "mbx_bus_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -475,7 +494,7 @@ static struct clk mbx_bus_clk = {
 	.parent = &csb_clk,
 };
 
-static struct clk mbx_clk = {
+static struct mpc512x_clk mbx_clk = {
 	.name = "mbx_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -484,7 +503,7 @@ static struct clk mbx_clk = {
 	.parent = &csb_clk,
 };
 
-static struct clk mbx_3d_clk = {
+static struct mpc512x_clk mbx_3d_clk = {
 	.name = "mbx_3d_clk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
@@ -494,44 +513,44 @@ static struct clk mbx_3d_clk = {
 	.div_shift = 14,
 };
 
-static void psc_mclk_in_calc(struct clk *clk)
+static void psc_mclk_in_calc(struct mpc512x_clk *clk)
 {
 	clk->rate = devtree_getfreq("psc_mclk_in");
 	if (!clk->rate)
 		clk->rate = 25000000;
 }
 
-static struct clk psc_mclk_in = {
+static struct mpc512x_clk psc_mclk_in = {
 	.name = "psc_mclk_in",
 	.calc = psc_mclk_in_calc,
 };
 
-static struct clk spdif_txclk = {
+static struct mpc512x_clk spdif_txclk = {
 	.name = "spdif_txclk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
 	.bit = 23,
 };
 
-static struct clk spdif_rxclk = {
+static struct mpc512x_clk spdif_rxclk = {
 	.name = "spdif_rxclk",
 	.flags = CLK_HAS_CTRL,
 	.reg = 1,
 	.bit = 23,
 };
 
-static void ac97_clk_calc(struct clk *clk)
+static void ac97_clk_calc(struct mpc512x_clk *clk)
 {
 	/* ac97 bit clock is always 24.567 MHz */
 	clk->rate = 24567000;
 }
 
-static struct clk ac97_clk = {
+static struct mpc512x_clk ac97_clk = {
 	.name = "ac97_clk_in",
 	.calc = ac97_clk_calc,
 };
 
-struct clk *rate_clks[] = {
+struct mpc512x_clk *rate_clks[] = {
 	&ref_clk,
 	&sys_clk,
 	&diu_clk,
@@ -560,7 +579,7 @@ struct clk *rate_clks[] = {
 	NULL
 };
 
-static void rate_clk_init(struct clk *clk)
+static void rate_clk_init(struct mpc512x_clk *clk)
 {
 	if (clk->calc) {
 		clk->calc(clk);
@@ -575,7 +594,7 @@ static void rate_clk_init(struct clk *cl
 
 static void rate_clks_init(void)
 {
-	struct clk **cpp, *clk;
+	struct mpc512x_clk **cpp, *clk;
 
 	cpp = rate_clks;
 	while ((clk = *cpp++))
@@ -586,16 +605,16 @@ static void rate_clks_init(void)
  * There are two clk enable registers with 32 enable bits each
  * psc clocks and device clocks are all stored in dev_clks
  */
-struct clk dev_clks[2][32];
+struct mpc512x_clk dev_clks[2][32];
 
 /*
  * Given a psc number return the dev_clk
  * associated with it
  */
-static struct clk *psc_dev_clk(int pscnum)
+static struct mpc512x_clk *psc_dev_clk(int pscnum)
 {
 	int reg, bit;
-	struct clk *clk;
+	struct mpc512x_clk *clk;
 
 	reg = 0;
 	bit = 27 - pscnum;
@@ -609,7 +628,7 @@ static struct clk *psc_dev_clk(int pscnu
 /*
  * PSC clock rate calculation
  */
-static void psc_calc_rate(struct clk *clk, int pscnum, struct device_node *np)
+static void psc_calc_rate(struct mpc512x_clk *clk, int pscnum, struct device_node *np)
 {
 	unsigned long mclk_src = sys_clk.rate;
 	unsigned long mclk_div;
@@ -666,7 +685,7 @@ static void psc_clks_init(void)
 		cell_index = of_get_property(np, "cell-index", NULL);
 		if (cell_index) {
 			int pscnum = *cell_index;
-			struct clk *clk = psc_dev_clk(pscnum);
+			struct mpc512x_clk *clk = psc_dev_clk(pscnum);
 
 			clk->flags = CLK_HAS_RATE | CLK_HAS_CTRL;
 			ofdev = of_find_device_by_node(np);
@@ -686,18 +705,6 @@ static void psc_clks_init(void)
 	}
 }
 
-static struct clk_interface mpc5121_clk_functions = {
-	.clk_get		= mpc5121_clk_get,
-	.clk_enable		= mpc5121_clk_enable,
-	.clk_disable		= mpc5121_clk_disable,
-	.clk_get_rate		= mpc5121_clk_get_rate,
-	.clk_put		= mpc5121_clk_put,
-	.clk_round_rate		= mpc5121_clk_round_rate,
-	.clk_set_rate		= mpc5121_clk_set_rate,
-	.clk_set_parent		= NULL,
-	.clk_get_parent		= NULL,
-};
-
 static int
 mpc5121_clk_init(void)
 {
@@ -721,7 +728,7 @@ mpc5121_clk_init(void)
 	/*iounmap(clockctl); */
 	DEBUG_CLK_DUMP();
 	clocks_initialized++;
-	clk_functions = mpc5121_clk_functions;
+	ppc_md.clk_get = mpc5121_clk_get;
 	return 0;
 }
 
