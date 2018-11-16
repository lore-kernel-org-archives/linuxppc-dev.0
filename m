Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D427C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:16:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECC72086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECC72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xXdb1H9kzF3hM
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 09:16:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xXW72qLQzF3gW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 09:11:15 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id s5so22717362oth.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 14:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WsBjmVUpfgFD4+GSZc9VvJ8gIlc1uQbIKJ5t1TJ0p+c=;
 b=IxpWM/l3k+Niwxpwyq+KFJI1oz2RIlidTTNU68YrRrCMxkBVlhlxNRsLLFYmtCsFPt
 xwgxRVDBhZNKIkbIG20cLCHEclT+FBZwwCrfR6QnyOGI19bH0yq8lNniasWrX+NV2LZ4
 jnSc5GGFHy4qeydwnseL1b495gQ7FVHa+8JKC2D6URhHCGogaSiVlwv8YLUFE3dxJ0NX
 1UZ9mlrYbaBl+xoh/Qwsu1KwLD4D1Z03RvuTOy+rPewlB48zuZmcVlOrN6yc2psY+Nlg
 uPj+ZOAdoVNnPu3QTPac0z4pi7dQQG3XC6QNkRxpzC2vw20lM2FR+rpXVGEsoooyvy5e
 /N2w==
X-Gm-Message-State: AGRZ1gI6VEu7X58XFywyHMJPhChNAU15h0oC76nNKpaVJpR3VcRsAAZw
 QmTZORBl9ZNV6AcMWoCHz0lOa2Op/g==
X-Google-Smtp-Source: AJdET5cjRP8GK30FQdOzO0d4yJmWyDXpj/R65hY1flmWGxxmvCM4gi6V5+dBm/RFkfCVyT0iR1SNag==
X-Received: by 2002:a9d:2990:: with SMTP id n16mr7158467otb.19.1542406273377; 
 Fri, 16 Nov 2018 14:11:13 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net.
 [166.173.57.127]) by smtp.googlemail.com with ESMTPSA id
 p204-v6sm12142631oib.25.2018.11.16.14.11.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Nov 2018 14:11:12 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] macintosh: Use device_type helpers to access the node type
