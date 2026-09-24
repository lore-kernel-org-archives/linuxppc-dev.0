Return-Path: <linuxppc-dev+bounces-28131-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2C5C98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:35:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZf2Lvjz3bZs;
	Fri, 25 Sep 2026 03:35:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271322;
	cv=none; b=mdwXdo7u6MmVa92OX7/SuKxvnNGN1s4BUCEIIDD9pMQ3v2DuiKj2O2ZKjiSZyN8gTOlsPb0cGyZOHET0D1/9ooWcLEJeNvWoA1iYp/FeP8m82UYTtN7oTSsg7byWMJGL12AFDbzQKKByVKcuasnYt2ClUO0uUaZWL2hZoTf29lz7s7hNjWyCKkDw89XKPj3f6bTO7JDcRVhfaWfsik+lMgbSLM88fIEfabw2O1X9HgJVZ9JJIrK7nb7Ih/Oq5LPR9nWhe9aQ+1kiatx4X8jPpUKODpAaTCssJ+gB6s5fgJRYXqRAcdjWASEMxVGybiqjDtl5RcwdYgBKTPIKfrRNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271322; c=relaxed/relaxed;
	bh=FYR5MAb0ktDGLlkQWDn+bRn8aUIoebMDEJfJ0HSFDY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IB/ogU435T/D/fPk5KAx/ukVQ1ctBNkwD+5wCP4QvWXnNyPdIu1XAWZ8tOinbJwGi7T+RGZS7U5WAi7DO/4iPheNufXVVlY+A1Qkz/xxIh+KXTdcuWvdP+hnnXksIPPfDx8yd0nfl68YlFKa0bjhNBOIoxnTabcxP+/5i+93Cyyjvq17t01OBxqdSNbk2Krh8w+F7B37qW6LcCaQ/C1R9SVOswZrwGeG+9dAp4bE75vjwgS/DbynmRS85TU9ELnhYFExd2/fbgh0S8i5st4d4LetBs8riR/wBzYc6BZNzVYa+RU28r37XuxowUSvoQgC9iHnjVxQkj77IqJFEQKLRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fdh+veNq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3t1-1aggkdeafocvncemiqqing.eqonkpwzrre-fgxnkuvu.q1ncdu.qti@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fdh+veNq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3t1-1aggkdeafocvncemiqqing.eqonkpwzrre-fgxnkuvu.q1ncdu.qti@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZV1YVsz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:14 +1000 (AEST)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2ce7dff6253so8092605ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271312; x=1790876112; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FYR5MAb0ktDGLlkQWDn+bRn8aUIoebMDEJfJ0HSFDY0=;
        b=fdh+veNqhRva4HDZ3Vyp0dvU7Nl3jA/M84VaZHaKeXH3qKpE3mzFkVhHWNJPfk3UJy
         5RtV5dO+F8N+/Uv/zf4zFsLtV6huGrBNszqEa8RGUmrkl5iU3bBTVQin5akO/ZtEVEKm
         0w6YMlgepQZ4DgL7Us+6XLdLH2H8HEkg7F7ysu+n6Vsp1jhYHQ5Xj5pE0b6JEwGifPBv
         kr43FhKL5mptU7B0h/Y/T3Bfn5Frv4+pT5K5S5XkpRrhZKtascksb9mq93z+wy1YwaTL
         2NQGciJMdX+WxR3Hoa3gJZnV77nV+aybzB9aEZTiCIOMw0BgyVdEpbBNgrQanUqr6aZR
         GyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271312; x=1790876112;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FYR5MAb0ktDGLlkQWDn+bRn8aUIoebMDEJfJ0HSFDY0=;
        b=KgSUSn61rb1Oxwo91SihXD5TrKK7pB5AQn7xT85+Yq8DHIfpEcTaTIhG6nxkqVJG7f
         CupCiOqxkIV5FYC+8mZnloKQibvc6xjTM2MqiY8LF3mnmNa3UmMhLBcyCWuDtZHKQ4ev
         SmGzMRMTwFMbOakG7Y2rkIEI+Uqq3/9GiMQeaSuBFMwzHfUKgsRmJXu/Myc4InTUuvUE
         VaQ28XNTyfoxEOIOSln3h45n3Osk9XWACd8E6usjFjjy1wlYFE2hdFindp/pj3fyeQ3t
         Bc9zDzbImlbpUvmWirRbYdyKjdyVXHJXMODnBFHuzLYhATLnbgg+qyKLmdpZHjJH22xo
         RCkA==
