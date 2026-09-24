Return-Path: <linuxppc-dev+bounces-28126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9992EC9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:35:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZS4C4Fz30TP;
	Fri, 25 Sep 2026 03:35:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1047"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271312;
	cv=none; b=OCXUYMg+j4fdyTOqoJGQ4Y8BthCuXz4LrggKqGNxoTi7Wj3FoRB8UAnxIJB/Wf8066ztu7Ngn4mb8Vvf4dASMaLdnoh3MAfgSL2zy3QZEDyEI+lwLpDXPnfoEPjAfXh8k7knH1tqZ6x+KYVXanyTlZJssL7fodjVN7IfOn24Ee/UaMSb/L94e75LvpkfD5Bj7DKjXhP5QNejg4duXhgHGj5pQG3VJ1BJicbNDtwGEZ5PiqcSeYSv1dZnYUdri9pz3KJmCGFfcnOCkQCo917OaLNsx/X3iyChwAYMqVjxVb5GX7pxvFi/rSbSXRdi4mhY0Y2vhjOjl20Tbk5Hizo7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271312; c=relaxed/relaxed;
	bh=N0rfVeKGfaHWBFQak5OwGNeTtzDcqQjSrfmq86KyFwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L5zXZzgy7g1RH6JY6id0WuWs+BkChKZ0dWQvBKPRJj3eZOXGL5zXgrRtDRE5WguGr0Fd86lC0PvNDQ3O7IjtYm25q9h+6vdrx06X26WLig/qVeHLalMThaDGcQlD/Q0Wf0NGC+5vRjl2n8OYc4M6R8GQI1CUlSr9g/Fba4zJeb8czjyiAknCM9rTsljWUHWImBxmD4hBXwVnHyHCyHeCJ9DuDX6N+V6v3mWdVid9zDSw5YtkNUscJz0XrmSoS/UpS5lfSwKfUKvjhzwlNItfNwi5GFCOqGuyecl4nI9mDnklT3UkbV1cBaJUKATr87EwE37fPf4oRy+NnFZt2HydXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZiIPHnIe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3tf-1aggkdd0clzskzbjfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZiIPHnIe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3tf-1aggkdd0clzskzbjfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com [IPv6:2607:f8b0:4864:20::1047])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZR0RKXz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:10 +1000 (AEST)
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-39512608fb1so183692a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271309; x=1790876109; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0rfVeKGfaHWBFQak5OwGNeTtzDcqQjSrfmq86KyFwA=;
        b=ZiIPHnIed9gHmtOUp/PyGCZ7vL/72oTDtcq7NfUxPQynsDSsqzxmFQrMXl7THnXhx5
         dusO29AE9oy569yFAzN0l8+h7PYc7IhqWwRGS3pCg5yp1oI6mArAhp8IYYymc1Qb9RWU
         00oA8E3MonUijGmyQFazopbM11sF0y2BA39ZeamHhw8o3V+Cj944stkGsTWcMZB6TPdp
         U3LPl3t6BxRFO943nZKmK8pIlcdOVTud1QPeLiH6UY4JdSTcx1HQcWDC26LWNC85vwB5
         k/afPwc2lBooaZDoDZYAK/EsfEQ/V+xYRgHwqtDwdXthmBUxytgVHvYAQKYG6139sg0O
         HILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271309; x=1790876109;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0rfVeKGfaHWBFQak5OwGNeTtzDcqQjSrfmq86KyFwA=;
        b=BssaU/S6UhSdQQ/FqeM0VLzEdvg9YnTuNMEHKHwHSHzYRJw9rjqMJdH72Rb6xQBYxh
         Q2g2OXsWy/vdM2qrUWWE9hhyQmU2Bx+ey/3CEIruWtalZEDiLDV1bNlNqoU8tTu2XdFG
         TN7tpRQ8XQyOg6XYjBOz8w4StD4thaX+4nnFgr2LlfQX0Oqo11YnYbEBiWWRwqJr2mF+
         z9EAuAMw87tj98t5dic7Qe/pVppvWKyeIoej1btB4jKTPoSqdq4aP0Xovqsx4DCXpx7G
         Kqhdf0GqlUYNZiEkiuKpIC0zKAbY09Y6V4hFCDzkNpjdwHLmjAIFuzWD6EKGPK+cg3g2
         jtzQ==
X-Forwarded-Encrypted: i=1; AKwUvByGMyZKh8vc52e12H5iu4zIsWsWC5gXSN3YVYR+ZSKMNm9u04pnJryfcMSgijOX0VrX/3clWi/qPo82SEU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m2L72OtReo1lVhqaWDKlFvQKmZ+bkjwfMrE8GCL4BiDUes4782
	FGT3Oux3Kr0mGmqG5KBuhq55EPjEmRffvDlEvvheFtDLnaYlgbRUChbN4Gnta8iyQDen91is0OB
	g1gW5AQbLTA8UiQ==
X-Received: from pgdu27.prod.google.com ([2002:a05:6a02:2f5b:b0:cc7:54bc:3f81])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2541:b0:39e:6c69:9b9e with SMTP id 98e67ed59e1d1-3a0992905acmr2586055a91.67.1790271308552;
 Thu, 24 Sep 2026 10:35:08 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:47 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
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
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-2-dmatlack@google.com>
Subject: [PATCH 01/15] PCI/DPC: Allocate the DPC save buffer during device setup
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Allocate the DPC capability's save buffer in pci_dpc_init() rather than
in dpc_probe().

dpc_probe() runs when the portdrv DPC service binds to a port, which is
long after the device has been added, and does not happen at all if the
service is not enabled. Until then pci_save_dpc_state() silently saves
nothing, so a reset in that window loses the DPC Control register.

Allocating during device setup makes buffer existence depend only on the
capability being present, which is what the save and restore paths
already assume. It also puts every capability save buffer in one phase
of a device's life, which a later patch relies on.

The size is a compile-time constant, so nothing about the allocation
itself has to move with it.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/dpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..b7f79266f66d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -408,6 +408,9 @@ void pci_dpc_init(struct pci_dev *pdev)
 	if (!pdev->dpc_cap)
 		return;
 
+	if (pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16)))
+		pci_err(pdev, "unable to allocate suspend buffer for DPC\n");
+
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
 	if (!(cap & PCI_EXP_DPC_CAP_RP_EXT))
 		return;
@@ -499,7 +502,6 @@ static int dpc_probe(struct pcie_device *dev)
 		 FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), pdev->dpc_rp_log_size,
 		 FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
 
-	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16));
 	return status;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


