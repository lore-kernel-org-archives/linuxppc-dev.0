Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB39606D81B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mc2GCuxE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4r3425z2yd7;
	Fri, 06 Nov 2026 11:43:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c48"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925788;
	cv=none; b=hm5vGmLhsMWwrID101rNkEEh8C1VJOvJ5k9pELk8OXRQEnRY+QyMxRTETyFjjng94ctNwG99Vy2IoA1W4BEXO1ptV2Juw2/FepGAS0s3Cx+EcVXkDjbT7O4d6IbiJpzTR+iuJf/6AJkOM5nayAsg7ecKWxFSgXTaus/xIjupClkhw+3VNCVHkSBl7Lt1w47Cz3yM7sofpUaSqU60/0u69zaYidUjwXX/92jv6hTD2LMKpPh4pcgN64j46zMQX4sqxm9R8vEDTjjJx7lPWgk1JivMjKAn1/4LXy+WRfr0dPABtWQRAfk8Kj786pq0yhX2w0gPGZIF1E3dP06uXkhgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925788; c=relaxed/relaxed;
	bh=fdvOmig1mqmuQ5cGPPo+aA7C4UMwvpl0I/Lv9SSRV3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mz6udvzS8QDYXEwPwSA7CAVVu3IIFf26RitAd+aq5KbjOVHu7i/YJjJlDFTt0//A3GdpBJiJHh4PT2FwFET7vVvB2XfYw6U3zcUG2t9voh9CknV/hTjRZPxMinLUY29CtTDhhrbCcxi8dwu/oRAoumBdYzTUwYWN+A3M17FmhLOmueGVw1qPXHlYYfBbonxgOLKiiZQVpxtVKXVWEYHaovwGtXr41biprqVyR6/iHWUBTjpkUftXp7H9ITrcWyhoEWY3iS2SuMjGprUBT+Sqy0WHA/MEcXdLUenyfC/8ce70rNo6E/9Wo5mjyrcOTCmxCkX5mZhC919G72StTPwP2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mc2GCuxE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c48; helo=mail-oo1-xc48.google.com; envelope-from=3lsltaggkdowraohzoqyuccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mc2GCuxE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::c48; helo=mail-oo1-xc48.google.com; envelope-from=3lsltaggkdowraohzoqyuccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc48.google.com (mail-oo1-xc48.google.com [IPv6:2607:f8b0:4864:20::c48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4m0Hwxz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:03 +1100 (AEDT)
Received: by mail-oo1-xc48.google.com with SMTP id 006d021491bc7-6f538c3453fso1448917eaf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925781; x=1794530581; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdvOmig1mqmuQ5cGPPo+aA7C4UMwvpl0I/Lv9SSRV3g=;
        b=mc2GCuxERUnoiWGbJ0dJJsUi9RgcJ/+2LDfkTXg+iGxeBzh/1MyjRIM/qkfbEH4tSO
         7IHvWr8YLANjr3gQt8PYu5qqxJFKF99gzDIGdXa44obiCYcFI3lfg8hMMFFCKx26bk3d
         ONDBDGeFMz9qf9xol8n8yHDZRgeLySU9Y0MQsUYMEMx7TzGZEA3g5Nxt7mOvhuGEbnM0
         gcghgnLfq0nj6XokmFCDSeiHvRpRzkDTZSYbb9X84ryiSkTyB3eJjrPd4iqhHhDNutrE
         4CxqEMk9RfOiXXFFcnfCBZ3k7nIMbJgLddEdhDhRIt/Fnuz8VrVCYFnms9xUmEmeLcqk
         V45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925781; x=1794530581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdvOmig1mqmuQ5cGPPo+aA7C4UMwvpl0I/Lv9SSRV3g=;
        b=ReTz0bnsF2pX/pqLEEWRJXPSUdHcsL31UTXXp1lnPoJ/aN6JhLgUtW+yRM/wr3pzDM
         KR8muxUdy8PoPG6j3wVZ7KdLGHwJfm7ZHQfxwLGSfqJR79UIPVabqtwoP6++nUmGsOeE
         7uMkUFtFxGpD4JcJdjquDcPQ6PrB90bas2q6woeeT4kSBr4bprXWkPfLVdmQYmVMseUG
         fMAwDtasXkXRiHgWQJMscLOXq2TkKr8vGKQtEsSQHg/C495eo0THzaujJ2jiBq0Z7LVg
         qJ95yaDT+DTtn/IwBW9mr59EtjjuOhFefEgHHwN7JsIf+jmhzBXZwB6DZdT3oo1jO+6v
         ufww==
