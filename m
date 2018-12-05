Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE8C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:56:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5704420850
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5704420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4398cg2np1zDr0p
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 06:56:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398VR1ylFzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:50:55 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id k98so19827117otk.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ij8ITH8RJzY1lIJct2VQtXMW7C9kcRtOy54VKLB1kRQ=;
 b=Oiwu0OlijCYB1SfEqai5Dv4yk7uLWUODIymeFW4t2LQdB5/mBH6suPWdfbgyU+m6rV
 5PXDrVQuFySJtSWhIS26gFAzRgioxbEk/MTbDsaFil9KJOEsABiVZTWqBt4ajDOFREtL
 Xo2E+Ju2ZjPsMYqpT0N6szRPtBq1hqLXHX37NlhNRv0J4mZcrWUL5r0p2JyamEmT5nPZ
 XFkMZh4s+wCOKJH/yG9+eDxvCqMLoBf+me+0TcH8umBUVTPgfRfE/t9LzdT5HD9VIE8+
 jOzKYlzNlx8y5msG8/Q8NSJXY81+jCalzi5tH2KzC2HT2+opSocaZtvopcua4TJCw3xL
 nVVg==
X-Gm-Message-State: AA+aEWZn92Yql2mnhKLaFeT5MQT8390FyYgZsTcnelZxgz0cpupE3gSM
 6/iUJBQEomENHopd+P29lQ==
X-Google-Smtp-Source: AFSGD/UPByWeeu86cqiuyl/cQAxJyj3tj0xza5uKtVSBQfYW9Dqo/zbG2Aq0T9OpPkGF9ZNVM7Os1g==
X-Received: by 2002:a9d:69cf:: with SMTP id v15mr17007543oto.77.1544039453181; 
 Wed, 05 Dec 2018 11:50:53 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:50:52 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:18 -0600
Message-Id: <20181205195050.4759-2-robh@kernel.org>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
 Alistair Popple <alistair@popple.id.au>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

