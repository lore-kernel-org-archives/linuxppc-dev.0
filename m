Return-Path: <linuxppc-dev+bounces-19539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4954DE99049
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:14:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSj76k7qz2yl2;
	Fri, 10 Apr 2026 17:14:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800269;
	cv=none; b=Ybe91rQ2aPH0yopOlERgHSU4aCmy349Cp4f0auuuFNgU5kcJ6mgHb7SiXj6sCt8TgOSQeYuZ4L3+CCuLrGwrXliXHr95dfBP2FSnnlsgmBejYROc5UsE9mGNK3RAFJkS5pf/QODr9wV8R0Lr8JyKFntxl0GxHc66/D5jD9OZn4Ytmznbl3p/gRTVFo7r54p9lfQPvlw0iQ2IijTOvX1dICp4Xsg0aCUJdWf1hwMXFK+sQZbrUHStnl4jUJu4yL9zaJnVIt5eonJiG0BXAoDXL3jlisvN1+lexI2pdeAWYFFM671p2StMlzwFD6L1ALibhIAZkcjOZ5l8VmA91NCEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800269; c=relaxed/relaxed;
	bh=7yuFROen8Mh93k48NdFogMOj9+O8qxySLeCynEm+GjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRzARQnWCOe8SjmNM08gCmYqx78l6VLveP1PkY/LzbxphCeksdxsmHTqJj2bzlk1AQjRB/H8mFH4DDieXRaRfYfIKsHxM7yjVL1D64r2LuLvIBYcT4U99iqmzeaBGNnbAcGCrfy2xZH0pqFviEtlSnAe6La8z4yRS9aY9LzhPES1VFqGPbcsho4nDW2b82q0z2wiACsVJCpFw4y/NtPKqMA0W/mLpZ24iQPTTGk3I34LNLVdWtP+m6ZuHiNAKiu/DPl7Jr5Y8HJvzNV/r71HX3/cG1yzx0UKNuQ80mqWZIiSkaMxIazOTdkoh5jm1fsJ8O/E2m3g7T/MVH2DV46VOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UEym+wkK; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UEym+wkK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQs81bqRz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:51:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A8B8043E28;
	Fri, 10 Apr 2026 05:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCD8C2BCAF;
	Fri, 10 Apr 2026 05:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800266;
	bh=RX84AOGhnQdH9CGDmJbIPMB5gZIx1iAxD/szIytsyBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEym+wkKOuwAcNoXVrfDiGaCBVZ2+pWzzawijRvVzHqsuRH2UaBKfp4SPsh6ag29/
	 2WnefhdZBk9GdStGxSpCDmEmcuU1C6hAI1VZrd70K1csKfvkXCJOmMvOGvG+0Nwske
	 1TV3gyn5mp4wVojjWNZ/d7AZcALOomO+tdxY+CkgyFc3vMr14uvLBGdmVKQi50402I
	 ou7QClqLTT3Q0wg7rmRQ7kmnYRVNItShnPmGUWkB8Ve27W5XZxYirALzzRAoOR3lMW
	 qmSuiPcR3aTC46a4QeE1TLLKu5N3chYbHBp0/a04RryOcqchBEtFtwEdcgHkBH9jiQ
	 xSb1CFBi8XdUQ==
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
Subject: [PATCH 06/20] PCI/sysfs: Convert PCI resource files to static attributes
Date: Fri, 10 Apr 2026 05:50:26 +0000
Message-ID: <20260410055040.39233-7-kwilczynski@kernel.org>
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

Currently, the PCI resource files (resourceN, resourceN_wc) are
dynamically created by pci_create_sysfs_dev_files(), called from
both pci_bus_add_device() and the pci_sysfs_init() late_initcall,
with only a sysfs_initialized flag for synchronisation.  This has
caused "duplicate filename" warnings and boot panics when both
paths race on the same device.

This is especially likely on Devicetree-based platforms, where the
PCI host controllers are platform drivers that probe via the driver
model, which can happen during or after the late_initcall.  As such,
pci_bus_add_device() and pci_sysfs_init() are more likely to overlap.

Thus, convert to static const attributes with three attribute groups
(I/O, UC, WC), each with an .is_bin_visible callback that checks
resource flags, BAR length, and non_mappable_bars.  A .bin_size
callback provides pci_resource_len() to the kernfs node for correct
stat and lseek behaviour.

As part of this conversion:

  - Rename pci_read_resource_io() and pci_write_resource_io() to
    pci_read_resource() and pci_write_resource() since the callbacks
    are no longer I/O-specific in the static attribute context.

  - Remove pci_create_resource_files(), pci_remove_resource_files(),
    and pci_create_attr() which are no longer needed.

  - Move the __weak stubs outside the #if guard so they remain
    available for callers converted in subsequent commits.

Platforms that do not define the HAVE_PCI_MMAP macro or the
ARCH_GENERIC_PCI_MMAP_RESOURCE macro, such as Alpha architecture,
continue using their platform-specific resource file creation.

