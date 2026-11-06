Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC269606A32D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MOpF7Y72
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4v37Myz3bfG;
	Fri, 06 Nov 2026 11:43:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::248"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925791;
	cv=none; b=oqA/Cwof+htq1DME1+o0YKBOtA6/HBsvPJmWOXRMsfSEuaR8ajoVGgEJkYDCziGJjF6Ra4gbXc/zok/JJYnP95VhcJ/4B3ROfuBajTMSUE+jPVi/GabJIllqULEAP1DcUuapKAngTEILUFhUdurLHPG8Mp711s6H3WNjyongpn2rT5qDeaI/NMqodi2n+ypjWJCBCJD3BEuxot5v77umKkn+MMBfj2IAJxg5/pSNUGWvKbgKwSqt/fAJ9CCqEAZV4/CS3m2mX2scCHKCKrO+1aTZ1ISWjY2XPBAL0Etm3bjeer4T0YdboyoK305MGf8VEx1OooMWfqNlEe94wrCXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925791; c=relaxed/relaxed;
	bh=iHjhOa1kArquGp6NzqJKIMKukUgu91Ev2XX32EWf/dM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KsfmaO1x//rNWgfNDfWpHIbj1nfaxLVuSOIyV8ZhdjmIn6t8eFHTrGX5ncnJHRbKtVgEklQwlctqPao/rgk+Xm5dZVC/KntJfvy5jRxL1pIlJgMtbiZwLn4/ePeyJ2xfrzxhxV2G6XHzCDIOPis6jZRjNukYumVeBn8mWx5+Fcug3KpmQPwBYTbWsUrfFUeSVk3ZsF6dqCACgNcsOb8KhBK5SA7dFVpbPN2GG6E4Kl3O1I+XOkUjDJXsHlFba8Wx7pN0lKqM7MoCT7FKKcnBG9MQGoKLsbhpfIet2TcjotnCFmD4WTu0rLMC/VF9Xk/3MLat9UHs2BqDNgG4DOwvOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MOpF7Y72; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::248; helo=mail-oi1-x248.google.com; envelope-from=3myltaggkdpixgunfuweaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MOpF7Y72;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::248; helo=mail-oi1-x248.google.com; envelope-from=3myltaggkdpixgunfuweaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x248.google.com (mail-oi1-x248.google.com [IPv6:2607:f8b0:4864:20::248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4t1CG8z30V2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:10 +1100 (AEDT)
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-4cc89e86e4dso86789b6e.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925788; x=1794530588; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHjhOa1kArquGp6NzqJKIMKukUgu91Ev2XX32EWf/dM=;
        b=MOpF7Y726/wFL8veHQX3wuZ9xQ5r9mdHY6uSYWCGY8piZ6k8ly0mBznfGIaG0fb5la
         kdM5hMfdlAyhLIN55+aZqIrH+p+J6SmohP7oDO2fRzjnDtXp4e8E+vgexl+G0bvR2ExX
         oI7HmLWB0iVLHtZ2Te/BZ0SiKpek5lNJyJt1+SoCOjXQDumEuCCyJ0YzH1BawA57Bu6Z
         r2Cys5XHKjng5uueZI2jZyDLzsKqlbJRSMDq3q9YNo4AY9SmUGsx2D3f5oNK4c7+BN79
         MLCmKL4+OPjd9TjUNtvdZgs+ytibYerdErERtBmICYZMSeqi7k+sRgtMdCLX0KsnEQgE
         tbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925788; x=1794530588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHjhOa1kArquGp6NzqJKIMKukUgu91Ev2XX32EWf/dM=;
        b=oezMUU1HWf7AEc1bm5YRKD/cLRldywzDCVYttjRu6ulUIGKeUmJ3RNyndpD1gPp7T8
         EON20IHW4DUIWhCeE+iS2INn8sBfWVvWjSvnSNXW4b2eE9zdJHLomraHZQL88rYCJEsG
         Jvrg+5wB8yNnQ+S67uKCT2dz6pQsZ6ejCcBsUYg1DwKsXdBEpmpimELcSTDWaBEdTjqY
         dvUPrJsrklF3r/LPzbXLJAL7WoJx0SjsdoKnlaGqrXmPZo6iTFt9CWPuiVCE38kOLfBD
         WyNr2ZuVwL07EeP9nCy1VRpqxoP3MPOBWG2aI9QSL/8jp6Wa1Tzp97RJ9roLjMh2Cshu
         B6PA==
X-Forwarded-Encrypted: i=1; AKwUvBywUjQsqe9cH6ZBeFsYDbV68E1YqOKCrB+8ReXimzy9jEmNaE6x4fQqCx4J63WzSEiBn8fvuSRYNDGogmE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/Fclv4suUWs3xfc1ezvP4X8h/2aMDU0JRneOXMePTm26BHeEyz
	tQEwkgJayUKglG/TPv4YL73IWKVSCc3XceR2p5AnHL9J7U8YZ7tKn+vb0Oz2wn9WkDEeALnmakI
	NsCCEC+5EYaydKw==
X-Received: from jabfi10.prod.google.com ([2002:a05:6638:630a:b0:61a:c6d0:4104])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f66:b0:4b2:8d7b:41b8 with SMTP id 5614622812f47-567e1440ea0mr750093b6e.18.1793925787537;
 Thu, 05 Nov 2026 16:43:07 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:10 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-10-dmatlack@google.com>
Subject: [PATCH v2 09/17] PCI/PTM: Save PTM state in the saved capability store
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Save and restore the PTM Control register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Reserve the register in pci_reserve_ptm_state(), called from
pci_ptm_init(), and report a refused reservation. pci_ptm_init() ignored
the return value of pci_add_ext_cap_save_buffer(), so a failed
allocation left PTM state unsaved without any message. An allocation
failure is now reported once by pci_saved_caps_finalize().

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/ptm.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index bd3bd39f6372..fc653d2d1ec5 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -34,6 +34,16 @@ static struct pci_dev *pci_upstream_ptm(struct pci_dev *dev)
 	return NULL;
 }
 
+static void pci_reserve_ptm_state(struct pci_dev *dev)
+{
+	int rc;
+
+	rc = pci_reserve_saved_cap(dev, dev->ptm_cap + PCI_PTM_CTRL, sizeof(u32));
+	if (rc)
+		pci_err(dev, "unable to reserve PTM save state (%pe)\n",
+			ERR_PTR(rc));
+}
+
 /*
  * Find the PTM Capability (if present) and extract the information we need
  * to use it.
@@ -53,7 +63,7 @@ void pci_ptm_init(struct pci_dev *dev)
 
 	dev->ptm_cap = ptm;
 	atomic_set(&dev->ptm_enable_cnt, 0);
-	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
+	pci_reserve_ptm_state(dev);
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	dev->ptm_granularity = FIELD_GET(PCI_PTM_GRANULARITY_MASK, cap);
@@ -90,36 +100,18 @@ void pci_ptm_init(struct pci_dev *dev)
 
 void pci_save_ptm_state(struct pci_dev *dev)
 {
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
+	if (!dev->ptm_cap)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
-		return;
-
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
2.56.0.455.g6c5a503b38-goog