A couple of open coded iterating thru the child node names are converted
to use for_each_child_of_node() instead.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/kernel/legacy_serial.c          |  7 +++--
 arch/powerpc/platforms/44x/warp.c            |  4 +--
 arch/powerpc/platforms/52xx/efika.c          |  6 ++---
 arch/powerpc/platforms/cell/setup.c          |  2 +-
 arch/powerpc/platforms/cell/spu_manage.c     | 10 ++------
 arch/powerpc/platforms/chrp/setup.c          |  5 +---
 arch/powerpc/platforms/powermac/feature.c    | 11 ++++----
 arch/powerpc/platforms/powermac/low_i2c.c    |  4 +--
 arch/powerpc/platforms/powermac/pci.c        | 27 ++++++++------------
 arch/powerpc/platforms/powermac/pfunc_base.c |  7 +++--
 arch/powerpc/platforms/powermac/pic.c        |  4 +--
 arch/powerpc/platforms/powermac/setup.c      | 10 ++------
 arch/powerpc/platforms/powermac/udbg_scc.c   |  2 +-
 arch/powerpc/platforms/powernv/opal.c        |  2 +-
 arch/powerpc/platforms/pseries/setup.c       |  2 +-
 15 files changed, 39 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 2a6f339e92cd..3343f9005ddc 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -398,8 +398,7 @@ void __init find_legacy_serial_ports(void)
 	/* Next, fill our array with ISA ports */
 	for_each_node_by_type(np, "serial") {
 		struct device_node *isa = of_get_parent(np);
-		if (isa && (!strcmp(isa->name, "isa") ||
-			    !strcmp(isa->name, "lpc"))) {
+		if (of_node_name_eq(isa, "isa") || of_node_name_eq(isa, "lpc")) {
 			if (of_device_is_available(np)) {
 				index = add_legacy_isa_port(np, isa);
 				if (index >= 0 && np == stdout)
@@ -413,11 +412,11 @@ void __init find_legacy_serial_ports(void)
 	/* Next, try to locate PCI ports */
 	for (np = NULL; (np = of_find_all_nodes(np));) {
 		struct device_node *pci, *parent = of_get_parent(np);
-		if (parent && !strcmp(parent->name, "isa")) {
+		if (of_node_name_eq(parent, "isa")) {
 			of_node_put(parent);
 			continue;
 		}
-		if (strcmp(np->name, "serial") &&
+		if (!of_node_name_eq(np, "serial") &&
 		    !of_node_is_type(np, "serial")) {
 			of_node_put(parent);
 			continue;
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index a886c2c22097..533c512ba5e1 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -179,9 +179,9 @@ static int pika_setup_leds(void)
 	}
 
 	for_each_child_of_node(np, child)
-		if (strcmp(child->name, "green") == 0)
+		if (of_node_name_eq(child, "green"))
 			green_led = of_get_gpio(child, 0);
-		else if (strcmp(child->name, "red") == 0)
+		else if (of_node_name_eq(child, "red"))
 			red_led = of_get_gpio(child, 0);
 
 	of_node_put(np);
diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 1ecbf176d35a..61538869e88a 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -82,11 +82,9 @@ static void __init efika_pcisetup(void)
 		return;
 	}
 
-	for (pcictrl = NULL;;) {
-		pcictrl = of_get_next_child(root, pcictrl);
-		if ((pcictrl == NULL) || (strcmp(pcictrl->name, "pci") == 0))
+	for_each_child_of_node(root, pcictrl)
+		if (of_node_name_eq(pcictrl, "pci"))
 			break;
-	}
 
 	of_node_put(root);
 
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 902d527d043f..e2e1371a71e2 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -131,7 +131,7 @@ static int cell_setup_phb(struct pci_controller *phb)
 
 	np = phb->dn;
 	model = of_get_property(np, "model", NULL);
-	if (model == NULL || strcmp(np->name, "pci"))
+	if (model == NULL || !of_node_name_eq(np, "pci"))
 		return 0;
 
 	/* Setup workarounds for spider */
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index f7e36373f6e0..bed935c51ec2 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -458,7 +458,6 @@ static void init_affinity_node(int cbe)
 	struct device_node *vic_dn, *last_spu_dn;
 	phandle avoid_ph;
 	const phandle *vic_handles;
-	const char *name;
 	int lenp, i, added;
 
 	last_spu = list_first_entry(&cbe_spu_info[cbe].spus, struct spu,
@@ -480,12 +479,7 @@ static void init_affinity_node(int cbe)
 			if (!vic_dn)
 				continue;
 
-			/* a neighbour might be spe, mic-tm, or bif0 */
-			name = of_get_property(vic_dn, "name", NULL);
-			if (!name)
-				continue;
-
-			if (strcmp(name, "spe") == 0) {
+			if (of_node_name_eq(vic_dn, "spe") ) {
 				spu = devnode_spu(cbe, vic_dn);
 				avoid_ph = last_spu_dn->phandle;
 			} else {
@@ -498,7 +492,7 @@ static void init_affinity_node(int cbe)
 				spu = neighbour_spu(cbe, vic_dn, last_spu_dn);
 				if (!spu)
 					continue;
-				if (!strcmp(name, "mic-tm")) {
+				if (of_node_name_eq(vic_dn, "mic-tm")) {
 					last_spu->has_mem_affinity = 1;
 					spu->has_mem_affinity = 1;
 				}
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 3c21f046e20c..e66644e0fb40 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -287,10 +287,7 @@ static __init void chrp_init(void)
 	 * or /pci@80000000/isa@C/serial@i2F8
 	 * The optional graphics card has also type 'serial' in VGA mode.
 	 */
-	property = of_get_property(node, "name", NULL);
-	if (!property)
-		goto out_put;
-	if (!strcmp(property, "failsafe") || !strcmp(property, "serial"))
+	if (of_node_name_eq(node, "failsafe") || of_node_name_eq(node, "serial"))
 		add_preferred_console("ttyS", 0, NULL);
 out_put:
 	of_node_put(node);
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index ed2f54b3f173..f9872ff275d7 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -173,9 +173,9 @@ static long ohare_htw_scc_enable(struct device_node *node, long param,
 	macio = macio_find(node, 0);
 	if (!macio)
 		return -ENODEV;
-	if (!strcmp(node->name, "ch-a"))
+	if (of_node_name_eq(node, "ch-a"))
 		chan_mask = MACIO_FLAG_SCCA_ON;
-	else if (!strcmp(node->name, "ch-b"))
+	else if (of_node_name_eq(node, "ch-b"))
 		chan_mask = MACIO_FLAG_SCCB_ON;
 	else
 		return -ENODEV;
@@ -610,9 +610,9 @@ static long core99_scc_enable(struct device_node *node, long param, long value)
 	macio = macio_find(node, 0);
 	if (!macio)
 		return -ENODEV;
-	if (!strcmp(node->name, "ch-a"))
+	if (of_node_name_eq(node, "ch-a"))
 		chan_mask = MACIO_FLAG_SCCA_ON;
-	else if (!strcmp(node->name, "ch-b"))
+	else if (of_node_name_eq(node, "ch-b"))
 		chan_mask = MACIO_FLAG_SCCB_ON;
 	else
 		return -ENODEV;
@@ -1392,8 +1392,7 @@ static long g5_mpic_enable(struct device_node *node, long param, long value)
 
 	if (parent == NULL)
 		return 0;
-	is_u3 = strcmp(parent->name, "u3") == 0 ||
-		strcmp(parent->name, "u4") == 0;
+	is_u3 = of_node_name_eq(parent, "u3") || of_node_name_eq(parent, "u4");
 	of_node_put(parent);
 	if (!is_u3)
 		return 0;
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 84bace3b546a..4de058a20d2b 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -617,7 +617,7 @@ static void __init kw_i2c_probe(void)
 		 * but not for now
 		 */
 		child = of_get_next_child(np, NULL);
-		multibus = !child || strcmp(child->name, "i2c-bus");
+		multibus = !of_node_name_eq(child, "i2c-bus");
 		of_node_put(child);
 
 		/* For a multibus setup, we get the bus count based on the
@@ -1205,7 +1205,7 @@ static void pmac_i2c_devscan(void (*callback)(struct device_node *dev,
 				if (bus != pmac_i2c_find_bus(np))
 					continue;
 			for (p = whitelist; p->name != NULL; p++) {
-				if (strcmp(np->name, p->name))
+				if (!of_node_name_eq(np, p->name))
 					continue;
 				if (p->compatible &&
 				    !of_device_is_compatible(np, p->compatible))
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 04527d13d5a4..3d7420503c37 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -501,9 +501,7 @@ static void __init init_p2pbridge(void)
 	/* XXX it would be better here to identify the specific
 	   PCI-PCI bridge chip we have. */
 	p2pbridge = of_find_node_by_name(NULL, "pci-bridge");
-	if (p2pbridge == NULL
-	    || p2pbridge->parent == NULL
-	    || strcmp(p2pbridge->parent->name, "pci") != 0)
+	if (p2pbridge == NULL || !of_node_name_eq(p2pbridge->parent, "pci"))
 		goto done;
 	if (pci_device_from_OF_node(p2pbridge, &bus, &devfn) < 0) {
 		DBG("Can't find PCI infos for PCI<->PCI bridge\n");
@@ -828,14 +826,14 @@ static int __init pmac_add_bridge(struct device_node *dev)
 	if (of_device_is_compatible(dev, "uni-north")) {
 		primary = setup_uninorth(hose, &rsrc);
 		disp_name = "UniNorth";
-	} else if (strcmp(dev->name, "pci") == 0) {
+	} else if (of_node_name_eq(dev, "pci")) {
 		/* XXX assume this is a mpc106 (grackle) */
 		setup_grackle(hose);
 		disp_name = "Grackle (MPC106)";
-	} else if (strcmp(dev->name, "bandit") == 0) {
+	} else if (of_node_name_eq(dev, "bandit")) {
 		setup_bandit(hose, &rsrc);
 		disp_name = "Bandit";
-	} else if (strcmp(dev->name, "chaos") == 0) {
+	} else if (of_node_name_eq(dev, "chaos")) {
 		setup_chaos(hose, &rsrc);
 		disp_name = "Chaos";
 		primary = 0;
@@ -914,16 +912,14 @@ void __init pmac_pci_init(void)
 		       "of device tree\n");
 		return;
 	}
-	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;) {
-		if (np->name == NULL)
-			continue;
-		if (strcmp(np->name, "bandit") == 0
-		    || strcmp(np->name, "chaos") == 0
-		    || strcmp(np->name, "pci") == 0) {
+	for_each_child_of_node(root, np) {
+		if (of_node_name_eq(np, "bandit")
+		    || of_node_name_eq(np, "chaos")
+		    || of_node_name_eq(np, "pci")) {
 			if (pmac_add_bridge(np) == 0)
 				of_node_get(np);
 		}
-		if (strcmp(np->name, "ht") == 0) {
+		if (of_node_name_eq(np, "ht")) {
 			of_node_get(np);
 			ht = np;
 		}
@@ -983,7 +979,7 @@ static bool pmac_pci_enable_device_hook(struct pci_dev *dev)
 	/* Firewire & GMAC were disabled after PCI probe, the driver is
 	 * claiming them, we must re-enable them now.
 	 */
-	if (uninorth_child && !strcmp(node->name, "firewire") &&
+	if (uninorth_child && of_node_name_eq(node, "firewire") &&
 	    (of_device_is_compatible(node, "pci106b,18") ||
 	     of_device_is_compatible(node, "pci106b,30") ||
 	     of_device_is_compatible(node, "pci11c1,5811"))) {
@@ -991,7 +987,7 @@ static bool pmac_pci_enable_device_hook(struct pci_dev *dev)
 		pmac_call_feature(PMAC_FTR_1394_ENABLE, node, 0, 1);
 		updatecfg = 1;
 	}
-	if (uninorth_child && !strcmp(node->name, "ethernet") &&
+	if (uninorth_child && of_node_name_eq(node, "ethernet") &&
 	    of_device_is_compatible(node, "gmac")) {
 		pmac_call_feature(PMAC_FTR_GMAC_ENABLE, node, 0, 1);
 		updatecfg = 1;
@@ -1262,4 +1258,3 @@ struct pci_controller_ops pmac_pci_controller_ops = {
 	.enable_device_hook	= pmac_pci_enable_device_hook,
 #endif
 };
-
diff --git a/arch/powerpc/platforms/powermac/pfunc_base.c b/arch/powerpc/platforms/powermac/pfunc_base.c
index fd2e210559c8..62311e84a423 100644
--- a/arch/powerpc/platforms/powermac/pfunc_base.c
+++ b/arch/powerpc/platforms/powermac/pfunc_base.c
@@ -101,9 +101,8 @@ static void macio_gpio_init_one(struct macio_chip *macio)
 	 * Find the "gpio" parent node
 	 */
 
-	for (gparent = NULL;
-	     (gparent = of_get_next_child(macio->of_node, gparent)) != NULL;)
-		if (strcmp(gparent->name, "gpio") == 0)
+	for_each_child_of_node(macio->of_node, gparent)
+		if (of_node_name_eq(gparent, "gpio"))
 			break;
 	if (gparent == NULL)
 		return;
@@ -313,7 +312,7 @@ static void uninorth_install_pfunc(void)
 	 * Install handlers for the hwclock child if any
 	 */
 	for (np = NULL; (np = of_get_next_child(uninorth_node, np)) != NULL;)
-		if (strcmp(np->name, "hw-clock") == 0) {
+		if (of_node_name_eq(np, "hw-clock")) {
 			unin_hwclock = np;
 			break;
 		}
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 5a71395e535e..c292ffac2ed4 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -553,13 +553,13 @@ void __init pmac_pic_init(void)
 
 		for_each_node_with_property(np, "interrupt-controller") {
 			/* Skip /chosen/interrupt-controller */
-			if (strcmp(np->name, "chosen") == 0)
+			if (of_node_name_eq(np, "chosen"))
 				continue;
 			/* It seems like at least one person wants
 			 * to use BootX on a machine with an AppleKiwi
 			 * controller which happens to pretend to be an
 			 * interrupt controller too. */
-			if (strcmp(np->name, "AppleKiwi") == 0)
+			if (of_node_name_eq(np, "AppleKiwi"))
 				continue;
 			/* I think we found one ! */
 			of_irq_dflt_pic = np;
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 2f00e3daafb0..2e8221e20ee8 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -560,15 +560,9 @@ static int __init check_pmac_serial_console(void)
 	}
 	pr_debug("stdout is %pOF\n", prom_stdout);
 
-	name = of_get_property(prom_stdout, "name", NULL);
-	if (!name) {
-		pr_debug(" stdout package has no name !\n");
-		goto not_found;
-	}
-
-	if (strcmp(name, "ch-a") == 0)
+	if (of_node_name_eq(prom_stdout, "ch-a"))
 		offset = 0;
-	else if (strcmp(name, "ch-b") == 0)
+	else if (of_node_name_eq(prom_stdout, "ch-b"))
 		offset = 1;
 	else
 		goto not_found;
diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c b/arch/powerpc/platforms/powermac/udbg_scc.c
index 8901973ed683..415b74d7c253 100644
--- a/arch/powerpc/platforms/powermac/udbg_scc.c
+++ b/arch/powerpc/platforms/powermac/udbg_scc.c
@@ -87,7 +87,7 @@ void udbg_scc_init(int force_scc)
 	for (ch = NULL; (ch = of_get_next_child(escc, ch)) != NULL;) {
 		if (ch == stdout)
 			ch_def = of_node_get(ch);
-		if (strcmp(ch->name, "ch-a") == 0)
+		if (of_node_name_eq(ch, "ch-a"))
 			ch_a = of_node_get(ch);
 	}
 	if (ch_def == NULL && !force_scc)
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index beed86f4224b..1459837c9c68 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -877,7 +877,7 @@ static int __init opal_init(void)
 	consoles = of_find_node_by_path("/ibm,opal/consoles");
 	if (consoles) {
 		for_each_child_of_node(consoles, np) {
-			if (strcmp(np->name, "serial"))
+			if (!of_node_name_eq(np, "serial"))
 				continue;
 			of_platform_device_create(np, NULL, NULL);
 		}
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 4078a05fa5c0..41f62ca27c63 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -190,7 +190,7 @@ static void __init pseries_setup_i8259_cascade(void)
 		of_node_put(old);
 		if (np == NULL)
 			break;
-		if (strcmp(np->name, "pci") != 0)
+		if (!of_node_name_eq(np, "pci"))
 			continue;
 		addrp = of_get_property(np, "8259-interrupt-acknowledge", NULL);
 		if (addrp == NULL)
-- 
2.19.1

