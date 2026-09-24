Return-Path: <linuxppc-dev+bounces-28136-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8CFC9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:36:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZj3x7Nz3bjW;
	Fri, 25 Sep 2026 03:35:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271325;
	cv=none; b=ZMYdYX7cAAOL4LbQCx/XmEmP5JC+rkpaIV4Zl25JlZMZdj1B8Pqg5zAfzoTfM2HI2iLTEmIFB4I3q/601No6ZVuVoOUpBlXzjDCMQaZpixfNYrmLqvaUlthpSvPSpQAcMXnSw7sTet0+At8y08d8/w1KtRjNmyYLlD23xWlDF5EoEaF2fDaV+gkv30O1UPzfoN70mJ4VVtgWxYNg0k7aVtPHwEJ1PivSIgUVooSi3t+nBnZAX2kwhxpzLnLwrP62W3j63J6IzoQtAX+YV2+hlNzKQl498YHBE8L04IXX1zRia02DKogVtEXtgJIwm1Afq+L1n6bijKnzjaKA3E1Q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271325; c=relaxed/relaxed;
	bh=zFj8/UWJalzVgVbf9Z+bMao7LvxnzpTDorii05nidDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P7WGVdFppwPqgq3SBKNCs95kT25jlXwaWpSOgzMtKnrmA0SV+gNxY0bFfuoULvt1fGeKHU8Chk5qx3+QpF/ah2FayLA0Iv0X2zACzVV2YQY65eFCWSahsXIgNmKTQFI5cO77bswxgpmP/KPrQBfYe4IRSCYHZN6CaGGI5tu55ewnwjkIu08JI949ncBysRjr3p97fX19XDVtDEMxkvXWqWx/y5jOZddU8g1w6vpE4kHnJmo0DQaKwXWAcPl3j+4Vsu92h8+9cKv3i0aftcXPydudb1BGnisQpMUVBpoyTsVVW87F1bbBMhEL3ctFpjhCVTzdew3LqZGZ7uU78zLttQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sMIB3B6b; dkim-atps=neutral; spf=pass (client-ip=209.85.216.72; helo=mail-pj1-f72.google.com; envelope-from=3vf-1aggkdeukth0shjrnvvnsl.jvtspu14wwj-kl2spz0z.v6shiz.vyn@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sMIB3B6b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=209.85.216.72; helo=mail-pj1-f72.google.com; envelope-from=3vf-1aggkdeukth0shjrnvvnsl.jvtspu14wwj-kl2spz0z.v6shiz.vyn@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZb5h5lz3bQq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:19 +1000 (AEST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39e087a17dfso145725a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271316; x=1790876116; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFj8/UWJalzVgVbf9Z+bMao7LvxnzpTDorii05nidDQ=;
        b=sMIB3B6bUqvbQjvIeEJTJusfNH7awiDgRGwprYtwsGcUdeXOIFE9QXstLso6XhuD9r
         /l6LrNhdJUFkTNcMMkc0e1sx9qZWPfu/LS0KL+c0CMNpqlRAQsnSj61OVA+I8eE8xOij
         Ebf1TAqvBylgNbSgZKfK4fR4UucPS+w8xr6ngbxruHcnX4iYtjIDgg39f27hYGM0iQks
         xzNdZTOjsTzQqZCUyYmNJl3OhStdf500bDDCyflprMXBl8iOh68BGX7iRmPEQi1BlrTx
         doCWP2dwVDOeR4JdCO5+R6NE0JEeA2Fm6k95u6suR6Hp7S16W2GOjwab8ZWjzoBl+91j
         m92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271316; x=1790876116;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFj8/UWJalzVgVbf9Z+bMao7LvxnzpTDorii05nidDQ=;
        b=O6W5OvI8E1voQo61WzmoepnYJyfUTwg9D+9UJ5RmX3evvXKcqbJHgKQ2F5fApxmlXY
         czMfN6kqIpF5OR2cs4PdmW9Be9BNOIzaUnUb3ers1z/Fk3YCt2eicpG14RlTHG1yTNmL
         by2NJ1rKvzYVz1gnNEHqzVZoV3h4/jX4vCNlGTRPZb3sUzHHZd6XcvFP5ObzWTcRY2Li
         XCArXz0RUQ2v0payeQ46ShOBze7QrHPSozxMXXeGaGSO3HGEgApuujitCmoDHda2ziPM
         Lk5fNLYo/BHud15Ow0uxQklZr2+C78pjjD41SK5fVDFpwn/JUO4HJGypZtczQaZ35tvu
         D7eA==
X-Forwarded-Encrypted: i=1; AKwUvBznbB0QHCMtyR5rTPCI05pOKG0JvJusrxcCjH4H1iQ8iN+oN2GZ3uYQwDh74zLRir21Z3JMwNdZPDHtw4c=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nWg9RJdIZ8Bus0UEUuiGcM9eLEEFKd+ixZNKIPYKpsVCa0dnNB
	hMLsJ21EMc7v1kv2Ki09Y3bYjvhqglEsOJ9vib9YLvW7nPAFR6oyCayg7Rgp5sXVzOdTaPSSTNO
	IBmpqyOOcR2ebvw==
X-Received: from pjzc9.prod.google.com ([2002:a17:90a:e109:b0:39d:bd8c:be19])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c12:b0:3a0:b210:643e with SMTP id 98e67ed59e1d1-3a0b21068bcmr591367a91.22.1790271316212;
 Thu, 24 Sep 2026 10:35:16 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:56 +0000
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
Message-ID: <20260924173501.856380-11-dmatlack@google.com>
Subject: [PATCH 10/15] PCI/TPH: Save TPH state in the saved capability store
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

Save and restore the TPH Control register and Steering Tag table through
the per-device saved capability store instead of a private
pci_cap_saved_state buffer.

The Steering Tag table is variable length, so pci_tph_init() had to compute
a buffer size and both the save and restore loops had to walk that buffer
in step with configuration space. Reserve the table by offset instead so
that the loops can address the entries directly.

Report a reservation failure. pci_tph_init() ignored the return value of
pci_add_ext_cap_save_buffer() entirely, so a failed allocation was only
noticed later as silently missing TPH state.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/tph.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..fa9f60e5a431 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -439,10 +439,7 @@ EXPORT_SYMBOL(pcie_enable_tph);
 
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
-	struct pci_cap_saved_state *save_state;
 	int num_entries, i, offset;
-	u16 *st_entry;
-	u32 *cap;
 
 	if (!pdev->tph_cap)
 		return;
@@ -450,29 +447,19 @@ void pci_restore_tph_state(struct pci_dev *pdev)
 	if (!pdev->tph_enabled)
 		return;
 
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
-	if (!save_state)
-		return;
-
 	/* Restore control register and all ST entries */
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
-	st_entry = (u16 *)cap;
+	pci_restore_cap_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL);
 	offset = PCI_TPH_BASE_SIZEOF;
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	for (i = 0; i < num_entries; i++) {
-		pci_write_config_word(pdev, pdev->tph_cap + offset,
-				      *st_entry++);
+		pci_restore_cap_word(pdev, pdev->tph_cap + offset);
 		offset += sizeof(u16);
 	}
 }
 
 void pci_save_tph_state(struct pci_dev *pdev)
 {
-	struct pci_cap_saved_state *save_state;
 	int num_entries, i, offset;
-	u16 *st_entry;
-	u32 *cap;
 
 	if (!pdev->tph_cap)
 		return;
@@ -480,21 +467,14 @@ void pci_save_tph_state(struct pci_dev *pdev)
 	if (!pdev->tph_enabled)
 		return;
 
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
-	if (!save_state)
-		return;
-
 	/* Save control register */
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, cap++);
+	pci_save_cap_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL);
 
 	/* Save all ST entries in extended capability structure */
