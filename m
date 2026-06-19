Return-Path: <linuxppc-dev+bounces-22807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD5ECD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:54:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWZt0HlFz3brv;
	Fri, 19 Jun 2026 18:53:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859190;
	cv=none; b=ZVNo/ySl12HqW4KUVhuVcJJsqmdCRYxKv+3AeuVm5wgkvz9Qoz8UplfSjxngAck3+dxi8P2lyFws/P1cAIm+7GqJD5GK3TvxOY2lMIWVSShdN7HZun/PuLk247RguOPpdpGB74nV4pjGFioFL5ozusajVOsAhMbRRMu2T0kEPX3hgoyZWyzYPTyoH7YxmGqj/vWI3bjeYM1/e50cYWLB62fl8JXHdV1E0BeP5n66rscVpabLqAD7j/93+VBCZPv56hcHjaED4rdGS+MhxKDJ8aApqTBSyJaHpvpzyYisEmCifmteun7Aq4dmDuNaUolWB6uI0dlj95tsoSOUsuwU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859190; c=relaxed/relaxed;
	bh=DIrwADqzFE+5ytdebW75nrlk0Er0k9JpPbwgDMSNHRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8i0czETMU6GF3CqbE+4VslzbLde8R8gb5zNYftHDTH/smfAaUkPzCxZVYUYbH+GrEnq5ILTcuM3lDNOjDr1liNo/6TEU6v0DdJEzZ2aXZe2ejmgHqeeP7ol548pMXnQ329FDDT/tdpwbfjhDYN8fV8+FyN4wFfU5zvEgQB3ehpzmJla00SrT3sj4DqZpn02H++SzIYUWWR3AwPt3xUuGlwHtyYeH3ARw6kGBbPcRs0t3ZpOkYHPGmRvpO4U/aV1wqbnHvMgyKnkqGBpsRJEhrKzcphHkxvI1jYuOFzRHMmanOy1yR+LdIoGeXn1RIoZKpdy5CDO0Ao/GCIGci9RAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEBoRzBf; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEBoRzBf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWZs0jThz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:53:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 291B0601E4;
	Fri, 19 Jun 2026 08:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ECA1F00AC4;
	Fri, 19 Jun 2026 08:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859186;
	bh=DIrwADqzFE+5ytdebW75nrlk0Er0k9JpPbwgDMSNHRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UEBoRzBfOev1XRDIBeSlKCZwH4RasEukGzaYoLNdKWTqkn6JtMBdKaEDd6r6Def6C
	 ITl6eHNeN5dYmew8/+wiQrusy9ydkFdGPJIAHMLH1alBMNxo5LQG+JHlFENlRtfzP/
	 rVsdK0DYy7ItcK4JFUszixxmGaIoyNcGDseW/d/5ZXeefrmIbitWiloPcGL1PPRQJH
	 8IrCeV/Q10DP6N/TcKp4oMZHoGygkpD5o8fIWIqxq2ytt8AJ804aPrNg/tiTlppwTe
	 NhZlO0gx1zus7YewRvmvf1pOKuPhLZeYPcvflx84Qc5LPeUKumpoTeHhm2LUO4GfCK
	 nVhoe1KAu9Dsw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
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
Subject: [PATCH v8 17/25] alpha/PCI: Convert resource files to static attributes
Date: Fri, 19 Jun 2026 08:51:52 +0000
Message-ID: <20260619085200.3729431-18-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
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

Currently, Alpha's PCI resource files (resourceN, resourceN_sparse,
resourceN_dense) are dynamically created by pci_create_resource_files(),
which overrides the generic __weak implementation.  The current code
allocates bin_attributes at runtime and manages them via the res_attr[]
and res_attr_wc[] fields in struct pci_dev.

Thus, convert to static const attributes with three attribute groups
(plain, sparse, dense), each with an .is_bin_visible callback that
checks resource length, has_sparse(), and sparse_mem_mmap_fits().  A
.bin_size callback provides the resource size to the kernfs node, with
the sparse variant shifting by 5 bits for byte-level addressing.

