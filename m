Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F2EC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:15:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BAB2086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BAB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xXbS3sLGzF36j
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 09:15:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xXW50pF2zF36j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 09:11:13 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id c206so15360741oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 14:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JIxdelAB7EuF88a5UdD4tgWq3Mk5wKSd6dZ9xl1Mu8U=;
 b=be7LlU+uzSTHrCgZIJiF4U1nK3XGgiE/21+ivwTHM+tCOhhiRiHrCMLtecOgXD3Hm6
 LeDge+ZiSL9AeeCppxt65kAyKEHOTGn7aatfaso0xwwmqLzmF+LMerqJ6woRFrFZMvuv
 hOAi1800dy7PTeFKVB5iaBSxAnUxTxAvpEyuY3QgEOBoUsBgLP40nKjm0nWhxfjEuNZU
 /zw5pDmnbbqzgQ3nv9Zti6j4B4J93upPawhKEzSrvV1KN3s9p3A9X8+lTJJoPYW9N/9u
 +JfCIv9Hh2TeufiW2QlufrpC2HPIMJnzJssIe0Lsr0ZBxRTB1gRxrkCXPVy+77fc4m+y
 bMKw==
X-Gm-Message-State: AGRZ1gLcdY+7VaDPmMAXCsoRNo2oAmfFYgtcKPVeZmjUwyzdqQKeYn9P
 R4U+Ap7fCZ79Q4pQDq0cBq8cE8obmg==
X-Google-Smtp-Source: AJdET5d8sIt8hkqcp6u8l/xU58hwAy68fdFSMOgRLHfkWDXIiKwC23Z+k1S0OvMO8Fde5+UZmxTM8Q==
X-Received: by 2002:aca:570a:: with SMTP id l10mr1912135oib.305.1542406270971; 
 Fri, 16 Nov 2018 14:11:10 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net.
 [166.173.57.127]) by smtp.googlemail.com with ESMTPSA id
 p204-v6sm12142631oib.25.2018.11.16.14.11.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Nov 2018 14:11:10 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Use device_type helpers to access the node type
