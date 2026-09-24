Return-Path: <linuxppc-dev+bounces-28129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CFCC9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:35:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZY74YXz30Yb;
	Fri, 25 Sep 2026 03:35:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1046"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271317;
	cv=none; b=GaxesDuQExkflaSe99GujkFtl44W+eS/1oYFWVIYT9J2W1Zntx3f9d+I5sKgF+/gpa2qR5ujGiOw7RKof+3XYh87HEgRKsmtH3399O3oCbobwmC4I/vHqbWuHCo2wN/sD63a7URHAznnIfzcppk9Yjt+eepmpI1Gi95bBmpWB9CiBfg0z9RQki7zlwGO+vvtlUMQ7euansUHlEzlv4oLWsc7gNXno9qIbzQdOAPnhSgnosoI7LDI35GgOpbTH7uz0lU9W7UBLBvbNTF6RHbD8pLR93D3b2oGd0Nw2Jqw+eF+/DVApzXr38yURpD3HxzFNBasDw3ra5cLYv2kUbntrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271317; c=relaxed/relaxed;
	bh=L9nB49a1MMywhjZTSEn2J6mRCdtFGuqMGvT1vH3q7CA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eWUOkDYLUXVU7qVQ2wTLcH5vX0PPdc47SerovpdA4T5bHRkB9PdeUA+dtBFb4ltDiGFdTKr2skLyQT1a+oGWqkWjNlckaCF2rQoc81DgmFUbV/8ksOTGxC9d5XJ/GJXi1jp4DVWM4rkaBblrRxwP1/Aoq+in3JHH4fSDNfdjD4yZmhCzGCTmkhLLLPWpl/wwggyGpmJv4sYyRORtjw8i97fgvQcgBsyeXOvnQjJLP2f3rppK5XOU12a1N1EKz5HDKjc8xRsEVtOqm4u3gKnA9bKaGCpbXoYneXbrPkTxUgVxurjtvydDBxKZFmZujV+HNw6UCy3fi43nEh1dUVjZrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I6YmJEWq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=3tv-1aggkdd4irfyqfhplttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I6YmJEWq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=3tv-1aggkdd4irfyqfhplttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1046.google.com (mail-pj1-x1046.google.com [IPv6:2607:f8b0:4864:20::1046])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZR6Y0lz30TL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:11 +1000 (AEST)
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso106758a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271310; x=1790876110; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9nB49a1MMywhjZTSEn2J6mRCdtFGuqMGvT1vH3q7CA=;
        b=I6YmJEWqATJ/XL6Lt/RF14ln9phVwO3bv6xx9Z7jqfh7qpkIs/MOvXY81CblPDZJsv
         dv3CJa8T+v9Vx9oUFc1G66GFMoNiO3bVIvsIWR8aGFSSQS431grh0Qjh0rEOSRqrWD4+
         MqFPZPDJQD17e7myL0z4+8asqpiQI0ZvVgz7LScZbz1zdGiuorO24EuTDqemSYH837mZ
         D+SjAEty/by99A258mvu3aHSzSr/6Pv4VeIqknQLobanXSNysz07oqrY9ePamKUm6lR2
         +ogXBO2jyTKAktEwlGWYTaXLK39OPIGGzzJnqZlMl94XcnzP7nmld7BrY3puVefUAIiA
         e/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271310; x=1790876110;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L9nB49a1MMywhjZTSEn2J6mRCdtFGuqMGvT1vH3q7CA=;
        b=CBuQUonwzg4FQPFtj9Q3m9xuFO9IHAgTpaLEE7PncsSjwu339fykAUSR4SNUnGAsbI
         lLh3OuOhaWHOPg9NWGQdxwW/2xGH67q+LnAZP/4FpWYqmnfpXe0rdDscqrwG4biPMhO0
         QvoPvnwMduNwPuQOPK4QFYI8UTDEQP47lMjAgLMFZx8ugI22QMYpXdevizzcOcklnnTj
         HKkmY/jJsf9+3JefUFFbAbEGE8B1i18Pn9xVjsaukgoADx+C0GI25xMT5C/eLa9PTm6X
         dxLtZeFWzoz1aiUSnA563tMNo+c3QTDlaHOPxptgSFqo2HEZBqPdtXuGLCi3g0bObXdc
         l/fQ==
