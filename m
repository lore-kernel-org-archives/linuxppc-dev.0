Return-Path: <linuxppc-dev+bounces-19628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A6EF36BA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:03:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5k85RbZz2ynP;
	Sat, 11 Apr 2026 18:02:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894544;
	cv=none; b=KUJxsIHmPeY83+kTn+irs78RCC12a+GzfHr2NZ7lh0k2xvGOu7Fyu6cvbqj4g51yA2mKvIILLb0GmJYrSxB83uQSeN/gDaoELclq8F+9jF/ALPKEB5lxAY4QvwQhd/jpbFKkxguy8j9S1pka692GhPAE6/qgYyMICgmGnCcxOtWu58trWyiMpKY0PvFX9TGDDguZy3CiqwZd4qFIzBlj5jBJRXO4iBl4Y0X9lH6g1k2L2suS8erjWbAprPPZMr0N2X+hcupJUZV/Us6IBLnGftUsCXEjNjEp98cvxCTp0Mc3rFH6I9LwfznWRLBECq9a+UdNGU9A9IRD7Z9OnJxKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894544; c=relaxed/relaxed;
	bh=hw5ggym5gsOgyXNq1pqVYyL3sTq1bxqihHcydzMkEzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFF7O/hihG8b9sduL6LWmbGB8vpVBWCR9Rd1U1Kq3/s9+hbvLUdwTy8h4XtmPOwlmxgNReeyYf3HDp51rXDp/dABCa5dqd1FlI6uv0pNEHx2gedLdfVXnF9ah/v8ID9D8rhyayfzM9fJMtUAGhjZIZJN6ieqCJ/Pbrd9HMJR7iaDxxo83vPr7ZsMBQgtugQK4kQbb1hsJmHZxEPZZD8gZfrjdLfbyTZj/SlfRkkjtDUnIW/FdaZmk/9CTe9gyjqrnIX7bVYLKY6xLIVmCWEZbwbnOgwY6LunO3uFrwedv03UG/qZcgMZPpyYFYlmVQvNjSFl99IhLmOhraW9E31lQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KzKF0gfZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KzKF0gfZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5k76gQhz2ymg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DC4B7600AE;
	Sat, 11 Apr 2026 08:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5B5C4CEF7;
	Sat, 11 Apr 2026 08:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894541;
	bh=UUdcfp1Jj+7X39UhUYZiEAGo8M2BFY1tXtTB8pe0jdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzKF0gfZsTJvOqnWuzxJdUYfZoqTbpWXMQrTizAIxQ/+UtJLTllDKMUPIcI3yM0DX
	 Ca6CHETvribfiTZtj2sXAn2CwIyqhjDmkT98/5L3VIC8oVthBAtSESEIoSLuGk3TUC
	 gkQDIy4Ss1TOVLbfhVsmrzGm0w08vKKoItkeqpC3WuY0aUyy0glfVX4+qDaO5PMYEI
	 zzwNlnxl2Kynv01wi5wG9jkDVSeQMdW04eiHDQfbyztARqaEzHqKJHij2xJ6mhUTQb
	 9/deriR2IALMiqOspq55xqLH0viTdKjg0CSQx8ZZ2zTK0c9b+ExDHD5R5hWSsd4RSt
	 QsgdytvWfOMbQ==
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
Subject: [PATCH v4 08/24] PCI/sysfs: Convert __resource_resize_store() to use static attributes
Date: Sat, 11 Apr 2026 08:01:32 +0000
Message-ID: <20260411080148.471335-9-kwilczynski@kernel.org>
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

Currently, __resource_resize_store() calls pci_remove_resource_files()
and pci_create_resource_files() to tear down and recreate resource
files after a BAR resize.

Replace these with sysfs_remove_groups() before the resize and
sysfs_create_groups() after, which re-evaluates visibility and
runs the .bin_size callback for the static resource attribute
groups.  Also, add a warning if pci_resize_resource() fails to
expose potential failures.

For architectures without HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE,
define pci_dev_resource_attr_groups as NULL so the resize path compiles
unconditionally and sysfs_remove_groups() and sysfs_create_groups() become
no-ops.

While at it, rename the resource_resize_is_visible() to
resource_resize_attr_is_visible() and the corresponding group variable
to align with the naming convention used by the resource attribute
groups.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2922905ff070..c0925bdc9ecd 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1386,6 +1386,14 @@ static const struct attribute_group pci_dev_resource_wc_attr_group = {
 	.bin_size = pci_dev_resource_bin_size,
 };
 
+static const struct attribute_group *pci_dev_resource_attr_groups[] = {
+	&pci_dev_resource_io_attr_group,
+	&pci_dev_resource_uc_attr_group,
+	&pci_dev_resource_wc_attr_group,
+	NULL,
+};
+#else
+#define pci_dev_resource_attr_groups NULL
 #endif
 
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
@@ -1692,14 +1700,17 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	pci_write_config_word(pdev, PCI_COMMAND,
 			      cmd & ~PCI_COMMAND_MEMORY);
 
-	pci_remove_resource_files(pdev);
+	sysfs_remove_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups);
 
 	ret = pci_resize_resource(pdev, n, size, 0);
+	if (ret)
+		pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
+			 n, ERR_PTR(ret));
 
 	pci_assign_unassigned_bus_resources(bus);
 
-	if (pci_create_resource_files(pdev))
-		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
+	if (sysfs_create_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups))
+		pci_warn(pdev, "Failed to recreate resource groups after BAR resizing\n");
 
 	pci_write_config_word(pdev, PCI_COMMAND, cmd);
 pm_put:
@@ -1742,7 +1753,7 @@ static struct attribute *resource_resize_attrs[] = {
 	NULL,
 };
 
-static umode_t resource_resize_is_visible(struct kobject *kobj,
+static umode_t resource_resize_attr_is_visible(struct kobject *kobj,
 					  struct attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1750,9 +1761,9 @@ static umode_t resource_resize_is_visible(struct kobject *kobj,
 	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
 }
 
-static const struct attribute_group pci_dev_resource_resize_group = {
+static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
-	.is_visible = resource_resize_is_visible,
+	.is_visible = resource_resize_attr_is_visible,
 };
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
@@ -1873,6 +1884,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_resource_uc_attr_group,
 	&pci_dev_resource_wc_attr_group,
 #endif
+	&pci_dev_resource_resize_attr_group,
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
@@ -1884,7 +1896,6 @@ const struct attribute_group *pci_dev_groups[] = {
 #ifdef CONFIG_ACPI
 	&pci_dev_acpi_attr_group,
 #endif
-	&pci_dev_resource_resize_group,
 	ARCH_PCI_DEV_GROUPS
 	NULL,
 };
-- 
2.53.0