-	st_entry = (u16 *)cap;
 	offset = PCI_TPH_BASE_SIZEOF;
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	for (i = 0; i < num_entries; i++) {
-		pci_read_config_word(pdev, pdev->tph_cap + offset,
-				     st_entry++);
+		pci_save_cap_word(pdev, pdev->tph_cap + offset);
 		offset += sizeof(u16);
 	}
 }
@@ -508,14 +488,22 @@ void pci_no_tph(void)
 
 void pci_tph_init(struct pci_dev *pdev)
 {
-	int num_entries;
-	u32 save_size;
+	unsigned int off, len;
+	int error, num_entries;
 
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
 	if (!pdev->tph_cap)
 		return;
 
+	off = pdev->tph_cap + PCI_TPH_CTRL;
+	error = pci_reserve_saved_cap(pdev, off, sizeof(u32));
+
 	num_entries = pcie_tph_get_st_table_size(pdev);
-	save_size = sizeof(u32) + num_entries * sizeof(u16);
-	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
+	if (!error && num_entries) {
+		off = pdev->tph_cap + PCI_TPH_BASE_SIZEOF;
+		len = num_entries * sizeof(u16);
+		error = pci_reserve_saved_cap(pdev, off, len);
+	}
+	if (error)
+		pci_err(pdev, "unable to reserve TPH save state\n");
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


