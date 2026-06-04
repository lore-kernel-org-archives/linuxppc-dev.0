Return-Path: <linuxppc-dev+bounces-22091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3975CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:17:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlT95d4zz3brN;
	Fri, 05 Jun 2026 12:17:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585338;
	cv=none; b=EqP9UCfZjm/6s+5F856J2mcKgu2zg6TQfKooV8MzFYgg/c2JkwBLLvJkts7h9FXkX2Y58u2WP3/TKtareBGbvMhDKf0C1uiH0wJzcTpPQ2nb5aMp4PbNbqx82+ps6oiDaPJmX+CUTPE0rlpwrFmWcAL56JjTP84N8s4IAycA1mBNFIgjF9x8Ouis9D0ery61pgCMkXHvwNBai4XRFUiy94qxYI0ZuPX/I9c0QBUss8ax93JmtjBQ9cuGi6TlMG1FnssP2znB5onPKeQ/gfvydJLQy8ABmcOfNv9xQ2lrFIN9hoGKB9/JBDcwhRWnWvvxO7KK+CgUKNTtTVHrcjlPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585338; c=relaxed/relaxed;
	bh=PAIcBy7MNrXi3sYH0OZZ5XdCzjkRdcl8LnKIR3KqnsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NchSoqWXS1WbHxX1UQgF/6BiBiKgmIeVRth8VprdQmC7JPPY973bEIjhkei37WRaABdoRbe3SiEEexhM7WkxAAf/n3bHzjSLkYfbowsWLC1J+7PJBoaJfbOoCyzXt0thd7odbF1NZQtQbr/qfyFZqQN80+7LO2IgCDziF1k2gYOKBtWG5KcPSqZjjG92OV2Vv+WSQ3okpN7LlKtOfCdVY66B1hauZ8jiSLy1Qs1zErFip+AVlcw3JhZC/BcNDKzTd1C4Kt5hxdZBeaYoE9GbwHf32P0GpdGp1v+lVSoNCqhW1FqfCJ3MdDljsRJW2gR22X0RjwIZr0LlP5SzlP/6+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bl4hvL9E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bl4hvL9E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTk1gLmz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:18 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso5546035ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585336; x=1781190136; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAIcBy7MNrXi3sYH0OZZ5XdCzjkRdcl8LnKIR3KqnsI=;
        b=Bl4hvL9EEYofmJKB1A4VNG1wVdH9YWZQb+n54f2ChKq77CpoNSge/Y/X5zBUbZwr6O
         sLfMLp8gNm1Y28pyyWxiEjLF5joWkXaELZkZ22a561yeJ41hllTdLbCBiDEZFPPVaG2X
         COZ02qRunKscG8XCNn8RW13dMFhzXjr6pY9PpINQ5cfbcVUHBStIx363hOyoc5qc0rCu
         MdCEyzpkXIRzhMjrDajRsdUmwa7IgadDKxWOkUr4Anya9ZsVCbcWBoCwzRsCzriqoMkJ
         EqrQzSt39r1XT7qmdt+DJzLdI5Gr63rIGgVfFHIZ8wsSZzuuGkSrFFSUSclg9UJll0FJ
         nNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585336; x=1781190136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAIcBy7MNrXi3sYH0OZZ5XdCzjkRdcl8LnKIR3KqnsI=;
        b=l+c2QCK51rcda7SYlqNhptwuKsllzJGhsjphM7Aq+X5EJ79GFgIpX73h5IcgAPEbk8
         g9R51IBVHoLROi2NpptdWa3tWJbY/kE2uea72zHP4M/uXoJzjljxymS+rA6DPJk7HYSr
         bnnmT9OyfCrNbzD0rSAJDtBz1aChKCUFR4IeqDX7sRGwfHNPJj0JgjTGoZ3meWp90tVF
         3zKYIuTalffDZksmdAZAGwtgyK+35aHVUoTPJOxiN/cbZo9/6V5A7QrWG/UaCbDTI0hJ
         kM1SigFuejO4CT0DjUfozjn3laBvZiJCRXFv8doBBFWie0vRB6rZ2OtRb5l0AMhFfASM
         TQZA==
