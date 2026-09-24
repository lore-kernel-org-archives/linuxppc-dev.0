Return-Path: <linuxppc-dev+bounces-28139-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E34C98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:36:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZn3t7wz3c8Q;
	Fri, 25 Sep 2026 03:35:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271329;
	cv=none; b=bCv6U553m3TOhelBgqR7XmhqWaQSTYFv7orOnXRzt1LjESAdsEAcYErme0Kyw7UivEDw8w7PpRu6H7RVJbNbwr6fNW+8eBRa19XeuYC2q7ffZ9YFXcpQl2u67TEulD6IGxX70fYLzaomFqfp7A8wYfUIYq6ab7j9AH2k5tG5XTIWl3eNZjNJsHohhANW2zbS0Lo+iUiIyz3nezjRPuUG4GyVhFLCtXkLn1xX7UtvHdsRdVD8eszbIvSHB7J65Wi9XZmVvTVaQmxEtYZJJOwsukeHsUchjr91A45S1R9XTse06OazaPzr96JooJASq7jUoCFwdy7vooKAOsVZRdQFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271329; c=relaxed/relaxed;
	bh=I5Z8coCk3E9gqKO3PHj9jQ4bq0JckBz/qt0J/ndctwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=flgP1w62W/06+yPHPiQOslGopkU44rE2kVxD+quHq+th+gAOUKkUIci8/qYNc8NFXRzLI4Y6SlLNoZNYPFqMSTJK9d03d8y3DlTxYZSVbkaNPXGQtkjo3vZo5iuivrI+U4yPeUBzmqIEIfRTbz0VIdS9oibdCwpUpB28Cs9EeRuprahQN8UjKOv96FM2KayrOLHxR02tXqkLsYTyDGtYA+SUBVaCHFUx3lFooss6B0aqKn1IHdp0J9/ibV6LgJUAI5W9Q5aRd8uFuE0M2qVOCDvjyn0O2jadqMW4k7EXaAzhhtFZinFXVaqnTIG016FJScDZuNpRRNwY3vew+QkPVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LkFlhMPc; dkim-atps=neutral; spf=pass (client-ip=209.85.215.200; helo=mail-pg1-f200.google.com; envelope-from=3wf-1aggkdekoxl4wlnvrzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LkFlhMPc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=209.85.215.200; helo=mail-pg1-f200.google.com; envelope-from=3wf-1aggkdekoxl4wlnvrzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZg5Td4z3bf2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:23 +1000 (AEST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so6418a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271320; x=1790876120; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I5Z8coCk3E9gqKO3PHj9jQ4bq0JckBz/qt0J/ndctwk=;
        b=LkFlhMPc80IXfeHuxlL3GVeypHSk5yrTC2yN7FL+Hu3WOGLyPha81lr6MfWAXMAncG
         okH5DI4Ugx582agxZPqDUewtgan+4L2Ozklv8A+Fyxk9WnyRk0t/8emlFj8vEylIbTCI
         WGbdNDFC816inuMjktXIinHd/ejO5BK/3yk1v8Td2uDW0scvO1u8KOBiXtf/k9ZiWH6D
         nwNSqqGbTRtJvXWZZSn7N5+V8oe3ojtQpe9YasDvxeL+VcHwN1PycwjMpXYRvT+mauuK
         3kNmFy0w/nWpKaUECk40Dmiw+33Js6cRXWLBufDwxiG/CDue8sOgZ8mLOIpHT1kmE1Bj
         LMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271320; x=1790876120;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I5Z8coCk3E9gqKO3PHj9jQ4bq0JckBz/qt0J/ndctwk=;
        b=twR0ayOt7bM4ELgc1zcO3cGu+xZXcUmrwYiBSvcLpYNDKPXqurHqLSrh7RTl34v70K
         AFNw72u+G+cJxAfmzpor+jPiLA7jZA4nMErgCF+PkLkBy6Fetcu+0UXu+PEVMAbcuzJE
         WVKKv4WScHvio+BHpFOFUYdC4KgPDRLylVXaWmWXpe9DNlOnUk1B6fuk4zyLZb8WxODu
         NkPSH1yN6qRpkhHbPA7O1aNHm67dA41TibxtwKaHa+ShNUujuVCoHO87MQ/pvujlNY3A
         t0oss2EzZ/vOp5gtDqMAWojFG21uKVIUCzy2IzlAOSY49Vv0yJ/xhCXCx1j3fw4Xy/d9
         S2Dw==
X-Forwarded-Encrypted: i=1; AKwUvBwsn2YWmwkkSQGJHDvHK+s4Ozag6e0MOyh3Nw75YLGVAkA7HQ+x05XMo6Rqhn3p0E5knfJ+JjLmPscsyk4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nhrhkxLkiu8v9Yx3tMtyZQ8OBnGfN3Rk97zWipgfgnGYMrwftM
	OydAPYuJx2AvDN4SJqO/avSC7aR+NP8N/QvivP6hwVtclJfDj6F1FDphrHPr4hcutjeTiYyMdOb
	zz9o88o8jdZb7bQ==
X-Received: from pgbcv2.prod.google.com ([2002:a05:6a02:4202:b0:cc7:6228:9be5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d82:b0:3dd:a006:7b3d with SMTP id adf61e73a8af0-3de0e895d9fmr2863185637.60.1790271320315;
 Thu, 24 Sep 2026 10:35:20 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:35:01 +0000
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
Message-ID: <20260924173501.856380-16-dmatlack@google.com>
Subject: [PATCH 15/15] PCI: Remove the per-capability save buffers
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

Delete struct pci_cap_saved_state, struct pci_cap_saved_data,
pci_dev.saved_cap_space and the helpers that managed them. Every capability
now saves its registers in the offset-indexed capability store, so nothing
is left to find, allocate or free. That retires the last of nine separate
save buffer allocations, four of which ignored their allocation failure
entirely.

Rename pci_allocate_cap_save_buffers() to pci_reserve_saved_caps(),
which is all it does now, and drop pci_free_cap_save_buffers() from
pci_release_capabilities(); pci_saved_caps_release() already frees the one
remaining allocation.

pci_store_saved_state() and pci_load_saved_state() no longer have to append
and consume the records of the capabilities that still had a buffer, so the
blob they exchange is now just the saved DWORDs.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c   | 140 +-------------------------------------------
 drivers/pci/pci.h   |  21 +------
 drivers/pci/probe.c |   5 +-
 include/linux/pci.h |   1 -
 4 files changed, 6 insertions(+), 161 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 73aa526e6901..b6e14c9a6c20 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1663,28 +1663,6 @@ static const u16 pcie_saved_regs[] = {
 	PCI_EXP_SLTCTL2,
 };
 
-static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
-						       u16 cap, bool extended)
-{
-	struct pci_cap_saved_state *tmp;
-
-	hlist_for_each_entry(tmp, &pci_dev->saved_cap_space, next) {
-		if (tmp->cap.cap_extended == extended && tmp->cap.cap_nr == cap)
-			return tmp;
-	}
-	return NULL;
-}
-
-struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap)
-{
-	return _pci_find_saved_cap(dev, cap, false);
-}
-
-struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev, u16 cap)
-{
-	return _pci_find_saved_cap(dev, cap, true);
-}
-
 static void pci_restore_pcie_state(struct pci_dev *dev)
 {
 	unsigned int i;
@@ -1844,32 +1822,12 @@ EXPORT_SYMBOL(pci_restore_state);
  *
  * Laid out so that the position of every value is described by the device's
  * configuration space rather than by the kernel.
- *
- * Capabilities that have not moved to the saved capability store yet keep
- * their own buffer, and their records trail @dword_val until the last of
- * those buffers goes away. Both areas vary in length and only one of them
- * can be a flexible array member, so the records are reached with
- * pci_saved_state_records() rather than declared here.
  */
 struct pci_saved_state {
 	unsigned long	dword_map[BITS_TO_LONGS(PCI_CFG_SPACE_EXP_DWORDS)];
 	u32		dword_val[];
-	/* struct pci_cap_saved_data cap[] follows dword_val */
 };
 
-/*
- * The records that follow the saved DWORDs, one per capability that still has
- * its own save buffer, terminated by an empty record.
- */
-static struct pci_cap_saved_data *
-pci_saved_state_records(struct pci_saved_state *state)
-{
-	unsigned int nr_dwords = bitmap_weight(state->dword_map,
-					       PCI_CFG_SPACE_EXP_DWORDS);
-
-	return (struct pci_cap_saved_data *)&state->dword_val[nr_dwords];
-}
-
 /**
  * pci_store_saved_state - Allocate and return an opaque struct containing
  *			   the device saved state.
@@ -1881,11 +1839,8 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 {
 	DECLARE_BITMAP(map, PCI_CFG_SPACE_EXP_DWORDS);
 	struct pci_saved_caps *caps = &dev->saved_caps;
-	struct pci_cap_saved_state *tmp;
-	struct pci_cap_saved_data *cap;
 	struct pci_saved_state *state;
 	unsigned int dword, nr_dwords, i = 0;
-	size_t size;
 
 	if (!dev->state_saved)
 		return NULL;
@@ -1897,14 +1852,7 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 
 	nr_dwords = bitmap_weight(map, PCI_CFG_SPACE_EXP_DWORDS);
 
-	size = struct_size(state, dword_val, nr_dwords);
-
-	/* Room for the buffers that are left, and for the terminator */
-	size += sizeof(struct pci_cap_saved_data);
-	hlist_for_each_entry(tmp, &dev->saved_cap_space, next)
-		size += sizeof(struct pci_cap_saved_data) + tmp->cap.size;
-
-	state = kzalloc(size, GFP_KERNEL);
+	state = kzalloc(struct_size(state, dword_val, nr_dwords), GFP_KERNEL);
 	if (!state)
 		return NULL;
 
@@ -1919,15 +1867,6 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 			pci_read_saved_cap_dword(dev, dword * sizeof(u32), val);
 	}
 
-	cap = pci_saved_state_records(state);
-	hlist_for_each_entry(tmp, &dev->saved_cap_space, next) {
-		size_t len = sizeof(struct pci_cap_saved_data) + tmp->cap.size;
-
-		memcpy(cap, &tmp->cap, len);
-		cap = (struct pci_cap_saved_data *)((u8 *)cap + len);
-	}
-	/* Empty record terminates the list */
-
 	return state;
 }
 EXPORT_SYMBOL_GPL(pci_store_saved_state);