X-Forwarded-Encrypted: i=1; AKwUvBybkS8bjmjWhyRkz1fOvaKjjoaGsMaWgRnptNHDo9yrRQeUDEWcV5B7sEj4N1kQ4MmMECcxn36VRglVlFc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nNiIz55ZERaN/TCoUzYTcrdRoq9OXrDnHyv/lAa1L2jVZwDD3J
	PRtXcLrjtCdb/nydGy5NQjDqbC4AASTaViCJtvwpLvg5msyIye5O5pe/+vvy26vNML0XOfsQe/l
	j0NHEE/0zYmMtNQ==
X-Received: from pleb19.prod.google.com ([2002:a17:902:d413:b0:2df:6eb9:45a2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:19cd:b0:2d7:5da6:2af4 with SMTP id d9443c01a7336-2df7dea6233mr20998285ad.4.1790271311978;
 Thu, 24 Sep 2026 10:35:11 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:51 +0000
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
Message-ID: <20260924173501.856380-6-dmatlack@google.com>
Subject: [PATCH 05/15] PCI: Save PCI-X state in the saved capability store
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

Save and restore the PCI-X Command register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Reserve the register by its configuration space offset during device setup
so that the save and restore paths no longer have to locate a buffer, and
so that the saved value can be found without knowing how the PCI core
happens to lay its buffers out.

While here, make pci_save_pcix_state() void now that it cannot fail.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c | 43 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1c2c572aa49c..9e49806c6891 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1733,40 +1733,26 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	}
 }
 
-static int pci_save_pcix_state(struct pci_dev *dev)
+static void pci_save_pcix_state(struct pci_dev *dev)
 {
 	int pos;
-	struct pci_cap_saved_state *save_state;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
 	if (!pos)
-		return 0;
-
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
-	if (!save_state) {
-		pci_err(dev, "buffer not found in %s\n", __func__);
-		return -ENOMEM;
-	}
-
-	pci_read_config_word(dev, pos + PCI_X_CMD,
-			     (u16 *)save_state->cap.data);
+		return;
 
-	return 0;
+	pci_save_cap_word(dev, pos + PCI_X_CMD);
 }
 
 static void pci_restore_pcix_state(struct pci_dev *dev)
 {
-	int i = 0, pos;
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	int pos;
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (!save_state || !pos)
+	if (!pos)
 		return;
-	cap = (u16 *)&save_state->cap.data[0];
 
-	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
+	pci_restore_cap_word(dev, pos + PCI_X_CMD);
 }
 
 /**
@@ -1786,11 +1772,7 @@ int pci_save_state(struct pci_dev *dev)
 	dev->state_saved = true;
 
 	pci_save_pcie_state(dev);
-
-	i = pci_save_pcix_state(dev);
-	if (i != 0)
-		return i;
-
+	pci_save_pcix_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
@@ -3579,7 +3561,7 @@ int pci_add_ext_cap_save_buffer(struct pci_dev *dev, u16 cap, unsigned int size)
 void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 {
 	unsigned int i;
-	int error;
+	int error, pos;
 
 	for (i = 0; pci_is_pcie(dev) && i < ARRAY_SIZE(pcie_saved_regs); i++) {
 		unsigned int off = dev->pcie_cap + pcie_saved_regs[i];
@@ -3591,9 +3573,12 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 		}
 	}
 
-	error = pci_add_cap_save_buffer(dev, PCI_CAP_ID_PCIX, sizeof(u16));
-	if (error)
-		pci_err(dev, "unable to preallocate PCI-X save buffer\n");
+	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (pos) {
+		error = pci_reserve_saved_cap(dev, pos + PCI_X_CMD, sizeof(u16));
+		if (error)
+			pci_err(dev, "unable to reserve PCI-X save state\n");
+	}
 
 	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_LTR,
 					    2 * sizeof(u16));
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


