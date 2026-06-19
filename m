Return-Path: <linuxppc-dev+bounces-22798-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C34CD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:53:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWZF1YYnz3bqs;
	Fri, 19 Jun 2026 18:52:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859157;
	cv=none; b=OEOMTKpYJZRODDckZJZrJ5quLXw6YD5HPi4HChrt/x8CAkrBXXJdGInttLEdwYvtIbOTtVsChRh6ObMIyfApRO16mdPviZ85WG85iGgNlNAjiTuGsC/Zxlec2xdS+UL2AXeWKTtrdezovOoylyoIKcFy2BIgbBzoL+WiGQcrJzogahC+8mZsEJTyEu568qDvtbDpPTOIj3EUqnQNnMspgXbt0md+Sde2ahDhuN4uZ6Ia35zSq/sgnv5wVsQsTITabOJ3TXVJ2XI3lQTHzkaq1Xr1mPls+PegJwAKrrFUbezGzMlD24/39bR7a7gHZCHQ0vfJ6yAtUmuqYKwPaBF1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859157; c=relaxed/relaxed;
	bh=r68zxN0KHcb5URqlhy3b5QGz3OV09mDNBvnBZmcOinI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2Lup3CojE7xyWp8hm399NadwWMoyBC9CnautfTF007E1MxLjDpLqk0dgz5Sl32crMu6gXc+N0WJI6VZtZuWvCSjUFYFcO54n5DMFJrzGALJnoFVI5egezAPtn725dbWz8c+lq9hRfswqhzReK/IfpG5QDY9WaddbboCQIZWDKLA0OBiqxfr24Lkw0igr6poKzp/asOWB1qatRWI1dLfGZlb+gQ47x7Sbf+bcC/FC//jyjdgS8ZtFiC2MewqIqVZjOoOoNXZRdumTdHCz6RZnfPVitCYieadivO16ZYergYwr8l65T198pqWN4NzL+mjQXMw5CpQs++W7uY3g5GmKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+HUR0Su; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+HUR0Su;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWZD2nZVz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:52:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7EEA6601E1;
	Fri, 19 Jun 2026 08:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F7F1F00A3A;
	Fri, 19 Jun 2026 08:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859154;
	bh=r68zxN0KHcb5URqlhy3b5QGz3OV09mDNBvnBZmcOinI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+HUR0SuVtr+KdBlj9DwDcjD2iiVtVekAzi01Hw9fc4udUAaSOKeQcP4PT6ohbgFY
	 r01XcEUYQVJmkecGUizQvNEGZ5OIR+5B4EUD+1JZCjo06+PttSC5My1YRC8st6fgN3
	 BgQr/cLnksZozav+YHtfwX7XZGkz2v7LLXbhJD3g+4rvaySw3CLMIqCBPH6jdtnNg4
	 6ONFRIoqbxpyShKoba1orlhZV2Is6isJydSDpnkJIMvNteOPSupXqYXsE5OJzxkas5
	 MbbkpZtxujsgwKS1s1v3BxKZSE+HlEMxBKMjKiF1GsEtsd+IvylpLgTqOwH8ct24TE
	 Jv4BMAeeT/Vtw==
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
Subject: [PATCH v8 08/25] PCI/sysfs: Warn about BAR resize failure in __resource_resize_store()
Date: Fri, 19 Jun 2026 08:51:43 +0000
Message-ID: <20260619085200.3729431-9-kwilczynski@kernel.org>
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

Add a pci_warn() to __resource_resize_store(), so that BAR resize
failures are visible to the user, which can help troubleshoot any
potential resource resize issues.

While at it, rename the resource_resize_is_visible() to
resource_resize_attr_is_visible() along with the corresponding
group variable to align with the naming convention used by the
resource attribute groups.

Also, change the order of pci_dev_groups[] such that the resize
group is now located alongside the other resource groups.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 615bbee1a1c8..b8b7fb809c69 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1679,6 +1679,9 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	sysfs_remove_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups);
 
 	ret = pci_resize_resource(pdev, n, size, 0);
+	if (ret)
+		pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
+			 n, ERR_PTR(ret));
 
 	pci_assign_unassigned_bus_resources(bus);
 
@@ -1726,7 +1729,7 @@ static struct attribute *resource_resize_attrs[] = {
 	NULL,
 };
 
-static umode_t resource_resize_is_visible(struct kobject *kobj,
+static umode_t resource_resize_attr_is_visible(struct kobject *kobj,
 					  struct attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1734,9 +1737,9 @@ static umode_t resource_resize_is_visible(struct kobject *kobj,
 	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
 }
 
-static const struct attribute_group pci_dev_resource_resize_group = {
+static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
-	.is_visible = resource_resize_is_visible,
+	.is_visible = resource_resize_attr_is_visible,
 };
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
@@ -1857,6 +1860,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_resource_uc_attr_group,
 	&pci_dev_resource_wc_attr_group,
 #endif
+	&pci_dev_resource_resize_attr_group,
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
@@ -1868,7 +1872,6 @@ const struct attribute_group *pci_dev_groups[] = {
 #ifdef CONFIG_ACPI
 	&pci_dev_acpi_attr_group,
 #endif
-	&pci_dev_resource_resize_group,
 	ARCH_PCI_DEV_GROUPS
 	NULL,
 };
-- 
2.54.0


