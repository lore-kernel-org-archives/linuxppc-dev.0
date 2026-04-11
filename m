Return-Path: <linuxppc-dev+bounces-19627-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BECF36BA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:02:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5k46VsSz2ynh;
	Sat, 11 Apr 2026 18:02:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894540;
	cv=none; b=GFpETaCvttU9wBCiTc0CLSdo6MUB31fcUvlXH1fdWPEzCZ2fIhfl35fH2r/aUTAG4P7zY8GLspV+7b1dJeT/lkrXEsk8AzaTkF9spvTJm6c91rKn+NeCuy7jxHTovXQg8lIu2tf0LfoVJtObhI5Gmxsw6ddBfKLmI+j0QgvG7mLfUqV/fktNUpbeK3YxgZvSSqdRsQY63WcqzpFLYEHhST7uYFgsfHm7b9xlLuRgd3q/6oIzIVM31IGIBB6gBMDBrlOQxGvaVO1cXV9Ysi/eDLrLcpTW7Aupy02RXk9uR2hcvDRJayaGKIpfyWSqlinB3S2q6gtv+ZcM4GZTlHqHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894540; c=relaxed/relaxed;
	bh=NNqValq5j8CWj6jVzsjwvNE0SmbPDKL3X/1j70jegdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8njY2CFfy3x4pnL3dbZX61EJRdbOfKaDefwOyzVdUzryWPtfaFA2WPHCUeSjPYEgkXIWx6L2PNO4FsK/oJfO/uzaAO8HNL4UQ+OVP25E8TheRyfRsJiAwrvKQOvSGU75wtBE10FGLo4uDgmDRqqqcQRyW4niqAsramaqD237IFAD/M3a/at7ymO2+Q+yEaJAkLBgX0pXBQFJvbspkbTziML+3OT5w77z6xIaR2jLHXzFQ9UpIfN2bRQTNDul/SnprsYIHioI5N4N3BgMgUVEaAm7dhBDoWUIFrzG6vxfGygplmzJw4MyZBbSOmyjurYN73Q7URRrGN5KCEqKvat8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BAXotC2Y; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BAXotC2Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5k36XSQz2ymg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 454C640903;
	Sat, 11 Apr 2026 08:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CBDC4CEF7;
	Sat, 11 Apr 2026 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894538;
	bh=x/AH9QAAoCuPUN8y8migAOrfyDLPzbk4dDO/e9lMKxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAXotC2Yr5clGYTPMxHQEBoeMf5BJMnTpV99tfXBZJOrqN32KRjOXesnB9S44/PJB
	 B3qSXv3mycS9a9+qmahpoDbqEyNOUW1Pu4WEw81W6dWm7rXi0Z4SRvdfvmmpUuTcXE
	 9uM8970/ijpCOHvP514ItzVYC0R+nJIDySwnLNDP5HoHByuuZ4yEHRI+wxnEpwpO3q
	 pTrIQSqpXAspLFTFe0CMgLMxkNl/5sd01GNesxUXhKC+eVIyMJQ6xy3zdXDDZGJuyv
	 konl4lde2I7y6w9jrGqhpgqf8pWcgZLa6OfYbKfPY17Y8tbe3GpbwGLn7mxJZ5AYcB
	 yHtYsr5lp18bQ==
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
Subject: [PATCH v4 07/24] PCI/sysfs: Convert PCI resource files to static attributes
Date: Sat, 11 Apr 2026 08:01:31 +0000
Message-ID: <20260411080148.471335-8-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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
index ca0074674acc..2922905ff070 100644
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
index 05aceb7f1f37..9c0782899ef9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2526,10 +2526,8 @@ int pcibios_alloc_irq(struct pci_dev *dev);
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