X-Forwarded-Encrypted: i=1; AKwUvBwqa+HXmsMk2QqOZdKbZGP2etlbIiH49+nGJwg/9+D7TW2IGYdbxA0tdBS7qTGGDIn7dO083lM0XUxrMeg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8UU5ui5LXrFydzataLzgsT/HcWJIHTVdvVlyb1eJwkHaD29wlj
	qLk+uqh0vRC+G+aG4Syr7eqzG+r7/pvilXAtrhacdJyESlKbJrPz9hgdnm372uadV68T/3jqGVW
	17wl/EyV2rooE+w==
X-Received: from iobmm28-n2.prod.google.com ([2002:a05:6602:711c:20b0:9e0:ee3f:c3a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:290f:b0:6d3:abd1:9b87 with SMTP id 006d021491bc7-716d221fc2emr2597233eaf.45.1793925781387;
 Thu, 05 Nov 2026 16:43:01 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:05 +0000
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
Message-ID: <20261106004218.604799-5-dmatlack@google.com>
Subject: [PATCH v2 04/17] PCI: Save PCIe state in the saved capability store
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

Save and restore the PCIe capability control registers through the
per-device saved capability store instead of a private pci_cap_saved_state
buffer.

The private buffer is an opaque array of u16s whose layout is a contract
between pci_save_pcie_state() and pci_restore_pcie_state(). Anything else
that needs to touch the saved state has to know that contract, e.g.
pci_update_aspm_saved_state() patches the saved Link Control register with
a comment reminding the reader that cap[1] is LNKCTL. Indexing the saved
state by configuration space offset removes the coupling.

Describe the registers to save in pcie_saved_regs[] and drive the
reservation, save, and restore loops from it so that the three can no
longer disagree about which register is where. Reserve the registers in
pci_reserve_pcie_state(), named to match pci_save_pcie_state() and
pci_restore_pcie_state().

Reserve the registers based on pci_is_pcie() rather than
pci_find_capability(PCI_CAP_ID_EXP), so that a device whose capability
list is broken but whose pcie_cap a quirk has fixed up gets saved state
like any other PCIe device. Drop the save buffer that
quirk_intel_qat_vf_cap() builds by hand, since it is no longer needed.

Keep using pcie_capability_read_word() and pcie_capability_write_word() to
access the hardware so that registers the device does not implement are
skipped. Reserve space for all of the registers regardless; that is
harmless, since an unimplemented register reads back as zero and is
never written.

Make pci_save_pcie_state() void, so pci_save_state() no longer fails with
-ENOMEM when the PCIe save buffer is missing. A failure to allocate the
store is reported once during device setup instead.

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c       | 92 +++++++++++++++++++++++------------------
 drivers/pci/pcie/aspm.c | 16 +++----
 drivers/pci/quirks.c    | 30 +-------------
 3 files changed, 59 insertions(+), 79 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 007f9bb289d5..fde1dcd99e94 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1795,7 +1795,20 @@ int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
 }
 EXPORT_SYMBOL(pci_set_power_state_locked);
 
-#define PCI_EXP_SAVE_REGS	7
+/*
+ * PCIe capability registers saved and restored by the PCI core. Registers a
+ * device does not implement are skipped by the pcie_capability_*() accessors,
+ * so space is reserved for all of them regardless of the device.
+ */
+static const u16 pcie_saved_regs[] = {
+	PCI_EXP_DEVCTL,
+	PCI_EXP_LNKCTL,
+	PCI_EXP_SLTCTL,
+	PCI_EXP_RTCTL,
+	PCI_EXP_DEVCTL2,
+	PCI_EXP_LNKCTL2,
+	PCI_EXP_SLTCTL2,
+};
 
 static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
 						       u16 cap, bool extended)
@@ -1819,41 +1832,47 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev, u16 cap)
 	return _pci_find_saved_cap(dev, cap, true);
 }
 
-static int pci_save_pcie_state(struct pci_dev *dev)
+static void pci_save_pcie_state(struct pci_dev *dev)
 {
-	int i = 0;
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	unsigned int i;
+	u16 val;
 
 	if (!pci_is_pcie(dev))
-		return 0;
+		return;
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
-	if (!save_state) {
-		pci_err(dev, "buffer not found in %s\n", __func__);
-		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(pcie_saved_regs); i++) {
+		pcie_capability_read_word(dev, pcie_saved_regs[i], &val);
+		pci_write_saved_cap_word(dev, dev->pcie_cap + pcie_saved_regs[i],
+					 val);
 	}
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_RTCTL,  &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
-
 	pci_save_aspm_l1ss_state(dev);
 	pci_save_ltr_state(dev);
+}
 
