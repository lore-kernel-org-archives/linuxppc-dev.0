Return-Path: <linuxppc-dev+bounces-19631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62310F36BA7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:03:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5kL2fw7z30Tx;
	Sat, 11 Apr 2026 18:02:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894554;
	cv=none; b=NQ3hr/1FNNgeHbskVFiNga5ponyOd2CQaHcfbo7LO2XXbygmdmH7ErIZ2E8SdftAR1NFGX82f9ShTO5IEJ9JHoT9Ygd6o5GAZlZpEjDlUO02kpTt6tLCb9l8tGXm1E9piD7XxsTCQUdLKBXLPke2RgrS/M/1/XolkpdQ400JA2M6yIIBV5skUZVv66mD9x7hqPJ0yCE5/B+jLBv7N/AbSFt25xojsiOO0IY7cZantfgqpevX+jOlkU0CiLFuAJUSW0Al7yFfFz22UEEO7oH1Vptntr/lGG2eDuVGYrAahgYviq7ouegUnkLD7VIFxSJ6GLDpjabGRKY/ZvppVEJkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894554; c=relaxed/relaxed;
	bh=QtmmcJHMOyqFXH+urF+0w2gN2raer7E1Oi8qWdv2OdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QreP7G2HTo0FWnvIcX5vXKg9BDhVCVBvX60T1qiAt6Fw9kh22VoXD665oeKzFtFlJRKNSmaPNTJGUWmJA3uK8LbbIUCG1RlyG55tbwX6oX/o8880jEk2Iosp6qiBLX7tiKULJIZfrXNPhn+wBauv5ZHGCqIwesiHntVWxpR347AoRZi0ZriQck8sq58/xQT0k61N8AJS4Lm90ZdD1ncpopVxxfHjxy1tqhB2SvzFCKMHeT5AIZUWmb8+qviFsb4AAKrfLPDsg44UtM8sJ5I/mSG4bccGwMFbdeC9AlEbbROaH2m8ik1e/xCCA6zuHX/J3FfInnMcq5k+kkwf+RIc7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K7dA5Uu+; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K7dA5Uu+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5kK5Ypsz2ypV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 034C54189C;
	Sat, 11 Apr 2026 08:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8495C4CEF7;
	Sat, 11 Apr 2026 08:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894551;
	bh=hnKN8ZM0yGcrm2yNmaVqMKt5Sul3nxMsmvK0n61ign4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7dA5Uu+kcIZ1LR3asshfBY0oE0RRywbGafj10BdAHCu3m7lmUm20cgZkVbN7m5CR
	 77UVnfczgyUo3XiAirellX7MXnjNIdx8TWFqhroxl9NVChwlSLNnhuTez3nYEEJIln
	 sJoXUK6QouEY7wc8jKRJ+GJBQgfVI/McQLbGSusMruJ7ridohWDZrNJLN3Nxh38g+E
	 fc3vrGAPWuArKL+ML3Q/AgCofeQGCtGrctUaRY1uXUAPMAGAkt4A0v62BH6Ey+3HOH
	 26cuelHVDqXOZn24E0uD8kWVn30VkwPNxc6IdE8Bou5ncsHK1n5kSnIiTfPWdQ8MZW
	 VAf16PnabcDuA==
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
Subject: [PATCH v4 11/24] alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
Date: Sat, 11 Apr 2026 08:01:35 +0000
Message-ID: <20260411080148.471335-12-kwilczynski@kernel.org>
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

Currently, Alpha's pci_mmap_resource() does not check
security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing
userspace to mmap PCI BARs.

The generic version has had this check since commit eb627e17727e
("PCI: Lock down BAR access when the kernel is locked down") to
prevent DMA attacks when the kernel is locked down.

Add the same check to Alpha's pci_mmap_resource().

Fixes: eb627e17727e ("PCI: Lock down BAR access when the kernel is locked down")
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 3048758304b5..2324720c3e83 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/security.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
@@ -71,7 +72,11 @@ static int pci_mmap_resource(struct kobject *kobj,
 	struct resource *res = attr->private;
 	enum pci_mmap_state mmap_type;
 	struct pci_bus_region bar;
-	int i;
+	int i, ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		if (res == &pdev->resource[i])
-- 
2.53.0


