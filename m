Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC8606D809
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RO1lGZnw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4y1Ytxz3c2q;
	Fri, 06 Nov 2026 11:43:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925794;
	cv=none; b=aZhBnf60tFce2i3ns4o0K8YyiW1NhG053V4uAeJhyg1OxvcCrJULUgoX/+PeNkq6QwldLbka3V2uyG3bHRnMsfKvgBvCKdgG3SGX8tpNEovj/pXZI7ps7Toor4z6xOeEye7k/7WGGTLTixw9nDkSAG0/To3/A8EKoqFSk8CPAN1DCbt4+lPlHNKgXuh9P+xBJcSR8Lq1xtsYjft6VPrgYk8K/hqf3PHWg6/JUMt4A/Rj8t6oeZonPg11hExDSbR/3gNqoCYXjNm+Kpf0chuI0y9WxP7283zkUS+6wT6EtERPc9tU11VEKhlbfHjF7t1hTq8eSS2+yHwQs/4P54eZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925794; c=relaxed/relaxed;
	bh=jmLjI9XOjWedNu4ucOWy6yZB8cv6/+TL9ec51bNxWwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3kX8xNEFGLTf/6tBKtnwCFMGiY0kBZesD5cSFAWYMEn4Svef4qjdORNzZ3rGjX11NzgGCZ2UDy9xml0d5qeJbwv5l3vvWD37kkvozxv6VaVz/hyh64P3iDoI1Nun6C4lm4TQMbvc9u5HN1OZz0AUFpwP3G4sj7gg5s+qJrisL/d1CbjsqgvZmeBuK/7cy+DakRKGDSTnQNlSGsRLAGnG7BA7+BrO676452Uaqc/0OxzNAY1NM5APyY3hgy+ReU1ya/qQtwHLG/YuhanjQNlXzUDAIX8wA41nOQFxxjnXj9uCB0dL7ZclVBDDz60LjR4WA8CK6Yz7Ep47Lp7MCQl/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RO1lGZnw; dkim-atps=neutral; spf=pass (client-ip=209.85.210.70; helo=mail-ot1-f70.google.com; envelope-from=3ncltaggkdpmyhvogvxfbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RO1lGZnw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=209.85.210.70; helo=mail-ot1-f70.google.com; envelope-from=3ncltaggkdpmyhvogvxfbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4w6mkzz30V2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:12 +1100 (AEDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-851f720d7afso128052a34.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925789; x=1794530589; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jmLjI9XOjWedNu4ucOWy6yZB8cv6/+TL9ec51bNxWwI=;
        b=RO1lGZnwBtyje8ijqiO4Qjn7XM21n0U42uCyzuG4rFJrUhRYj6aSAkHF+fpOIXlBVB
         WW4qjvgCt6Yw+ZqPmGGDS5Bvy+pFoRZmuwYnFz2GY7RG6H9RtTwppIYqFJE/YWMBHRSf
         rBArx3FN8Uc+C7s8CaWlVjTXPp7CQI1mnjSxpCnn13cHRNdlA07OeqjrNDympOpw88/v
         R3IXbl9093KERa6tUoVm4MbX9QqGXX87IiwPeVcTOKLkSZzeb+1+Og2ADghWftHOE0WB
         KYFm5IckzXF+LFecrW1b9IhSUpAJH/MPSFlHZoJ57f0fldPSqQ7GUfEStf/fQyMmRZ/V
         yvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925789; x=1794530589;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jmLjI9XOjWedNu4ucOWy6yZB8cv6/+TL9ec51bNxWwI=;
        b=sFIiEgPxCVka+otKnd02707cREaaX9L0iqvYAJXHWyN2A0MaNPK2Wb4Usx2YJTRChM
         rMpN9tllxMJAMF9nDTeCts5kHOOow20avvGxFnunDK228eleVgk2nptJmymegt3sKCLa
         PU3KxUOEV4DYrCAKkiLduU3nAntdBo5RXRYm4eMxdBtEzsQjNXAJfHbpLZqGIkP1NzVJ
         qDUjYsVMrqpU4/1kalH1rDuPyAf4s7wf4/zGOCiXomicf+ZREKSaDZXiYBHoctkOG8Xs
         dZbx9CDGUrqq6Wim0qH0Vb1LRgIBIr07uCvzi5H4dxz1K7+oXlg65AldwI91o7+a7K8/
         j2pw==
X-Forwarded-Encrypted: i=1; AKwUvByX68NbGPpetpZWTpP9QqyRogcnwB0xq62eksCxtxYx5hGR2fJ2EMe9+OVTdSEqv2YrlRjkjNB6NcrOzqM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9cjlpbIt5ckTPyhluePSLrcLbAXQPV36m1rn0+fkDDWqBPHgHU
	Ock0On1pkmpJkQhnOU+Lo2DXFPhNfB95De9UyXGtDvYEP99j6OzURrAJy7Lv0gFWEpKux0O1IMW
	9fA8Y26V7Hyvulw==
X-Received: from iofl4-n1.prod.google.com ([2002:a05:6602:8384:10b0:9e3:4909:2e0c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5394:b0:4d6:92b3:5c85 with SMTP id 5614622812f47-567e18964a2mr623375b6e.66.1793925788751;
 Thu, 05 Nov 2026 16:43:08 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:11 +0000
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
Message-ID: <20261106004218.604799-11-dmatlack@google.com>
Subject: [PATCH v2 10/17] PCI/TPH: Save TPH state in the saved capability store
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

Save and restore the TPH Control register and Steering Tag table through
the per-device saved capability store instead of a private
pci_cap_saved_state buffer.

The Steering Tag table is variable length, so pci_tph_init() had to compute
a buffer size and both the save and restore loops had to walk that buffer
in step with configuration space. Reserve the table by offset instead so
that the loops can address the entries directly.

Reserve the registers in pci_reserve_tph_state(), called from
pci_tph_init(), and report a refused reservation. pci_tph_init() ignored
the return value of pci_add_ext_cap_save_buffer(), so a failed
allocation left TPH state unsaved without any message. An allocation
failure is now reported once by pci_saved_caps_finalize().

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/tph.c | 54 +++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..3ab8d5b2ab10 100644
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
@@ -506,16 +486,30 @@ void pci_no_tph(void)
 	pr_info("PCIe TPH is disabled\n");
 }
 
-void pci_tph_init(struct pci_dev *pdev)
+static void pci_reserve_tph_state(struct pci_dev *pdev)
 {
-	int num_entries;
-	u32 save_size;
+	unsigned int off, len;
+	int num_entries, rc;
+
+	off = pdev->tph_cap + PCI_TPH_CTRL;
+	rc = pci_reserve_saved_cap(pdev, off, sizeof(u32));
 
+	num_entries = pcie_tph_get_st_table_size(pdev);
+	if (!rc && num_entries) {
+		off = pdev->tph_cap + PCI_TPH_BASE_SIZEOF;
+		len = num_entries * sizeof(u16);
+		rc = pci_reserve_saved_cap(pdev, off, len);
+	}
+	if (rc)
+		pci_err(pdev, "unable to reserve TPH save state (%pe)\n",
+			ERR_PTR(rc));
+}
+
+void pci_tph_init(struct pci_dev *pdev)
+{
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
 	if (!pdev->tph_cap)
 		return;
 
-	num_entries = pcie_tph_get_st_table_size(pdev);
-	save_size = sizeof(u32) + num_entries * sizeof(u16);
-	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
+	pci_reserve_tph_state(pdev);
 }
-- 
2.56.0.455.g6c5a503b38-goog


