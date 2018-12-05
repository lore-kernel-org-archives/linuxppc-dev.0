Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27C2C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:03:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DD720850
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DD720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4398mp5418zDqQy
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:03:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398Vf0hNpzDqyh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:51:06 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id j21so18612392oii.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rdRtXJjao5iiuZC+RcYq+07+GOJpOeBXQh3zqMydc3Y=;
 b=BnXqgrp3XXmiy+RQTe4/fily4IrYNdAtKCc8s82s68PpCw80tiT8DF3PeltU79Cl2N
 WybkgSaCTYF8bptz9nwanYPUZAZV+iLlF2uEda5tmJs4+/vz95gSZOcNffjHsuUfJ+wT
 cbfZxGHkVG/kqgfHWd56IBVLcoMowEx5GpCk6BSGzToFT9WnD0WjYsT3nN7CkxZVAm7O
 AFzc1XbOfOtr4ZDMeGrdqFh1Ev/H9hZ3SYbk2GKLCs82vIYsbM9Ht+odbU/bQVDlrNUc
 uMNh1INUORwPnF3a7aGEDNFFjw0uu+a8EMUtKeON58BNk0kkGB12dsMf4YY04316pVnF
 pJPw==
X-Gm-Message-State: AA+aEWaCylZ8DOkbtFRgRfN3gFkj5KlpDnDY9TgZIndYgjEftr4QO5gI
 ho/rq4grDN/oAHZSiDBbfw==
X-Google-Smtp-Source: AFSGD/VyWjTPGhu8HSlSfHfRz0NBz78wPVpWWBR90Yt9Zg17JsiPR946q0NyZWBMQ4/UgDT9h8K9MQ==
X-Received: by 2002:aca:e495:: with SMTP id
 b143mr14756706oih.286.1544039464209; 
 Wed, 05 Dec 2018 11:51:04 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:03 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh: Use of_node_name_{eq,
 prefix} for node name comparisons
Date: Wed,  5 Dec 2018 13:50:28 -0600
Message-Id: <20181205195050.4759-12-robh@kernel.org>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert string compares of DT node names to use of_node_name_{eq,prefix}
helpers instead. This removes direct access to the node name pointer.

This changes a single case insensitive node name comparison to case
sensitive for "ata4". This is the only instance of a case insensitive
comparison for all the open coded node name comparisons on powerpc.
Searching the commit history, there doesn't appear to be any reason for
it to be case insensitive.

A couple of open coded iterating thru the child node names are converted
to use for_each_child_of_node() instead.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/ans-lcd.c               |  2 +-
 drivers/macintosh/macio_asic.c            | 33 +++++++++++------------
 drivers/macintosh/rack-meter.c            | 13 ++++-----
 drivers/macintosh/via-pmu.c               |  4 +--
 drivers/macintosh/windfarm_lm87_sensor.c  |  4 +--
 drivers/macintosh/windfarm_smu_controls.c |  4 +--
 drivers/macintosh/windfarm_smu_sensors.c  |  2 +-
 7 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index c8e078b911c7..ef0c2366cf59 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -160,7 +160,7 @@ anslcd_init(void)
 	struct device_node* node;
 
 	node = of_find_node_by_name(NULL, "lcd");
