Return-Path: <linuxppc-dev+bounces-19552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC722E99046
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSl64kswz2yk6;
	Fri, 10 Apr 2026 17:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800320;
	cv=none; b=lsMv24aTQbrUcIU309RTiHBi9m2GBNeH3uDsOnCrFngj9ZXMRdphatWsFDZ57biO/Ij3B6yICQadDDrEWbpRF6j0rNCKpYZr+lcN+QUV3EJOEMAI08P7dxcMtQJhQNrDL2DvBTw6iqpxU5PVJv7/ydLXr15clSC2TlODOYkhj4bS0CC/M8AT+8i7kXCHWKRw/TTyy3LdzjXIAhjIXPZTp5IUbYGdcA6YO1DkeT0ig1jS3Isq6Jg2IeMlUP0MP1GJqu6Y/P10xauADqxX0rkFsyxKoWZuasyd3cRV5Jis2IGn+kY7ZjhgycT5CpUnri+/ihM+zl10euXkmNksAkFVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800320; c=relaxed/relaxed;
	bh=Vf9MEFyGKh14U92xsQRFvgF2M9A007f/HtMNMj53BKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKYQ5a+4/uUK1cK2j93CoEluFA6idHDGFobANfd3EdJSG6CvQOfu6QuEDIw/wgYYBwr7c8wkj4lnDIiGoBtOoRHtvsnMIjJ5Y005VypfTOWd/Qu39D+8Y3eG+T0oi1zk8EKWeYY/sHwfDiiGfpzIGAZS4ZIwGdtyQa5XvuAfHDV4AUo05GjK/6Rb5zhYWzW4XcwLWfspVmiSdZLa374/b0FLW5J4GpdaI15FgRCscOx3HuEg/Inbv/zr1WHllJ+TRlPC5TwmYjD6JuBJhYmOyFeqETC4I1xbZ+99zQ/VhNplABfVGGDPm9Jr64u5f2/Jlv64kXQzEyKZJyLQwH2mGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JzEyOtxT; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JzEyOtxT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQt81d36z2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:52:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 82EDF42DD5;
	Fri, 10 Apr 2026 05:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEB4C2BC9E;
	Fri, 10 Apr 2026 05:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800318;
	bh=/IpJWCBhMhJdU8pXWsPZ3Sw6vKiOKGEePNM6vsVCf/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JzEyOtxTrvkK74a9ZHKH5WHsmnqPAjQtqa4Tn7FqUsSZk8Xzh9w5EFLce4Kyck6lO
	 JvvmD6vjPRt5Z+lB/CugxHSKswjo5yByl7DtICw3gQ0KUkZEzWSKsjiPuW/9q9CS6D
	 5VwYAhr7+DEB5B11bqMAls6REMmBeI2Nue0rxag8crqWOolWWmXSj6PnstSrl+dPcN
	 a+YTv68diVewwRdB2GN6iVNfwNSzlIbGswJ63e76g2H/0wW+1L0kLq3LQuGNaL5djH
	 ZS9mrQ5WYWj05xkyv8fnQLHwRhwub1BdrTZTXCXhKcm6dKNP7hXLl4wzjIj+Jw0+Bo
	 AggwhS3/CrnzA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 20/20] PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()
Date: Fri, 10 Apr 2026 05:50:40 +0000
Message-ID: <20260410055040.39233-21-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, pci_create_legacy_files() and pci_remove_legacy_files() are
no-op stubs.  With legacy attributes now handled by static groups
registered via pcibus_groups[], no call site needs them.

Remove both functions, their declarations, and the call sites in
pci_register_host_bridge(), pci_alloc_child_bus(), and pci_remove_bus().

Remove the pci_sysfs_init() late_initcall and sysfs_initialized.  The
late_initcall originally existed to create all the dynamic PCI sysfs
files, but with both resource and legacy attributes now handled by
static groups, it is no longer needed.

Remove the legacy_io and legacy_mem fields from struct pci_bus which
were used to track the dynamically allocated legacy attributes.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 21 ---------------------
 drivers/pci/pci.h       |  8 --------
 drivers/pci/probe.c     |  6 ------
 drivers/pci/remove.c    |  2 --
 include/linux/pci.h     |  2 --
 5 files changed, 39 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dc0bb0488317..3275698a5d5d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -37,10 +37,6 @@
 #define ARCH_PCI_DEV_GROUPS
 #endif
 
-#ifdef HAVE_PCI_LEGACY
-static int sysfs_initialized;	/* = 0 */
-#endif
-
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
@@ -1135,8 +1131,6 @@ static const struct attribute_group pci_legacy_mem_sparse_group = {
 	.is_bin_visible = pci_legacy_mem_sparse_is_visible,
 };
 
-void pci_create_legacy_files(struct pci_bus *b) { }
-void pci_remove_legacy_files(struct pci_bus *b) { }
 #endif /* HAVE_PCI_LEGACY */
 
 const struct attribute_group *pcibus_groups[] = {
@@ -1809,21 +1803,6 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 };
 #endif
 
-#ifdef HAVE_PCI_LEGACY
-static int __init pci_sysfs_init(void)
-{
-	struct pci_bus *pbus = NULL;
-
-	sysfs_initialized = 1;
-
-	while ((pbus = pci_find_next_bus(pbus)))
-		pci_create_legacy_files(pbus);
-
-	return 0;
-}
-late_initcall(pci_sysfs_init);
-#endif
-
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
 	&dev_attr_serial_number.attr,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f52caf7e4d13..63f249d4833a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -356,14 +356,6 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 int pci_hp_add_bridge(struct pci_dev *dev);
 bool pci_hp_spurious_link_change(struct pci_dev *pdev);
 
-#if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
-void pci_create_legacy_files(struct pci_bus *bus);
-void pci_remove_legacy_files(struct pci_bus *bus);
-#else
-static inline void pci_create_legacy_files(struct pci_bus *bus) { }
-static inline void pci_remove_legacy_files(struct pci_bus *bus) { }
-#endif
-
 /* Lock for read/write access to pci device and bus lists */
 extern struct rw_semaphore pci_bus_sem;
 extern struct mutex pci_slot_mutex;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..94c52bf3a65c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1068,9 +1068,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 			dev_err(&bus->dev, "failed to add bus: %d\n", err);
 	}
 
-	/* Create legacy_io and legacy_mem files for this bus */
-	pci_create_legacy_files(bus);
-
 	if (parent)
 		dev_info(parent, "PCI host bridge to bus %s\n", name);
 	else
@@ -1276,9 +1273,6 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 			dev_err(&child->dev, "failed to add bus: %d\n", ret);
 	}
 
-	/* Create legacy_io and legacy_mem files for this bus */
-	pci_create_legacy_files(child);
-
 	return child;
 }
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 6e796dbc5b29..d8bffa21498a 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -65,8 +65,6 @@ void pci_remove_bus(struct pci_bus *bus)
 	list_del(&bus->node);
 	pci_bus_release_busn_res(bus);
 	up_write(&pci_bus_sem);
-	pci_remove_legacy_files(bus);
-
 	if (bus->ops->remove_bus)
 		bus->ops->remove_bus(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5a418fbe5a5f..c0828b96eb66 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -723,8 +723,6 @@ struct pci_bus {
 	pci_bus_flags_t bus_flags;	/* Inherited by child buses */
 	struct device		*bridge;
 	struct device		dev;
-	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
-	struct bin_attribute	*legacy_mem;	/* Legacy mem */
 	unsigned int		is_added:1;
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
 	unsigned int		flit_mode:1;	/* Link in Flit mode */
-- 
2.53.0


