Return-Path: <linuxppc-dev+bounces-19540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46673E99049
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:14:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSjH6zvrz2ynH;
	Fri, 10 Apr 2026 17:14:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800273;
	cv=none; b=dfw/ZLNYgu9Rp7VZJ6VVIkQQAVuiEbIAGOyP/pkrmGlNCXGX0tpG+QE1dmtwW82wWtpEy7MZmPvA8JxdoWTLX7f1pLKLhL53iaHJbdnfOtR7JMN2a7RAtXYke0c9r6IOlTaq/9r8cWyidW6UhLoKybIksDLNkx9m7wW+PikxOYZYXitwd3TmSQfvsWiLau5nE2FneEosDDXZ1rD6g2BS/C+huyNi9vz3F8tYq+9fmesMHmKsUvnudWQOQye+NSp/dWBWu/WTXr/ql5xI0qLumQc6ilUSNWEWaQ7fH+hZWV4nD/iPzsA9CdH4tnhnJN/Hx48LyGYkPR5t01i11uZk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800273; c=relaxed/relaxed;
	bh=d2zGmrYTPkxrrM6eq9nj4B3qdcGy2+6kMRJhiABDag4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzKsd3H7rgkofFCq62gTlL0C9ptgK+FQtbUlbwPSIhw8YJfLopBETemnEg+FVq0bN4W9F1v0M0CuSraI1HkCZr9n2opUcyR2MOH6KLjEuaiKr6XPOkNDvuftcOAj9x7LSgwlLK9vsm9CEa/IYphh+ad126Fo2kxkoOReQZDuOWEA9G8tqYi2uz6WIP8MfQiNcBIpR/+GxzDsEAA3mNjTeC+KiqV4oGZub1m8YoOu8VIaUStTszJflVaG1skD9XpdH/pG6CEJcCl5hIui7oa8gFXESrAITZJhNsUnUQU2wDkZEnuz9qERrGZSg6/m6+HTYjfq6sNuAe27mbHNenWvYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OcvCvu1F; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OcvCvu1F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQsD1xDxz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:51:12 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 667AD6013F;
	Fri, 10 Apr 2026 05:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09FCC19421;
	Fri, 10 Apr 2026 05:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800270;
	bh=SlA86Vk8baRXQR0BnWNH5kTBhDDsrbQCeLelGiUcIhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcvCvu1F0ELy21z3VhUeHZ6QkMm2uK3tzS3tjPDvgLq3IkQCv59Ks34yFtdIYtfkb
	 OwNykDB4t4X9XeTkfS80bpawZL8lajMVhR9KZOrBDO06iXISXejvRIVcDf1qKzGvqE
	 6S/keGfXeBHWPi/f8NZ83MhatTuZl7IBNXeJYgV//BBAit3YnfmNs9dB78yjSHz3/H
	 AQoDsbJKLzVa2jN/WM9xgfeNm89ixMJqurWfa9wiWiKtlKj4Us9R/pY80LaVx03kqK
	 NShhU1170i4ZwjUivcMBfjuEKYVCuyjG34uQgRLuc2KJEvxedHfkEOfcP++w+2m7AW
	 nTkyouxx4lTZw==
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
Subject: [PATCH 07/20] PCI/sysfs: Convert __resource_resize_store() to use static attributes
Date: Fri, 10 Apr 2026 05:50:27 +0000
Message-ID: <20260410055040.39233-8-kwilczynski@kernel.org>
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

Currently, __resource_resize_store() calls pci_remove_resource_files()
and pci_create_resource_files() to tear down and recreate resource
files after a BAR resize.

Replace this with sysfs_update_groups(), which re-evaluates visibility
and also runs the .bin_size callback for the static resource attribute
groups after a BAR resize.

At the moment, the resize code references the static resource group
symbols, so wrap it and the resize group registration in pci_dev_groups[]
under the same "HAVE_PCI_MMAP || ARCH_GENERIC_PCI_MMAP_RESOURCE" guard.

While at it, add a warning if pci_resize_resource() fails to
expose potential failures, and rename resource_resize_is_visible()
to resource_resize_attr_is_visible() and the corresponding group
variable to align with the naming convention used by the resource
attribute groups.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index e56fddbe7914..1fabd0baeb56 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1386,6 +1386,12 @@ static const struct attribute_group pci_dev_resource_wc_attr_group = {
 	.bin_size = pci_dev_resource_bin_size,
 };
 
+static const struct attribute_group *pci_dev_resource_attr_groups[] = {
+	&pci_dev_resource_io_attr_group,
+	&pci_dev_resource_uc_attr_group,
+	&pci_dev_resource_wc_attr_group,
+	NULL,
+};
 #endif
 
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
@@ -1643,6 +1649,7 @@ static const struct attribute_group pci_dev_reset_method_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1692,14 +1699,15 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	pci_write_config_word(pdev, PCI_COMMAND,
 			      cmd & ~PCI_COMMAND_MEMORY);
 
-	pci_remove_resource_files(pdev);
-
 	ret = pci_resize_resource(pdev, n, size, 0);
+	if (ret)
+		pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
+			 n, ERR_PTR(ret));
 
 	pci_assign_unassigned_bus_resources(bus);
 
-	if (pci_create_resource_files(pdev))
-		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
+	if (sysfs_update_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups))
+		pci_warn(pdev, "Failed to update resource groups after BAR resizing\n");
 
 	pci_write_config_word(pdev, PCI_COMMAND, cmd);
 pm_put:
@@ -1742,7 +1750,7 @@ static struct attribute *resource_resize_attrs[] = {
 	NULL,
 };
 
-static umode_t resource_resize_is_visible(struct kobject *kobj,
+static umode_t resource_resize_attr_is_visible(struct kobject *kobj,
 					  struct attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1750,10 +1758,11 @@ static umode_t resource_resize_is_visible(struct kobject *kobj,
 	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
 }
 
-static const struct attribute_group pci_dev_resource_resize_group = {
+static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
-	.is_visible = resource_resize_is_visible,
+	.is_visible = resource_resize_attr_is_visible,
 };
+#endif
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
@@ -1872,6 +1881,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_resource_io_attr_group,
 	&pci_dev_resource_uc_attr_group,
 	&pci_dev_resource_wc_attr_group,
+	&pci_dev_resource_resize_attr_group,
 #endif
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
@@ -1884,7 +1894,6 @@ const struct attribute_group *pci_dev_groups[] = {
 #ifdef CONFIG_ACPI
 	&pci_dev_acpi_attr_group,
 #endif
-	&pci_dev_resource_resize_group,
 	ARCH_PCI_DEV_GROUPS
 	NULL,
 };
-- 
2.53.0


