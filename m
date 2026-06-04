Return-Path: <linuxppc-dev+bounces-22090-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FABCCD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:17:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlT36JRrz3byh;
	Fri, 05 Jun 2026 12:17:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585335;
	cv=none; b=VnW4u2ws58QAhnaH6AiJMpiHgaKXJwcooTpkksIcOj4TJs9iu6eZp2/eDr0iGR/gGnGRW0fWiuyf1veSEshKXJCJjqngqtfT7O6kQWtOuZXXExTULAuulWwyltJxCNdkOXeP/7KH8KoS/yApb8QNSOGDa2znB01lmBKHYa7xRPPBhK3Z1lBX8RmccIKJ72bwDWL/SSVbPV4SZMrVEkP2q3xep5ai5rW5UuGKXvdhjS+qYwRXr7vOryq3PUGDfvYkRW2SAsmdZxJqJERtUemJ4nEXRUvGjDx0p5cCn42QuW956FoeK0PlwY41Wd9556qbc0C7dkxzODyZ4yHD6HEtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585335; c=relaxed/relaxed;
	bh=2Bo6bv9IyO26QNTtP+PpQ5foOOUKiHlTonbwk1FrZVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0ubqcUo+h/OZz9EnWkn3eqBET/v3WbYRQdOHgYLEcQJuMYcrWQZNQKoFEslC8fRiTPJmJ+zH4Fs+KO2rqdG6Wz+0G5/tF30yYWRBmLmdiTaHqMeWEuwQF5uDlGc80qG9gaJoGw7ibiMkVcorJAkaCyl0Rb0hJisNc67FssBji40opzqh0qTZDYZuozi40fJHVnRc+U7YG37LL6IwLnZ6zc5MuQuGmYIpDWEJmmcCxKXIram2AGlf1k7q82cBzgtlJJUsLNDEsrcoWXef2R5hN7d2AG8AJAodMC6iX0SsnMi3KZlVj4iZSHYlm8mtmtNanpj3DJK2EsuqVVikoP20w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TLjTobT+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TLjTobT+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTf3jxjz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:14 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2bf3781ca51so9119955ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585332; x=1781190132; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bo6bv9IyO26QNTtP+PpQ5foOOUKiHlTonbwk1FrZVg=;
        b=TLjTobT+Kr5/LRfZaZJFRGorIyZYzETRIpaOt3YlIadZGlAk2LaL2RAonPtfZt7jEo
         RjU9Iw2PonSrq4Ty/ozPctY1xEhdltrRWGevzKzbTfZO6K5vCSyxusnDgxkFGH+aukuc
         2Bnz7pmzMraJGsO9Yfw5mzg7qF9nNSfaHBi7eCoSM0j5zSOto6Hijrs92+xh80mZ5Av6
         4XwJmE29Yl4UxhG5Lklz5Vjv9o+xJtC/U6aPfjiD7ZJmyFzmJ8YDcF+2rArGLO2KwY/D
         v7BrRP7/OaEeqB1q6oFCHv/XjqHwg/Zh1j8bdttg104pw6wFey6ifKYvgVUEMBMq7GJo
         EvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585332; x=1781190132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Bo6bv9IyO26QNTtP+PpQ5foOOUKiHlTonbwk1FrZVg=;
        b=mglaK5KllSi284UQq+F2dblwTUfsE56ndqUfFbdllSkEC5dizPPi7U+WsYlyD+ozbY
         Tokr2HuKl1ELzOK28xOnZz2hZRXtlmL0c11y0SlHrRqZri9nzqLjTVIBvJCY5Y0XJaN0
         WP6nSK9KL/c+cKeK24su3tfFXFmRd1vYR3BzJiojIQFbCDDjDqQcdZZShn5lVxXpGafR
         SxcvKo9tEOQbVbxsAE63O+GTuNbCzE6MGC08utuXm+Q15kW43mOHSOZRbp7/RuZaKXg9
         MFzwUhNmJelAa3U8ignTuTQ0FvgW1IuEaB7vRPN+A+TVQ1OJqZPmS/vCDC6NloLJqQQw
         Wxnw==
X-Forwarded-Encrypted: i=1; AFNElJ8qZQjP3RWUo2zHa0N4Avel22sn9k6tTS90T+LRls4eAjwmTyBUqYOE8X1cY222kW/rpRXSaRrZsFRkAII=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZwe9to2KwPqaj4W2iUHYuKPgELaTAaTYPQOb269uEZLRbUGnf
	VyuOuusdauwjqho+VXXbFrbQooJFBDB75xvidoLqd7oW/isI8uIgDt7r
X-Gm-Gg: Acq92OFS66CIYQx9W8M4khFNUpLYu16JhM7bIGPkd3LzZI7+R9YraCYtszBwVcFhLWe
	i/vQWZMtAyMcfe5C1EEiJByVp7xEgwNG6C6boT11Fyos9MqsEQMuTuDC41qCVqaVpnSjeql0Nxo
	ygXpzj9T1MG1xeZy5tut8H9Ti9iYFYyrSb2M8QnJHxJEsE0XbVUORxsDJZL+H/Kzsh0v22MoS3E
	j1HxviIavWzJuiW5KvH9XpeuKwu29TFt0ogNtaPI8v0ksqxFTA4ebKlxGdlzhL+iL57udtW/VcF
	gvh03siZ9D+nA0HefSfM/32SKl/pMtQfWXyLfXNgMxJ+Daig2qCzbhsxBqVknMDcR4ysoZNBnvG
	qvhlDoFIswUga/OPyK3De+7qPnT6c9+j8ISLTtyAFLpr9B8K1X4WM1/+sN1EFQk70RozxV/D572
	qtOyqZ5d3WoZdF+L5nywOHfxRID1KI/M4FLyjo9IrpgrSh7L6Y
