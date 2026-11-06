Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04703606EEB0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nQFiIuPy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4s6yk1z30Tf;
	Fri, 06 Nov 2026 11:43:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::345"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925789;
	cv=none; b=fkNYj9SXWSsD05AE/hW/iEzNrFvT1Rh6xUogT9Q0trh2xw7sGD4v7NfhU9J7gTLoHYR4urlmwBggZliP29WWzAD4fHrxgzE9LiHAnwLZd77qbuMj8nAHccEEZQ0VFE6v7m7MYoYpHvfNBuZCWiXujfebLaCGe8ienVtlBxEnKo/rUXm0YTpdOy5fJ5btFv4/hFc2K7miH5DUAsez0u2bCnStrs1PskPg7SMYCT3lDLD9y1D3Ooi/T9DqOGSLlrCUiSaObkPaFhI6nc4ESccZT/BML8xdNFlD/UrrEXW9SoY8L7f42aAh5KGK1CMio/fdZt1LZPfGD+zeAgCguZ7oIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925789; c=relaxed/relaxed;
	bh=ddBqCr/aEaadxkJlxFoZmLz139RBeJBOYwKmQVBOEIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N34Z/QqXlwtkCqpZNxPon4y1SC6+8kPhatn5TemKJeHZq/ctUUdX0G6KoyYb7iSQF1+7MHbDkuZtz4mn4pfpRLG8rKSlKQ+QH3GfrPpwc0KeuSDq7G15XCAOnmVV1JMOeR81SD5o7XaQN+u43GRw0Ayf0MyjdCJ5bnHiz7TEOW7pbetVRKDIIVqriCrOkAidfzKv1PKBIWnQuljUJ5q6kGyySGpvSbYfSqQVBmVJH+PgBAIsyL0K0EntaVffzKZom1GYa8PwBc6clG+TsCPFhE/+dtI5gJv1cvDt+8J4x85AIJbWlNeRF8vOaVvwha9Ugi2CfXzEoCe2G7wpfbPYhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nQFiIuPy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::345; helo=mail-ot1-x345.google.com; envelope-from=3msltaggkdpavesldsucyggydw.ugedafmphhu-vwndaklk.grdstk.gjy@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nQFiIuPy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::345; helo=mail-ot1-x345.google.com; envelope-from=3msltaggkdpavesldsucyggydw.ugedafmphhu-vwndaklk.grdstk.gjy@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x345.google.com (mail-ot1-x345.google.com [IPv6:2607:f8b0:4864:20::345])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4r4Lfyz30DZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:08 +1100 (AEDT)
Received: by mail-ot1-x345.google.com with SMTP id 46e09a7af769-851f7cdfaefso153947a34.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925785; x=1794530585; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddBqCr/aEaadxkJlxFoZmLz139RBeJBOYwKmQVBOEIY=;
        b=nQFiIuPygCCtYTnKtmBNzVouMaiAFWykfYIobAeH7LKzKjkpwUcfQQqwE913FQUhJY
         uA+qZdlue1QaKJSePVlp6B/MS0c63pl8lmu1E+W/nVHhvOPo2GiE8Pb+5mLuyaNSPfpg
         DaiLaHb11xDO1FKpj8GHyLv0TWeCjRIzEFAhSMYX8NNmf/+8WVgrRZng8d2LHbffRkrS
         YaLo0SaEDj2Dd09eB0pikok+ytMmaaqY2yoF/4Xn6kVw85oYWgAloFZntJwVb2afZ47I
         o/1AOvQoP8RWGCXlGopTq3c/x2FSzSjOFIwUD3sGUNxvbNEiIdIKLwrQzehEpGuBS+mi
         BhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925785; x=1794530585;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddBqCr/aEaadxkJlxFoZmLz139RBeJBOYwKmQVBOEIY=;
        b=SFzq38Ts9KCcvPDDhFrtnGvRb4SKVGeUIJoim7zZUUhSG2JWyx5E0fBQaglJzg7PK9
         o0UDGxmIFtUEli0+4eQaNvC1+5HLh0YkKsvoHiSt3nWQFzPgKUoB0vRkuA9HehjSGUw7
         58H4dPhG0Xaf+YjW0GY9nAg6atUnnqvBaZkeh4Wbl3RYPxL2DFyflSyLfSlNKkXHhbrx
         pUJ+QXkDyFI8W4BIS9SpV0RbatWaY3GqYufIrAHk8SKD19kbqpm5AueHq4/fmBA+tjL8
         5okOgvDcFWXMOr7eGc3NU3GOIzR/gD0NPkP/vzlCJrviE3pnTXYBMlVSfGrZ8Y//5ndn
         BkMA==