For reference, the dynamic creation dates back to the pre-Git era:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/drivers/pci/pci-sysfs.c?id=42298be0eeb5ae98453b3374c36161b05a46c5dc

The write-combine support was added in commit 45aec1ae72fc ("x86: PAT
export resource_wc in pci sysfs").

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 242 +++++++++++++++++++++-------------------
 include/linux/pci.h     |   2 -
 2 files changed, 127 insertions(+), 117 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d29d79be8ee5..e56fddbe7914 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1200,14 +1200,14 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 #endif
 }
 
-static ssize_t pci_read_resource_io(struct file *filp, struct kobject *kobj,
+static ssize_t pci_read_resource(struct file *filp, struct kobject *kobj,
 				    const struct bin_attribute *attr, char *buf,
 				    loff_t off, size_t count)
 {
 	return pci_resource_io(filp, kobj, attr, buf, off, count, false);
 }
 
-static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
+static ssize_t pci_write_resource(struct file *filp, struct kobject *kobj,
 				     const struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
@@ -1261,129 +1261,136 @@ static const struct bin_attribute dev_resource##_bar##_wc_attr = {		\
 	.mmap = pci_mmap_resource_wc,						\
 }
 
-/**
- * pci_remove_resource_files - cleanup resource files
- * @pdev: dev to cleanup
- *
- * If we created resource files for @pdev, remove them from sysfs and
- * free their resources.
- */
-static void pci_remove_resource_files(struct pci_dev *pdev)
+static inline umode_t
+__pci_resource_attr_is_visible(struct kobject *kobj,
+			       const struct bin_attribute *a,
+			       int bar, bool write_combine,
+			       unsigned long flags)
 {
-	int i;
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		struct bin_attribute *res_attr;
-
-		res_attr = pdev->res_attr[i];
-		if (res_attr) {
-			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
-			kfree(res_attr);
-		}
-
-		res_attr = pdev->res_attr_wc[i];
-		if (res_attr) {
-			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
-			kfree(res_attr);
-		}
-	}
-}
-
-static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
-{
-	/* allocate attribute structure, piggyback attribute name */
-	int name_len = write_combine ? 13 : 10;
-	struct bin_attribute *res_attr;
-	char *res_attr_name;
-	int retval;
-
-	res_attr = kzalloc(sizeof(*res_attr) + name_len, GFP_ATOMIC);
-	if (!res_attr)
-		return -ENOMEM;
-
-	res_attr_name = (char *)(res_attr + 1);
-
-	sysfs_bin_attr_init(res_attr);
-	if (write_combine) {
-		sprintf(res_attr_name, "resource%d_wc", num);
-		res_attr->mmap = pci_mmap_resource_wc;
-	} else {
-		sprintf(res_attr_name, "resource%d", num);
-		if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
-			res_attr->read = pci_read_resource_io;
-			res_attr->write = pci_write_resource_io;
-			if (arch_can_pci_mmap_io())
-				res_attr->mmap = pci_mmap_resource_uc;
-		} else {
-			res_attr->mmap = pci_mmap_resource_uc;
-		}
-	}
-	if (res_attr->mmap) {
-		res_attr->f_mapping = iomem_get_mapping;
-		/*
-		 * generic_file_llseek() consults f_mapping->host to determine
-		 * the file size. As iomem_inode knows nothing about the
-		 * attribute, it's not going to work, so override it as well.
-		 */
-		res_attr->llseek = pci_llseek_resource;
-	}
-	res_attr->attr.name = res_attr_name;
-	res_attr->attr.mode = 0600;
-	res_attr->size = pci_resource_len(pdev, num);
-	res_attr->private = (void *)(unsigned long)num;
-	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
-	if (retval) {
-		kfree(res_attr);
-		return retval;
-	}
-
-	if (write_combine)
-		pdev->res_attr_wc[num] = res_attr;
-	else
-		pdev->res_attr[num] = res_attr;
-
-	return 0;
-}
-
-/**
- * pci_create_resource_files - create resource files in sysfs for @dev
- * @pdev: dev in question
- *
- * Walk the resources in @pdev creating files for each resource available.
- */
-static int pci_create_resource_files(struct pci_dev *pdev)
-{
-	int i;
-	int retval;
-
-	/* Skip devices with non-mappable BARs */
 	if (pdev->non_mappable_bars)
 		return 0;
 
-	/* Expose the PCI resources from this device as files */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+	if (!pci_resource_len(pdev, bar))
+		return 0;
 
-		/* skip empty resources */
-		if (!pci_resource_len(pdev, i))
-			continue;
+	if ((pci_resource_flags(pdev, bar) & flags) != flags)
+		return 0;
 
-		retval = pci_create_attr(pdev, i, 0);
-		/* for prefetchable resources, create a WC mappable file */
-		if (!retval && arch_can_pci_mmap_wc() &&
-		    pci_resource_flags(pdev, i) & IORESOURCE_PREFETCH)
-			retval = pci_create_attr(pdev, i, 1);
-		if (retval) {
-			pci_remove_resource_files(pdev);
-			return retval;
-		}
-	}
-	return 0;
+	if (write_combine && !arch_can_pci_mmap_wc())
+		return 0;
+
+	return a->attr.mode;
 }
