Return-Path: <linuxppc-dev+bounces-19547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D17E99049
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:15:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSkJ03T9z2yhD;
	Fri, 10 Apr 2026 17:15:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800302;
	cv=none; b=EdsquRJqNTmPI/0q7PZ5YoZe9FzHYmSwT+glf2TKjbcHHXD850hTUQ3bEgWOJ8PgFk8DB7yXxC+aaBO9o5TnPq042oPywWE50XnIlyjWm96DrjQeRz4Lo556IU3eXFiOSVq3gy5xYk3n9ldQH9PL1sgCLgv6Bt5IB61a0LKsmjX5UF740Ioq21IhyMNWPalM4sSXuEZFpwl6InGPyNwR/Rs/msu25wyvyO5yH9MpNkMfVLSyEknXHhvTwkVh9Wyn/ySVlr+H2/a+i9Pai2bZo2xwXVchypjVHvdUqwD/0LJKlUzK7ToBOdu91nRj5Kp99uO8OScOBnDGm7WQgbhk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800302; c=relaxed/relaxed;
	bh=8NYC+QD+HyGHX3YE1IJw2J11iijMuVzNfeMnCtdaf80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVo7HmQtArMPkORBHvJPCJR7cNdXa26bK3bN8UJb2Nsr9sSL3nu9L1/pIvseP+DTtlR6/UBgmypTG5rXGQMH/B98wXu6hvzV8xFRXK7KgHgcXe4zqr/QPIhITu/x6VglsEXTyiUiBXkDUoSCRgXtFFO2kMzq7HHGQtWkDZAh4FENWVeDSAmltOxFTcLuTyUNjR/1WVmzfnERyL3KKuWNnRvJKHuXeVKkOE1KV56Mla4YujIoIRaB2Ndz/DVGss8IxtMsZCPnmAAFze+zFUR21Kc1CkF+1MmHqnEj4A/7OY5Y1AolUrytHqmLde2krRGMHE8yXQL3SWy2duKKSh7gLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eIY1trp1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eIY1trp1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQsn6T0gz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:51:41 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AFC716015B;
	Fri, 10 Apr 2026 05:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8242EC2BC9E;
	Fri, 10 Apr 2026 05:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800299;
	bh=VwxDCPHrFd12naEpS7Vz5emE8UOkZKepRm7XcdqKrB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIY1trp1GPgA+Klc7GZ5OOthmAjs9Tx3c02Of689n70OAXMf3Rdcy0LoOM3pRGbMq
	 MGLnIXqkUTIqBvSLmcfkhn80o3ecLuKXi5zYiUTwAUyEHFE6TsTLF5nUrpM/bG4s7o
	 c5kiNJ0w0omfQ5NcrP6R07jN6LQKcNT3AXWjgaOYhy6BsZ1C54spVppD2lFTdekXUw
	 KGwJ5HjmxTOqdKyN+EB1RNqKQGrywEs/22uDqKu1UUVi9vsjQcLbPu524bj8ey031y
	 VWrHpnJYayCC3Z1nNT6/g4Vi2Ggn5fFR7ZpGoqWF4EZWVg+GTLGsDyNm+6uV4Y2v/8
	 q1DSdiII/QUIg==
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
Subject: [PATCH 15/20] alpha/PCI: Convert resource files to static attributes
Date: Fri, 10 Apr 2026 05:50:35 +0000
Message-ID: <20260410055040.39233-16-kwilczynski@kernel.org>
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

Currently, Alpha's PCI resource files (resourceN, resourceN_sparse,
resourceN_dense) are dynamically created by pci_create_resource_files(),
which overrides the generic __weak implementation.  The current code
allocates bin_attributes at runtime and manages them via the res_attr[]
and res_attr_wc[] fields in struct pci_dev.

Thus, convert to static const attributes with three attribute groups
(plain, sparse, dense), each with an .is_bin_visible callback that
checks BAR length, has_sparse(), and sparse_mem_mmap_fits().  A .bin_size
callback provides the resource size to the kernfs node, with the sparse
variant shifting by 5 bits for byte-level addressing.

Register the groups via ARCH_PCI_DEV_GROUPS so the driver model handles
creation and removal automatically.

Finally, remove pci_create_resource_files(), pci_remove_resource_files(),
pci_create_attr(), and pci_create_one_attr() which are no longer needed.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/include/asm/pci.h  |   9 ++
 arch/alpha/kernel/pci-sysfs.c | 292 +++++++++++++++++++---------------
 2 files changed, 173 insertions(+), 128 deletions(-)

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
index 0e016b597b06..27adfe6dbd5e 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -12,8 +12,6 @@
 
 #include <linux/sched.h>
 #include <linux/security.h>
-#include <linux/stat.h>
-#include <linux/slab.h>
 #include <linux/pci.h>
 
 static int hose_mmap_page_range(struct pci_controller *hose,
@@ -124,34 +122,6 @@ pci_dev_resource##_bar##_suffix##_attr = {				\
 	__pci_dev_resource_attr(_bar, resource##_bar##_dense, _dense,	\
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
-	if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {
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
 
 static int __legacy_mmap_fits(struct pci_controller *hose,
@@ -388,3 +260,167 @@ int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val, size_t size)
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
+	return (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ?
+		pci_mmap_mem : pci_mmap_io;
+}
+
+static inline umode_t __pci_dev_resource_is_visible(struct kobject *kobj,
+						    const struct bin_attribute *a,
+						    int bar)
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
+	return __pci_dev_resource_is_visible(kobj, a, bar);
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
+	return __pci_dev_resource_is_visible(kobj, a, bar);
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
+		return __pci_dev_resource_is_visible(kobj, a, bar);
+
+	dense_base = (type == pci_mmap_mem) ? hose->dense_mem_base :
+					      hose->dense_io_base;
+	if (!dense_base)
+		return 0;
+
+	return __pci_dev_resource_is_visible(kobj, a, bar);
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
2.53.0