X-Forwarded-Encrypted: i=1; AKwUvByn6W6qe0AxTELe2TfTURTycvK9la1ZhzLkrVXnBHeuqoqhpuqh4ezHLZYBg5O8GC+0AJ+8xox1slshpMM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lJ4r6v7rZiFwG+vN/1uKn8dmhDzXs7Wj62eiNZkwGv4mAQzPuE
	Of5EZ3IfCBlDH90rhE6iss9ekW3I2X75/2AKjUYWZoLP3Bq8gHIEb1zNec92XQGCL0dyvfqABNd
	pHtZaEOHlemDIwQ==
X-Received: from pjsc15.prod.google.com ([2002:a17:90a:bf0f:b0:3a0:9b5f:3970])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:bc9:b0:3a0:a515:c477 with SMTP id 98e67ed59e1d1-3a0a515c8a1mr1154012a91.16.1790271309408;
 Thu, 24 Sep 2026 10:35:09 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:48 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
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
Mime-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-3-dmatlack@google.com>
Subject: [PATCH 02/15] PCI: Add an offset-indexed store for saved capability registers
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a per-device store for saved capability registers that is indexed by
the offset of the register in configuration space, and whose values are
allocated in one piece during device setup.

The store holds capability registers only. The configuration space header
continues to be saved in pci_dev.saved_config_space, which is embedded in
struct pci_dev so that saving it cannot fail.

Today each capability that has state to preserve across a reset owns a
separate save buffer, allocated by pci_add_cap_save_buffer() and found
by capability ID. The layout of each buffer is private to the code that
saves and restores that capability: a dense array of whichever registers
that code happens to save, in whichever order it saves them.

That has a few consequences:

  - Each capability allocates its own buffer, at nine call sites (plus
    one hand-built by a quirk) that can each fail independently. Four of
    them (AER, DPC, PTM, TPH) ignore the failure, and the save paths for
    those capabilities return quietly when the buffer is missing, so a
    failed allocation leaves the capability unsaved without any message.

  - The layout is defined by the kernel rather than by the device, so it
    changes whenever the core starts or stops saving a register.

  - Nothing ties a saved value back to the register it came from, which
    makes the buffers unusable outside the kernel version that produced
    them.

Reserve registers by configuration space offset during device setup
instead, and allocate the values in a single array once every capability
has been initialized. Reserving a register sets a bit in a per-device
bitmap indexed by DWORD, so a register's position in the store is
derived from the device's own layout, and "was this register saved?" is
a property of the store rather than of which buffers happened to be
allocated.

Embed the bitmap in struct pci_dev rather than allocating it. Every
device needs one during enumeration, so allocating it separately saves
nothing and only adds a failure path that every caller has to tolerate.
The values remain the one allocation, since their number is not known
until enumeration is complete.

Save registers a DWORD at a time, since configuration space reads have
no side effects, but restore them at their own width: neighbouring
registers within a DWORD may be RW1C or may not tolerate being written,
e.g. PCI_EXP_DEVCTL and PCI_EXP_DEVSTA share a DWORD.

A capability's layout can come from the device, so a malformed or
unresponsive device can ask to reserve a register beyond the end of
configuration space. Refuse that quietly and let the caller report it, and
let pci_saved_cap_reserved() ask whether a register has a slot without
warning. Keep warning on a request that no device could have produced,
or on a restore of a register that was never reserved, since both are
kernel bugs, unless the device already had a reservation refused, in
which case skip the restore quietly.

