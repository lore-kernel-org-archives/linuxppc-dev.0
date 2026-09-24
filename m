Return-Path: <linuxppc-dev+bounces-28137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FF3C98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:36:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZk1jt3z3bkq;
	Fri, 25 Sep 2026 03:35:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271325;
	cv=none; b=DCUdMHTZ7/MZxSZdmlY2RxdbuNPClxkejWLCCxAvitrO/qnY1G+wOhm9jQeMt8v6EkYAvaWkVgKp/1h+OELuO3yJhUf1lXwCyS7lk47xQML1VCG8jPliaSgOBVqSXgdTPlFW9VlHXf2GRNTNb0F29rUVwKlo17O1zgcBwCJYSYZ69vwHawNctuvLz3k/v7HdFQ+kXkNUQvdnHGhXaWhBpXSSbWGHuYcAPj+Db02yXc5dLAodjUWiBA2FZqf+zn1qZ7lN6c/DPTP/ni4sQOdpvpcWEhFAZFlxS/PGcrK5FvBj5e9sCb2ITHgj0xHxkI3qumN02MZtg8XpFCwoo6Xd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271325; c=relaxed/relaxed;
	bh=K99KP4+ZdUEIy16B2JsKwnOlIfNzTFpXvKThE7YBS/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5z5yjBftVi5mqSnkU2dHzhG9GavJifEs0isGgn4vYBwrwRDU+KQvdEFfRW3oevp9lchCDv5o6YPkVETDVlPLU7UbB3y0ykyW3YHYjUGArBt+9gyQVeSGslo4O7d14dJN9yzeWLa7fFvZI+a8wQ/WlwuXM7Srs1bkqJu9Er3eKg9ssXWrT8dsnYXqwjXzLZoPvC8q94CaC28YOnMRReheD97z++ISgpEVlWqH2f3LipxF/E33N+YFCw7OrdTQuWrd2tJvk/M1XvJ7Y+uUeimxPp8TBaPYWVsY5j1Q1Y0yW34QKrLrv0oupOiFssBbAfq49Pej3iQ0cKrxd61Tmb2fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K1X/3Ji3; dkim-atps=neutral; spf=pass (client-ip=209.85.216.72; helo=mail-pj1-f72.google.com; envelope-from=3vv-1aggkdeylui1tiksowwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K1X/3Ji3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=209.85.216.72; helo=mail-pj1-f72.google.com; envelope-from=3vv-1aggkdeylui1tiksowwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZb6y9sz3bRp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:19 +1000 (AEST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39af92138f9so101136a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271317; x=1790876117; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K99KP4+ZdUEIy16B2JsKwnOlIfNzTFpXvKThE7YBS/A=;
        b=K1X/3Ji37jHiDrv4TDd0SdxDz+Kev58PheLC7VwZ99YJC9iYStQege+d2u3AwPowbl
         3kY3t4PXhZkfkhxZOtlaGVv78+1wtJICevd8hiaxs95wK2nLfW7bAeYxLYQnJfYlDpTw
         UwrnwORfg2R6UL8J/cjFHvUYzUzMFEdWUcM5B4kVhNEODSEnjcxd/FI3IZREng8SGbOn
         h0Z/t1QE5z2FU9Ut6wACz4Cq9vKxW/aLngIhob6jzLp5gPV2r5euNZhbArNHvvKvVf/S
         tvIAP5aO3XDo/6OGIC+Aymnz0tV6DrUzhtobEXNg5wYYxxBfU1067NyBnqAFt2D9BVEo
         H5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271317; x=1790876117;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K99KP4+ZdUEIy16B2JsKwnOlIfNzTFpXvKThE7YBS/A=;
        b=RAA6qXYyDYGqx2MwLyoJqv+vegCt1wrCjWzVu2kcLT5DQCeZefe+H/uxyIS+elsomd
         7V+jVHJEu670cV79AU7OqlxKkMAVxWqWNs3Q2dTFRaUz+uO6npnOsj5aa1ELdCKDY0nh
         UXHkr/lCOk9CNkKaujl05ZfrrcEl2xG8aePnukPNNrks1o1swHh8Y+64SvAuCUiDSve1
         WewtCqmD1b2h2o0ZZHjxm/ltAoGqev5yoOuIx19lr0Na5BOJSvHNTBXqlcFavrBWEZ1T
         kdPw8zg7y6Wjz9p7x/JtN7sRZfymGD+CRNDRfcwkB5rqJcPOAKGxRKO6MyUo7lNUzYSt
         N56A==
X-Forwarded-Encrypted: i=1; AKwUvBz0P8cgU0cg30kbj2w6SHF2g0KmdurPS3P9Qb41v5Z8pIGN8SNfyFnREiSZ0UK3/4PAPABgzuxO6+urmeI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ltQv9s9TK/WgXqwHfEIkhiLCSRmOSxdY6I8XD7IP8WaPwMIodI
	hKq0NcP5jVXWGD8ZD+Xto/tqMvG04p08IxFoIcqDnOm37bgmQyLZX7vjJVch5gr2H7MQwnuZv3S
	Ti1hiSVoUT+RRlQ==
X-Received: from pjqo18.prod.google.com ([2002:a17:90a:ac12:b0:3a0:42b3:e871])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2ec7:b0:39e:6c68:fd89 with SMTP id 98e67ed59e1d1-3a098b2133cmr2058390a91.30.1790271317025;
 Thu, 24 Sep 2026 10:35:17 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:57 +0000
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
Message-ID: <20260924173501.856380-12-dmatlack@google.com>
Subject: [PATCH 11/15] PCI/DPC: Save DPC state in the saved capability store
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

Save and restore the DPC Control register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Key the save and restore paths off pdev->dpc_cap rather than
pci_is_pcie(). The presence of the save buffer used to stand in for the
presence of the capability, which the store cannot do because it is
addressed by configuration space offset.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/dpc.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index b7f79266f66d..6f40cf2c712c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -45,34 +45,18 @@ static const char * const rp_pio_error_string[] = {
 
 void pci_save_dpc_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
-	if (!save_state)
+	if (!dev->dpc_cap)
 		return;
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, cap);
+	pci_save_cap_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL);
 }
 
 void pci_restore_dpc_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
-	if (!save_state)
+	if (!dev->dpc_cap)
 		return;
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
+	pci_restore_cap_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL);
 }
 
 static DECLARE_WAIT_QUEUE_HEAD(dpc_completed_waitqueue);
@@ -408,8 +392,8 @@ void pci_dpc_init(struct pci_dev *pdev)
 	if (!pdev->dpc_cap)
 		return;
 
-	if (pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16)))
-		pci_err(pdev, "unable to allocate suspend buffer for DPC\n");
+	if (pci_reserve_saved_cap(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, sizeof(u16)))
+		pci_err(pdev, "unable to reserve DPC save state\n");
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
 	if (!(cap & PCI_EXP_DPC_CAP_RP_EXT))
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


