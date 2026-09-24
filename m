Return-Path: <linuxppc-dev+bounces-28130-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFE3C9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:35:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZb3MdJz3bNw;
	Fri, 25 Sep 2026 03:35:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271319;
	cv=none; b=Cbxf4dR706gojL/VVXH3qLchFJDOMCi7RvSFdrTbOKqkWb4JYJuLfNfHGSQvCE3t9v9QdRrGZFt05c6QPlZfR1L1JJbQfcEtIqvtTm9Jju2cqjZReoUnHz47EdPsE7vrxPKMtNtAZSskILaoB+RWWuSC8VKDFOQdl1EeyMVMnNmPJX+ytxqks0tIvITgj++AZtPQyXbxxNZDUvBjUlYTgfr9Wak4BAptoYSDJ2zuRLpdwmZEmJpR+po9RUt//NoB44W7l87/uKsbLerrOT8flWjORW7LMx/2IofDex/5G13QjKVDwYf4T2IlF3RhVxFYu5DpzKyogmMd/5cSAI5hQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271319; c=relaxed/relaxed;
	bh=yVR7tTueFjx2BoB8JeWxPq21TCubaJ8apr4e1etJ6IU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bd7VbBx3mBXgykOCK0apme1iCiM5b6Oa0zFGbnDt8xYzUaprRsJZDDlJ3q6ns8UN6MlWhmaYOi6AyKcCMxgihMMGQgSVZkDYwqS8edS7/6N9Ep5wH1hGjQumMcgED+JWD0UwMdJiyGoXwHGFo8vGLXV+gN4BOLXJ6VeZLbDrw2dHeNFKOjVhGx1UOlyLihP1A6MFnlXjwqrweDIhMO3RvEaDI75rfXRmn/CS92Camjw5tU7gWqorPoXSt9DS/031WDGu2DYaOTWUtaTIXv4kRXd0hg6ZQA6TotcEpP+64fj8RzSjFjJtQHoOP4LcCOJwyknwoci26Opo0XkaFL4XUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UzJ5e8tP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3t1-1aggkdeafocvncemiqqing.eqonkpwzrre-fgxnkuvu.q1ncdu.qti@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UzJ5e8tP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3t1-1aggkdeafocvncemiqqing.eqonkpwzrre-fgxnkuvu.q1ncdu.qti@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZT6s3Sz30VM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:13 +1000 (AEST)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2dd1631d291so161525ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271311; x=1790876111; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVR7tTueFjx2BoB8JeWxPq21TCubaJ8apr4e1etJ6IU=;
        b=UzJ5e8tP1QwghjskZWvtEhFAChdh37D4QwP4KM3n2zlF/LlyicHPq6vd3APjAq3xkn
         /Ba3YzfNWmg+Xy9DJdgsHpLHwIlpnxhlGjVcIvm01E3Dap13GxjamTrS+YBU2X2LDj94
         4h06dUbFt3h8Nq1EAZE+ghPuqLnPeSAY+ExL55M5SFVBR+YbXJnDIAxnCijIsH4ljkCH
         Z/DK5l4jTP8OjrOVL1Lzghfm2Kteyjgt6JXdudImn6PAnTY2lOtb66l4tFbSHcOlRV0P
         5U324tsmqgeyE8WkBkF5mIdBTGLh8Bm2ikVBRDHluWfBj+FHGPAQCJ2uL+0r0yD5NiKt
         aiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271311; x=1790876111;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVR7tTueFjx2BoB8JeWxPq21TCubaJ8apr4e1etJ6IU=;
        b=TzxO7Vnn2pBfWFYygbFAOh3BaVYsJsPX7Zf9VpdKOUumIg599mwL/iiA3EFbBOxr1f
         FngwJsMxg0v7NzoU3QDbgvOqEd7HWL4DLnYQNcdV7Ows7VNjnQ+tJjmSTO1ckcyoU0X9
         ql6QYoBGBxIyjKpSpLh/+fHVY2zCEOBUQKldTDqi66obUOmuHXKnpCT0HLOWvs8THYbL
         rKsMNN5LWB7piE18gUp0anOg5BMT3nZ+yLQY0JpRFy4F53FmEAcPSuB/D5luJtw+W8c7
         IjCIx8l9sr3grvr754jFr/fOsnG1zzyweT2q1XVF3jMxzTPZliCdxWdGDaKapCXttnEW
         qc0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxghHzXX+Gz6LZrIUoa7PmzD/OpjwSl07k1C8EiGFswh6Tzi8rXV+KRsZ2QeSZ7l5xQfGhm7YKRbB0FrMU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m+uUPGxF9yPiTnY7Q6Lc5NUSTy52DXCnUg981Pr7l44smRu2hW
	tEMT0CKHKpANLpoGBM7VSj1h9DhiSTBjPlhEpfZVVUcnjnZFNHbbYr/6qEFBA5puHxEW16Ray3G
	fa+4/otkwW4wFlg==
