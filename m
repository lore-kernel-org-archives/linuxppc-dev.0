Return-Path: <linuxppc-dev+bounces-19543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CF3E99049
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:14:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSjg2G4Kz2ypV;
	Fri, 10 Apr 2026 17:14:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800283;
	cv=none; b=c/FAg5TkNLzuvFifnFHDPQ1q7DLzAaPYkh6o/3SIXwkF5TxfjwVGa6oyZFdEO59put9abaoo2tBllEoQRYaIs+uQ7L6+0gm/rpau76K9GTes4m12QT1AxnOiR5qjogoyQKAq51lnbHNanLcA1YNLHC/xGsCERnMH6LzSE0sZbBnCVK0pztiljcjiqLCliM0fu3sex/RyZRODeMR3NVJ28UbLbF7nWLKIP8zD2TXYa47td1BxgSYh2Zueft3xUkz9GoeZNwwzmLpHS/Q9qGNtkJ9CZfY5/Ha1kN4Vw558Nqubsf2fOnPwf6f/moPmiqKTgvjSpRxRnGG7jG+BiUu+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800283; c=relaxed/relaxed;
	bh=HlWUt6Kc1y/8AXosy6RuaUHIk6+kZCgimcEm5r9/R5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V97YXU02CUvVr1XHOQ5ri8dr/y6IV/918zMsYJGpXGx/ibK9yl7Oy5RvXw2xbhN/DG8jdftTtiQAJ41y40ARMv0iO7qwfug3Vp/cE82r6xt5GyiwyCDaiQIfWx+yPpEBGIlioKpsvXnmEaazo9hKpB0SkOGc8dsvItVGa9L2Oj/nLa1YGI3Gvxz2jQm+FGnPMccvHPJz1DQjmLWWfiGRHXI4EkrdEhlQo8sajNYBAOKUkSiG2a6zk44UPhUEwi6xWJauOHsyJ0n4+he8DkyRD75uTbUL06GDT/aXalS2vaQApymnrsXU3yMbFYFiKBoc+4N8wQmS0SQu39FD80SWMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=liCvDkXg; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=liCvDkXg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQsQ6VT4z2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:51:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 15AF360145;
	Fri, 10 Apr 2026 05:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD2EC19424;
	Fri, 10 Apr 2026 05:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800280;
	bh=RJIbkZ2vyHUaEoq5eiCMqBUxiew4KtMmfoufXoK9vfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liCvDkXgv7IA7HXmjFq8dJ0WMbYu6MZvNqB4kiD0BSaMgAPd/2c2zB2OX9kHJ0ATy
	 W+PnIPy3kIG686pSrdTPCUcgVjtAkVa8Oh0JtY0Z+wMgZyuJGoUqxYFKX5yxKhvUeT
	 XXpIHUgpXZsp08QWBXesvroou4mvzJgHjvboX9BSjAWUAko9ZP2LtK+gQCIlHo2G0x
	 FTfMh+sPelY4HKAsauSsunCiWVGWmcmtN25ky16oOFQbBeldoblTxD5NQulR2WvUxy
	 N0Jk8jQxi1XZldp8ovRL1OlUzUz6l6biiioMY4LkFVC0S2Dvy2Mu2w4fKRmbF+bwwz
	 Zwoesx3LRDWMw==
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
Subject: [PATCH 10/20] alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
Date: Fri, 10 Apr 2026 05:50:30 +0000
Message-ID: <20260410055040.39233-11-kwilczynski@kernel.org>
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

Currently, Alpha's pci_mmap_resource() does not check
security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing
userspace to mmap PCI BARs.

The generic version has had this check since commit eb627e17727e
("PCI: Lock down BAR access when the kernel is locked down") to
prevent DMA attacks when the kernel is locked down.

Add the same check to Alpha's pci_mmap_resource().

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


