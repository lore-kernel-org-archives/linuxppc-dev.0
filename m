Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E54606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XrlIUmFI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4t5kf3z30Vr;
	Fri, 06 Nov 2026 11:43:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::347"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925790;
	cv=none; b=ah2V0qfLKgaZ5pUQFc8H7xCtbthQW+Oz/wHFOMBP/C+GMpH5bFPo+5m54lb0hLBaegt5wnp5ncgUHVDhPKLinycj6VbAcJmjHVlFumczNfYo+RNOQsw/tre9iFmqSsIGb6WA3LuZQ3J5XxX08AY5sOKtByw5M1by+mjiRX9gWRBYhWPmFn83yIQN/79ZBH9tKWa4aCw/6gYJtEDG8zooe9KYQGyEXxB+RgOrZ8nGIojetigj+lyx1o9kQAXiGzBiuPkxf0iudPhBeouKEMRuIoxH0S2yHGyXj4hxvz+RmxQuMU7M7/JcpngMEM79CNLADoYZ4jCiPsU7g6l4NAqQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925790; c=relaxed/relaxed;
	bh=L+Hzdt+LObwzKPIKo4htZh/cma3z4S09Q2AYbp2zhRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mHJvRHri/sMg5h0qL4Y21AXGZwTVlYr0Cu4EqGXM5eq3d2VihtKfgDxUAsC/EFaLXbsF/HkhIgxzHADpZZA8/1hUxrDduOcLk/G2fxTEqv6eWTVUF2YFbPpk+DTqE3n3bsZZmfLFi65EYMyHWErfRJf6l1Y8d/9brL2/KMRXD/WZ5TepYLF0Ih+E4XRfuuBlAjv6xz9+1clBQkIdfXKllWUpAhxKdgzWi9HpFO8Bp6B49NolNYg92WjbhUSx/6h7lFmUxcYXRvB4FcYF++TJ9FS7EXB8Q/3eQ4FG+MWNLfoO8k9U/KZQ4F0/mAdbrhJI2Pha/YfyhxeWhVg4/IiSdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XrlIUmFI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::347; helo=mail-ot1-x347.google.com; envelope-from=3miltaggkdpewftmetvdzhhzex.vhfebgnqiiv-wxoeblml.hsetul.hkz@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XrlIUmFI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::347; helo=mail-ot1-x347.google.com; envelope-from=3miltaggkdpewftmetvdzhhzex.vhfebgnqiiv-wxoeblml.hsetul.hkz@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x347.google.com (mail-ot1-x347.google.com [IPv6:2607:f8b0:4864:20::347])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4s1VmJz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:09 +1100 (AEDT)
Received: by mail-ot1-x347.google.com with SMTP id 46e09a7af769-85c6a056128so157832a34.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925787; x=1794530587; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+Hzdt+LObwzKPIKo4htZh/cma3z4S09Q2AYbp2zhRQ=;
        b=XrlIUmFISvT2Qj/wWAQf3VyuRCxKVARVslPm7bQHw+bsLNSGbjE8xQ0f2D2GK7ztSM
         zVd7Pjp2NBGEX3gzvDEInevwhZFDlB92qDFN3DuAImiky3XJXmoBs2SqAb5ytqgtGSC5
         7eYNKhNEDEIKJDpIMB43JS+k2526he9Vny3YzB3qh5i8v1dHvujrjsndpzrnk7hx0rb6
         H3BkrJXfuUKie6UKhFGhZV0C9iVZUTsaf8gJwxixWk6MVzmTCpajJ2pobMzkUpChiOkH
         WdHTt7VWVYvUspIANr5ZQ/oNDmeQwwvh0oCOm8Hecf5oosOY+iNTY1OyrNlok+bkZ2p+
         8LGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925787; x=1794530587;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L+Hzdt+LObwzKPIKo4htZh/cma3z4S09Q2AYbp2zhRQ=;
        b=acrz2jDBeH5iI4KbW1VFpKoDLUDnliMN9u2PNdkj02YxM9SYvxw7z311lTaWhWc1Gj
         R4BSfQlcA6nwaDNBLlg2msZyB5dawbznYW5W/Uc9UefpNcAIFudNGWcpcyP4mQFltt+o
         hUiodpYMEqlqHXabBoNvI8OO72QgLwTXlc+YgT+STk/Cel4OgzTNKVkHEF1kd7OJXlOQ
         OAbhTvshKYSoXfIu0a/92q/pTudyrMgAM3I3FPHOLbAFRBZj3n31HNuDFbzvuhdx2tLD
         SpDIltmpT49G7rm4TzRRsSC0vfmBoVrqg6JqT/gsumOt6g/ZzD+zCnDJNYrxXkW+/unF
         e1Ow==
X-Forwarded-Encrypted: i=1; AKwUvBwy/IUCqIwimEGPp1ke/joZie03RWK/VH5Nc0Y97oBrFlrx6dQfk0UoAK2Gqmz+tNUt8bj5Geh+pccRJz0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9QK1gl+jJu/ZCPvmlDS/LC1reYW8IjZO+uSPiCjVhFmjA0Aqji
	zQ+faRTpod4vzFwz7RIK2AV+vNJp+2BkFUlKv5cFToa8rPr1d0ZX1GzPalnpTqJuqQGMdzpzsm9
	abR8Ej7VCmUHD/Q==
