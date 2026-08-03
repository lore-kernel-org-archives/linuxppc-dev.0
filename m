Return-Path: <linuxppc-dev+bounces-25312-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031B8C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:15:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDXbS4NC7z307v;
	Tue, 04 Aug 2026 09:15:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::446"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785794384;
	cv=none; b=h/8DQhsFJx/xk95D2Xy9R5Hv5AhwjT1zWaP8rLKnqcRAcIpLFo53Zic/kOVDF+OnbV+e5HN6i7xkckPkvmeJnoITgDFM8mfpFteBJRaNaSzOAPLOTlmpHSMBaWPjJvHWrTeQlxfK8QlR05BNa3E53rsCMs6G/WWx3svSB27aebHnowMq7pSUqQeBf5EUZ+C0LWa2ugnhh8+hlpilE/cUHFkWpyg0CxVND6AB4gJ4U/9R+J63MJN5SUup+JKXWvNgBmLIafi06FzKjqv7rxN9MkO/Zxvk2RQ4Iw/5QMZwmFU3lOtUuS0hXHjYdjItypBCNVncblRrYR3fuhgTJ+ZUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785794384; c=relaxed/relaxed;
	bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fsCTVNKvguKsklONlLQpge1yBpwamunM8sBWhi9Ek5RJGl6jzlbWuDZ6feIF7B39OlMCgeagM8+/ZgiDqf+wYQsT0nM/ee8aIhi3W9OjSkvQuVVROubf9VcLfRtDSHGPk3gty88GiXFPNwklXTCcA8CtjulNDzca7BRzDcYk+tXkxJllBgi01JH6yai1WR6rMX5PvYTSjTNwI6c/AITvUz+nkfwUqwebZ7ORjz5POmXW6hDmsvMz1wh6/WJ9b6FI/pQ5Sux3YOYCm68VJz33KuKOqZmUKq1bToZy/R7CxM5BK4H2GMg+7HAwMdRMUdcOZoIYh4hj8F8r7W8FzoWWRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RF5CSjIl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::446; helo=mail-pf1-x446.google.com; envelope-from=3tq9xag0kdio5o7v2r35wco1yu22uzs.q20zw18b33q-rs9zw676.2dzop6.25u@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RF5CSjIl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::446; helo=mail-pf1-x446.google.com; envelope-from=3tq9xag0kdio5o7v2r35wco1yu22uzs.q20zw18b33q-rs9zw676.2dzop6.25u@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x446.google.com (mail-pf1-x446.google.com [IPv6:2607:f8b0:4864:20::446])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDVvh04kvz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 07:59:43 +1000 (AEST)
Received: by mail-pf1-x446.google.com with SMTP id d2e1a72fcca58-848d21bbb55so7096792b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785794381; x=1786399181; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
        b=RF5CSjIl47qxurqxG6ObHLUzZApGhlPvyzEnEFJgj/S86dUS51f2624wroZay4mVyc
         MXWcuILuicHTF9D5LjN9F/UHL8O9/J//50it8uZrkNwi8Yf9shj/2Xp62iJxqgFt305G
         z9++1fhVeQ5cw2OTy3lqDsFRuUXJNy45NS2E9ZmQZ7u88o6vvUTIOH4kHrdS6gWT1oC2
         A2fx7IaVU9ZahGPhSLrydIVgjrdl1f2OslY10ZXtD4MAOkOYVlZN+VRF+bQJPyQFiAn8
         2z0W5ZEbRzkCyEFK8tLMIIGT1Ep9byisVsORrUCEMy5AWj9EUr733WoajQhp9UnQXwa5
         RTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794381; x=1786399181;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
        b=jxoV2oSRRJ2D72Su4bdBG+Vq4iclgqPVUnfwZuLTRyzqrEgB5w8s3DWS0F5BM/LL4C
         TxgQHLYKYszzwsy44R0oFx0P1gpo9iYJd79592/nxwwobRTT9SnaE3DYt5LEbA4RQSbH
         2IbgG+R1JK3YrIvtsex8oU89vJ7/qRgHcnpKP6Fq2Is86tWj58GGFdyKQFEOndV/i32o
         x059LAtRklBmi+9+y5JTyDMc3Wz2vyZxB1HDhP7V7FGqeHDwR7x91DgaNH/feSPhk2le
         Q5TzcL61418FA1BOrAZorkGP2ehIZVdlbZhNQkW0Zs9lR3GJpNMSmucRI9qHO5BuBc6X
         OuLw==
X-Gm-Message-State: AOJu0Yy2bHZ5+0m714Mbvjx78y4B1njAdcIOObpn1sFmyEd3QlIPXsfc
	uq9miV86Vb5/5iNoU8wqQS3Ys3DnygtQOcllicuyg+/SHn9WAjhfq8fKdHxBzYbwawTZUQ5lxuP
	6QKURti3zWBl5bzAKScc0WbwuDe5t79/Qaw==
X-Received: from pfbkr8.prod.google.com ([2002:a05:6a00:4b48:b0:845:e386:e036])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:f98:b0:845:e9e5:cdec with SMTP id d2e1a72fcca58-84ee4933b3emr10031695b3a.62.1785794381432;
 Mon, 03 Aug 2026 14:59:41 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:59:39 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
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
References: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v2-2-fd199b0171fd@google.com>
Subject: [PATCH v2 2/2] PCI/AER: Fix memory leak in aer_recover_work_func()
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