@@ -1940,7 +1879,6 @@ EXPORT_SYMBOL_GPL(pci_store_saved_state);
 int pci_load_saved_state(struct pci_dev *dev,
 			 struct pci_saved_state *state)
 {
-	struct pci_cap_saved_data *cap;
 	unsigned int dword, i = 0;
 
 	dev->state_saved = false;
@@ -1967,19 +1905,6 @@ int pci_load_saved_state(struct pci_dev *dev,
 		pci_write_saved_cap_dword(dev, off, val);
 	}
 
-	cap = pci_saved_state_records(state);
-	while (cap->size) {
-		struct pci_cap_saved_state *tmp;
-
-		tmp = _pci_find_saved_cap(dev, cap->cap_nr, cap->cap_extended);
-		if (!tmp || tmp->cap.size != cap->size)
-			return -EINVAL;
-
-		memcpy(tmp->cap.data, cap->data, tmp->cap.size);
-		cap = (struct pci_cap_saved_data *)((u8 *)cap +
-		       sizeof(struct pci_cap_saved_data) + cap->size);
-	}
-
 	dev->state_saved = true;
 	return 0;
 }
@@ -3479,61 +3404,11 @@ void pci_ea_init(struct pci_dev *dev)
 		offset = pci_ea_read(dev, offset);
 }
 