-#else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
-int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
-void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
+
+static umode_t pci_dev_resource_io_is_visible(struct kobject *kobj,
+					      const struct bin_attribute *a,
+					      int n)
+{
+	return __pci_resource_attr_is_visible(kobj, a, n, false,
+					      IORESOURCE_IO);
+}
+
+static umode_t pci_dev_resource_uc_is_visible(struct kobject *kobj,
+					      const struct bin_attribute *a,
+					      int n)
+{
+	return __pci_resource_attr_is_visible(kobj, a, n, false,
+					      IORESOURCE_MEM);
+}
+
+static umode_t pci_dev_resource_wc_is_visible(struct kobject *kobj,
+					      const struct bin_attribute *a,
+					      int n)
+{
+	return __pci_resource_attr_is_visible(kobj, a, n, true,
+					      IORESOURCE_MEM | IORESOURCE_PREFETCH);
+}
+
+static size_t pci_dev_resource_bin_size(struct kobject *kobj,
+					const struct bin_attribute *a,
+					int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_resource_len(pdev, n);
+}
+
+pci_dev_resource_io_attr(0);
+pci_dev_resource_io_attr(1);
+pci_dev_resource_io_attr(2);
+pci_dev_resource_io_attr(3);
+pci_dev_resource_io_attr(4);
+pci_dev_resource_io_attr(5);
+
+pci_dev_resource_uc_attr(0);
+pci_dev_resource_uc_attr(1);
+pci_dev_resource_uc_attr(2);
+pci_dev_resource_uc_attr(3);
+pci_dev_resource_uc_attr(4);
+pci_dev_resource_uc_attr(5);
+
+pci_dev_resource_wc_attr(0);
+pci_dev_resource_wc_attr(1);
+pci_dev_resource_wc_attr(2);
+pci_dev_resource_wc_attr(3);
+pci_dev_resource_wc_attr(4);
+pci_dev_resource_wc_attr(5);
+
+static const struct bin_attribute *const pci_dev_resource_io_attrs[] = {
+	&dev_resource0_io_attr,
+	&dev_resource1_io_attr,
+	&dev_resource2_io_attr,
+	&dev_resource3_io_attr,
+	&dev_resource4_io_attr,
+	&dev_resource5_io_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_dev_resource_uc_attrs[] = {
+	&dev_resource0_uc_attr,
+	&dev_resource1_uc_attr,
+	&dev_resource2_uc_attr,
+	&dev_resource3_uc_attr,
+	&dev_resource4_uc_attr,
+	&dev_resource5_uc_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_dev_resource_wc_attrs[] = {
+	&dev_resource0_wc_attr,
+	&dev_resource1_wc_attr,
+	&dev_resource2_wc_attr,
+	&dev_resource3_wc_attr,
+	&dev_resource4_wc_attr,
+	&dev_resource5_wc_attr,
+	NULL,
+};
+
+static const struct attribute_group pci_dev_resource_io_attr_group = {
+	.bin_attrs = pci_dev_resource_io_attrs,
+	.is_bin_visible = pci_dev_resource_io_is_visible,
+	.bin_size = pci_dev_resource_bin_size,
+};
+
+static const struct attribute_group pci_dev_resource_uc_attr_group = {
+	.bin_attrs = pci_dev_resource_uc_attrs,
+	.is_bin_visible = pci_dev_resource_uc_is_visible,
+	.bin_size = pci_dev_resource_bin_size,
+};
+
+static const struct attribute_group pci_dev_resource_wc_attr_group = {
+	.bin_attrs = pci_dev_resource_wc_attrs,
+	.is_bin_visible = pci_dev_resource_wc_is_visible,
+	.bin_size = pci_dev_resource_bin_size,
+};
+
 #endif
 
+int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
+void __weak pci_remove_resource_files(struct pci_dev *dev) { }
+
 /**
  * pci_write_rom - used to enable access to the PCI ROM display
  * @filp: sysfs file
@@ -1861,6 +1868,11 @@ static const struct attribute_group pci_dev_group = {
 
 const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_group,
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+	&pci_dev_resource_io_attr_group,
+	&pci_dev_resource_uc_attr_group,
+	&pci_dev_resource_wc_attr_group,
+#endif
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..a7a104427b07 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2501,10 +2501,8 @@ int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
 
-#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 extern int pci_create_resource_files(struct pci_dev *dev);
 extern void pci_remove_resource_files(struct pci_dev *dev);
-#endif
 
 #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
 void __init pci_mmcfg_early_init(void);
-- 
2.53.0


