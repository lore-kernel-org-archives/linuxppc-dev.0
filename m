Return-Path: <linuxppc-dev+bounces-19802-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9571F8D763
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:02:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQnY0n0nz2ywy;
	Fri, 17 Apr 2026 04:01:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362513;
	cv=none; b=clUfTAdb4/ggFFDU88yqqZBUgsFNsQEQfdz8STF4mbhGdu+eh1SCjlM+4NzLPo5mGvTHYUjexBnhEQSQ+JVrQ2SvbXsI+arL+aDDczhfD0/D8qMiehdVxxX/3Tj0KzNu4XbimegHDXgMMQGD7JNXZxXqfvmYF/MZ7c1v5EnCGHYWhNEnSheCDZGpZJkIofuPXQsO7cPqs2g4eaaOwJNy2qL4VzD/cmcJG9mfxks0/j1XiSoaiaD+3rN3/h8S3F9tdUlfNq9OR3XjEjc0IsYFQuk4FXMuUP5IvxmsgnpBuurzmMwllFGy/hb1x0u0bfhAalLmnHcCOZo5EYQwrwHsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362513; c=relaxed/relaxed;
	bh=dmKrlGku+qVgZfPpsLskaZgkhTvxKdm51xS6hJbhb70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDCjcA8y9L3jJfG2Opp/SBlMM3vwNusosEbh3a+WHERPOOonriFAk1Cmur0a+l7HJpWgxqDpJYdNXUYekSFD96UnJaCeYMP+Ye9r3QpFqEeLWwReM/PRVxXeJcnXb+s0fKXjsLq2cnd6QJ0hA4iuve9hN6jN0lhwYas6o9mnnAPXw/g4DkacyTbC3FHeU/Z3mEg4Kw5PYGBNcLPVBgdpBlEdYc8t6cEttsLO9wQOl4Ltb4DXvus8KkbTJo0NOZe+hYKxEbXlyRoDga4v9ez9wlxBci5t56nCdGy2SN0OhJbw07BqDb6X/55E1SpNGeOyJZez0t4wW62Z+T8PqE1X1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vRS/mQhV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vRS/mQhV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQnX3XdMz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:01:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D59FF419C8;
	Thu, 16 Apr 2026 18:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A12AC2BCAF;
	Thu, 16 Apr 2026 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362510;
	bh=ynGnSMSFqOAAKmLZRmEyMAZNgYryMwxIuUv1xLlXFbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRS/mQhVt4v6pbbwRuRp+3xi/wnp2uYmhsRaYhN4EMQyiIPjz7f1U8eTl4xhkqjt8
	 KlF2dtVGTSMrztvuWx0t2NhJD1N+THTMSRMwESPQTtgxODKTWrX9qkhuagqpgZRfoW
	 mwXSliJWA6X0ArMLDMA5p0wCcCMaD9AAbOcf6VTtJeGoK+ZqgKVW3zsRzn0Y3Y4WzF
	 DePodAHWOLMKDqCW/IiMI8SyvahzGh0dDt53HjVpwwPjTar4AGqmXLEXJBacNyvymd
	 pppmWG9/19Earg7BHtBunVuN50FU/lXGZs2wXdyTbtWC6FFDhXoVWJu2QaXheZXKZZ
	 2YVPFFVbfCD/Q==
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
Subject: [PATCH v5 11/23] alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
Date: Thu, 16 Apr 2026 18:00:55 +0000
Message-ID: <20260416180107.777065-12-kwilczynski@kernel.org>
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

Currently, Alpha's pci_mmap_resource() does not check
security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing
userspace to mmap PCI BARs.

The generic version has had this check since commit eb627e17727e
("PCI: Lock down BAR access when the kernel is locked down") to
prevent DMA attacks when the kernel is locked down.

Add the same check to Alpha's pci_mmap_resource().

Fixes: eb627e17727e ("PCI: Lock down BAR access when the kernel is locked down")
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
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