-static void pci_add_saved_cap(struct pci_dev *pci_dev,
-	struct pci_cap_saved_state *new_cap)
-{
-	hlist_add_head(&new_cap->next, &pci_dev->saved_cap_space);
-}
-
 /**
- * _pci_add_cap_save_buffer - allocate buffer for saving given
- *			      capability registers
+ * pci_reserve_saved_caps - reserve room to save capability registers
  * @dev: the PCI device
- * @cap: the capability to allocate the buffer for
- * @extended: Standard or Extended capability ID
- * @size: requested size of the buffer
  */
-static int _pci_add_cap_save_buffer(struct pci_dev *dev, u16 cap,
-				    bool extended, unsigned int size)
-{
-	int pos;
-	struct pci_cap_saved_state *save_state;
-
-	if (extended)
-		pos = pci_find_ext_capability(dev, cap);
-	else
-		pos = pci_find_capability(dev, cap);
-
-	if (!pos)
-		return 0;
-
-	save_state = kzalloc(sizeof(*save_state) + size, GFP_KERNEL);
-	if (!save_state)
-		return -ENOMEM;
-
-	save_state->cap.cap_nr = cap;
-	save_state->cap.cap_extended = extended;
-	save_state->cap.size = size;
-	pci_add_saved_cap(dev, save_state);
-
-	return 0;
-}
-
-int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size)
-{
-	return _pci_add_cap_save_buffer(dev, cap, false, size);
-}
-
-int pci_add_ext_cap_save_buffer(struct pci_dev *dev, u16 cap, unsigned int size)
-{
-	return _pci_add_cap_save_buffer(dev, cap, true, size);
-}
-
-/**
- * pci_allocate_cap_save_buffers - allocate buffers for saving capabilities
- * @dev: the PCI device
- */
-void pci_allocate_cap_save_buffers(struct pci_dev *dev)
+void pci_reserve_saved_caps(struct pci_dev *dev)
 {
 	unsigned int i;
 	int error, pos;
@@ -3567,15 +3442,6 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	pci_vc_reserve_saved_caps(dev);
 }
 