No capability uses this yet. Subsequent patches convert them one at a
time, after which the per-capability buffers are removed.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/Makefile     |   3 +-
 drivers/pci/pci.h        |  12 ++
 drivers/pci/probe.c      |   4 +
 drivers/pci/saved-caps.c | 280 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h      |  30 +++++
 5 files changed, 328 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/saved-caps.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..114fbcb3aee9 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -5,7 +5,8 @@
 obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 				   remove.o pci.o pci-driver.o search.o \
 				   rebar.o rom.o setup-res.o irq.o vpd.o \
-				   setup-bus.o vc.o mmap.o devres.o
+				   setup-bus.o vc.o mmap.o devres.o \
+				   saved-caps.o
 
 obj-$(CONFIG_PCI)		+= msi/
 obj-$(CONFIG_PCI)		+= pcie/
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..93916b0cdd21 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -258,6 +258,18 @@ struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
 struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 						   u16 cap);
 
+void pci_saved_caps_finalize(struct pci_dev *dev);
+void pci_saved_caps_release(struct pci_dev *dev);
+int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int len);
+bool pci_saved_cap_reserved(struct pci_dev *dev, unsigned int off);
+void pci_save_cap_word(struct pci_dev *dev, unsigned int off);
+void pci_save_cap_dword(struct pci_dev *dev, unsigned int off);
+void pci_restore_cap_word(struct pci_dev *dev, unsigned int off);
+void pci_restore_cap_dword(struct pci_dev *dev, unsigned int off);
+bool pci_read_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 *val);
+bool pci_read_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 *val);
+void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val);
+
 #define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..b4c0b8171d94 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2469,6 +2469,7 @@ static void pci_release_capabilities(struct pci_dev *dev)
 	pci_rcec_exit(dev);
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
+	pci_saved_caps_release(dev);
 }
 
 /**
@@ -2677,6 +2678,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
+
+	/* No capability may reserve saved registers after this */
+	pci_saved_caps_finalize(dev);
 }
 
 /*
diff --git a/drivers/pci/saved-caps.c b/drivers/pci/saved-caps.c
new file mode 100644
index 000000000000..649d2cd09e81
--- /dev/null
+++ b/drivers/pci/saved-caps.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Saved capability registers.
+ *
+ * The capability registers that the PCI core saves and restores across resets
+ * and power transitions are kept in a per-device store indexed by the offset
+ * of the register in the device's configuration space. The layout of the
+ * store is therefore described by the device rather than by the kernel, and
+ * does not change when the core starts or stops saving a given register.
+ *
+ * The store covers capability registers only. The configuration space header
+ * is saved in pci_dev.saved_config_space, which is embedded in struct pci_dev
+ * so that saving it cannot fail.
+ *
+ * Only registers that have been reserved during device setup are saved. All
+ * reservations must be made before the store is finalized, which lets the
+ * values be held in a single allocation.
+ *
+ * Registers are stored a DWORD at a time, since reading configuration space
+ * has no side effects and a DWORD read is always safe. Restoring is done at
+ * the width of the register being restored, because neighbouring registers
+ * within the same DWORD may not tolerate being written.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include "pci.h"
+
+/*
+ * Return the slot holding the value saved for the DWORD containing @off, or
+ * NULL if there is nowhere to save it.
+ */
+static u32 *pci_saved_cap_slot(struct pci_dev *dev, unsigned int off)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+	unsigned int dword = off / sizeof(u32);
+
+	/*
+	 * Capabilities whose layout comes from the device can name a register
+	 * beyond the end of configuration space, which is refused at
+	 * reservation time. Degrade quietly.
+	 */
+	if (dword >= PCI_CFG_SPACE_EXP_DWORDS)
+		return NULL;
+
+	if (!test_bit(dword, caps->dword_map)) {
+		/*
+		 * Reaching a register that nobody reserved is a kernel bug,
+		 * unless the device described a capability that does not fit
+		 * in its configuration space. That was refused and reported
+		 * at reservation time.
+		 */
+		WARN_ONCE(!caps->incomplete,
+			  "%s: config space offset %#x was not reserved\n",
+			  pci_name(dev), off);
+		return NULL;
+	}
+
+	/*
+	 * The values are allocated once per device and never reallocated, so
+	 * a device whose allocation failed simply has no saved state. Degrade
+	 * quietly, the failure has already been reported.
+	 */
+	if (!caps->dword_val)
+		return NULL;
+
+	return &caps->dword_val[bitmap_weight(caps->dword_map, dword)];
+}
+
+/**
+ * pci_saved_cap_reserved - test whether a register can be saved
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ *
+ * Return: true if the DWORD containing @off has a slot in the store, false
+ * if nothing reserved it or the values could not be allocated.
+ */
+bool pci_saved_cap_reserved(struct pci_dev *dev, unsigned int off)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+	unsigned int dword = off / sizeof(u32);
+
+	if (!caps->dword_val || dword >= PCI_CFG_SPACE_EXP_DWORDS)
+		return false;
+
+	return test_bit(dword, caps->dword_map);
+}
+
+/**
+ * pci_reserve_saved_cap - reserve space to save a capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @len: size of the register in bytes
+ *
+ * Reserve room to save the register at @off, which may then be saved with
+ * pci_save_cap_word() and friends. Must be called during device setup, before
+ * the store is finalized.
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int len)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+	unsigned int first, last;
+
+	if (WARN_ON(caps->finalized))
+		return -EBUSY;
+
+	/*
+	 * The configuration space header is saved in
+	 * pci_dev.saved_config_space, so only capability registers may be
+	 * reserved here.
+	 */
+	if (WARN_ON(!len || off < PCI_STD_HEADER_SIZEOF))
+		return -EINVAL;
+
+	/*
+	 * Capability sizes and table offsets can come from the device, so a
+	 * malformed or unresponsive device can describe a range that runs past
+	 * the end of configuration space. That is not a kernel bug, so fail
+	 * quietly and let the caller report it.
+	 */
+	if (off + len > PCI_CFG_SPACE_EXP_SIZE) {
+		caps->incomplete = true;
+		return -EINVAL;
+	}
+
+	first = off / sizeof(u32);
+	last = (off + len - 1) / sizeof(u32);
+
+	bitmap_set(caps->dword_map, first, last - first + 1);
+
+	return 0;
+}
+
+/**
+ * pci_save_cap_dword - save a 32-bit capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ */
+void pci_save_cap_dword(struct pci_dev *dev, unsigned int off)
+{
+	u32 *slot = pci_saved_cap_slot(dev, off);
+
+	if (!slot)
+		return;
+
+	pci_read_config_dword(dev, ALIGN_DOWN(off, sizeof(u32)), slot);
+}
+
+/**
+ * pci_save_cap_word - save a 16-bit capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ */
+void pci_save_cap_word(struct pci_dev *dev, unsigned int off)
+{
+	pci_save_cap_dword(dev, ALIGN_DOWN(off, sizeof(u32)));
+}
+
+/**
+ * pci_read_saved_cap_dword - read the saved value of a 32-bit register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @val: where to store the saved value
+ *
+ * Return: true if a saved value was available, false otherwise.
+ */
+bool pci_read_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 *val)
+{
+	u32 *slot = pci_saved_cap_slot(dev, off);
+
+	if (!slot)
+		return false;
+
+	*val = *slot;
+
+	return true;
+}
+
+/**
+ * pci_read_saved_cap_word - read the saved value of a 16-bit register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @val: where to store the saved value
+ *
+ * Return: true if a saved value was available, false otherwise.
+ */
+bool pci_read_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 *val)
+{
+	u32 dword;
+
+	if (!pci_read_saved_cap_dword(dev, ALIGN_DOWN(off, sizeof(u32)), &dword))
+		return false;
+
+	*val = dword >> (8 * (off & (sizeof(u32) - 1)));
+
+	return true;
+}
+
+/**
+ * pci_write_saved_cap_word - change the saved value of a 16-bit register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @val: value to save
+ */
+void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val)
+{
+	unsigned int shift = 8 * (off & (sizeof(u32) - 1));
+	u32 *slot = pci_saved_cap_slot(dev, off);
+
+	if (!slot)
+		return;
+
+	*slot &= ~((u32)U16_MAX << shift);
+	*slot |= (u32)val << shift;
+}
+
+/**
+ * pci_restore_cap_dword - restore a 32-bit capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ */
+void pci_restore_cap_dword(struct pci_dev *dev, unsigned int off)
+{
+	u32 val;
+
+	if (pci_read_saved_cap_dword(dev, off, &val))
+		pci_write_config_dword(dev, off, val);
+}
+
+/**
+ * pci_restore_cap_word - restore a 16-bit capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ */
+void pci_restore_cap_word(struct pci_dev *dev, unsigned int off)
+{
+	u16 val;
+
+	if (pci_read_saved_cap_word(dev, off, &val))
+		pci_write_config_word(dev, off, val);
+}
+
+/**
+ * pci_saved_caps_finalize - allocate room for a device's saved registers
+ * @dev: the PCI device
+ *
+ * Called once every capability that reserves registers has been initialized.
+ * No register may be reserved after this.
+ */
+void pci_saved_caps_finalize(struct pci_dev *dev)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+
+	caps->finalized = true;
+
+	caps->nr_dwords = bitmap_weight(caps->dword_map, PCI_CFG_SPACE_EXP_DWORDS);
+	if (!caps->nr_dwords)
+		return;
+
+	caps->dword_val = kzalloc_objs(*caps->dword_val, caps->nr_dwords, GFP_KERNEL);
+	if (!caps->dword_val)
+		pci_err(dev, "unable to allocate %u saved capability registers\n",
+			caps->nr_dwords);
+}
+
+/**
+ * pci_saved_caps_release - free a device's saved capability registers
+ * @dev: the PCI device
+ */
+void pci_saved_caps_release(struct pci_dev *dev)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+
+	kfree(caps->dword_val);
+	caps->dword_val = NULL;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..7b80f809f934 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -333,6 +333,35 @@ struct pci_vpd {
 	u8		cap;
 };
 