-	return 0;
+static void pci_reserve_pcie_state(struct pci_dev *dev)
+{
+	unsigned int i;
+	int rc;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(pcie_saved_regs); i++) {
+		unsigned int off = dev->pcie_cap + pcie_saved_regs[i];
+
+		rc = pci_reserve_saved_cap(dev, off, sizeof(u16));
+		if (rc) {
+			pci_err(dev, "unable to reserve PCI Express save state (%pe)\n",
+				ERR_PTR(rc));
+			return;
+		}
+	}
 }
 
 static void pci_restore_pcie_state(struct pci_dev *dev)
 {
-	int i = 0;
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	unsigned int i;
 
 	/*
 	 * Restore max latencies (in the LTR capability) before enabling
@@ -1862,8 +1881,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	pci_restore_ltr_state(dev);
 	pci_restore_aspm_l1ss_state(dev);
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
-	if (!save_state)
+	if (!pci_is_pcie(dev))
 		return;
 
 	/*
@@ -1873,14 +1891,13 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	 */
 	pci_bridge_reconfigure_ltr(dev);
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_SLTCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_RTCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
+	for (i = 0; i < ARRAY_SIZE(pcie_saved_regs); i++) {
+		u16 reg = pcie_saved_regs[i];
+		u16 val;
+
+		if (pci_read_saved_cap_word(dev, dev->pcie_cap + reg, &val))
+			pcie_capability_write_word(dev, reg, val);
+	}
 }
 
 static int pci_save_pcix_state(struct pci_dev *dev)
@@ -1935,9 +1952,7 @@ int pci_save_state(struct pci_dev *dev)
 	}
 	dev->state_saved = true;
 
-	i = pci_save_pcie_state(dev);
-	if (i != 0)
-		return i;
+	pci_save_pcie_state(dev);
 
 	i = pci_save_pcix_state(dev);
 	if (i != 0)
@@ -3733,10 +3748,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 {
 	int error;
 
-	error = pci_add_cap_save_buffer(dev, PCI_CAP_ID_EXP,
-					PCI_EXP_SAVE_REGS * sizeof(u16));
-	if (error)
-		pci_err(dev, "unable to preallocate PCI Express save buffer\n");
+	pci_reserve_pcie_state(dev);
 
 	error = pci_add_cap_save_buffer(dev, PCI_CAP_ID_PCIX, sizeof(u16));
 	if (error)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 95ac34a34bd5..02922b887ec6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -324,26 +324,20 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 
 static void pci_update_aspm_saved_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
-	u16 *cap, lnkctl, aspm_ctl;
-
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
-	if (!save_state)
-		return;
+	u16 lnkctl, aspm_ctl;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
 
 	/*
-	 * Update ASPM and CLKREQ bits of LNKCTL in save_state. We only
+	 * Update ASPM and CLKREQ bits of LNKCTL in the saved state. We only
 	 * write PCI_EXP_LNKCTL_CCC during enumeration, so it shouldn't
-	 * change after being captured in save_state.
+	 * change after being captured in the saved state.
 	 */
 	aspm_ctl = lnkctl & (PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
 	lnkctl &= ~(PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
 
-	/* Depends on pci_save_pcie_state(): cap[1] is LNKCTL */
-	cap = (u16 *)&save_state->cap.data[0];
-	cap[1] = lnkctl | aspm_ctl;
+	pci_write_saved_cap_word(dev, dev->pcie_cap + PCI_EXP_LNKCTL,
+				 lnkctl | aspm_ctl);
 }
 
 static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e500c202d2ec..9203ffb2ff72 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5512,10 +5512,9 @@ int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
  */
 static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 {
-	int pos, i = 0, ret;
+	int pos, ret;
 	u8 next_cap;
-	u16 reg16, *cap;
-	struct pci_cap_saved_state *state;
+	u16 reg16;
 
 	/* Bail if the hardware bug is fixed */
 	if (pdev->pcie_cap || pci_find_capability(pdev, PCI_CAP_ID_EXP))
@@ -5546,10 +5545,6 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 	pci_read_config_word(pdev, pos, &reg16);
 	if (reg16 == (0x0000 | PCI_CAP_ID_EXP)) {
 		u32 status;
-#ifndef PCI_EXP_SAVE_REGS
-#define PCI_EXP_SAVE_REGS     7
-#endif
-		int size = PCI_EXP_SAVE_REGS * sizeof(u16);
 
 		pdev->pcie_cap = pos;
 		pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
@@ -5561,27 +5556,6 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 		ret = pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status);
 		if ((ret != PCIBIOS_SUCCESSFUL) || (PCI_POSSIBLE_ERROR(status)))
 			pdev->cfg_size = PCI_CFG_SPACE_SIZE;
-
-		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
-			return;
-
-		/* Save PCIe cap */
-		state = kzalloc(sizeof(*state) + size, GFP_KERNEL);
-		if (!state)
-			return;
-
-		state->cap.cap_nr = PCI_CAP_ID_EXP;
-		state->cap.cap_extended = 0;
-		state->cap.size = size;
-		cap = (u16 *)&state->cap.data[0];
-		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_RTCTL,  &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_LNKCTL2, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL2, &cap[i++]);
-		hlist_add_head(&state->next, &pdev->saved_cap_space);
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
-- 
2.56.0.455.g6c5a503b38-goog