-void pci_free_cap_save_buffers(struct pci_dev *dev)
-{
-	struct pci_cap_saved_state *tmp;
-	struct hlist_node *n;
-
-	hlist_for_each_entry_safe(tmp, n, &dev->saved_cap_space, next)
-		kfree(tmp);
-}
-
 /**
  * pci_configure_ari - enable or disable ARI forwarding
  * @dev: the PCI device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 99de55799826..343a37524a22 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -237,26 +237,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int pci_try_reset_bridge(struct pci_dev *bridge);
 
-struct pci_cap_saved_data {
-	u16		cap_nr;
-	bool		cap_extended;
-	unsigned int	size;
-	u32		data[];
-};
-
-struct pci_cap_saved_state {
-	struct hlist_node		next;
-	struct pci_cap_saved_data	cap;
-};
-
-void pci_allocate_cap_save_buffers(struct pci_dev *dev);
-void pci_free_cap_save_buffers(struct pci_dev *dev);
-int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
-int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
-				u16 cap, unsigned int size);
-struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
-struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
-						   u16 cap);
+void pci_reserve_saved_caps(struct pci_dev *dev);
 
 /* DWORDs of the configuration space header, i.e. pci_dev.saved_config_space */
 #define PCI_STD_HEADER_DWORDS	(PCI_STD_HEADER_SIZEOF / sizeof(u32))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b4c0b8171d94..5f6236fc9002 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2468,7 +2468,6 @@ static void pci_release_capabilities(struct pci_dev *dev)
 	pci_aer_exit(dev);
 	pci_rcec_exit(dev);
 	pci_iov_release(dev);
-	pci_free_cap_save_buffers(dev);
 	pci_saved_caps_release(dev);
 }
 
@@ -2654,8 +2653,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_msi_init(dev);		/* Disable MSI */
 	pci_msix_init(dev);		/* Disable MSI-X */
 
-	/* Buffers for saving PCIe and PCI-X capabilities */
-	pci_allocate_cap_save_buffers(dev);
+	/* Room to save PCIe, PCI-X and LTR state */
+	pci_reserve_saved_caps(dev);
 
 	pci_imm_ready_init(dev);	/* Immediate Readiness */
 	pci_pm_init(dev);		/* Power Management */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7b80f809f934..62a541a63a0c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -548,7 +548,6 @@ struct pci_dev {
 
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
-	struct hlist_head saved_cap_space;
 	struct pci_saved_caps saved_caps; /* Saved capability registers */
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


