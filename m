Return-Path: <linuxppc-dev+bounces-27747-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A164FC982D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 17:25:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmfdY0sjrz30VL;
	Sat, 19 Sep 2026 03:25:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789752305;
	cv=none; b=bbhfuEBBxDVO4Srcl0kyf9F+dDODLd8I0EkUBALsccMD89CozZ3xSFhWLJF7OlM7tKtRWpRnH3/PtK/gJzryEqx+7OLjQgZNmcn4Tx8WkHAs/7MdIr0j4sIkwOzoCujpLSnYbPTtnyMcxTYW2t/YZ4oA1qK6pU64E7knQgxD6x2TAwVFIqYma5IO3H6yH99UD4BE5EKmnpdna4w+UgLyctfQor6pt9BHbofqJAmH+Fhf8vIRVi/S/81nFCHzyF90bD6c6dvTZjrIn7v/YZ+x6nOfyQi0dOn0PxcQnuR8bCqCchIPVPAHEA+zZ9bnPVqsJkziz584mCt5aYrjkQpegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789752305; c=relaxed/relaxed;
	bh=2+kfPgEY96uE/H1ipyuvALA/uo1X/ydteu6QiwY353A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pklth/ZkcsSLz0ju/1sgPTCcL/RxUDFH9KnDzE1DfSuI1wHfbWyoQCViOiq0nfwYX9hGe33S4jndUs7Jdc6d8/IvjThSx95xu3hSuHKywl3+zZMSlEIuqtdTwgNf2UoXLtmID+SKuIhXa+DYAdIjTDqUOJ8+6tWqFXW9S5o35x5yYktU4acwPnlL3W/Qt7Z/3+FKzK0p0qLHLFdD0g8be4qHU677WXq8n9GtTADcDMmCgGtG7pcKR8ZkJQH3+JUuph02WljGORqOAExITrPTUtWSZ/qETcF/9rc03/F/6LIM9rcJNAM1x3CTf4QoFavKtk/2XQLaazHHW2TXaJ+SZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ILUHef4f; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=37xotag0kdoyzibpwlxzqgivsowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ILUHef4f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=37xotag0kdoyzibpwlxzqgivsowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmfdX2SMgz30TP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 03:25:03 +1000 (AEST)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cc51591102fso1355280a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789752302; x=1790357102; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+kfPgEY96uE/H1ipyuvALA/uo1X/ydteu6QiwY353A=;
        b=ILUHef4fc4NhOpk/yfH75fthugfiE7YbPZKb+1DtIKXQMv0mKbVFAt/rqP3MclkwsO
         dWqNjJq5x33kmsNVncQ2qAzumszLfJjwU3Ejvylzrm9ZOYRe3O3ExFChVGND7TSV1Gah
         iWNm+OxYR/TtaasjY3Vmo2zvcLrpV+mlbuPuQZ9LTdH1GLOuGBlEKehRDWwbxByukkz4
         r5WaQRsPCEwu+aGe9/fNdHSz7iDfkcx/EbJ5duoTCkYyFO1S74oabj6vlIHRkRvsk8ej
         2OaEbxYC8NDJ/AyN+bHnM8xuwwylpcFKw+bjT288FEKZBXjWNMXmTzoXRHQuYmVBynZB
         XpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752302; x=1790357102;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+kfPgEY96uE/H1ipyuvALA/uo1X/ydteu6QiwY353A=;
        b=J7ULKPqBVqGmzTOKTutt3flYECrX9rF3TnxyKlXeGtUiI2X+8dYp9k/LUvpNPrfVMB
         vmF1WSkaExEzt75jz6MkWYOhWOGrJSUuG8SjgQvG3QmzR1QshbAYf6BmY9x33cHN0K6D
         L5JVpNr2lmdSmAtnidacOXvKJgcXN2FbYw24njI3E+BeFGlf/Wobz84OV5L2XKAlu/Ye
         33D3ZGuZDmaV3GEnjyAfAocS2Dv6F+kRXUHNcCb7E1UB5RWFRgq8RBxsCYjFItTjSlB8
         LMZ+/Co+3tg6otHtV7wBDB2nLnslBioLrW3lGpft4veLMfNh7ReQOHRVgMkHLjjtqqce
         T5XA==
X-Forwarded-Encrypted: i=1; AKwUvBwFI7h5yDZJLhOaZSjpxpuL19KaP5Y6WpwVCQNNQ+Tbk9XVDHTa12ThseV3vIugj4vTXyvrseMNggTWNQw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nwrazHKDrJkiL893UIgaQAcpjOerfFiptdHNsZcHthiuhZtX6Y
	T4K2tHkGi+wgGlsY2QjHL7WLKkR4gsRq6uCW6UIQ0Ye8ahCGWHVS8JTrqT7JSj5Z2u4KEr8wLfS
	4k21k9Vv2fdKh80fArJcgN0PmPeirIt8BOg==
X-Received: from pjbin15.prod.google.com ([2002:a17:90b:438f:b0:39e:5e7e:fbe7])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:3f08:b0:39e:6a81:5a98 with SMTP id 98e67ed59e1d1-39e6a815e38mr670166a91.44.1789752301759;
 Fri, 18 Sep 2026 10:25:01 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:25:00 +0000
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
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
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260918-b4-fix-aer-memleaks-v4-2-f0a2c21ed1d1@google.com>
Subject: [PATCH v4 2/2] PCI/AER: Fix memory leak in aer_recover_work_func()
 when pci_dev is missing
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues
the entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

This is reachable whenever the device reported by firmware is not (or is
no longer) present in the PCI device tree, e.g. after hot-removal or when
firmware reports an error for a device the kernel never enumerated.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Cc: stable@vger.kernel.org
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b013b853b555..a6600801af6e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1366,14 +1366,13 @@ static void aer_recover_work_func(struct work_struct *work)
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
@@ -1385,13 +1384,15 @@ static void aer_recover_work_func(struct work_struct *work)
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
2.55.0.1082.g2b9226bbc0-goog