X-Forwarded-Encrypted: i=1; AFNElJ/14hgke+eJM795Wigc6d76fpfPRq8mLolWz+YbD9x5G2zdTlZ6Q2ssZpJESD/2Z/ZbUNkIjkAhVllHXx8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyss5ivU2e6IivDHb51iBb2TP5ftyJukugOgAaZ5eJGofwkI2F6
	DkW81jwiq1jUBqFbbaHBbDhrs8UWV83hYBAV5acw6MMee8Bm14DFjhlK
X-Gm-Gg: Acq92OHmwDAH3qqMCbzrg4PgehxM5WLYrUNcyMcufeg07OqQoOu4uIT6zrq9qZ0KCpj
	geylR3hqxq3HcNiQvepHeqdyw9U+TGAdIRvySh4SENpk1aYvZFLRjr44zZi74QnPdVSVVsDAXyt
	g+AIRFFCW0ofCMWpfVW//UYDgB9AogLu3g4wHkMGa/wh4JNh10o/lJaRXfj84eeUNljPvfwA41p
	p+GasqlNZ2OpCqJT48NZqNqqMvIkgu3ygLu1pnxCLUe3jLpURFrQ2jHInFNcYF5Rr5DjVLpM8ra
	/JcTPlFtM+eJpBB3Vpy3PYVxw/3uH5uTaSdUnR2iaIMHuICRnWHFfDczqGPkshEVItCWrcIjCu/
	rCbU/1/9dcyxMK/NFtgy0MUSE1UagAbmzZghAweRuxAqeUBvaBGOjHr7ngM8oB0WVCQgvbQA0YI
	f27AvCiQC+UR8fJPstD0xv3NsN9bbaKoGMiXaY1/Q=
X-Received: by 2002:a17:903:3c45:b0:2c0:bb2d:a30b with SMTP id d9443c01a7336-2c1644ae17fmr84740035ad.32.1780585333563;
        Thu, 04 Jun 2026 08:02:13 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm64303575ad.54.2026.06.04.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:13 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 11/12] PCI: Initialize and release SIOV capability
Date: Thu,  4 Jun 2026 08:01:52 -0700
Message-ID: <20260604150153.3619662-12-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
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

From: Dimitri Daskalakis <daskald@meta.com>

Modify pci_init_capabilities() to discover the SIOV extended capability
(cap ID 0x38). When present, allocate struct pci_siov that records the
capability position, total SDI count, routing ID offset and stride, and
the maximum bus range the SDIs can span.

The init path mirrors sriov_init(): read the capability registers,
compute the worst-case bus consumption from total_SDIs, and stash the
result in the PF's pci_dev. Release frees the structure on teardown.

If is_physfn was already set (by sriov_init), it will not be cleared if
siov_init() fails. This prevents clobbering the flag for devices that
enable both virtualization types.

The SR-IOV code does not unset the is_physfn bit of a pci device
when disabled, and the SIOV code follows that pattern.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/Makefile |   1 +
 drivers/pci/pci.h    |  16 ++++++
 drivers/pci/probe.c  |   2 +
 drivers/pci/siov.c   | 113 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 drivers/pci/siov.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..a584cd1bf08a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
+obj-$(CONFIG_PCI_SIOV)		+= siov.o
 obj-$(CONFIG_PCI_BRIDGE_EMUL)	+= pci-bridge-emul.o
 obj-$(CONFIG_PCI_LABEL)		+= pci-label.o
 obj-$(CONFIG_X86_INTEL_MID)	+= pci-mid.o
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd7c04e26c16..a516db996aab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1042,6 +1042,22 @@ static inline u16 pci_virtfn_routing_id(struct pci_dev *pf, u16 offset,
 }
 #endif
 
+#ifdef CONFIG_PCI_SIOV
+int pci_siov_init(struct pci_dev *dev);
+void pci_siov_release(struct pci_dev *dev);
+int pci_siov_bus_range(struct pci_bus *bus);
+#else
+static inline int pci_siov_init(struct pci_dev *dev)
+{
+	return -ENODEV;
+}
+static inline void pci_siov_release(struct pci_dev *dev) { }
+static inline int pci_siov_bus_range(struct pci_bus *bus)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
 void pci_save_tph_state(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..bebc32c8d374 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2473,6 +2473,7 @@ static void pci_release_capabilities(struct pci_dev *dev)
 	pci_aer_exit(dev);
 	pci_rcec_exit(dev);
 	pci_iov_release(dev);
+	pci_siov_release(dev);
 	pci_free_cap_save_buffers(dev);
 }
 