Register the groups via ARCH_PCI_DEV_GROUPS so the driver model handles
creation and removal automatically.

Use the new pci_resource_is_mem() helper for the type check, replacing
the open-coded bitwise flag test.

Finally, remove pci_create_resource_files(), pci_remove_resource_files(),
pci_create_attr(), and pci_create_one_attr() which are no longer needed.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/include/asm/pci.h  |   9 ++
 arch/alpha/kernel/pci-sysfs.c | 291 +++++++++++++++++++---------------
 2 files changed, 172 insertions(+), 128 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index 6c04fcbdc8ed..ef19295f2e33 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -88,4 +88,13 @@ extern void pci_adjust_legacy_attr(struct pci_bus *bus,
 				   enum pci_mmap_state mmap_type);
 #define HAVE_PCI_LEGACY	1
 
+extern const struct attribute_group pci_dev_resource_attr_group;
+extern const struct attribute_group pci_dev_resource_sparse_attr_group;
+extern const struct attribute_group pci_dev_resource_dense_attr_group;
+
+#define ARCH_PCI_DEV_GROUPS		\
+	&pci_dev_resource_attr_group,	\
+	&pci_dev_resource_sparse_attr_group,	\
+	&pci_dev_resource_dense_attr_group,
+
 #endif /* __ALPHA_PCI_H */
diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 650f7795cc40..ae448a2e40c5 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -12,8 +12,6 @@
 
 #include <linux/sched.h>
 #include <linux/security.h>
-#include <linux/stat.h>
-#include <linux/slab.h>
 #include <linux/pci.h>
 
 static int hose_mmap_page_range(struct pci_controller *hose,
@@ -124,34 +122,6 @@ pci_dev_resource##_bar##_suffix##_attr = {			\
 	__pci_dev_resource_attr(_dense, _bar, resource##_bar##_dense,	\
 				pci_mmap_resource_dense)
 
-/**
- * pci_remove_resource_files - cleanup resource files
- * @pdev: pci_dev to cleanup
- *
- * If we created resource files for @dev, remove them from sysfs and
- * free their resources.
- */
-void pci_remove_resource_files(struct pci_dev *pdev)
-{
-	int i;
-
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
 static int sparse_mem_mmap_fits(struct pci_dev *pdev, int num)
 {
 	struct pci_bus_region bar;
@@ -171,104 +141,6 @@ static int sparse_mem_mmap_fits(struct pci_dev *pdev, int num)
 	return bar.end < sparse_size;
 }
 
-static int pci_create_one_attr(struct pci_dev *pdev, int num, char *name,
-			       char *suffix, struct bin_attribute *res_attr,
-			       unsigned long sparse)
-{
-	size_t size = pci_resource_len(pdev, num);
-
-	sprintf(name, "resource%d%s", num, suffix);
-	res_attr->mmap = sparse ? pci_mmap_resource_sparse :
-				  pci_mmap_resource_dense;
-	res_attr->attr.name = name;
-	res_attr->attr.mode = S_IRUSR | S_IWUSR;
-	res_attr->size = sparse ? size << 5 : size;
-	res_attr->private = (void *)(unsigned long)num;
-	return sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
-}
-
-static int pci_create_attr(struct pci_dev *pdev, int num)
-{
-	/* allocate attribute structure, piggyback attribute name */
-	int retval, nlen1, nlen2 = 0, res_count = 1;
-	unsigned long sparse_base, dense_base;
-	struct bin_attribute *attr;
-	struct pci_controller *hose = pdev->sysdata;
-	char *suffix, *attr_name;
-
-	suffix = "";	/* Assume bwx machine, normal resourceN files. */
-	nlen1 = 10;
-
-	if (pci_resource_is_mem(pdev, num)) {
-		sparse_base = hose->sparse_mem_base;
-		dense_base = hose->dense_mem_base;
-		if (sparse_base && !sparse_mem_mmap_fits(pdev, num)) {
-			sparse_base = 0;
-			suffix = "_dense";
-			nlen1 = 16;	/* resourceN_dense */
-		}
-	} else {
-		sparse_base = hose->sparse_io_base;
-		dense_base = hose->dense_io_base;
-	}
-
-	if (sparse_base) {
-		suffix = "_sparse";
-		nlen1 = 17;
-		if (dense_base) {
-			nlen2 = 16;	/* resourceN_dense */
-			res_count = 2;
-		}
-	}
-
-	attr = kzalloc(sizeof(*attr) * res_count + nlen1 + nlen2, GFP_ATOMIC);
-	if (!attr)
-		return -ENOMEM;
-
-	/* Create bwx, sparse or single dense file */
-	attr_name = (char *)(attr + res_count);
-	pdev->res_attr[num] = attr;
-	retval = pci_create_one_attr(pdev, num, attr_name, suffix, attr,
-				     sparse_base);
-	if (retval || res_count == 1)
-		return retval;
-
-	/* Create dense file */
-	attr_name += nlen1;
-	attr++;
-	pdev->res_attr_wc[num] = attr;
-	return pci_create_one_attr(pdev, num, attr_name, "_dense", attr, 0);
-}
-
-/**
- * pci_create_resource_files - create resource files in sysfs for @pdev
- * @pdev: pci_dev in question
- *
- * Walk the resources in @dev creating files for each resource available.
- *
- * Return: %0 on success, or negative error code
- */
-int pci_create_resource_files(struct pci_dev *pdev)
-{
-	int i;
-	int retval;
-
-	/* Expose the PCI resources from this device as files */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-
-		/* skip empty resources */
-		if (!pci_resource_len(pdev, i))
-			continue;
-
-		retval = pci_create_attr(pdev, i);
-		if (retval) {
-			pci_remove_resource_files(pdev);
-			return retval;
-		}
-	}
-	return 0;
-}
-
 /* Legacy I/O bus mapping stuff. */
 
 static int __legacy_mmap_fits(struct vm_area_struct *vma,
@@ -381,3 +253,166 @@ int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val, size_t size)
 	}
 	return -EINVAL;
 }