+/*
+ * Reservations are tracked for the largest configuration space a device can
+ * have, since quirks can still change pci_dev.cfg_size after the device has
+ * been enumerated.
+ */
+#define PCI_CFG_SPACE_EXP_DWORDS	(PCI_CFG_SPACE_EXP_SIZE / sizeof(u32))
+
+/**
+ * struct pci_saved_caps - a device's saved capability registers
+ * @nr_dwords: number of DWORDs reserved, i.e. entries in @dword_val
+ * @finalized: set once @dword_val has been allocated, after which nothing
+ *	       may be reserved
+ * @incomplete: set if the device described a register that does not fit
+ *		in its configuration space, so the reservation was refused
+ * @dword_val: saved values, in ascending configuration space offset order
+ * @dword_map: one bit per DWORD of configuration space, set if that DWORD
+ *	       has a slot in @dword_val
+ *
+ * Private to the PCI core, defined here only so that it can be embedded in
+ * struct pci_dev. Use the pci_{save,restore}_cap_*() accessors.
+ */
+struct pci_saved_caps {
+	u16		nr_dwords;
+	bool		finalized;
+	bool		incomplete;
+	u32		*dword_val;
+	unsigned long	dword_map[BITS_TO_LONGS(PCI_CFG_SPACE_EXP_DWORDS)];
+};
+
 struct irq_affinity;
 struct pcie_bwctrl_data;
 struct pcie_link_state;
@@ -520,6 +549,7 @@ struct pci_dev {
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
+	struct pci_saved_caps saved_caps; /* Saved capability registers */
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


