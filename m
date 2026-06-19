Return-Path: <linuxppc-dev+bounces-22800-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1255FCD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:53:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWZN3JrCz3brB;
	Fri, 19 Jun 2026 18:52:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859164;
	cv=none; b=NCjr6xfR24yxUbp+BqS8o//DA2lonbXiDKLAVOBHz44jqodzDt6X/EwoppmkLRQ0INPL/xLIa8j3gte/AjvxV/JvhsffKWiQCxS1fo2pdFpWKrSHhYrypHeAtHTNgbor7WeKfBcslPk7TsuYUy2AByDX+huBghZWbOtI9Uzh5zOdlSGq2t1nmOF5L090PieArR3X6gVooG0O9uCwlccV26qYEPxQMW1xLkThKCXQanIIjcwGR8JatMp9mCsvI+57T4w8adLeSyZcaeCDxK1UERaoKZ/0zyz+nmjhMMQUrr2H6/j+jVXSanqEuCLHYUVNWJj+wVCfLWKyV6OP3E4S3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859164; c=relaxed/relaxed;
	bh=hZpSQCgMlKTKZQdytllooM44So4t4sr5jU9EJXYUHVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dX7h+2mGebmWPXPiaQ6CRGEmNAIwYHqIf+xNcEAE1CEiqussNcuIdkYnC/rg9dUJK8qRUSSsdtooFcfKHvgeot/r7pdjwlw+5/dlZnigdKVGhfnZurKOaelCwJJ6vKTLB6rpw3FupD4r4f9sl3KQtxFntjgXQq8sh3ZCTuXd7o6F5VZ75A8zgePyCo47PJmwIHUCYJU3tHhSp+WpYg98GPnyXbbez+FoDvO5YAXmn5d6rGXZVUe+F/2bS4/Hpt2gvR0RkgVBY84Tc37sDTI3y3q7gNhvuA4sK0rm70htBA5VZv0ggY0Q7SME9XI3CG2bYIBsToDW7e5dkFFfdAdHoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1ZMOHhM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1ZMOHhM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWZM4H9Zz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:52:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B1BA4601E1;
	Fri, 19 Jun 2026 08:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9BB1F00AC4;
	Fri, 19 Jun 2026 08:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859161;
	bh=hZpSQCgMlKTKZQdytllooM44So4t4sr5jU9EJXYUHVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1ZMOHhMl+y1+Dw1MeuXMLFbr5eQDs6bYt4mPEeMYE0+tCyo4Lse8Wpo9pgtcpS01
	 shrYlFlpaQWcEVBAxThHaQBTVmwGlLqvdHQbR4k+RCOhmVThTC5c1wsNCM7zrvnv3e
	 uP2vf5UMwsykYQo9EA5NV7n9heStDbsN0Ltx6kiMPElumWMJNPk06p8GeIaP44lNyV
	 e+G7djMnqKu4tDzVRtjs67K5dgbZB/MJM0qLeChO0wYikGmtvuqJJsTJrZId/yDzwf
	 ehMto8Hh3ZsgiCfKM/g/VuK5HrVery5hw2skk+BrRY15aU1hyDWPwKH6e2YQsT9P8l
	 6QZnT1n9wz/KQ==
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
Subject: [PATCH v8 10/25] PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
Date: Fri, 19 Jun 2026 08:51:45 +0000
Message-ID: <20260619085200.3729431-11-kwilczynski@kernel.org>
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

Currently, pci_sysfs_init() and sysfs_initialized compile
unconditionally, even on platforms where static attribute
groups handle all resource file creation.

Thus, place them behind a new HAVE_PCI_SYSFS_INIT macro,
especially as the late_initcall is only needed when:

  - HAVE_PCI_LEGACY is set, to iterate buses and create legacy
    I/O and memory files.

  - Neither HAVE_PCI_MMAP nor ARCH_GENERIC_PCI_MMAP_RESOURCE is
    set, to iterate devices and create resource files via the
    __weak pci_create_resource_files() stub override (this is
    how the Alpha architecture handles this currently).

On most systems both conditions are false and the entire
late_initcall compiles away.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 208ec7057b50..57d89e12bfec 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -37,7 +37,14 @@
 #define ARCH_PCI_DEV_GROUPS
 #endif
 
+#if defined(HAVE_PCI_LEGACY) || \
+	!defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+#define HAVE_PCI_SYSFS_INIT
+#endif
+
+#ifdef HAVE_PCI_SYSFS_INIT
 static int sysfs_initialized;	/* = 0 */
+#endif
 
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
@@ -1768,6 +1775,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 }
 #endif
 
+#ifdef HAVE_PCI_SYSFS_INIT
 static int __init pci_sysfs_init(void)
 {
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
@@ -1794,6 +1802,7 @@ static int __init pci_sysfs_init(void)
 	return 0;
 }
 late_initcall(pci_sysfs_init);
+#endif
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
-- 
2.54.0


