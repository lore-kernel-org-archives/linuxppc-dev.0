Return-Path: <linuxppc-dev+bounces-20588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92681CD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:36:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbsd4XF7z2xm1;
	Fri, 08 May 2026 14:36:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778214965;
	cv=none; b=Tn+onhK1aZFu+DB9Rr031eD9Xz7kMmvZ2KvBQvEfhhsxEUg6jDGJ4iR7vht7QLBHGJto9nurQRZL8788QP2bOwAUk378u3u8A4HTzHZOIMEpp0yWg0HFNrbw0DGulB13eD0mOTElnx0QxrpVb6YB3pjMNH/021QuSjsowW+j6uNaYw4ZDK3Sbci+bYF0o+HZMR8HVYGVzVXF0QI1MZaSbFFr+Nyzey5cUY0u95fHSllmLxiyJ3iTtS1CKx1ak0NbwyO/6tI1Y3VkAl1wJy4uCUvV3oA2QvBNsOjXzle5M2mbrBKlLG9hvDNcVsha6/R1PEzY/i1oILOBhamNJO20sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778214965; c=relaxed/relaxed;
	bh=hL5eYVsSUY1Is3NsEHFXNssm619EpveDtS/ShwL5AvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbj+J7T2rvUXQM8SlHNrS2s18yJI0NYcKhJ+V4DuelZ/nCmmhg8KuL7XA+p8xgZKH1SEPZvSqqerJl4bXeEtAX7nRV4PWSG9apiIy3LOxNQJleO3WS8+YhiWLCvjDZ9eYja8Jc93pYWLGJnXEerSDYWgDmWNXoFOmAPvlVDxrrUebOoODiG4rPxPT0pZlpu1bDgBzcdrygye0/QKfhigasLBdftBcm+4Wr6Y+ReGBPTZtDHPB1jKhZ0GlOa40EyR/KtAH1AeAB3NRvWpJPkqIHofhb4ADODBlr5Vo+27hNgOf90SMyOH5o7sPr7NUduAMRMuQaKJiMPmfpWzC/c5DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d1n/BPYa; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d1n/BPYa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbsc70dgz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:36:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 769E043560;
	Fri,  8 May 2026 04:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0987DC2BCB4;
	Fri,  8 May 2026 04:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214963;
	bh=im9Vn3gtovnQ43+zgtWx6f84+VVW78Es3AfaAKaONdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1n/BPYaRi1gXC3Gz3HZJeLlxIu+lFnW11fuqw0pVb89lIUIWwYU4WmAza3o4ig4t
	 22DZdvjuymZMCXCo6nwAeRN8B6bHSvH9UbTPn9LsZrSXq6Zf9+crYxRLW0PW9JABL4
	 QJNRjDjs8lPwPBHuDQ2h0KyRz5iMS+mFwVq5yKtF6It/TzsiLsRCpuxCN3ICjFQspn
	 JVLRQT0tisZJehAoXdXY3zHZ4rJuppdVyHdCMSGpH+4D9RK+abpDTr+hvUnr61T9lG
	 B27sMCi4bKDZ/aHuFVEB1j5LiAyYQD0te5/ZAhfb0cZolKrYbv+2wnYc7BbH8JzuTp
	 BA3TWelz08Osw==
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
Subject: [PATCH v7 04/24] PCI/sysfs: Split pci_llseek_resource() for device and legacy attributes
Date: Fri,  8 May 2026 04:35:23 +0000
Message-ID: <20260508043543.217179-5-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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

Both legacy and resource attributes set .f_mapping = iomem_get_mapping,
so the default generic_file_llseek() would consult iomem_inode for the
file size, which knows nothing about the attribute.  That is why custom
llseek callbacks exist.

Currently, the legacy and resource attributes have .size set at creation
time, as such, using the attr->size is sufficient.  However, the upcoming
static resource attributes will have .size == 0 set, since they are const,
and the .bin_size callback will be used to provide the real size to kernfs
instead.

The legacy attributes operate on a struct pci_bus, not struct pci_dev,
so calling to_pci_dev() on them would be invalid.

Thus, split pci_llseek_resource() into two functions:

  - pci_llseek_resource(), which derives the file size from the BAR
    using pci_resource_len().

  - pci_llseek_resource_legacy(), which uses attr->size directly.

Update the dynamic legacy attribute creation to use the new
pci_llseek_resource_legacy() callback.

The original pci_llseek_resource() was added in commit 24de09c16f97
("PCI: Implement custom llseek for sysfs resource entries").

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2e4e226e78d4..2280b7edb41f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -881,13 +881,26 @@ static const struct attribute_group pci_dev_config_attr_group = {
  * llseek operation for mmappable PCI resources.
  * May be left unused if the arch doesn't provide them.
  */
+static __maybe_unused loff_t
+pci_llseek_resource_legacy(struct file *filep,
+			   struct kobject *kobj __always_unused,
+			   const struct bin_attribute *attr,
+			   loff_t offset, int whence)
+{
+	return fixed_size_llseek(filep, offset, whence, attr->size);
+}
+
 static __maybe_unused loff_t
 pci_llseek_resource(struct file *filep,
-		    struct kobject *kobj __always_unused,
+		    struct kobject *kobj,
 		    const struct bin_attribute *attr,
 		    loff_t offset, int whence)
 {
-	return fixed_size_llseek(filep, offset, whence, attr->size);
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	int bar = (unsigned long)attr->private;
+
+	return fixed_size_llseek(filep, offset, whence,
+				 pci_resource_len(pdev, bar));
 }
 
 #ifdef HAVE_PCI_LEGACY
@@ -1022,7 +1035,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
 	/* See pci_create_attr() for motivation */
-	b->legacy_io->llseek = pci_llseek_resource;
+	b->legacy_io->llseek = pci_llseek_resource_legacy;
 	b->legacy_io->mmap = pci_mmap_legacy_io;
 	b->legacy_io->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_io);
@@ -1038,7 +1051,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
 	/* See pci_create_attr() for motivation */
-	b->legacy_mem->llseek = pci_llseek_resource;
+	b->legacy_mem->llseek = pci_llseek_resource_legacy;
 	b->legacy_mem->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_mem);
 	error = device_create_bin_file(&b->dev, b->legacy_mem);
-- 
2.54.0


