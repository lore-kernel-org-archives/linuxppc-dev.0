Return-Path: <linuxppc-dev+bounces-28135-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5EDC9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:36:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZj09WQz3bj7;
	Fri, 25 Sep 2026 03:35:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271324;
	cv=none; b=bCRO63NsqltMNVhZJX0QWbl1k12t1REiRga6XqZO/0NJa6kKFBqGbrRqNeOwKyOMf9HrgwnxSAZJEZtWzBDFuRGYszZOG5M9rtey792JJy6ZoolaoCw+euLbHMwLnuu+etC+U4Z5xx9zJtnHfw+5jWU7XnQt/qwkqtEuJmFqPUQC2z9XEt2mZlI/Uh6Co1LK488NH6hvc9B6u0zRXAwpaBaA9AOX/PbWUZFEzEUH1xx3GydvMybu5/4Fbg4rkEjT5VOyyEwOm2Pq6Vks2Gp6DCQbKsgN+X8lGAFe6S8GjY1+drQDuX6CTKKdDTgn1DyYn+JBniFzyIp4xu7nGrf2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271324; c=relaxed/relaxed;
	bh=HaY3giQHInn5O/nliw0nJVwoVW0YaeGKgr+RxcxHBtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CbddQyB0SYYb0G3cRdDrnC0KX6tp9rQZtyPUrn8e6SjzWZLfGCx0PdmAJio8FEVy0GOoQtB3VySU7vqBCyp8yM3Wlby4CU0voBigFdFQ5ZVk2lA8P4eByo7XbsKI8tKXL9scUcEPQ2AGxweyJ86E2sL5OaXK0sS6Twg3MSxJu+FbVJyXWbiQqq8gfw32TzN6v4gxl28yEDv5lcOwtwpHc2TZqjcxvotvF4enVV3NcrtftNNAxSmbMblEZpZWiZTj28QccpcjD8FyEOGGLhi7JsJaw+qqJ4t+54346BV5UxYdRkaXSEW5rvJY7ZMLisNH1i6pI7UkTSM9uO4RbbHrzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SSfJtVOh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3uv-1aggkdeihqexpegoksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SSfJtVOh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3uv-1aggkdeihqexpegoksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZX0jj2z30WS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:16 +1000 (AEST)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so21800a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271314; x=1790876114; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HaY3giQHInn5O/nliw0nJVwoVW0YaeGKgr+RxcxHBtA=;
        b=SSfJtVOh4qVPWUBlo9C/JxWb1JQ8t+zxA8nFagxHOiAoZf+60N0aFz3Z5/HbzqWLqP
         DDisqiZGj5PbrKisiGicNZ8LsCSk/OXDWdzMXFd3sLH+/I90t6jSE24PV27dxqlY21B7
         g0WouLB4aKIBxKbFTt4mk/Qw/PLnhZADxFCckRuziaSpXkmckUxeYkKeChijlV8OTJ2S
         Sw497P1Z8weP60M+Wkp/nSbZpZELIp0IZwbPGpuX8WBJEd6IZVrgWDRGB6PlseRw89sD
         y8Lf5hlovMmNhSjRdrC0t4w2BWd+RJDELuFDoNSz+eaPBVyXbpwHvzLMK+0FxRkLR37a
         ft8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271314; x=1790876114;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HaY3giQHInn5O/nliw0nJVwoVW0YaeGKgr+RxcxHBtA=;
        b=iBoXFDeDF4AxneVxkLOM3zm5Y9eUMmZwytGnguV2lfoHHgKLTJ1y8E4iYDPrjposQ5
         Hqy3uYFWWw40oMQKglgvMsv6cGZHJs2ADfYZBFRjnOwAE7TbxBaO9izzDDa51KLSnUGW
         lPfTbcnp7MN+zwJ1QEo1mYinAD5qbLZy+jblxmZ1a8Vij9uZas7mlQ32bjB5kNdMiozD
         zwofnYsQfyosrjcg5YyWwoWpjvxL0XTJ4Se6uVXeWFaY4iFNR/RQURHQ3TZsMtLtDLKY
         FJ2BxMaKdZwN3Afg+lQBjp0KPoFTxxXFwFS8bJ1g9lqwdy/TVuJB+1XA95qjA0c2ffts
         ZNzA==
X-Forwarded-Encrypted: i=1; AKwUvBwNZoX7u/N9A7t6rAIARIOIf5G8tvAjEUGRBiNoZV2ztY1731+JQMHKftW5uzj+IW8IHrN9cCqzId+KPoU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mztaNooH19RahaNNzoZU7YCczqbUPXjgiXqVuIvehYHGil5X6x
	IRd528wWP1vL3XYLsHUlEC/GUV3g477hbAHrtIiFUz9+OyftFbeo0AtTyzHaS7Wb8dtTUFOHR8n
	DqlFWwt94KL8X0w==
