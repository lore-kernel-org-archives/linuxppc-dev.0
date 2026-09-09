Return-Path: <linuxppc-dev+bounces-26949-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E17C79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 14:26:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg35d0Bzkz2ytj;
	Thu, 10 Sep 2026 00:26:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788963988;
	cv=none; b=bajw+gxlm7H6Dsv0DLl6wZjHPZ/nvstIc19ZaeSvR77OFt3lZRIspby9TQ21KFnJxAB2XUKQsPGZdYdAsDYLvExs8MVTU/RQbClCZXPsbzY7bdMrWiTv7Xl1AZD9xc7cQO8xX20ARntIxkpYeQmhbb8ZxGcAaCsLlGsqG6MyRrxwE91jm4eUwkSsX+58OxnL6vwvREd0zgdveK5UC3cJv0g1r+VRJh6wJaqBIboROOgTWxhzUDTZPU5kfZI6YAkzkUvVtsmVAPYaCRSnr6Yyf4t47auqGg/vMWyQd2ULlEaISsMC3BBJPbWmbl71zNRnhrR4CBXQA2nvDbvLgy6mVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788963988; c=relaxed/relaxed;
	bh=B2E1XiouJbiKFZMbAZsWqLwigQkhP4Kdgia2e4biCBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfVogorCU0aV2N3YbIf0O4psdico14a0EHFzipXNvUmfSPRE7v9ZcleqeNAkeWt3LACiFKvkKyJAiBl4+4YVBYfRWah/4WP5C5FgarUe4/qhakSt8YK1x/JjHnwcNWBDSMITWykr/bsikbkT6eUcKCXFRYJk9CBp+ExFvX0fs1t4fG2nOotSn2Ye7gTlUdm/h38v6FpgY3CU5QXRozd/5JPDQa4Qg7MLwDi26u+WVJisbij1Bsw/DZQxHMhPvCc4S4ZguGDnEOMKIJstOX74tOHCJJqHSpj3f9ZfObQLIcRPRfF7B45YHK8yAFGLi6mmejlz7QnJFUJN+UI1q/nbVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lof0ndO+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lof0ndO+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg35c1BSZz2yth
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 00:26:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6C77640E35;
	Wed,  9 Sep 2026 14:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912861F00A3D;
	Wed,  9 Sep 2026 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963986;
	bh=B2E1XiouJbiKFZMbAZsWqLwigQkhP4Kdgia2e4biCBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lof0ndO+GCvvBWzlCg0yuyQ5KaJmYCa1A9RAJ7L7UlIY4hT386H/5yqmWj13bm194
	 tIDcdPEisVu66g0/lV8RVxBYwCrCYSJlm1/+mysASFusAIc8rm5ysuTDCgINWuCvzf
	 u4F86HGZffRfd0dMRiICmcN6xeAl/m4c5nWBxh2hjbcLrR5twQkwH4me2Waldn6VDg
	 glLz1gQSey5KTegEGp2bM0KVH+UNShIWypEX85pJtUL5NBn7NhyT9MOIk4a0S4iC83
	 b2go8ZI0KoKhglZ1l7l6M2FBEf0znzStbZbhSqKTeZZ53q3LuavNXBe7pzRQLHRnDB
	 V+YNUsH8IbkAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
Date: Wed,  9 Sep 2026 10:26:22 -0400
Message-ID: <20260909142623.2468439-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090355-depose-snarl-daa4@gregkh>
References: <2026090355-depose-snarl-daa4@gregkh>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Farhan Ali <alifm@linux.ibm.com>

[ Upstream commit c243e6c470c4695965cc8287767925bc1d9a7867 ]

Introduce a constant for placeholder value and update the kerneldoc for
pci_create_slot() to reference PCI_SLOT_PLACEHOLDER instead of -1
throughout. No functional change.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://patch.msgid.link/20260805165518.794-2-alifm@linux.ibm.com