Date: Fri, 16 Nov 2018 16:11:00 -0600
Message-Id: <20181116221104.23024-4-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Replace the open coded iterating over child nodes with
for_each_child_of_node() while we're here.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/kernel/cacheinfo.c               |  2 +-
 arch/powerpc/kernel/isa-bridge.c              |  3 +--
 arch/powerpc/kernel/legacy_serial.c           |  5 ++--
 arch/powerpc/kernel/pci_of_scan.c             | 11 +++-----
 arch/powerpc/kernel/setup-common.c            |  2 +-
 arch/powerpc/mm/numa.c                        |  2 +-
 arch/powerpc/platforms/4xx/pci.c              |  6 ++---
 arch/powerpc/platforms/cell/cbe_regs.c        |  6 ++---
 arch/powerpc/platforms/cell/setup.c           |  3 +--
 arch/powerpc/platforms/chrp/pci.c             |  6 ++---
 arch/powerpc/platforms/chrp/setup.c           |  5 +---
 arch/powerpc/platforms/maple/pci.c            |  6 ++---
 arch/powerpc/platforms/powermac/low_i2c.c     |  7 +++--
 arch/powerpc/platforms/powermac/pic.c         |  2 +-
 arch/powerpc/platforms/powermac/udbg_adb.c    |  2 +-
 .../platforms/pseries/hotplug-memory.c        |  8 ++----
 arch/powerpc/platforms/pseries/setup.c        | 10 +++----
 arch/powerpc/platforms/pseries/vio.c          | 27 +++++++++----------
 18 files changed, 45 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index be57bd07596d..53102764fd2f 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -428,7 +428,7 @@ static void link_cache_lists(struct cache *smaller, struct cache *bigger)
 static void do_subsidiary_caches_debugcheck(struct cache *cache)
 {
 	WARN_ON_ONCE(cache->level != 1);
-	WARN_ON_ONCE(strcmp(cache->ofnode->type, "cpu"));
+	WARN_ON_ONCE(!of_node_is_type(cache->ofnode, "cpu"));
 }
 
 static void do_subsidiary_caches(struct cache *cache)
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index fda3ae48480c..0e7099da4f25 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -327,8 +327,7 @@ static int isa_bridge_notify(struct notifier_block *nb, unsigned long action,
 		/* Check if we have no ISA device, and this happens to be one,
 		 * register it as such if it has an OF device
 		 */
-		if (!isa_bridge_devnode && devnode && devnode->type &&
-		    !strcmp(devnode->type, "isa"))
+		if (!isa_bridge_devnode && of_node_is_type(devnode, "isa"))
 			isa_bridge_find_late(pdev, devnode);
 
 		return 0;
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 33b34a58fc62..2a6f339e92cd 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -192,7 +192,7 @@ static int __init add_legacy_soc_port(struct device_node *np,
 	/* Add port, irq will be dealt with later. We passed a translated
 	 * IO port value. It will be fixed up later along with the irq
 	 */
-	if (tsi && !strcmp(tsi->type, "tsi-bridge"))
+	if (of_node_is_type(tsi, "tsi-bridge"))
 		return add_legacy_port(np, -1, UPIO_TSI, addr, addr,
 				       0, legacy_port_flags, 0);
 	else
@@ -417,7 +417,8 @@ void __init find_legacy_serial_ports(void)
 			of_node_put(parent);
 			continue;
 		}
-		if (strcmp(np->name, "serial") && strcmp(np->type, "serial")) {
+		if (strcmp(np->name, "serial") &&
+		    !of_node_is_type(np, "serial")) {
 			of_node_put(parent);
 			continue;
 		}
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 98f04725def7..24191ea2d9a7 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -125,16 +125,13 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 				 struct pci_bus *bus, int devfn)
 {
 	struct pci_dev *dev;
-	const char *type;
 
 	dev = pci_alloc_dev(bus);
 	if (!dev)
 		return NULL;
-	type = of_get_property(node, "device_type", NULL);
-	if (type == NULL)
-		type = "";
 
-	pr_debug("    create device, devfn: %x, type: %s\n", devfn, type);
+	pr_debug("    create device, devfn: %x, type: %s\n", devfn,
+		 of_node_get_device_type(node));
 
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.parent = bus->bridge;
@@ -167,12 +164,12 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 
-	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
+	if (of_node_is_type(node, "pci") || of_node_is_type(node, "pciex")) {
 		/* a PCI-PCI bridge */
 		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
 		dev->rom_base_reg = PCI_ROM_ADDRESS1;
 		set_pcie_hotplug_bridge(dev);
-	} else if (!strcmp(type, "cardbus")) {
+	} else if (of_node_is_type(node, "cardbus")) {
 		dev->hdr_type = PCI_HEADER_TYPE_CARDBUS;
 	} else {
 		dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 93ee3703b42f..4a6d6e866be7 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -687,7 +687,7 @@ int check_legacy_ioport(unsigned long base_port)
 		return ret;
 	parent = of_get_parent(np);
 	if (parent) {
-		if (strcmp(parent->type, "isa") == 0)
+		if (of_node_is_type(parent, "isa"))
 			ret = 0;
 		of_node_put(parent);
 	}
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3a048e98a132..2b8a6e72a5a2 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1475,7 +1475,7 @@ static int dt_update_callback(struct notifier_block *nb,
 
 	switch (action) {
 	case OF_RECONFIG_UPDATE_PROPERTY:
-		if (!of_prop_cmp(update->dn->type, "cpu") &&
+		if (of_node_is_type(update->dn, "cpu") &&
 		    !of_prop_cmp(update->prop->name, "ibm,associativity")) {
 			u32 core_id;
 			of_property_read_u32(update->dn, "reg", &core_id);
diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx/pci.c
index 5aca523551ae..d0825f5c5b1b 100644
--- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -2081,7 +2081,6 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
 	const u32 *pval;
 	int portno;
 	unsigned int dcrs;
-	const char *val;
 
 	/* First, proceed to core initialization as we assume there's
 	 * only one PCIe core in the system
@@ -2127,10 +2126,9 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
 	 * Resulting from this setup this PCIe port will be configured
 	 * as root-complex or as endpoint.
 	 */
-	val = of_get_property(port->node, "device_type", NULL);
-	if (!strcmp(val, "pci-endpoint")) {
+	if (of_node_is_type(port->node, "pci-endpoint")) {
 		port->endpoint = 1;
-	} else if (!strcmp(val, "pci")) {
+	} else if (of_node_is_type(port->node, "pci")) {
 		port->endpoint = 0;
 	} else {
 		printk(KERN_ERR "PCIE: missing or incorrect device_type for %pOF\n",
diff --git a/arch/powerpc/platforms/cell/cbe_regs.c b/arch/powerpc/platforms/cell/cbe_regs.c
index b926438d73af..27ee65b89099 100644
--- a/arch/powerpc/platforms/cell/cbe_regs.c
+++ b/arch/powerpc/platforms/cell/cbe_regs.c
@@ -53,7 +53,7 @@ static struct cbe_regs_map *cbe_find_map(struct device_node *np)
 	int i;
 	struct device_node *tmp_np;
 
-	if (strcasecmp(np->type, "spe")) {
+	if (!of_node_is_type(np, "spe")) {
 		for (i = 0; i < cbe_regs_map_count; i++)
 			if (cbe_regs_maps[i].cpu_node == np ||
 			    cbe_regs_maps[i].be_node == np)
@@ -70,8 +70,8 @@ static struct cbe_regs_map *cbe_find_map(struct device_node *np)
 		tmp_np = tmp_np->parent;
 		/* on a correct devicetree we wont get up to root */
 		BUG_ON(!tmp_np);
-	} while (strcasecmp(tmp_np->type, "cpu") &&
-		 strcasecmp(tmp_np->type, "be"));
+	} while (!of_node_is_type(tmp_np, "cpu") ||
+		 !of_node_is_type(tmp_np, "be"));
 
 	np->data = cbe_find_map(tmp_np);
 
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 7d31b8d14661..902d527d043f 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -168,8 +168,7 @@ static int __init cell_publish_devices(void)
 	 * platform devices for the PCI host bridges
 	 */
 	for_each_child_of_node(root, np) {
-		if (np->type == NULL || (strcmp(np->type, "pci") != 0 &&
-					 strcmp(np->type, "pciex") != 0))
+		if (!of_node_is_type(np, "pci") && !of_node_is_type(np, "pciex"))
 			continue;
 		of_platform_device_create(np, NULL, NULL);
 	}
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 5ddb57b82921..9630fd340abf 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -175,7 +175,7 @@ setup_python(struct pci_controller *hose, struct device_node *dev)
 
 	/* Clear the magic go-slow bit */
 	reg = ioremap(r.start + 0xf6000, 0x40);
-	BUG_ON(!reg); 
+	BUG_ON(!reg);
 	val = in_be32(&reg[12]);
 	if (val & PRG_CL_RESET_VALID) {
 		out_be32(&reg[12], val & ~PRG_CL_RESET_VALID);
@@ -230,8 +230,8 @@ chrp_find_bridges(void)
 		else if (strncmp(machine, "Pegasos", 7) == 0)
 			is_pegasos = 1;
 	}
-	for (dev = root->child; dev != NULL; dev = dev->sibling) {
-		if (dev->type == NULL || strcmp(dev->type, "pci") != 0)
+	for_each_child_of_node(root, dev) {
+		if (!of_node_is_type(dev, "pci"))
 			continue;
 		++index;
 		/* The GG2 bridge on the LongTrail doesn't have an address */
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index d6d8ffc0271e..3c21f046e20c 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -280,10 +280,7 @@ static __init void chrp_init(void)
 	node = of_find_node_by_path(property);
 	if (!node)
 		return;
-	property = of_get_property(node, "device_type", NULL);
-	if (!property)
-		goto out_put;
-	if (strcmp(property, "serial"))
+	if (!of_node_is_type(node, "serial"))
 		goto out_put;
 	/*
 	 * The 9pin connector is either /failsafe
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index e3821379e86f..13fba004b7e7 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -604,10 +604,8 @@ void __init maple_pci_init(void)
 		printk(KERN_CRIT "maple_find_bridges: can't find root of device tree\n");
 		return;
 	}
-	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;) {
-		if (!np->type)
-			continue;
-		if (strcmp(np->type, "pci") && strcmp(np->type, "ht"))
+	for_each_child_of_node(root, np) {
+		if (!of_node_is_type(np, "pci") && !of_node_is_type(np, "ht"))
 			continue;
 		if ((of_device_is_compatible(np, "u4-pcie") ||
 		     of_device_is_compatible(np, "u3-agp")) &&
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index d4d411820597..84bace3b546a 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -917,10 +917,9 @@ static void __init smu_i2c_probe(void)
 	 * type as older device trees mix i2c busses and other things
 	 * at the same level
 	 */
-	for (busnode = NULL;
-	     (busnode = of_get_next_child(controller, busnode)) != NULL;) {
-		if (strcmp(busnode->type, "i2c") &&
-		    strcmp(busnode->type, "i2c-bus"))
+	for_each_child_of_node(controller, busnode) {
+		if (!of_node_is_type(busnode, "i2c") &&
+		    !of_node_is_type(busnode, "i2c-bus"))
 			continue;
 		reg = of_get_property(busnode, "reg", NULL);
 		if (reg == NULL)
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 57bbff465964..5a71395e535e 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -417,7 +417,7 @@ int of_irq_parse_oldworld(struct device_node *device, int index,
 		if (ints != NULL)
 			break;
 		device = device->parent;
-		if (device && strcmp(device->type, "pci") != 0)
+		if (!of_node_is_type(device, "pci"))
 			break;
 	}
 	if (ints == NULL)
diff --git a/arch/powerpc/platforms/powermac/udbg_adb.c b/arch/powerpc/platforms/powermac/udbg_adb.c
index 64f38f0d15ed..12158bb4fed7 100644
--- a/arch/powerpc/platforms/powermac/udbg_adb.c
+++ b/arch/powerpc/platforms/powermac/udbg_adb.c
@@ -194,7 +194,7 @@ int __init udbg_adb_init(int force_btext)
 	 */
 	for_each_node_by_name(np, "keyboard") {
 		struct device_node *parent = of_get_parent(np);
-		int found = (parent && strcmp(parent->type, "adb") == 0);
+		int found = of_node_is_type(parent, "adb");
 		of_node_put(parent);
 		if (found)
 			break;
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2a983b5a52e1..3b881ac66d9a 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -313,7 +313,6 @@ static int pseries_remove_memblock(unsigned long base, unsigned int memblock_siz
 
 static int pseries_remove_mem_node(struct device_node *np)
 {
-	const char *type;
 	const __be32 *regs;
 	unsigned long base;
 	unsigned int lmb_size;
@@ -322,8 +321,7 @@ static int pseries_remove_mem_node(struct device_node *np)
 	/*
 	 * Check to see if we are actually removing memory
 	 */
-	type = of_get_property(np, "device_type", NULL);
-	if (type == NULL || strcmp(type, "memory") != 0)
+	if (!of_node_is_type(np, "memory"))
 		return 0;
 
 	/*
@@ -936,7 +934,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 
 static int pseries_add_mem_node(struct device_node *np)
 {
-	const char *type;
 	const __be32 *regs;
 	unsigned long base;
 	unsigned int lmb_size;
@@ -945,8 +942,7 @@ static int pseries_add_mem_node(struct device_node *np)
 	/*
 	 * Check to see if we are actually adding memory
 	 */
-	type = of_get_property(np, "device_type", NULL);
-	if (type == NULL || strcmp(type, "memory") != 0)
+	if (!of_node_is_type(np, "memory"))
 		return 0;
 
 	/*
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0f553dcfa548..4078a05fa5c0 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -469,8 +469,8 @@ static void __init find_and_init_phbs(void)
 	struct device_node *root = of_find_node_by_path("/");
 
 	for_each_child_of_node(root, node) {
-		if (node->type == NULL || (strcmp(node->type, "pci") != 0 &&
-					   strcmp(node->type, "pciex") != 0))
+		if (!of_node_is_type(node, "pci") &&
+		    !of_node_is_type(node, "pciex"))
 			continue;
 
 		phb = pcibios_alloc_controller(node);
@@ -978,11 +978,7 @@ static void pseries_power_off(void)
 
 static int __init pSeries_probe(void)
 {
-	const char *dtype = of_get_property(of_root, "device_type", NULL);
-
- 	if (dtype == NULL)
- 		return 0;
- 	if (strcmp(dtype, "chrp"))
+	if (!of_node_is_type(of_root, "chrp"))
 		return 0;
 
 	/* Cell blades firmware claims to be chrp while it's not. Until this
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 88f1ad1d6309..93cc9eec6601 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1356,9 +1356,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	 */
 	parent_node = of_get_parent(of_node);
 	if (parent_node) {
-		if (!strcmp(parent_node->type, "ibm,platform-facilities"))
+		if (of_node_is_type(parent_node, "ibm,platform-facilities"))
 			family = PFO;
-		else if (!strcmp(parent_node->type, "vdevice"))
+		else if (of_node_is_type(parent_node, "vdevice"))
 			family = VDEVICE;
 		else {
 			pr_warn("%s: parent(%pOF) of %pOFn not recognized.\n",
@@ -1395,9 +1395,8 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	if (viodev->family == VDEVICE) {
 		unsigned int unit_address;
 
-		if (of_node->type != NULL)
-			viodev->type = of_node->type;
-		else {
+		viodev->type = of_node_get_device_type(of_node);
+		if (!viodev->type) {
 			pr_warn("%s: node %pOFn is missing the 'device_type' "
 					"property.\n", __func__, of_node);
 			goto out;
@@ -1672,32 +1671,30 @@ struct vio_dev *vio_find_node(struct device_node *vnode)
 {
 	char kobj_name[20];
 	struct device_node *vnode_parent;
-	const char *dev_type;
 
 	vnode_parent = of_get_parent(vnode);
 	if (!vnode_parent)
 		return NULL;
 
-	dev_type = of_get_property(vnode_parent, "device_type", NULL);
-	of_node_put(vnode_parent);
-	if (!dev_type)
-		return NULL;
-
 	/* construct the kobject name from the device node */
-	if (!strcmp(dev_type, "vdevice")) {
+	if (of_node_is_type(vnode_parent, "vdevice")) {
 		const __be32 *prop;
 		
 		prop = of_get_property(vnode, "reg", NULL);
 		if (!prop)
-			return NULL;
+			goto out;
 		snprintf(kobj_name, sizeof(kobj_name), "%x",
 			 (uint32_t)of_read_number(prop, 1));
-	} else if (!strcmp(dev_type, "ibm,platform-facilities"))
+	} else if (of_node_is_type(vnode_parent, "ibm,platform-facilities"))
 		snprintf(kobj_name, sizeof(kobj_name), "%pOFn", vnode);
 	else
-		return NULL;
+		goto out;
 
+	of_node_put(vnode_parent);
 	return vio_find_name(kobj_name);
+out:
+	of_node_put(vnode_parent);
+	return NULL;
 }
 EXPORT_SYMBOL(vio_find_node);
 
-- 
2.19.1