X-Received: from plrr9.prod.google.com ([2002:a17:902:c609:b0:2db:1a14:e0c8])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c40c:b0:2df:434f:5f50 with SMTP id d9443c01a7336-2df7e43e9b3mr28496375ad.36.1790271311136;
 Thu, 24 Sep 2026 10:35:11 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:50 +0000
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
Message-ID: <20260924173501.856380-5-dmatlack@google.com>
Subject: [PATCH 04/15] PCI: Save PCIe state in the saved capability store
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
longer disagree about which register is where.

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

While here, make pci_save_pcie_state() void now that it cannot fail.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c       | 83 +++++++++++++++++++++--------------------
 drivers/pci/pcie/aspm.c | 16 +++-----
 drivers/pci/quirks.c    | 30 +--------------
 3 files changed, 49 insertions(+), 80 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7be54751a5d3..1c2c572aa49c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1648,7 +1648,20 @@ int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
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
@@ -1672,41 +1685,27 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev, u16 cap)
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
-
-	return 0;
 }
 
 static void pci_restore_pcie_state(struct pci_dev *dev)
 {
-	int i = 0;
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	unsigned int i;
 
 	/*
 	 * Restore max latencies (in the LTR capability) before enabling
@@ -1715,8 +1714,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	pci_restore_ltr_state(dev);
 	pci_restore_aspm_l1ss_state(dev);
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
-	if (!save_state)
+	if (!pci_is_pcie(dev))
 		return;
 
 	/*
@@ -1726,14 +1724,13 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
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
@@ -1788,9 +1785,7 @@ int pci_save_state(struct pci_dev *dev)
 	}
 	dev->state_saved = true;
 
-	i = pci_save_pcie_state(dev);
-	if (i != 0)
-		return i;
+	pci_save_pcie_state(dev);
 
 	i = pci_save_pcix_state(dev);
 	if (i != 0)
@@ -3583,12 +3578,18 @@ int pci_add_ext_cap_save_buffer(struct pci_dev *dev, u16 cap, unsigned int size)
  */
 void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 {
+	unsigned int i;
 	int error;
 
-	error = pci_add_cap_save_buffer(dev, PCI_CAP_ID_EXP,
-					PCI_EXP_SAVE_REGS * sizeof(u16));
-	if (error)
-		pci_err(dev, "unable to preallocate PCI Express save buffer\n");
+	for (i = 0; pci_is_pcie(dev) && i < ARRAY_SIZE(pcie_saved_regs); i++) {
+		unsigned int off = dev->pcie_cap + pcie_saved_regs[i];
+
+		error = pci_reserve_saved_cap(dev, off, sizeof(u16));
+		if (error) {
+			pci_err(dev, "unable to reserve PCI Express save state\n");
+			break;
+		}
+	}
 
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
index de9bbccda21f..ffebab844165 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5514,10 +5514,9 @@ int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
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
@@ -5548,10 +5547,6 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 	pci_read_config_word(pdev, pos, &reg16);
 	if (reg16 == (0x0000 | PCI_CAP_ID_EXP)) {
 		u32 status;
-#ifndef PCI_EXP_SAVE_REGS
-#define PCI_EXP_SAVE_REGS     7
-#endif
-		int size = PCI_EXP_SAVE_REGS * sizeof(u16);
 
 		pdev->pcie_cap = pos;
 		pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
@@ -5563,27 +5558,6 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
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
2.56.0.rc1.315.gc6ed9934b7-goog