X-Received: from pgbdm10.prod.google.com ([2002:a05:6a02:d8a:b0:cc7:8562:ccf8])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:b08d:b0:3dd:a197:edfa with SMTP id adf61e73a8af0-3de0e97b53dmr3097217637.73.1790271313700;
 Thu, 24 Sep 2026 10:35:13 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:53 +0000
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
Message-ID: <20260924173501.856380-8-dmatlack@google.com>
Subject: [PATCH 07/15] PCI/ASPM: Save L1SS state in the saved capability store
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

Save and restore the L1 PM Substates control registers through the
per-device saved capability store instead of a private pci_cap_saved_state
buffer.

pci_restore_aspm_l1ss_state() needs both the Upstream and Downstream
Port's saved L1SS configuration, and had to fetch two buffers and decode
each by index. Read the saved values by configuration space offset
instead, which names the register at every use. Add
pci_read_saved_l1ss_ctl() to read one device's pair, so that the Port
and the device below it are read the same way.

Reserve PCI_L1SS_CTL1 and PCI_L1SS_CTL2 with a single request, since
they are adjacent DWORDs, just as the old code allocated one two-DWORD
buffer for both. Skip the reservation entirely for devices without the
capability, which the previous code could not do because it allocated
the buffer through pci_add_ext_cap_save_buffer() before looking at
pdev->l1ss.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/aspm.c | 52 +++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 16f22af98686..9d64c6aebb9f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -59,19 +59,19 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
 	int rc;
 
 	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!pdev->l1ss)
+		return;
 
-	rc = pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_L1SS,
-					 2 * sizeof(u32));
+	/* PCI_L1SS_CTL1 and PCI_L1SS_CTL2 are adjacent DWORDs */
+	rc = pci_reserve_saved_cap(pdev, pdev->l1ss + PCI_L1SS_CTL1, 2 * sizeof(u32));
 	if (rc)
-		pci_err(pdev, "unable to allocate ASPM L1SS save buffer (%pe)\n",
+		pci_err(pdev, "unable to reserve ASPM L1SS save state (%pe)\n",
 			ERR_PTR(rc));
 }
 
 void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	struct pci_dev *parent = pdev->bus->self;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
 
 	/*
 	 * If this is a Downstream Port, we never restore the L1SS state
@@ -88,32 +88,32 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
 	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
 	 */
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
-		return;
-
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
-	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
+	pci_save_cap_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2);
+	pci_save_cap_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1);
 
 	/*
 	 * Save parent's L1 substate configuration so we have it for
 	 * pci_restore_aspm_l1ss_state(pdev) to restore.
 	 */
-	save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
-		return;
+	pci_save_cap_dword(parent, parent->l1ss + PCI_L1SS_CTL2);
+	pci_save_cap_dword(parent, parent->l1ss + PCI_L1SS_CTL1);
+}
 
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, cap++);
-	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, cap++);
+/*
+ * Read a device's saved L1 substate configuration.
+ *
+ * Return: true if both registers had a saved value, false otherwise.
+ */
+static bool pci_read_saved_l1ss_ctl(struct pci_dev *dev, u32 *ctl1, u32 *ctl2)
+{
+	return pci_read_saved_cap_dword(dev, dev->l1ss + PCI_L1SS_CTL1, ctl1) &&
+	       pci_read_saved_cap_dword(dev, dev->l1ss + PCI_L1SS_CTL2, ctl2);
 }
 
 void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 {
-	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
 	struct pci_dev *parent = pdev->bus->self;
-	u32 *cap, pl_ctl1, pl_ctl2, pl_l1_2_enable;
+	u32 pl_ctl1, pl_ctl2, pl_l1_2_enable;
 	u32 cl_ctl1, cl_ctl2, cl_l1_2_enable;
 	u16 clnkctl, plnkctl;
 
@@ -128,18 +128,10 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 	if (!pdev->l1ss || !parent->l1ss)
 		return;
 
-	cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
-	pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
-	if (!cl_save_state || !pl_save_state)
+	if (!pci_read_saved_l1ss_ctl(pdev, &cl_ctl1, &cl_ctl2) ||
+	    !pci_read_saved_l1ss_ctl(parent, &pl_ctl1, &pl_ctl2))
 		return;
 
-	cap = &cl_save_state->cap.data[0];
-	cl_ctl2 = *cap++;
-	cl_ctl1 = *cap;
-	cap = &pl_save_state->cap.data[0];
-	pl_ctl2 = *cap++;
-	pl_ctl1 = *cap;
-
 	/* Make sure L0s/L1 are disabled before updating L1SS config */
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &clnkctl);
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &plnkctl);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