@@ -2666,6 +2667,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_vpd_init(dev);		/* Vital Product Data */
 	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
 	pci_iov_init(dev);		/* Single Root I/O Virtualization */
+	pci_siov_init(dev);		/* Scalable I/O Virtualization */
 	pci_ats_init(dev);		/* Address Translation Services */
 	pci_pri_init(dev);		/* Page Request Interface */
 	pci_pasid_init(dev);		/* Process Address Space ID */
diff --git a/drivers/pci/siov.c b/drivers/pci/siov.c
new file mode 100644
index 000000000000..7372ce95714b
--- /dev/null
+++ b/drivers/pci/siov.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express Scalable I/O Virtualization (SIOV) support
+ */
+
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+#include "pci.h"
+
+static int pci_siov_sdi_bus(struct pci_dev *dev, int sdi_id)
+{
+	if (!dev->siov)
+		return -EINVAL;
+	return pci_virtfn_routing_id(dev, dev->siov->offset,
+				  dev->siov->stride, sdi_id) >> 8;
+}
+
+static int compute_max_sdi_buses(struct pci_dev *dev)
+{
+	struct pci_siov *siov = dev->siov;
+
+	if (!siov->offset || (siov->total_SDIs > 1 && !siov->stride))
+		return -EIO;
+
+	siov->max_SDI_buses = pci_siov_sdi_bus(dev, siov->total_SDIs - 1);
+	return 0;
+}
+
+static int siov_init(struct pci_dev *dev, int pos)
+{
+	struct pci_siov *siov;
+	bool was_physfn;
+	u16 total;
+	u8 status;
+	int rc;
+
+	pci_read_config_byte(dev, pos + PCI_SIOV_STATUS, &status);
+	if (status & PCI_SIOV_STATUS_ENABLED)
+		pci_warn(dev, "SIOV: SDIs active at init, FLR may be required\n");
+
+	pci_read_config_word(dev, pos + PCI_SIOV_TOTAL_SDI, &total);
+	if (!total)
+		return 0;
+
+	siov = kzalloc_obj(*siov);
+	if (!siov)
+		return -ENOMEM;
+
+	siov->pos = pos;
+	siov->total_SDIs = total;
+	siov->driver_max_SDIs = total;
+	siov->self = dev;
+	pci_read_config_dword(dev, pos + PCI_SIOV_CAP, &siov->cap);
+	pci_read_config_word(dev, pos + PCI_SIOV_SDI_OFFSET, &siov->offset);
+	pci_read_config_word(dev, pos + PCI_SIOV_SDI_STRIDE, &siov->stride);
+
+	was_physfn = dev->is_physfn;
+
+	dev->siov = siov;
+	dev->is_physfn = 1;
+	dev->is_siov = 1;
+	rc = compute_max_sdi_buses(dev);
+	if (rc) {
+		dev->siov = NULL;
+		dev->is_siov = 0;
+		if (!was_physfn)
+			dev->is_physfn = 0;
+		kfree(siov);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void siov_release(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(dev->siov->num_SDIs);
+
+	kfree(dev->siov);
+	dev->siov = NULL;
+	dev->is_siov = 0;
+}
+
+/**
+ * pci_siov_init - initialize the Scalable IOV capability
+ * @dev: the PCI device
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int pci_siov_init(struct pci_dev *dev)
+{
+	int pos;
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SIOV);
+	if (pos)
+		return siov_init(dev, pos);
+
+	return -ENODEV;
+}
+
+/**
+ * pci_siov_release - release resources used by the SIOV capability
+ * @dev: the PCI device
+ */
+void pci_siov_release(struct pci_dev *dev)
+{
+	if (dev->siov)
+		siov_release(dev);
+}
-- 
2.52.0


