Return-Path: <linuxppc-dev+bounces-28134-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6D7C98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:36:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZj01Lwz3bbf;
	Fri, 25 Sep 2026 03:35:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271324;
	cv=none; b=jQ0k87w0uuQkrwv9rZZAn4HmEUZJPI/iCRZjxt8PqfRzLeSWy97OPAachhpicnwYpnK3R/KC4Mzoc3Un9QAtBYL19EvBXUVX6spnbOXxs/bR6QqF6FKbzs6ZfaYDbvQRc6sjFYrqus93bzllbOiqAgbPLvcNhRMGAfCZhJitlPK3I4AXO3we9qRVMNZf/IJFDrS5Jg5OOTgkDie884xBLukLEfZlohAJnUDUvzo4WesaJU41i0NCH4R88Qi+krAOFEOERA6fNU164W0dptrcgfKQ5VpmVGW6EJN61V+4BsQErgUrtH5XyB0pDJ8u4csuzZbbMcZGLnaJBm044f+QlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271324; c=relaxed/relaxed;
	bh=y60xW3TpxqTBbPYvTrQ94YIZwmg/m6Sy4R0GJoihbbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DfZ4LBI5jaiIKFPOKZ5xsruEfHTd5TEmyfz0m2HihsoJwZjmAIs3mXMEbMcFH/BIvMgpDKnxZic7SnkrxDefwxzZuU7VRfzWgiLYhKcnyyyto2a/69uANsXRp04IRVlttAecCv2YQM42NyJCyOb7fIpENeuUerZkS6QlMgLhVqe4tV5Ie9qYKUTC4JJ4EqhqOZ4Z/KIbsy/Nd5dI9PAzZlxJVL8LhAukjOUIa7tIfAq2XbAw3BnXkyUAAL9rIfQSofJpbG/2ITb5GX2DIE2DeNR/4pf4qAFSJ5C/s/8xeqHXR9yBPsD3e5Y33E8hX0SCAkBPQ/yC/Gp8Zt51PgqykA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=olVboM7u; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3ul-1aggkdemirfyqfhplttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=olVboM7u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3ul-1aggkdemirfyqfhplttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZY24gMz30Wd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:16 +1000 (AEST)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so21806a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271315; x=1790876115; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y60xW3TpxqTBbPYvTrQ94YIZwmg/m6Sy4R0GJoihbbA=;
        b=olVboM7ufFtwyg9N0FGG7R96yQwC5MtcIr2d3KKvqILvx1mHVHw8G8wm+MM1h30yU4
         57JfsMDW722VdKKtuxuxFSiyt02Tbcd8jrYKv+WIOgolGtI1KcCajs3a+GiHj5vtdmMF
         cPYMlEkVwXxKIlb1Tn94aKoaL1vhlkYta8mWqKZqecf73/mp3NVkToGVmFtRhoTWKxvb
         5bs3l/WtD1Ii0YzEwxPHdLJCJfR+lbiXPaUtYNeUuXgcSdSbUzMILlla+VTJ6cnW7fQd
         QdnC8wLDm2pgLxvuZmkCEGPvuwsi4nQESYGdvjVHaAX+COMa5jX34Y5ybA42itXPB3hv
         FUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271315; x=1790876115;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y60xW3TpxqTBbPYvTrQ94YIZwmg/m6Sy4R0GJoihbbA=;
        b=gsxSgvJpEa07ug5Je0FZQ8MdZIJiwKX/6VVXZ7zqFcjYc5G7Sc1fLrEIM2/46aU4PP
         EZ0OYqfwExrTHrXsLZe5KwXA3cr1oMb8fmHECxDCenXIauCIZqo0WcvIudRIpwI36KNE
         AlLm6P6oihUJebIRZvvNkN4OaZP4eGxxzxFfgBOzwchk99+3xD5Kxaxg1Oob7ccvS0sJ
         597O6k/QmEgws527G7NsC04eMJIS4WIMEiT6UtYnbSINZdunPTuptSjfy0mzTqKSaNOE
         buro3NZZsJKjRm2bQ9CKQB8PS/6+QQWRLtnN4U1MNt6b6ARO+LhmGKXW0FvvwfWax5PY
         GSQQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3KVkTrfDyB0npY9BNngb+lvR0fPJRfiNfmS8zM6m3tYqp+P9WRWVjPHdrMdUR/5m/ccsNQ3836gq+xSk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kDmAfTGEU0KHFDLYbrKJ1CyP1n3f15eGCVTjr3AVdava8l0LUx
	EVOYMB8V+3iAjnXPjq/30JflHRBFs9gWbShnZHlPrkE1XnrDD8+V6z4YAllm1atdh+k/VmzLSVM
	d50yD+s7Qce3BeA==
X-Received: from pfbem41.prod.google.com ([2002:a05:6a00:3769:b0:877:cfaa:5ea3])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3307:b0:878:34d7:6a37 with SMTP id d2e1a72fcca58-87e9ef54169mr2679356b3a.43.1790271314522;
 Thu, 24 Sep 2026 10:35:14 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:54 +0000
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
Message-ID: <20260924173501.856380-9-dmatlack@google.com>
Subject: [PATCH 08/15] PCI/AER: Save AER state in the saved capability store
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

Save and restore the AER mask, severity, capability and root command
registers through the per-device saved capability store instead of a
private pci_cap_saved_state buffer.

Describe the registers in aer_saved_regs[] and drive the reservation, save,
and restore loops from it. Previously the three had to be kept in the same
order by hand, and pci_aer_init() encoded the register count as a bare 4 or
5.

Report a reservation failure. pci_aer_init() ignored the return value of
pci_add_ext_cap_save_buffer() entirely, so a failed allocation was only
noticed later as silently missing AER state.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/aer.c | 79 +++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..765899cf4046 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -352,53 +352,53 @@ int pci_aer_clear_status(struct pci_dev *dev)
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
+
+void pci_save_aer_state(struct pci_dev *dev)
+{
+	unsigned int i;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
-	if (!save_state)
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
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
-	if (!save_state)
+	if (!dev->aer_cap)
 		return;
 
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, *cap++);
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, *cap++);
-	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, *cap++);
-	pci_write_config_dword(dev, aer + PCI_ERR_CAP, *cap++);
-	if (pcie_cap_has_rtctl(dev))
-		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, *cap++);
+	for (i = 0; i < aer_nr_saved_regs(dev); i++)
+		pci_restore_cap_dword(dev, dev->aer_cap + aer_saved_regs[i]);
 }
 
 void pci_aer_init(struct pci_dev *dev)
 {
-	int n;
+	unsigned int i;
+	int error;
 
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!dev->aer_cap)
@@ -415,14 +415,15 @@ void pci_aer_init(struct pci_dev *dev)
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
+	for (i = 0; i < aer_nr_saved_regs(dev); i++) {
+		unsigned int off = dev->aer_cap + aer_saved_regs[i];
+
+		error = pci_reserve_saved_cap(dev, off, sizeof(u32));
+		if (error) {
+			pci_err(dev, "unable to reserve AER save state\n");
+			break;
+		}
+	}
 
 	/*
 	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


