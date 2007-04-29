Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 361FDDDF28
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 16:28:39 +1000 (EST)
Date: Sun, 29 Apr 2007 16:29:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] get_property cleanups
Message-Id: <20070429162908.c8bffbec.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just another pass through arch/powerpc for old usages.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/ras.c         |    4 ++--
 arch/powerpc/platforms/pasemi/cpufreq.c   |   11 ++++++-----
 arch/powerpc/platforms/pasemi/gpio_mdio.c |    6 +++---
 arch/powerpc/sysdev/uic.c                 |    8 ++++----
 4 files changed, 15 insertions(+), 14 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/cell/ras.c b/arch/powerpc/platforms/cell/ras.c
index b5ebc91..3961a08 100644
--- a/arch/powerpc/platforms/cell/ras.c
+++ b/arch/powerpc/platforms/cell/ras.c
@@ -149,7 +149,7 @@ static int __init cbe_ptcal_enable(void)
 	if (!np)
 		return -ENODEV;
 
-	size = get_property(np, "ibm,cbe-ptcal-size", NULL);
+	size = of_get_property(np, "ibm,cbe-ptcal-size", NULL);
 	if (!size)
 		return -ENODEV;
 
@@ -168,7 +168,7 @@ static int __init cbe_ptcal_enable(void)
 
 	/* support for older device tree - use cpu nodes */
 	for_each_node_by_type(np, "cpu") {
-		const u32 *nid = get_property(np, "node-id", NULL);
+		const u32 *nid = of_get_property(np, "node-id", NULL);
 		if (!nid) {
 			printk(KERN_ERR "%s: node %s is missing node-id?\n",
 					__FUNCTION__, np->full_name);
diff --git a/arch/powerpc/platforms/pasemi/cpufreq.c b/arch/powerpc/platforms/pasemi/cpufreq.c
index 4dd5c51..2a57d60 100644
--- a/arch/powerpc/platforms/pasemi/cpufreq.c
+++ b/arch/powerpc/platforms/pasemi/cpufreq.c
@@ -134,7 +134,8 @@ void restore_astate(int cpu)
 
 static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	u32 *max_freq;
+	const u32 *max_freqp;
+	u32 max_freq;
 	int i, cur_astate;
 	struct resource res;
 	struct device_node *cpu, *dn;
@@ -175,16 +176,16 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
 
-	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
-	if (!max_freq) {
+	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
+	if (!max_freqp) {
 		err = -EINVAL;
 		goto out_unmap_sdcpwr;
 	}
 
 	/* we need the freq in kHz */
-	*max_freq /= 1000;
+	max_freq = *max_freqp / 1000;
 
-	pr_debug("max clock-frequency is at %u kHz\n", *max_freq);
+	pr_debug("max clock-frequency is at %u kHz\n", max_freq);
 	pr_debug("initializing frequency table\n");
 
 	/* initialize frequency table */
diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index b1d3b6b..c91a335 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -258,7 +258,7 @@ static int __devinit gpio_mdio_probe(struct of_device *ofdev,
 	new_bus->write = &gpio_mdio_write,
 	new_bus->reset = &gpio_mdio_reset,
 
-	prop = get_property(np, "reg", NULL);
+	prop = of_get_property(np, "reg", NULL);
 	new_bus->id = *prop;
 	new_bus->priv = priv;
 
@@ -269,10 +269,10 @@ static int __devinit gpio_mdio_probe(struct of_device *ofdev,
 		new_bus->irq[i] = irq_create_mapping(NULL, 10);
 
 
-	prop = get_property(np, "mdc-pin", NULL);
+	prop = of_get_property(np, "mdc-pin", NULL);
 	priv->mdc_pin = *prop;
 
-	prop = get_property(np, "mdio-pin", NULL);
+	prop = of_get_property(np, "mdio-pin", NULL);
 	priv->mdio_pin = *prop;
 
 	new_bus->dev = dev;
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index cdbe684..968fb40 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -230,7 +230,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	memset(uic, 0, sizeof(*uic));
 	spin_lock_init(&uic->lock);
 	uic->of_node = of_node_get(node);
-	indexp = get_property(node, "cell-index", &len);
+	indexp = of_get_property(node, "cell-index", &len);
 	if (!indexp || (len != sizeof(u32))) {
 		printk(KERN_ERR "uic: Device node %s has missing or invalid "
 		       "cell-index property\n", node->full_name);
@@ -238,7 +238,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	}
 	uic->index = *indexp;
 
-	dcrreg = get_property(node, "dcr-reg", &len);
+	dcrreg = of_get_property(node, "dcr-reg", &len);
 	if (!dcrreg || (len != 2*sizeof(u32))) {
 		printk(KERN_ERR "uic: Device node %s has missing or invalid "
 		       "dcr-reg property\n", node->full_name);
@@ -278,7 +278,7 @@ void __init uic_init_tree(void)
 
 	np = of_find_compatible_node(NULL, NULL, "ibm,uic");
 	while (np) {
-		interrupts = get_property(np, "interrupts", NULL);
+		interrupts = of_get_property(np, "interrupts", NULL);
 		if (! interrupts)
 			break;
 
@@ -297,7 +297,7 @@ void __init uic_init_tree(void)
 	/* The scan again for cascaded UICs */
 	np = of_find_compatible_node(NULL, NULL, "ibm,uic");
 	while (np) {
-		interrupts = get_property(np, "interrupts", NULL);
+		interrupts = of_get_property(np, "interrupts", NULL);
 		if (interrupts) {
 			/* Secondary UIC */
 			int cascade_virq;
-- 
1.5.1.2