+
+pci_dev_resource_attr(0);
+pci_dev_resource_attr(1);
+pci_dev_resource_attr(2);
+pci_dev_resource_attr(3);
+pci_dev_resource_attr(4);
+pci_dev_resource_attr(5);
+
+pci_dev_resource_sparse_attr(0);
+pci_dev_resource_sparse_attr(1);
+pci_dev_resource_sparse_attr(2);
+pci_dev_resource_sparse_attr(3);
+pci_dev_resource_sparse_attr(4);
+pci_dev_resource_sparse_attr(5);
+
+pci_dev_resource_dense_attr(0);
+pci_dev_resource_dense_attr(1);
+pci_dev_resource_dense_attr(2);
+pci_dev_resource_dense_attr(3);
+pci_dev_resource_dense_attr(4);
+pci_dev_resource_dense_attr(5);
+
+static inline enum pci_mmap_state pci_bar_mmap_type(struct pci_dev *pdev,
+						    int bar)
+{
+	return pci_resource_is_mem(pdev, bar) ? pci_mmap_mem : pci_mmap_io;
+}
+
+static inline umode_t __pci_resource_attr_is_visible(struct kobject *kobj,
+						     const struct bin_attribute *a,
+						     int bar)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (!pci_resource_len(pdev, bar))
+		return 0;
+
+	return a->attr.mode;
+}
+
+static umode_t pci_dev_resource_is_visible(struct kobject *kobj,
+					   const struct bin_attribute *a,
+					   int bar)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_controller *hose = pdev->sysdata;
+
+	if (has_sparse(hose, pci_bar_mmap_type(pdev, bar)))
+		return 0;
+
+	return __pci_resource_attr_is_visible(kobj, a, bar);
+}
+
+static umode_t pci_dev_resource_sparse_is_visible(struct kobject *kobj,
+						  const struct bin_attribute *a,
+						  int bar)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_controller *hose = pdev->sysdata;
+	enum pci_mmap_state type = pci_bar_mmap_type(pdev, bar);
+
+	if (!has_sparse(hose, type))
+		return 0;
+
+	if (type == pci_mmap_mem && !sparse_mem_mmap_fits(pdev, bar))
+		return 0;
+
+	return __pci_resource_attr_is_visible(kobj, a, bar);
+}
+
+static umode_t pci_dev_resource_dense_is_visible(struct kobject *kobj,
+						 const struct bin_attribute *a,
+						 int bar)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_controller *hose = pdev->sysdata;
+	enum pci_mmap_state type = pci_bar_mmap_type(pdev, bar);
+	unsigned long dense_base;
+
+	if (!has_sparse(hose, type))
+		return 0;
+
+	if (type == pci_mmap_mem && !sparse_mem_mmap_fits(pdev, bar))
+		return __pci_resource_attr_is_visible(kobj, a, bar);
+
+	dense_base = (type == pci_mmap_mem) ? hose->dense_mem_base :
+					      hose->dense_io_base;
+	if (!dense_base)
+		return 0;
+
+	return __pci_resource_attr_is_visible(kobj, a, bar);
+}
+
+static inline size_t __pci_dev_resource_bin_size(struct kobject *kobj,
+						 int bar, bool sparse)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	size_t size = pci_resource_len(pdev, bar);
+
+	return sparse ? size << 5 : size;
+}
+
+static size_t pci_dev_resource_bin_size(struct kobject *kobj,
+					const struct bin_attribute *a,
+					int bar)
+{
+	return __pci_dev_resource_bin_size(kobj, bar, false);
+}
+
+static size_t pci_dev_resource_sparse_bin_size(struct kobject *kobj,
+					       const struct bin_attribute *a,
+					       int bar)
+{
+	return __pci_dev_resource_bin_size(kobj, bar, true);
+}
+
+static const struct bin_attribute *const pci_dev_resource_attrs[] = {
+	&pci_dev_resource0_attr,
+	&pci_dev_resource1_attr,
+	&pci_dev_resource2_attr,
+	&pci_dev_resource3_attr,
+	&pci_dev_resource4_attr,
+	&pci_dev_resource5_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_dev_resource_sparse_attrs[] = {
+	&pci_dev_resource0_sparse_attr,
+	&pci_dev_resource1_sparse_attr,
+	&pci_dev_resource2_sparse_attr,
+	&pci_dev_resource3_sparse_attr,
+	&pci_dev_resource4_sparse_attr,
+	&pci_dev_resource5_sparse_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_dev_resource_dense_attrs[] = {
+	&pci_dev_resource0_dense_attr,
+	&pci_dev_resource1_dense_attr,
+	&pci_dev_resource2_dense_attr,
+	&pci_dev_resource3_dense_attr,
+	&pci_dev_resource4_dense_attr,
+	&pci_dev_resource5_dense_attr,
+	NULL,
+};
+
+const struct attribute_group pci_dev_resource_attr_group = {
+	.bin_attrs = pci_dev_resource_attrs,
+	.is_bin_visible = pci_dev_resource_is_visible,
+	.bin_size = pci_dev_resource_bin_size,
+};
+
+const struct attribute_group pci_dev_resource_sparse_attr_group = {
+	.bin_attrs = pci_dev_resource_sparse_attrs,
+	.is_bin_visible = pci_dev_resource_sparse_is_visible,
+	.bin_size = pci_dev_resource_sparse_bin_size,
+};
+
+const struct attribute_group pci_dev_resource_dense_attr_group = {
+	.bin_attrs = pci_dev_resource_dense_attrs,
+	.is_bin_visible = pci_dev_resource_dense_is_visible,
+	.bin_size = pci_dev_resource_bin_size,
+};
-- 
2.54.0