X-Received: from iozd24.prod.google.com ([2002:a05:6602:3298:b0:9c7:85f4:7637])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:23cf:b0:532:d9f5:1de6 with SMTP id 5614622812f47-567e182dc9fmr636250b6e.65.1793925786350;
 Thu, 05 Nov 2026 16:43:06 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:09 +0000
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
Message-ID: <20261106004218.604799-9-dmatlack@google.com>
Subject: [PATCH v2 08/17] PCI/AER: Save AER state in the saved capability store
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

Save and restore the AER mask, severity, capability and root command
registers through the per-device saved capability store instead of a
private pci_cap_saved_state buffer.

Describe the registers in aer_saved_regs[] and drive the reservation, save,
and restore loops from it. Previously the three had to be kept in the same
order by hand, and pci_aer_init() encoded the register count as a bare 4 or
5.

Reserve the registers in pci_reserve_aer_state(), called from
pci_aer_init(), and report a refused reservation. pci_aer_init() ignored
the return value of pci_add_ext_cap_save_buffer(), so a failed
allocation left AER state unsaved without any message. An allocation
failure is now reported once by pci_saved_caps_finalize().

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/aer.c | 85 +++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..25436bcf9fb9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -352,54 +352,68 @@ int pci_aer_clear_status(struct pci_dev *dev)
 	return pci_aer_raw_clear_status(dev);
 }
 
-void pci_save_aer_state(struct pci_dev *dev)
+/*
+ * AER registers saved and restored by the PCI core. PCI_ERR_ROOT_COMMAND is
+ * only implemented by Root Ports and Root Complex Event Collectors (PCIe
+ * r6.0, sec 7.8.4.9) and so must come last.
+ */
+static const u16 aer_saved_regs[] = {
+	PCI_ERR_UNCOR_MASK,
+	PCI_ERR_UNCOR_SEVER,
+	PCI_ERR_COR_MASK,
+	PCI_ERR_CAP,
+	PCI_ERR_ROOT_COMMAND,
+};
+
+static unsigned int aer_nr_saved_regs(struct pci_dev *dev)
 {
-	int aer = dev->aer_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
+	if (pcie_cap_has_rtctl(dev))
+		return ARRAY_SIZE(aer_saved_regs);
 
-	if (!aer)
-		return;
+	return ARRAY_SIZE(aer_saved_regs) - 1;
+}
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
-	if (!save_state)
+void pci_save_aer_state(struct pci_dev *dev)
+{
+	unsigned int i;
+
+	if (!dev->aer_cap)
 		return;
 
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, cap++);
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, cap++);
-	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, cap++);
-	pci_read_config_dword(dev, aer + PCI_ERR_CAP, cap++);
-	if (pcie_cap_has_rtctl(dev))
-		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, cap++);
+	for (i = 0; i < aer_nr_saved_regs(dev); i++)
+		pci_save_cap_dword(dev, dev->aer_cap + aer_saved_regs[i]);
 }
 
 void pci_restore_aer_state(struct pci_dev *dev)
 {
-	int aer = dev->aer_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
+	unsigned int i;
 
-	if (!aer)
+	if (!dev->aer_cap)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
-	if (!save_state)
-		return;
+	for (i = 0; i < aer_nr_saved_regs(dev); i++)
+		pci_restore_cap_dword(dev, dev->aer_cap + aer_saved_regs[i]);
+}
 
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, *cap++);
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, *cap++);
-	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, *cap++);
-	pci_write_config_dword(dev, aer + PCI_ERR_CAP, *cap++);
-	if (pcie_cap_has_rtctl(dev))
-		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, *cap++);
+static void pci_reserve_aer_state(struct pci_dev *dev)
+{
+	unsigned int i;
+	int rc;
+
+	for (i = 0; i < aer_nr_saved_regs(dev); i++) {
+		unsigned int off = dev->aer_cap + aer_saved_regs[i];
+
+		rc = pci_reserve_saved_cap(dev, off, sizeof(u32));
+		if (rc) {
+			pci_err(dev, "unable to reserve AER save state (%pe)\n",
+				ERR_PTR(rc));
+			return;
+		}
+	}
 }
 
 void pci_aer_init(struct pci_dev *dev)
 {
-	int n;
-
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!dev->aer_cap)
 		return;
@@ -415,14 +429,7 @@ void pci_aer_init(struct pci_dev *dev)
 	ratelimit_state_init(&dev->aer_info->nonfatal_ratelimit,
 			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
 
-	/*
-	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
-	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
-	 * Collectors also implement PCI_ERR_ROOT_COMMAND (PCIe r6.0, sec
-	 * 7.8.4.9).
-	 */
-	n = pcie_cap_has_rtctl(dev) ? 5 : 4;
-	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
+	pci_reserve_aer_state(dev);
 
 	/*
 	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
-- 
2.56.0.455.g6c5a503b38-goog


