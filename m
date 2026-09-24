Return-Path: <linuxppc-dev+bounces-28132-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72B1C98321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:35:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZg1SvPz3bcr;
	Fri, 25 Sep 2026 03:35:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271322;
	cv=none; b=oUUy5a/OLXpSq/SoCJLrPIU0LZvdIndyhD8y/W7ON3pxaT1NYs6iwrH0rXvM8M8hxrLFtqOOObbuaQ1tbjb5oRSiOsX4HtHJ2fmCuuXPsQokd1y7yVb0YM1krS695rnTPYvpZPfXI+4buitUw9aR3BSXfhIFf/cbhR3ORD3Fp5kfg3+xug/5czm+oqS4+pf6whYVTbD9odfcM8p2Kn4WisciRzJvdVZUmVfy4cJdd1zG3hQh6xqtkE2GTyYpTGJlDIlYhOHy7gdcd6WZcpPoDHblrITbE2yBGqJ7SblFpg/oxqf0kmdYUK6Pt6w0GQBNcXmOHU19ntx4Ae+WyRWPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271322; c=relaxed/relaxed;
	bh=9KIWUowhWgqgcS9B9uJaCFyMmng9ri0RWLxjQM7dDfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VpwlCAh8CswCGjSi+eTsMO1mRI66FDpRwwK5mJjIi9xj2ws7wxPkBqP7V+5oco2aB0ad2bb2XUeBwJ7d5R9s3ltsb7mz+whWoH+XeArxDlXIXpwbO8nIQZJlDf9pgt4Tc0E3Z+4+ZvRWVk95UGaIW+JZR1mctyTvkX5PoSOZeKvyKFa2N6XsmD6GwloCdyqAklADMoeluYsLYpCWmSutCqJTvtOUfmCjnlBRnS82CT2s1gr/29DITRTp1FM88qlakOwF5O5zvP18GadzW/lD8Pm86FgUC1WCYMcOq/XQc8zPGz4umzNEkGMsg3tubi5z5q/WEbqTBYSIHSev8CSzxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=msoofylT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3u1-1aggkdeqjsgzrgiqmuumrk.iusrot03vvi-jk1royzy.u5rghy.uxm@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=msoofylT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3u1-1aggkdeqjsgzrgiqmuumrk.iusrot03vvi-jk1royzy.u5rghy.uxm@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZZ0llvz30dj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:17 +1000 (AEST)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso20484a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271315; x=1790876115; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KIWUowhWgqgcS9B9uJaCFyMmng9ri0RWLxjQM7dDfo=;
        b=msoofylTe92kMzFFjbY+5Q1njMmliDo1KFDzf4jmxmCy6RuWCzN7xEp29hUA5apyO8
         NicaNJoyZz1EGPx1/7rF4LIkLA+v2vX2eQG0FAGj3NTkDra26WpzaTg4kBtCgfBJZb0x
         1s7ZC48AfBUgrcOtpghQfGBlyLav2R+X6zOsGAH5z2sOs4sbD8R4Yub0ZyPiYOAlpysi
         ReoQ0V563aSIw5X6XOrpisWSZD3hvSfwzMd9dr9jaDD/QkDshIL7iHzrwW24kYOZnkRZ
         wU/wBf7ncVdA0h70WO6npHH4THQe+q0QTSl62wHVGCLfdZTZKv5Ic3DEvjfdIPQ49vE6
         7tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271315; x=1790876115;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9KIWUowhWgqgcS9B9uJaCFyMmng9ri0RWLxjQM7dDfo=;
        b=FuaWxzSLNhHAJ+ZKufiF48K6jwt//P6YXg4bTrDDJ9044iH314wxiHGZLzTDc+EDhA
         UW8seIEAYnIiENWX1keywSMZLAY7csjnLGQgg48DS9s9PNnfuFUrvn2U+Eh102Xqeda9
         6C/tfnC4yYX2EP48vXD2frXo8Xn56TAFXvNDi34A3J9B6bDfQFf8Fh1nLbBPrPPLDznW
         AaiMp/3iOSrWH0bR58PWqK/9v2AIiC29ZC//8V1MHGw2eEqwYo3YPYTH+/7j91l1+4Wi
         InuWepXIXLtxxpRJjpULbFDV8UIccJmhwpg04vHsaTX/H6yiK1Dn+vAt0B9zngENZFNd
         D6UQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLadSgW78+sMFprhfzPPRUsgyv2NtUNdD+LDwvGYqgwJTKkrJz8vdHcXpwxnSEQMNX5m3hrH53vaVtU4Q=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mf2B/UZjA8diIV4zwzlXAivLxCz3/Et0r90Vz0Z4UZDmdtdQTE
	hfXpG+NDSlnNti7mej4ZXVJhxh/K/pHCCVfKGQUjnWTVRs4CS2/1iBqATBHmzejGDMKxG76tYpm
	qQx483l/ryrh62Q==
X-Received: from pfbmt15.prod.google.com ([2002:a05:6a00:6e6f:b0:87f:a748:7030])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:b7a6:b0:3dd:651e:b71d with SMTP id adf61e73a8af0-3de0e7445c3mr3228498637.24.1790271315360;
 Thu, 24 Sep 2026 10:35:15 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:55 +0000
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
Message-ID: <20260924173501.856380-10-dmatlack@google.com>
Subject: [PATCH 09/15] PCI/PTM: Save PTM state in the saved capability store
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

Save and restore the PTM Control register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Report a reservation failure. pci_ptm_init() ignored the return value of
pci_add_ext_cap_save_buffer() entirely, so a failed allocation was only
noticed later as silently missing PTM state.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/ptm.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index bd3bd39f6372..a9e29e19b0f9 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -53,7 +53,8 @@ void pci_ptm_init(struct pci_dev *dev)
 
 	dev->ptm_cap = ptm;
 	atomic_set(&dev->ptm_enable_cnt, 0);
-	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
+	if (pci_reserve_saved_cap(dev, ptm + PCI_PTM_CTRL, sizeof(u32)))
+		pci_err(dev, "unable to reserve PTM save state\n");
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	dev->ptm_granularity = FIELD_GET(PCI_PTM_GRANULARITY_MASK, cap);
@@ -90,36 +91,18 @@ void pci_ptm_init(struct pci_dev *dev)
 
 void pci_save_ptm_state(struct pci_dev *dev)
 {
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
+	if (!dev->ptm_cap)
 		return;
 
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, cap);
+	pci_save_cap_dword(dev, dev->ptm_cap + PCI_PTM_CTRL);
 }
 
 void pci_restore_ptm_state(struct pci_dev *dev)
 {
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
+	if (!dev->ptm_cap)
 		return;
 
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, *cap);
+	pci_restore_cap_dword(dev, dev->ptm_cap + PCI_PTM_CTRL);
 }
 
 /* Enable PTM in the Control register if possible */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


