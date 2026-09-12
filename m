Return-Path: <linuxppc-dev+bounces-27173-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DE7C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 09:31:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhmQ5059Gz2ynZ;
	Sat, 12 Sep 2026 19:31:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789205500;
	cv=none; b=TvHWFNNdv42+gEkuOay1ZxGMbPJ0CewdecIeIkYlNG8QioIwwskgjDCGqin9RHQwXpC9RJQIxpNJL3crf/uknFF9UTCYixTR1RGDwhPrrxgupVQDod5efdt+QV6N5s7FeG/eYuChxX+83PBAJqr4tHqVgbNEuNvEKUwePGpQ1b9CNA5qIEtc4KCJLfQ8pIwTvOviFihh8mZ6vEvu1caj3/qgOsGeWvWbGXgjG6gQWTL8HbzBjSXybZwzlu17fAbejBLv+6uQmCep2HlM7/tqahTBuILB0bfZb/40/bjJplWt3AjbeivD6TIODUwq5GqXrKKO631I3ADmAp3Z1TbCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789205500; c=relaxed/relaxed;
	bh=Qeuf2jDxwPLc/wzfsoXpvPvWt6VcJKt+2J/8FUsoeyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLIfXmRki/sB54QHU+k4KYtLP1WeFTWb4N3k8GGLwsRo/Idk+EigDMBLCX4JTANypEEKxqeSfWGjo8vjPCsRZfb8sHal+BaAZ8oY/6IjvvUhkD+Nc7IxY2jL+3UhjC93YcQiJe0l9hXC9SuSej1lOQMW34fuUNbqbR+0wTytZ4QFllt7Tkg8Qlzvjtg5qGuzy5AJsRfrjqfHqRXQX0EBWoViXlGuvc95zZDvNmIEDvFhAR39ku/HGAf8VVT3mpFLGhVw4IqgSrIFQz1u9ikX5i4JpJ/eJYmelu1BHJ/2+d73cQef/cdbcH/CdMX2GRL7jE7K1b1W9KzbMrakCWkFDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1CqLPcja; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1CqLPcja;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhmQ403gMz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 19:31:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7E046601EF;
	Sat, 12 Sep 2026 09:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A811F000FF;
	Sat, 12 Sep 2026 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789205497;
	bh=Qeuf2jDxwPLc/wzfsoXpvPvWt6VcJKt+2J/8FUsoeyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1CqLPcjaAvyb4hZ7lVUBjPIVAiBmlQ+ZZfs+Yci5awUjiEdBOmfAGJF1WJTVpd0TY
	 Rl+1huzQZ4ndljLgbyQa+7S+vEIyfjcOzuFzpXx54xt94BkzjiWtQJ8FoT/Yo4eNM/
	 EpDOmpSzmc4tS6DmjKMwmk3j8zYUVIFzGBG+N4P4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 0015/1518] PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
Date: Sat, 12 Sep 2026 08:36:24 +0200
Message-ID: <20260912065623.762409402@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912065623.398859879@linuxfoundation.org>
References: <20260912065623.398859879@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/hotplug/pnv_php.c     |    2 -
 drivers/pci/hotplug/rpaphp_slot.c |    2 -
 drivers/pci/slot.c                |   50 ++++++++++++++++++++++++++++----------
 include/linux/pci.h               |   13 +++++++++
 4 files changed, 51 insertions(+), 16 deletions(-)

--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -813,7 +813,7 @@ static struct pnv_php_slot *pnv_php_allo
 	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
-		php_slot->slot_no = -1;   /* Placeholder slot */
+		php_slot->slot_no = PCI_SLOT_PLACEHOLDER;   /* Placeholder slot */
 
 	kref_init(&php_slot->kref);
 	php_slot->state	                = PNV_PHP_STATE_INITIALIZED;
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -85,7 +85,7 @@ int rpaphp_register_slot(struct slot *sl
 	struct device_node *child;
 	u32 my_index;
 	int retval;
-	int slotno = -1;
+	int slotno = PCI_SLOT_PLACEHOLDER;
 
 	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
 		__func__, slot->dn, slot->index, slot->name,
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -37,11 +37,20 @@ static const struct sysfs_ops pci_slot_s
 
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
@@ -73,7 +82,8 @@ static void pci_slot_release(struct kobj
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -166,7 +176,8 @@ void pci_dev_assign_slot(struct pci_dev
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -188,7 +199,8 @@ static struct pci_slot *get_slot(struct
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn) or -1 for placeholder
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), PCI_SLOT_PLACEHOLDER for placeholder, or
+ *	PCI_SLOT_ALL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
  *
@@ -213,15 +225,26 @@ static struct pci_slot *get_slot(struct
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
@@ -234,7 +257,7 @@ struct pci_slot *pci_create_slot(struct
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
@@ -285,7 +308,8 @@ placeholder:
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot_nr)
+		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot_nr)
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
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
 



