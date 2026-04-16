Return-Path: <linuxppc-dev+bounces-19795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F9BF8D763
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:01:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQn51jD7z2yvY;
	Fri, 17 Apr 2026 04:01:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362489;
	cv=none; b=K7odrKz43PLT2DWETgAJZ67roMCZeVClKiZzfh6o8JzyMeb5DOFF4Tb8w2aX8jol2dtl6yJlvTrD2rZBgPCv66ABWXMQW7Q8AGSueF7YLTXLTkxNnRrRs35e0TUqkCMrW5QogyYEd3lCAFwbhyvo++SjaY/FMxjSG8ji30l8mIT0OmxW653mtRFq5KFuPKWfWzGswPtEJrfYHUnvPz4oZ6EQ0SpDXTLMovSYtjBFaOKbT+FzqhiGRoK4AvrxpVDRIebacImJp9UBOAJ682f7fT9aWUrZDX40/HGNhUGqwjq+C5j/0YuuslKxRj4txNuzvHybAGWsGVkglu7YiqDVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362489; c=relaxed/relaxed;
	bh=mCbrZ9cEa2ffcOKFTYY1hWjOtPoJOynRc3FM6uguhqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvbdlfFwXD9Q7sLoUQPtxj/KUPS0Qs6y8kFrKf3HQdfOmFK6K22+RvVTIktceQue2sfIRSW2TxmY9+6p2Y18P0248PvSdez2N1Np/2MAfCzXBg/JUz/REEzjZbLdLJxadoJBt4FmpjxzNcm0Bt5BZFLytfaqgc2cWPxDV81WhBT6beYo7b0c5hyI4OC+t5nbcDiXRWVZZYzlZbeQZdQshr9BHLQLMBAOV5wFPMxOBsK1V2UK2liFp2HjNn4tU4d9hFJRbPSClUiv8VwUEoqRgFHn4696qnQ4kUeguZOp8D/vZeEBXvfvnCG6oEcypDSohdf1jpNMf1MhG5WiVu270Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UAy3npCC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UAy3npCC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQn42fh0z2yvR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:01:28 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6EE0460130;
	Thu, 16 Apr 2026 18:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7F9C2BCAF;
	Thu, 16 Apr 2026 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362486;
	bh=H0WndVWw8wLHCufLJXaP5uTZO+d0TQtPZDWQ71hp9UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAy3npCCNQwAvlkB/5+e3ChaNPyvJRJUHVQ1Uz3GO6aAPWAXEgOs9PyWxK7NL2ixR
	 A2hNgVAMkLAme875enuYBf29jWhQJeRckZjcOuh2gNy7o6SmW9oqq7mNGCMjOo6A75
	 iZbHm9i7DixEbkjeZrFHSV+7IE+/utbFDZRrqO84jRNoKWptFF0eHIQ4ATacwS34rf
	 4+mU73yjtnwG0MqpdFwVi001OS3vWj9n7BZgZEwMELntD648tIXpWeDCwVxgIZ3x0Q
	 16pnpMrgRYpYKEby1h8UAoC7+0yCeV3Z6qk/IaszP4CuoePJuZU5EfDxViR48l/VaO
	 /d/GOiMJGnAkQ==
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
Subject: [PATCH v5 04/23] PCI/sysfs: Use BAR length in pci_llseek_resource() when attr->size is zero
Date: Thu, 16 Apr 2026 18:00:48 +0000
Message-ID: <20260416180107.777065-5-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
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
file size, which knows nothing about the attribute.  That is why this
custom llseek callback exists.

Currently, the legacy and resource attributes have .size set at creation
time, as such, using the attr->size is sufficient.  However, the upcoming
static resource attributes will have .size == 0 set, since they are const,
and the .bin_size callback will be used to provide the real size to kernfs
instead.

Thus, update pci_llseek_resource() to derive the file size from the
BAR using pci_resource_len() instead of reading the attr->size directly.

The custom pci_llseek_resource() helper has been added in commit
24de09c16f97 ("PCI: Implement custom llseek for sysfs resource
entries").

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6783c6168445..73a9ae9d289b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -909,11 +909,21 @@ static const struct attribute_group pci_dev_config_attr_group = {
  */
 static __maybe_unused loff_t
 pci_llseek_resource(struct file *filep,
-		    struct kobject *kobj __always_unused,
+		    struct kobject *kobj,
 		    const struct bin_attribute *attr,
 		    loff_t offset, int whence)
 {
-	return fixed_size_llseek(filep, offset, whence, attr->size);
+	struct pci_dev *pdev;
+	int bar;
+
+	if (attr->size)
+		return fixed_size_llseek(filep, offset, whence, attr->size);
+
+	pdev = to_pci_dev(kobj_to_dev(kobj));
+	bar = (unsigned long)attr->private;
+
+	return fixed_size_llseek(filep, offset, whence,
+				 pci_resource_len(pdev, bar));
 }
 
 #ifdef HAVE_PCI_LEGACY
-- 
2.53.0


