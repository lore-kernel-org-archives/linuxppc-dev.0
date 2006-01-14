Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix Maple build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 16:35:35 +1100
Message-Id: <1137216935.4854.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The changes to the device node structure broke Maple build. This fixes it.
Unfortunately I coudn't test as my Maple board appears to be dead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/maple/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/pci.c	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/maple/pci.c	2006-01-14 15:44:38.000000000 +1100
@@ -316,7 +316,6 @@ static int __init add_bridge(struct devi
 	char* disp_name;
 	int *bus_range;
 	int primary = 1;
-	struct property *of_prop;
 
 	DBG("Adding PCI host bridge %s\n", dev->full_name);
 
Index: linux-work/arch/powerpc/platforms/maple/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/setup.c	2006-01-14 15:37:50.000000000 +1100
+++ linux-work/arch/powerpc/platforms/maple/setup.c	2006-01-14 15:49:03.000000000 +1100
@@ -71,38 +71,60 @@
 #define DBG(fmt...)
 #endif
 
+static unsigned long maple_find_nvram_base(void)
+{
+	struct device_node *rtcs;
+	unsigned long result = 0;
+
+	/* find NVRAM device */
+	rtcs = of_find_compatible_node(NULL, "nvram", "AMD8111");
+	if (rtcs) {
+		struct resource r;
+		if (of_address_to_resource(rtcs, 0, &r)) {
+			printk(KERN_EMERG "Maple: Unable to translate NVRAM"
+			       " address\n");
+			goto bail;
+		}
+		if (!(r.flags & IORESOURCE_IO)) {
+			printk(KERN_EMERG "Maple: NVRAM address isn't PIO!\n");
+			goto bail;
+		}
+		result = r.start;
+	} else
+		printk(KERN_EMERG "Maple: Unable to find NVRAM\n");
+ bail:
+	of_node_put(rtcs);
+	return result;
+}
+
 static void maple_restart(char *cmd)
 {
 	unsigned int maple_nvram_base;
 	unsigned int maple_nvram_offset;
 	unsigned int maple_nvram_command;
-	struct device_node *rtcs;
+	struct device_node *sp;
 
-	/* find NVRAM device */
-	rtcs = find_compatible_devices("nvram", "AMD8111");
-	if (rtcs && rtcs->addrs) {
-		maple_nvram_base = rtcs->addrs[0].address;
-	} else {
-		printk(KERN_EMERG "Maple: Unable to find NVRAM\n");
-		printk(KERN_EMERG "Maple: Manual Restart Required\n");
-		return;
-	}
+	maple_nvram_base = maple_find_nvram_base();
+	if (maple_nvram_base == 0)
+		goto fail;
 
 	/* find service processor device */
-	rtcs = find_devices("service-processor");
-	if (!rtcs) {
+	sp = of_find_node_by_name(NULL, "service-processor");
+	if (!sp) {
 		printk(KERN_EMERG "Maple: Unable to find Service Processor\n");
-		printk(KERN_EMERG "Maple: Manual Restart Required\n");
-		return;
+		goto fail;
 	}
-	maple_nvram_offset = *(unsigned int*) get_property(rtcs,
+	maple_nvram_offset = *(unsigned int*) get_property(sp,
 			"restart-addr", NULL);
-	maple_nvram_command = *(unsigned int*) get_property(rtcs,
+	maple_nvram_command = *(unsigned int*) get_property(sp,
 			"restart-value", NULL);
+	of_node_put(sp);
 
 	/* send command */
 	outb_p(maple_nvram_command, maple_nvram_base + maple_nvram_offset);
 	for (;;) ;
+ fail:
+	printk(KERN_EMERG "Maple: Manual Restart Required\n");
 }
 
 static void maple_power_off(void)
@@ -110,33 +132,29 @@ static void maple_power_off(void)
 	unsigned int maple_nvram_base;
 	unsigned int maple_nvram_offset;
 	unsigned int maple_nvram_command;
-	struct device_node *rtcs;
+	struct device_node *sp;
 
-	/* find NVRAM device */
-	rtcs = find_compatible_devices("nvram", "AMD8111");
-	if (rtcs && rtcs->addrs) {
-		maple_nvram_base = rtcs->addrs[0].address;
-	} else {
-		printk(KERN_EMERG "Maple: Unable to find NVRAM\n");
-		printk(KERN_EMERG "Maple: Manual Power-Down Required\n");
-		return;
-	}
+	maple_nvram_base = maple_find_nvram_base();
+	if (maple_nvram_base == 0)
+		goto fail;
 
 	/* find service processor device */
-	rtcs = find_devices("service-processor");
-	if (!rtcs) {
+	sp = of_find_node_by_name(NULL, "service-processor");
+	if (!sp) {
 		printk(KERN_EMERG "Maple: Unable to find Service Processor\n");
-		printk(KERN_EMERG "Maple: Manual Power-Down Required\n");
-		return;
+		goto fail;
 	}
-	maple_nvram_offset = *(unsigned int*) get_property(rtcs,
+	maple_nvram_offset = *(unsigned int*) get_property(sp,
 			"power-off-addr", NULL);
-	maple_nvram_command = *(unsigned int*) get_property(rtcs,
+	maple_nvram_command = *(unsigned int*) get_property(sp,
 			"power-off-value", NULL);
+	of_node_put(sp);
 
 	/* send command */
 	outb_p(maple_nvram_command, maple_nvram_base + maple_nvram_offset);
 	for (;;) ;
+ fail:
+	printk(KERN_EMERG "Maple: Manual Power-Down Required\n");
 }
 
 static void maple_halt(void)
@@ -179,9 +197,6 @@ void __init maple_setup_arch(void)
  */
 static void __init maple_init_early(void)
 {
-	unsigned int default_speed;
-	u64 physport;
-
 	DBG(" -> maple_init_early\n");
 
 	/* Initialize hash table, from now on, we can take hash faults
Index: linux-work/arch/powerpc/platforms/maple/time.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/time.c	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/maple/time.c	2006-01-14 15:52:29.000000000 +1100
@@ -168,11 +168,24 @@ unsigned long __init maple_get_boot_time
 	struct rtc_time tm;
 	struct device_node *rtcs;
 
-	rtcs = find_compatible_devices("rtc", "pnpPNP,b00");
-	if (rtcs && rtcs->addrs) {
-		maple_rtc_addr = rtcs->addrs[0].address;
-		printk(KERN_INFO "Maple: Found RTC at 0x%x\n", maple_rtc_addr);
-	} else {
+	rtcs = of_find_compatible_node(NULL, "rtc", "pnpPNP,b00");
+	if (rtcs) {
+		struct resource r;
+		if (of_address_to_resource(rtcs, 0, &r)) {
+			printk(KERN_EMERG "Maple: Unable to translate RTC"
+			       " address\n");
+			goto bail;
+		}
+		if (!(r.flags & IORESOURCE_IO)) {
+			printk(KERN_EMERG "Maple: RTC address isn't PIO!\n");
+			goto bail;
+		}
+		maple_rtc_addr = r.start;
+		printk(KERN_INFO "Maple: Found RTC at IO 0x%x\n",
+		       maple_rtc_addr);
+	}
+ bail:
+	if (maple_rtc_addr == 0) {
 		maple_rtc_addr = RTC_PORT(0); /* legacy address */
 		printk(KERN_INFO "Maple: No device node for RTC, assuming "
 		       "legacy address (0x%x)\n", maple_rtc_addr);
 