X-Received: by 2002:a17:902:ced1:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c1634f9212mr84880605ad.0.1780585331912;
        Thu, 04 Jun 2026 08:02:11 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df79sm62220215ad.42.2026.06.04.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:11 -0700 (PDT)
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
Subject: [RFC 10/12] PCI: Add Scalable I/O Virtualization data structure definitions
Date: Thu,  4 Jun 2026 08:01:51 -0700
Message-ID: <20260604150153.3619662-11-dimitri.daskalakis1@gmail.com>
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

Define the PCIe SIOV extended capability registers per the PCIe 7.0
spec, and introduce the kernel-internal data structures needed to track
SIOV state on a Physical Function. PCI-SIG members can access the spec
here https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/22464.

The PCI_SIOV kconfig selects PCI_ATS rather than attempting to decouple
the sriov/physfn union within struct pci_dev from CONFIG_PCI_ATS. If
desired this can be done in the future, since ATS is optional
for SR-IOV and SIOV.

Inspired by struct pci_sriov, struct pci_siov records the
capability position, total SDI count, routing ID offset/stride, and
driver-configurable limits.

Add an is_siov bit to struct pci_dev along with helpers to identify
SIOV PFs/VFs.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/Kconfig           | 11 +++++++++++
 drivers/pci/pci.h             | 13 +++++++++++++
 include/linux/pci.h           | 16 +++++++++++++++-
 include/uapi/linux/pci_regs.h | 12 +++++++++++-
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 33c88432b728..930231835c40 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -164,6 +164,17 @@ config PCI_IOV
 
 	  If unsure, say N.
 
+config PCI_SIOV
+	bool "PCI Scalable IOV support"
+	select PCI_ATS
+	help
+	  Scalable I/O Virtualization is a PCIe feature that allows devices
+	  to expose lightweight Scalable Device Interfaces (SDIs). Unlike
+	  SR-IOV Virtual Functions, SDIs have no config space or BARs and
+	  rely on software to compose the control path.
+
+	  If unsure, say N.
+
 config PCI_NPEM
 	bool "Native PCIe Enclosure Management"
 	depends on LEDS_CLASS=y
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 45411960fd2e..fd7c04e26c16 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -683,6 +683,19 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
+/* Scalable I/O Virtualization */
+struct pci_siov {
+	struct pci_dev	*self;		/* This PF */
+	u32		cap;		/* SIOV Capabilities */
+	u16		pos;		/* Capability position */
+	u16		total_SDIs;	/* Total SDIs associated with the PF */
+	u16		num_SDIs;	/* Number of SDIs currently enabled */
+	u16		offset;		/* First SDI Routing ID offset */
+	u16		stride;		/* Following SDI stride */
+	u16		driver_max_SDIs;/* Max num SDIs driver supports */
+	u8		max_SDI_buses;	/* Max buses consumed by SDIs */
+};
+
 #ifdef CONFIG_PCI_DOE
 void pci_doe_init(struct pci_dev *pdev);
 void pci_doe_destroy(struct pci_dev *pdev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ca84f66425b2..eba562474017 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -480,6 +480,7 @@ struct pci_dev {
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
 	unsigned int	is_sriov:1;		/* SR-IOV is enabled on this device (PF or VF) */
+	unsigned int	is_siov:1;		/* SIOV is enabled on this device (PF or VF/SDI) */
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
@@ -549,6 +550,9 @@ struct pci_dev {
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
 #endif
+#ifdef CONFIG_PCI_SIOV
+	struct pci_siov	*siov;		/* PF: Scalable IOV info */
+#endif
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
@@ -598,7 +602,7 @@ struct pci_dev {
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 {
-#ifdef CONFIG_PCI_IOV
+#if defined(CONFIG_PCI_IOV) || defined(CONFIG_PCI_SIOV)
 	if (dev->is_virtfn)
 		dev = dev->physfn;
 #endif
@@ -615,6 +619,16 @@ static inline bool pci_is_sriov_virtfn(const struct pci_dev *dev)
 	return dev->is_virtfn && dev->is_sriov;
 }
 
+static inline bool pci_is_siov_physfn(const struct pci_dev *dev)
+{
+	return dev->is_physfn && dev->is_siov;
+}
+
+static inline bool pci_is_siov_virtfn(const struct pci_dev *dev)
+{
+	return dev->is_virtfn && dev->is_siov;
+}
+
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..0f81c8c72b05 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -763,7 +763,8 @@
 #define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
 #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
+#define PCI_EXT_CAP_ID_SIOV	0x38	/* Scalable I/O Virtualization */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_SIOV
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1005,6 +1006,15 @@
 #define  PCI_SRIOV_VFM_AV	0x3	/* Active.Available */
 #define PCI_EXT_CAP_SRIOV_SIZEOF 0x40
 
+/* Scalable I/O Virtualization */
+#define PCI_SIOV_CAP		0x04	/* SIOV Capabilities */
+#define PCI_SIOV_TOTAL_SDI	0x08	/* Total SDIs */
+#define PCI_SIOV_STATUS		0x0B	/* SIOV Status */
+#define PCI_SIOV_STATUS_ENABLED 0x01	/* At least one SDI is enabled */
+#define PCI_SIOV_SDI_OFFSET	0x0C	/* First SDI Offset */
+#define PCI_SIOV_SDI_STRIDE	0x0E	/* SDI Stride */
+#define PCI_EXT_CAP_SIOV_SIZEOF	0x10
+
 #define PCI_LTR_MAX_SNOOP_LAT	0x4
 #define PCI_LTR_MAX_NOSNOOP_LAT	0x6
 #define  PCI_LTR_VALUE_MASK	0x000003ff
-- 
2.52.0