Stable backport: this tree predates 102c8b26b54e ("PCI: Allow all bus
devices to use the same slot"). Include its PCI_SLOT_ALL_DEVICES definition,
slot-number documentation, and core matching/address handling so that
subsequent commit dcc5bec09e23 ("PCI: Allow per function PCI slots to fix
slot reset on s390") applies without conflicts. Keep the PCIe hotplug
callers unchanged; enabling bus-wide slots there is outside this dependency.

Retain the stable tree's kzalloc() and ATTRIBUTE_GROUPS() implementations.
The placeholder conversion covers both PowerPC hotplug callers and the
PCI core. All code changes stay within existing functions.

Stable-dep-of: dcc5bec09e23 ("PCI: Allow per function PCI slots to fix slot reset on s390")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pnv_php.c     |  2 +-
 drivers/pci/hotplug/rpaphp_slot.c |  2 +-
 drivers/pci/slot.c                | 50 +++++++++++++++++++++++--------
 include/linux/pci.h               | 13 +++++++-
 4 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index ec7828ad66617..2bd2b7599d1c4 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -799,7 +799,7 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
-		php_slot->slot_no = -1;   /* Placeholder slot */
+		php_slot->slot_no = PCI_SLOT_PLACEHOLDER;   /* Placeholder slot */
 
 	kref_init(&php_slot->kref);
 	php_slot->state	                = PNV_PHP_STATE_INITIALIZED;
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 779eab12e9810..ac8c512190df4 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -85,7 +85,7 @@ int rpaphp_register_slot(struct slot *slot)
 	struct device_node *child;
 	u32 my_index;
 	int retval;
-	int slotno = -1;
+	int slotno = PCI_SLOT_PLACEHOLDER;
 
 	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
 		__func__, slot->dn, slot->index, slot->name,
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index ed645c7a4e4b4..4cdef17152779 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -38,11 +38,20 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
 
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number == 0xff)
+	if (slot->number == PCI_SLOT_PLACEHOLDER)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
 
+	/*
+	 * Preserve legacy ABI expectations that hotplug drivers that manage
+	 * multiple devices per slot emit 0 for the device number.
+	 */
+	if (slot->number == PCI_SLOT_ALL_DEVICES)
+		return sysfs_emit(buf, "%04x:%02x:00\n",
+				  pci_domain_nr(slot->bus),
+				  slot->bus->number);
+
 	return sysfs_emit(buf, "%04x:%02x:%02x\n",
 			  pci_domain_nr(slot->bus),
 			  slot->bus->number,
@@ -74,7 +83,8 @@ static void pci_slot_release(struct kobject *kobj)
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -167,7 +177,8 @@ void pci_dev_assign_slot(struct pci_dev *dev)
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -189,7 +200,8 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn) or -1 for placeholder
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), PCI_SLOT_PLACEHOLDER for placeholder, or
+ *	PCI_SLOT_ALL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
  *
@@ -214,15 +226,26 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
  * In most cases, @pci_bus, @slot_nr will be sufficient to uniquely identify
  * a slot. There is one notable exception - pSeries (rpaphp), where the
  * @slot_nr cannot be determined until a device is actually inserted into
- * the slot. In this scenario, the caller may pass -1 for @slot_nr.
+ * the slot. In this scenario, the caller may pass PCI_SLOT_PLACEHOLDER for @slot_nr.
  *
  * The following semantics are imposed when the caller passes @slot_nr ==
- * -1. First, we no longer check for an existing %struct pci_slot, as there
- * may be many slots with @slot_nr of -1.  The other change in semantics is
- * user-visible, which is the 'address' parameter presented in sysfs will
- * consist solely of a dddd:bb tuple, where dddd is the PCI domain of the
- * %struct pci_bus and bb is the bus number. In other words, the devfn of
- * the 'placeholder' slot will not be displayed.
+ * PCI_SLOT_PLACEHOLDER. First, we no longer check for an existing %struct
+ * pci_slot, as there may be many slots with @slot_nr of
+ * PCI_SLOT_PLACEHOLDER. The other change in semantics is user-visible,
+ * which is the 'address' parameter presented in sysfs will consist solely
+ * of a dddd:bb tuple, where dddd is the PCI domain of the %struct pci_bus
+ * and bb is the bus number. In other words, the devfn of the 'placeholder'
+ * slot will not be displayed.
+ *
+ * Bus-wide slots:
+ * For PCIe hotplug, the physical slot encompasses the entire secondary
+ * bus, not just a single device number. If the device supports ARI and ARI
+ * Forwarding is enabled in the upstream bridge, a multi-function device
+ * may include functions that appear to have several different device
+ * numbers, i.e., PCI_SLOT() values.  Pass @slot_nr == PCI_SLOT_ALL_DEVICES
+ * to create a slot that matches all devices on the bus. Unlike placeholder
+ * slots, bus-wide slots go through normal slot lookup and reuse existing
+ * slots if present.
  */
 struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
@@ -235,7 +258,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
@@ -287,7 +310,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot_nr)
+		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot_nr)
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index db4d82aae1343..9e28323631d03 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -72,12 +72,23 @@
 /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
 #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
 
+/*
+ * PCI_SLOT_ALL_DEVICES indicates a slot that covers all devices on the bus.
+ * Used for PCIe hotplug where the physical slot is the entire secondary bus,
+ * and, if ARI Forwarding is enabled, functions may appear to be on multiple
+ * devices.
+ */
+#define PCI_SLOT_ALL_DEVICES	0xfe
+
+/* Used to identify a slot as a placeholder */
+#define PCI_SLOT_PLACEHOLDER	0xff
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
-	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
+	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
 	struct kobject		kobj;
 };
 
-- 
2.53.0