-	if (!node || !node->parent || strcmp(node->parent->name, "gc")) {
+	if (!node || !of_node_name_eq(node->parent, "gc")) {
 		of_node_put(node);
 		return -ENODEV;
 	}
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index bc8418801224..3543a82081de 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -190,11 +190,11 @@ static int macio_resource_quirks(struct device_node *np, struct resource *res,
 		return 0;
 
 	/* Grand Central has too large resource 0 on some machines */
-	if (index == 0 && !strcmp(np->name, "gc"))
+	if (index == 0 && of_node_name_eq(np, "gc"))
 		res->end = res->start + 0x1ffff;
 
 	/* Airport has bogus resource 2 */
-	if (index >= 2 && !strcmp(np->name, "radio"))
+	if (index >= 2 && of_node_name_eq(np, "radio"))
 		return 1;
 
 #ifndef CONFIG_PPC64
@@ -207,20 +207,20 @@ static int macio_resource_quirks(struct device_node *np, struct resource *res,
 	 * level of hierarchy, but I don't really feel the need
 	 * for it
 	 */
-	if (!strcmp(np->name, "escc"))
+	if (of_node_name_eq(np, "escc"))
 		return 1;
 
 	/* ESCC has bogus resources >= 3 */
-	if (index >= 3 && !(strcmp(np->name, "ch-a") &&
-			    strcmp(np->name, "ch-b")))
+	if (index >= 3 && (of_node_name_eq(np, "ch-a") ||
+			   of_node_name_eq(np, "ch-b")))
 		return 1;
 
 	/* Media bay has too many resources, keep only first one */
-	if (index > 0 && !strcmp(np->name, "media-bay"))
+	if (index > 0 && of_node_name_eq(np, "media-bay"))
 		return 1;
 
 	/* Some older IDE resources have bogus sizes */
-	if (!strcmp(np->name, "IDE") || !strcmp(np->name, "ATA") ||
+	if (of_node_name_eq(np, "IDE") || of_node_name_eq(np, "ATA") ||
 	    of_node_is_type(np, "ide") || of_node_is_type(np, "ata")) {
 		if (index == 0 && (res->end - res->start) > 0xfff)
 			res->end = res->start + 0xfff;
@@ -260,7 +260,7 @@ static void macio_add_missing_resources(struct macio_dev *dev)
 	irq_base = 64;
 
 	/* Fix SCC */
-	if (strcmp(np->name, "ch-a") == 0) {
+	if (of_node_name_eq(np, "ch-a")) {
 		macio_create_fixup_irq(dev, 0, 15 + irq_base);
 		macio_create_fixup_irq(dev, 1,  4 + irq_base);
 		macio_create_fixup_irq(dev, 2,  5 + irq_base);
@@ -268,18 +268,18 @@ static void macio_add_missing_resources(struct macio_dev *dev)
 	}
 
 	/* Fix media-bay */
-	if (strcmp(np->name, "media-bay") == 0) {
+	if (of_node_name_eq(np, "media-bay")) {
 		macio_create_fixup_irq(dev, 0, 29 + irq_base);
 		printk(KERN_INFO "macio: fixed media-bay irq on gatwick\n");
 	}
 
 	/* Fix left media bay childs */
-	if (dev->media_bay != NULL && strcmp(np->name, "floppy") == 0) {
+	if (dev->media_bay != NULL && of_node_name_eq(np, "floppy")) {
 		macio_create_fixup_irq(dev, 0, 19 + irq_base);
 		macio_create_fixup_irq(dev, 1,  1 + irq_base);
 		printk(KERN_INFO "macio: fixed left floppy irqs\n");
 	}
-	if (dev->media_bay != NULL && strcasecmp(np->name, "ata4") == 0) {
+	if (dev->media_bay != NULL && of_node_name_eq(np, "ata4")) {
 		macio_create_fixup_irq(dev, 0, 14 + irq_base);
 		macio_create_fixup_irq(dev, 0,  3 + irq_base);
 		printk(KERN_INFO "macio: fixed left ide irqs\n");
@@ -438,11 +438,8 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 
 static int macio_skip_device(struct device_node *np)
 {
-	if (strncmp(np->name, "battery", 7) == 0)
-		return 1;
-	if (strncmp(np->name, "escc-legacy", 11) == 0)
-		return 1;
-	return 0;
+	return of_node_name_prefix(np, "battery") ||
+	       of_node_name_prefix(np, "escc-legacy");
 }
 
 /**
@@ -489,9 +486,9 @@ static void macio_pci_add_devices(struct macio_chip *chip)
 					    root_res);
 		if (mdev == NULL)
 			of_node_put(np);
-		else if (strncmp(np->name, "media-bay", 9) == 0)
+		else if (of_node_name_prefix(np, "media-bay"))
 			mbdev = mdev;
-		else if (strncmp(np->name, "escc", 4) == 0)
+		else if (of_node_name_prefix(np, "escc"))
 			sdev = mdev;
 	}
 
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 1f29d2413c74..3940e2a032f7 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -376,18 +376,19 @@ static int rackmeter_probe(struct macio_dev* mdev,
 	pr_debug("rackmeter_probe()\n");
 
 	/* Get i2s-a node */
-	while ((i2s = of_get_next_child(mdev->ofdev.dev.of_node, i2s)) != NULL)
-	       if (strcmp(i2s->name, "i2s-a") == 0)
-		       break;
+	for_each_child_of_node(mdev->ofdev.dev.of_node, i2s)
+		if (of_node_name_eq(i2s, "i2s-a"))
+			break;
+
 	if (i2s == NULL) {
 		pr_debug("  i2s-a child not found\n");
 		goto bail;
 	}
 	/* Get lightshow or virtual sound */
-	while ((np = of_get_next_child(i2s, np)) != NULL) {
-	       if (strcmp(np->name, "lightshow") == 0)
+	for_each_child_of_node(i2s, np) {
+	       if (of_node_name_eq(np, "lightshow"))
 		       break;
-	       if ((strcmp(np->name, "sound") == 0) &&
+	       if (of_node_name_eq(np, "sound") &&
 		   of_get_property(np, "virtual", NULL) != NULL)
 		       break;
 	}
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 60f57e2abf21..ac0cf37d6239 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -318,8 +318,8 @@ int __init find_via_pmu(void)
 			PMU_INT_ADB |
 			PMU_INT_TICK;
 	
-	if (vias->parent->name && ((strcmp(vias->parent->name, "ohare") == 0)
-	    || of_device_is_compatible(vias->parent, "ohare")))
+	if (of_node_name_eq(vias->parent, "ohare") ||
+	    of_device_is_compatible(vias->parent, "ohare"))
 		pmu_kind = PMU_OHARE_BASED;
 	else if (of_device_is_compatible(vias->parent, "paddington"))
 		pmu_kind = PMU_PADDINGTON_BASED;
diff --git a/drivers/macintosh/windfarm_lm87_sensor.c b/drivers/macintosh/windfarm_lm87_sensor.c
index 35aa571d498a..09724acd70b6 100644
--- a/drivers/macintosh/windfarm_lm87_sensor.c
+++ b/drivers/macintosh/windfarm_lm87_sensor.c
@@ -110,8 +110,8 @@ static int wf_lm87_probe(struct i2c_client *client,
 	 * the Xserve G5 has several lm87's. However, for now we only
 	 * care about the internal temperature sensor
 	 */
-	while ((np = of_get_next_child(client->dev.of_node, np)) != NULL) {
-		if (strcmp(np->name, "int-temp"))
+	for_each_child_of_node(client->dev.of_node, np) {
+		if (!of_node_name_eq(np, "int-temp"))
 			continue;
 		loc = of_get_property(np, "location", NULL);
 		if (!loc)
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index 86d65462a61c..2cb9652a9998 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -267,7 +267,7 @@ static int __init smu_controls_init(void)
 
 	/* Look for RPM fans */
 	for (fans = NULL; (fans = of_get_next_child(smu, fans)) != NULL;)
-		if (!strcmp(fans->name, "rpm-fans") ||
+		if (of_node_name_eq(fans, "rpm-fans") ||
 		    of_device_is_compatible(fans, "smu-rpm-fans"))
 			break;
 	for (fan = NULL;
@@ -287,7 +287,7 @@ static int __init smu_controls_init(void)
 
 	/* Look for PWM fans */
 	for (fans = NULL; (fans = of_get_next_child(smu, fans)) != NULL;)
-		if (!strcmp(fans->name, "pwm-fans"))
+		if (of_node_name_eq(fans, "pwm-fans"))
 			break;
 	for (fan = NULL;
 	     fans && (fan = of_get_next_child(fans, fan)) != NULL;) {
diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 1ba86de93f92..a58f6733381a 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -424,7 +424,7 @@ static int __init smu_sensors_init(void)
 	/* Look for sensors subdir */
 	for (sensors = NULL;
 	     (sensors = of_get_next_child(smu, sensors)) != NULL;)
-		if (!strcmp(sensors->name, "sensors"))
+		if (of_node_name_eq(sensors, "sensors"))
 			break;
 
 	of_node_put(smu);
-- 
2.19.1

