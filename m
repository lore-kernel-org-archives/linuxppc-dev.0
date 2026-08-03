Return-Path: <linuxppc-dev+bounces-25309-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E970C55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:15:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDXZh6kH9z307v;
	Tue, 04 Aug 2026 09:15:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785793872;
	cv=none; b=elg9uTOl8kKqLQKRJOm0kq4PXF3jyXIGxWh6fhR8nXICEMwAL1xvwETR1a3JAw8ldhnAGbXSOyNaibUVcCbppkHIXh1y4BKBB8VvcR1syXq8TThLY+xS/xG/5haCnmDoYYL41FFOcDqYt/NQIqU8vU5QKSORUVf/UbYdRA6Iip7F/jo0V89J94/yS2cCHL6+WHaRmAcSUR/6wPtUb+eIvpfZcGkJ1ehHIS2XBu6D15+F8j2O6d7XVWnWiZfyhEm6zu8LDKZJYAZNslsJjDK2Jo1fnUi5Gu+O7/hnZSWx38xH2Dhs0l9yOMXhVv/O0IFgXFxMBjyNjIrRsjE1CJOD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785793872; c=relaxed/relaxed;
	bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ty11hHRRrI13uleAx3zf0O015WbRC2Bxh7yVcz2ZyWwmUx2Tb43OTBgRoVHU9rW/UARdyCbwLYquEYbaRPfRcrB745R2MJ8jb1Gt4E/E4RcZ5OBqPdbs9p/OPECAt8T0YP5YClyKIxkvcEHWjPTMvWK7Wg+EYUalpDxkWMa12u38Wrm6bNgUz3SE65Usf+7ot/Vg6sde+FyYp/1NzBsIlVgnlzYR44j7jEJZcwLqXYSYTAzOAxvPdkH/v6mq8Rv9z3KpYZzUE5mWuXutRU4J4gu+Er5uexlPsHdhYPZAt5D9qKESInMwCbnIh0Rl7qJ2HXg3vGF6LoEjOnGY2C5DVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GGLSoPgw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com; envelope-from=3ta1xag0kdiu0j2qxmy0r7jwtpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GGLSoPgw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com; envelope-from=3ta1xag0kdiu0j2qxmy0r7jwtpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com [IPv6:2607:f8b0:4864:20::645])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDVjq2K8vz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 07:51:11 +1000 (AEST)
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2cc6dd43737so83355715ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785793869; x=1786398669; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
        b=GGLSoPgwofe21lWy7dyT7xGMJ+rr0gjJov4iTj+ob7sygWdzLEx3ishJYgL97LGqXp
         stK3u9hPFKU1GmwsgZAlyPv+oA1Qkc4GJ1sKAARW2ndQg7cR5Z9Xg/c4OHv4ddfj+kUH
         wq1PVaK98XqpseeU7dUpppnGLDUaQUNB3x9CDffHcYLrPJjmgW/SwFR6S/Q1jQROWKGl
         spiPpEb+4jQYb2gH8YC1aYnEZPGbYRdB8+3QKkXbuuR0iyK37EMW3kf8skXuW58+VOIV
         fkY4Bg5JPfCv1srjKMRIMHx/tmj1FlbLdaaWeMkLPdzQd3bH8riz6PuB6s2Ro/nnjXS+
         YRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793869; x=1786398669;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
        b=JiFVWngJ7rhp/mAFnglz614b7AY3S9nEtPhNGA3F4BnBX4zy0BHYfZsfLPymO7gvZD
         TUNnaO/cWn7e2uto3My7x+o9WhbRIbmM4Ivw8bqv6zD819ln6Yy/DXix9Vq/6QWUCgbj
         4HL7xa5XYwEr5Z76fhJbidsLbjNXgSwnKPNQYnBSRhcNhQMXyPuU0IykgyNpsxdMU+Jl
         426kFYXXVphe2Qi1Xv6zNFWsAoJ7U6z4mv6lZtxf62lFHZJkJzKFPvxC2lsuf5Osh1Tu
         STveIKPYCTcifF7aF0UMVlWO0AzTloCOOTsiewVDU8uuZ+/6HVG1256xyFmpWmL3ppPF
         EbYg==
X-Gm-Message-State: AOJu0YxkX/E7qQ1Nw0dn8v56vUSyjq7ludg5uSV9L7DsE2tesmwKLAJF
	l7AsSfsS1ITSqrgKc2V5FEE8XO3Qpse6XNEl8knw2WTSUvnz3/dAPL/HqhLKkVt0gEP46fL4eTn
	WCjhSYwCwY41p8NDV30KzxhNBFx+3jg4TEA==
X-Received: from plxd6.prod.google.com ([2002:a17:902:ef06:b0:2cc:7709:b166])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:390b:b0:2cf:bfbb:61e2 with SMTP id d9443c01a7336-2d0524723b8mr113426065ad.39.1785793868519;
 Mon, 03 Aug 2026 14:51:08 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:51:06 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
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
Mime-Version: 1.0
References: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v3-2-e87159611933@google.com>
Subject: [PATCH v3 2/2] PCI/AER: Fix memory leak in aer_recover_work_func()
 when pci_dev is missing
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues
the entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 967cde9dd519..9683cdef649b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1223,14 +1223,13 @@ static void aer_recover_work_func(struct work_struct *work)
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
-		if (!pdev) {
+		if (!pdev)
 			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
 					   entry.domain, entry.bus,
 					   PCI_SLOT(entry.devfn),
 					   PCI_FUNC(entry.devfn));
-			continue;
-		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+		else
+			pci_print_aer(pdev, entry.severity, entry.regs);
 
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
@@ -1242,13 +1241,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
-		pci_dev_put(pdev);
+		if (pdev) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+			pci_dev_put(pdev);
+		}
 	}
 }
 

-- 
2.55.0.571.g244d577d93-goog


