Return-Path: <linuxppc-dev+bounces-22794-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90869CD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:52:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWYy5rHMz3bpp;
	Fri, 19 Jun 2026 18:52:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859142;
	cv=none; b=TcAvlaoZrN9PpK8OHlcOCldJn+ZSDpdw39jarCi+iElCf73Cf1LHctxsiAGN8om2OakctDt8AW7TUTbludLXz1FBizzVVbGrOEsRjPKcrR3G9wbpq28EC87XFtPHFj/F/P6uM98csbd2+ppZz0/42XUuNexg38JfqKAn1EZ6zi1aGqWc+e4/qMyNW1cFqwBL611Y1bZu69oZ3zjk9abpMEZIE07TrNPjAojyb0lR53q2HkSHk6Y5YH4wsYYVPDR8Ve9fngi1grTkQxgh8QqjjinI4D4A+29PjYQOePJE1uimwjs56w52FfALvgegQaSK9OrsAAsrNnlBItR4EAScUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859142; c=relaxed/relaxed;
	bh=hL5eYVsSUY1Is3NsEHFXNssm619EpveDtS/ShwL5AvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqf2lP9qzGBLuDw6OqeKcECkRUd95gadhzjgonseVSAY2R8JOxyo3GnZ5LE6ImKrhKbCe1xHz8OomgPmS8D24SxAmbLyDeiGQbtHrAZrDoViCchDHl+TAOyj5l/1mYQQC441Bm/sJY95KGqtsYaDHfK+1OUFt12ZZhBwrqtirwFjSdEgfg7AHljqV+eTF9wbtORWxWH9Hr2+XpjZrK+eeaL+0+rdJRRXp+nHtrPyHY2aIWN8D8XQi1r4JKqNZcCWx1KEsZNaRZZJZizA6gIcLLIGAxpnwFLo19B+S3VHe/eGqXpugKolxgp1hu6oYGUy70FcBgO7eAhhUnq1CHiCpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW4kBCdi; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW4kBCdi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWYy05Hhz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:52:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 12A8A601E3;
	Fri, 19 Jun 2026 08:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F07C1F00AC4;
	Fri, 19 Jun 2026 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859139;
	bh=hL5eYVsSUY1Is3NsEHFXNssm619EpveDtS/ShwL5AvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YW4kBCdiHYTHfFH9rK5KUGN4rtaCMSSInNBjv7DcP5WkWPht3N2qGueMytdws5nXX
	 wqMq9vGI4qNnSP9f0T0vnfGiq8eS0q4Uk/qeGyFd9WhH8DIq/d6s7+AHUZklaRBqHf
	 AB/SkwQtgEtnNem5jiDpyPO4ptHfePEKSntBMWDTQ27ZMeSDwFhPlSyUG1rUPWJws0
	 bG1knsJofLCS9DyL6HYWNFZH3Es8wnBTGz0X01JQTMeJwsZQ2oBR4g11Nfyw0g/INJ
	 0D3znnyEXRLfWWWUS7eH3HC5e+oaBBWJPPDf1ij+8WwNIiJGqXFhoVHVYmOhyxisaf
	 bWJSI7LUfkMUA==
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
Subject: [PATCH v8 04/25] PCI/sysfs: Split pci_llseek_resource() for device and legacy attributes
Date: Fri, 19 Jun 2026 08:51:39 +0000
Message-ID: <20260619085200.3729431-5-kwilczynski@kernel.org>
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