Date: Fri, 16 Nov 2018 16:11:01 -0600
Message-Id: <20181116221104.23024-5-robh@kernel.org>
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/macio_asic.c            |  4 ++--
 drivers/macintosh/macio_sysfs.c           | 18 ++++++------------
 drivers/macintosh/windfarm_fcu_controls.c |  8 ++++----
 drivers/macintosh/windfarm_smu_sat.c      |  9 ++++-----
 drivers/macintosh/windfarm_smu_sensors.c  | 13 ++++++-------
 5 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 17d3bc917562..bc8418801224 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -220,8 +220,8 @@ static int macio_resource_quirks(struct device_node *np, struct resource *res,
 		return 1;
 
 	/* Some older IDE resources have bogus sizes */
-	if (!(strcmp(np->name, "IDE") && strcmp(np->name, "ATA") &&
-	      strcmp(np->type, "ide") && strcmp(np->type, "ata"))) {
+	if (!strcmp(np->name, "IDE") || !strcmp(np->name, "ATA") ||
+	    of_node_is_type(np, "ide") || of_node_is_type(np, "ata")) {
 		if (index == 0 && (res->end - res->start) > 0xfff)
 			res->end = res->start + 0xfff;
 		if (index == 1 && (res->end - res->start) > 0xff)
diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index d2451e58acb9..27f5eefc508f 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -3,17 +3,6 @@
 #include <linux/stat.h>
 #include <asm/macio.h>
 
-
-#define macio_config_of_attr(field, format_string)			\
-static ssize_t								\
-field##_show (struct device *dev, struct device_attribute *attr,	\
-              char *buf)						\
-{									\
-	struct macio_dev *mdev = to_macio_device (dev);			\
-	return sprintf (buf, format_string, mdev->ofdev.dev.of_node->field); \
-}									\
-static DEVICE_ATTR_RO(field);
-
 static ssize_t
 compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -65,7 +54,12 @@ static ssize_t name_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(name);
 
-macio_config_of_attr (type, "%s\n");
+static ssize_t type_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", of_node_get_device_type(dev->of_node));
+}
+static DEVICE_ATTR_RO(type);
 
 static struct attribute *macio_dev_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/macintosh/windfarm_fcu_controls.c b/drivers/macintosh/windfarm_fcu_controls.c
index 2b3ca628a650..629f19875d7f 100644
--- a/drivers/macintosh/windfarm_fcu_controls.c
+++ b/drivers/macintosh/windfarm_fcu_controls.c
@@ -439,11 +439,11 @@ static void wf_fcu_lookup_fans(struct wf_fcu_priv *pv)
 		DBG(" control: %pOFn, type: %s\n", np, of_node_get_device_type(np));
 
 		/* Detect control type */
-		if (!strcmp(np->type, "fan-rpm-control") ||
-		    !strcmp(np->type, "fan-rpm"))
+		if (of_node_is_type(np, "fan-rpm-control") ||
+		    of_node_is_type(np, "fan-rpm"))
 			type = FCU_FAN_RPM;
-		if (!strcmp(np->type, "fan-pwm-control") ||
-		    !strcmp(np->type, "fan-pwm"))
+		if (of_node_is_type(np, "fan-pwm-control") ||
+		    of_node_is_type(np, "fan-pwm"))
 			type = FCU_FAN_PWM;
 		/* Only care about fans for now */
 		if (type == -1)
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index a0f61eb853c5..b4be718beba8 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -197,7 +197,7 @@ static int wf_sat_probe(struct i2c_client *client,
 	struct wf_sat *sat;
 	struct wf_sat_sensor *sens;
 	const u32 *reg;
-	const char *loc, *type;
+	const char *loc;
 	u8 chip, core;
 	struct device_node *child;
 	int shift, cpu, index;
@@ -220,7 +220,6 @@ static int wf_sat_probe(struct i2c_client *client,
 	child = NULL;
 	while ((child = of_get_next_child(dev, child)) != NULL) {
 		reg = of_get_property(child, "reg", NULL);
-		type = of_get_property(child, "device_type", NULL);
 		loc = of_get_property(child, "location", NULL);
 		if (reg == NULL || loc == NULL)
 			continue;
@@ -249,15 +248,15 @@ static int wf_sat_probe(struct i2c_client *client,
 			continue;
 		}
 
-		if (strcmp(type, "voltage-sensor") == 0) {
+		if (of_node_is_type(child, "voltage-sensor")) {
 			name = "cpu-voltage";
 			shift = 4;
 			vsens[core] = index;
-		} else if (strcmp(type, "current-sensor") == 0) {
+		} else if (of_node_is_type(child, "current-sensor")) {
 			name = "cpu-current";
 			shift = 8;
 			isens[core] = index;
-		} else if (strcmp(type, "temp-sensor") == 0) {
+		} else if (of_node_is_type(child, "temp-sensor")) {
 			name = "cpu-temp";
 			shift = 10;
 		} else
diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 172fd267dcf6..1ba86de93f92 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -197,15 +197,14 @@ static const struct wf_sensor_ops smu_slotspow_ops = {
 static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 {
 	struct smu_ad_sensor *ads;
-	const char *c, *l;
+	const char *l;
 	const u32 *v;
 
 	ads = kmalloc(sizeof(struct smu_ad_sensor), GFP_KERNEL);
 	if (ads == NULL)
 		return NULL;
-	c = of_get_property(node, "device_type", NULL);
 	l = of_get_property(node, "location", NULL);
-	if (c == NULL || l == NULL)
+	if (l == NULL)
 		goto fail;
 
 	/* We currently pick the sensors based on the OF name and location
@@ -215,7 +214,7 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 	 * the names and locations consistents so I'll stick with the names
 	 * and locations for now.
 	 */
-	if (!strcmp(c, "temp-sensor") &&
+	if (of_node_is_type(node, "temp-sensor") &&
 	    !strcmp(l, "CPU T-Diode")) {
 		ads->sens.ops = &smu_cputemp_ops;
 		ads->sens.name = "cpu-temp";
@@ -224,7 +223,7 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 			    SMU_SDB_CPUDIODE_ID);
 			goto fail;
 		}
-	} else if (!strcmp(c, "current-sensor") &&
+	} else if (of_node_is_type(node, "current-sensor") &&
 		   !strcmp(l, "CPU Current")) {
 		ads->sens.ops = &smu_cpuamp_ops;
 		ads->sens.name = "cpu-current";
@@ -233,7 +232,7 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 			    SMU_SDB_CPUVCP_ID);
 			goto fail;
 		}
-	} else if (!strcmp(c, "voltage-sensor") &&
+	} else if (of_node_is_type(node, "voltage-sensor") &&
 		   !strcmp(l, "CPU Voltage")) {
 		ads->sens.ops = &smu_cpuvolt_ops;
 		ads->sens.name = "cpu-voltage";
@@ -242,7 +241,7 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 			    SMU_SDB_CPUVCP_ID);
 			goto fail;
 		}
-	} else if (!strcmp(c, "power-sensor") &&
+	} else if (of_node_is_type(node, "power-sensor") &&
 		   !strcmp(l, "Slots Power")) {
 		ads->sens.ops = &smu_slotspow_ops;
 		ads->sens.name = "slots-power";
-- 
2.19.1

