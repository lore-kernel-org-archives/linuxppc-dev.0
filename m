Return-Path: <linuxppc-dev+bounces-29629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B576CCF2C1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 17:56:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6Tyg5vQRz2y8W;
	Sun, 18 Oct 2026 04:56:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792259803;
	cv=none; b=nNvzELyLpYfaKGSl3DJVys6K0fxbTemjZbDl2+EJ/IH7GSwUWOhrxKdD6FPLkGERUZI6DGc6/nh10AQpGKroGCtLbX1PGs1ou0wMqMBs8kVVO55x38iSlEVr/iV7n8h2zeTiHmDr2JQEqzSxOTGVfEdutqgJ+II18yfsbWqJ6LZHKJmfH7Cp1H1Lu3ZU1UFNi0ftTeIHWCCzr8KFlXZdKATMkuzcqeZBS4j+fO+/XOQ8Ral1tl0OpiBv1QW4pFQYJH5S/rbyQ41YLtvtXGIXMyppzb8pBIlo6QNJXwXpfDD0BtRfFCBTcEBoeT8Vu3mQ6spt99rZGeyihQatgJtA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792259803; c=relaxed/relaxed;
	bh=/W2oRDwkJkEjEDefnbSrBi9IX40AcPibGPsEqj97cOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZGsPfVn1OWy+w0DEfgLnh/HHBof5BbPU6C05rW8k92e7hJdsdm9KMeM7oN+nEfYy0waBnDUAA70xW/qIZwCfsQD89iLMJ6HmDvfrOWX/MZql3opjEjEBFXg+OXxac805Pa1D1eukyG/3CjlYTZEWGmE678tRX1cKbAzh1GoNoG5SpPbeJ18hmjvBn3c7sV9OkRuYtRj828FuM+Zmw1vM4RsS5AXkmD9LLPwrkEHxozLbXzc/iBgixXUEyqJfM9s2VKBu+KLYppPOXchexDYjv8Z2YQk+wc7SFp4MNwozSJbyGlGtHt6lU4rNcpf0MaPgavMrbhurEQ3TsVm3kCM0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=B1thLh76; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=B1thLh76;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6Tyf21Pkz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 04:56:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 02EF04140C;
	Sat, 17 Oct 2026 17:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BB81F000C4;
	Sat, 17 Oct 2026 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792259798;
	bh=/W2oRDwkJkEjEDefnbSrBi9IX40AcPibGPsEqj97cOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1thLh76V0VM8qt5Zaaap8E+AhqcCszisiYvYbALom8GPf9549GCXKyz6RDzrjN16
	 xE+NcJnhZ6z0QwSsnKWcGnn3/7gD8GVSTfY+Kd2WzsFOR07+qjDjogvJR+Lc+Hr9W9
	 MvFELyN/uomS8ISgYxncDYA9h7AqFbyaqJRsvpaA=
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
Subject: [PATCH 6.6 1335/1674] PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
Date: Sat, 17 Oct 2026 18:00:07 +0200
Message-ID: <20261017160505.412125939@linuxfoundation.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017160431.119607952@linuxfoundation.org>
References: <20261017160431.119607952@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
Stable-dep-of: dcc5bec09e23 ("PCI: Allow per function PCI slots to fix slot reset on s390")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pnv_php.c     |  2 +-
 drivers/pci/hotplug/rpaphp_slot.c |  2 +-
 drivers/pci/slot.c                | 30 +++++++++++++++++-------------
 include/linux/pci.h               | 13 ++++++++++++-
 4 files changed, 31 insertions(+), 16 deletions(-)

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
index ed645c7a4e4b4..3a233b4a13136 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -38,7 +38,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
 
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number == 0xff)
+	if (slot->number == PCI_SLOT_PLACEHOLDER)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
@@ -74,7 +74,8 @@ static void pci_slot_release(struct kobject *kobj)
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -167,7 +168,8 @@ void pci_dev_assign_slot(struct pci_dev *dev)
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -189,7 +191,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn) or -1 for placeholder
+ * @slot_nr: PCI_SLOT(pci_dev->devfn) or PCI_SLOT_PLACEHOLDER for placeholder
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
  *
@@ -214,15 +216,16 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
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
  */
 struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
@@ -235,7 +238,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
@@ -287,7 +290,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot_nr)
+		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot_nr)
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bef23297fb801..b35a3fe9d46f5 100644
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