X-Forwarded-Encrypted: i=1; AKwUvBxAoJslKgQLsl8brbtXHw6S1QQcVYTNE50lklXCWMvabIIpOx3TMsDE+E+CylcDUppyEXdJJd7mC3S5bXc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/dulcztJUTGiVk1xNpawr1VpRRaMMrl6O1Sr5NPBoa8VGucbUH
	fR6LxJ9TQBYCfmRXn77IwPQAzHNzrnOJ/mOKxcUce0UBZxoazHBi4skxymCRb5xulcUKV/BXhm+
	E3msNbte/Mz1fXQ==
X-Received: from iobmm23-n1.prod.google.com ([2002:a05:6602:7117:10b0:9ca:dec8:c75d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1987:b0:4f3:68d6:f131 with SMTP id 5614622812f47-567e099488cmr858385b6e.2.1793925785214;
 Thu, 05 Nov 2026 16:43:05 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:08 +0000
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
Message-ID: <20261106004218.604799-8-dmatlack@google.com>
Subject: [PATCH v2 07/17] PCI/ASPM: Save L1SS state in the saved capability store
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

Save and restore the L1 PM Substates control registers through the
per-device saved capability store instead of a private pci_cap_saved_state
buffer.

pci_restore_aspm_l1ss_state() needs both the Upstream and Downstream
Port's saved L1SS configuration, and had to fetch two buffers and decode
each by index. Read the saved values by configuration space offset
instead, which names the register at every use. Add
pci_read_saved_l1ss_ctl() to read one device's pair, so that the Port
and the device below it are read the same way.

Reserve PCI_L1SS_CTL1 and PCI_L1SS_CTL2 with a single request in
pci_reserve_aspm_l1ss_state(), since they are adjacent DWORDs. Skip the
reservation when the device has no L1SS capability, which
pci_add_ext_cap_save_buffer() did implicitly.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/aspm.c | 63 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 39adf2cad331..2978fde87af6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -68,24 +68,29 @@ void pci_restore_ltr_state(struct pci_dev *dev)
 	pci_restore_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
 }
 
-void pci_configure_aspm_l1ss(struct pci_dev *pdev)
+static void pci_reserve_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	int rc;
 
-	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-
-	rc = pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_L1SS,
-					 2 * sizeof(u32));
+	/* PCI_L1SS_CTL1 and PCI_L1SS_CTL2 are adjacent DWORDs */
+	rc = pci_reserve_saved_cap(pdev, pdev->l1ss + PCI_L1SS_CTL1, 2 * sizeof(u32));
 	if (rc)
-		pci_err(pdev, "unable to allocate ASPM L1SS save buffer (%pe)\n",
+		pci_err(pdev, "unable to reserve ASPM L1SS save state (%pe)\n",
 			ERR_PTR(rc));
 }
 
+void pci_configure_aspm_l1ss(struct pci_dev *pdev)
+{
+	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!pdev->l1ss)
+		return;
+
+	pci_reserve_aspm_l1ss_state(pdev);
+}
+
 void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	struct pci_dev *parent = pdev->bus->self;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
 
 	/*
 	 * If this is a Downstream Port, we never restore the L1SS state
@@ -102,32 +107,32 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
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
 
@@ -142,18 +147,10 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
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
2.56.0.455.g6c5a503b38-goog


