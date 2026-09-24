Return-Path: <linuxppc-dev+bounces-28128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B46EC98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:35:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZY0WDPz30T9;
	Fri, 25 Sep 2026 03:35:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::445"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271316;
	cv=none; b=N0G5Ujl74JfQjWmnOWCEunjhL9ER4wNTNgs8GrnZOhpqOiTow1kHdUCpD1BRg+QDTdEBo2OYFQwDrcjShfAVtkZN6tYPOXd2BNRAzV+gRAe0WYqUccBZ7lP5TmThl2a3N+Xf5jgLgbMQyTszvHYRhpSV1wD7jMmTHomCq43OU7UEjPH7TuYoC3NQs3Gn4IVv+dYrV5oGSCz/kZZD5ZFSmgUx1ZEhlRwQSXrrLfi/rSlFsGfDhlDweIO3+E9nEkhZIwhN0QC75OMu9cHBZ+yu8w8bDdzBUGf0FUJoTTPpJnYzjdAaa0VeXUAoPmQe/Z4ILiKHGJH0U8YG7ujpzkgMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271316; c=relaxed/relaxed;
	bh=ACjFFHMgW+Gwh6CM6AIAcR2m9FJl/y1RH2aBBB5Bmwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WNeFsQJlPT6ETkAt8QfF7JgUqQciDD886VXfcVxexl1JcS2lBHIPMrpAxf5UZKfMIcdTPpNs+87/qSmlV5YrVzlvHrMrUNyTpM1dAYshSFVwgDj9UWydj78AGOQKRnoZqMJmC88qiHdoa+ggEev1J44OOfEEwRAOX/hH0e215GO79fzSY9z1veGL/Xt8u/7MNm4kFKjwukcCQA7vJM46Qa4n1TKll6p1NBc50HBS6Kbmb+dQO762zG/nawpHArMTi3Mvb8krgWJiS9E4sb+029kKhmx9Hdxgf8Annf29l52ulHgxSwGIUrmas6Hl7JWykH8sxU8oI14pD9j7WDJClg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U88aZfX/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=3tl-1aggkdd8enbumbdlhpphmf.dpnmjovyqqd-efwmjtut.p0mbct.psh@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U88aZfX/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=3tl-1aggkdd8enbumbdlhpphmf.dpnmjovyqqd-efwmjtut.p0mbct.psh@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com [IPv6:2607:f8b0:4864:20::445])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZS4Yhmz30TQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:12 +1000 (AEST)
Received: by mail-pf1-x445.google.com with SMTP id d2e1a72fcca58-855315ccb64so93626b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271310; x=1790876110; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACjFFHMgW+Gwh6CM6AIAcR2m9FJl/y1RH2aBBB5Bmwo=;
        b=U88aZfX/glocdlGWVw2C5FDRMXHn3bbgNmTvkRN5a0+9AGde/jyH1eOOJHfymfeKyJ
         ugEcDpQf8dT1uj9oHo+oMgDM6MOczrEPnLYpEPh8/CUCd4EwwaYQDH7GNJnmBShdLT/N
         eNyEmT/N9YTX45rb/PntOU4mc6XugBQDspAxOBlgXSFSAjT1JT2ct2KywHHIsrtii1Fz
         ixQFOD24ZKo33qM1Lyc+c+RAYoN7a+YHuPJVEosW4msiknU4OdbA6CjSlYmUvUpnZwzV
         GZvjZOrCUVCElhdDo5yEuPHY3SVsa4nRIsEQ1s+iY0MLpJETTai3QCcbDwuvQHsuNcww
         0fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271310; x=1790876110;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACjFFHMgW+Gwh6CM6AIAcR2m9FJl/y1RH2aBBB5Bmwo=;
        b=maQ5SJz/AA+BZIqgzhNFtwMe4OJs8C0oV5W6XIVluHENLR4L7zgLrqoEL4Dl0ccA8Y
         XPROosonPzyG593xHVuifwNV6vBG0H1zYExZAIpObCNp2WMCcdcl8wev9rvX8LqR7PWQ
         QNR66lPQ0msMTWEf2E3zmmxxUqkaZlrQ2Gybti05IiiFQtbrzW8qfwuvMcFndBsqnylf
         xiRiBIREtdO4QSkhtb6GbyDIttSu3dzK0B12TQ1Itms2MDTRetqEm2omelB7Lxxu+hvl
         +RM10E9+JrJSJmO8YwlHWzNMWBWFNcTtgT4qQYzSAyJamiJ5WJ0rxkYEmM1oju8RqN1s
         iRPw==
X-Forwarded-Encrypted: i=1; AKwUvBw4tc+rv6Bx14TQ/lBauiHE364mzjv5wMUxnbxubg+jAqNSeWFChWnbxktvJApero1B9+SyLuu20Somi6c=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kl6TixEJGaobB58S9OZ6eEVqd3ERfM8mfLQ/Kd9jF8kmHNLaC9
	QPUY2D5xrS1HxiFCSjK1W2g1AKEsQ0+ygdhIUwLFBDFtCoPHa6bhjooEdatUNsyX7l8iTmZkabV
	0Wxq22UNqkYsgmg==
X-Received: from pffz27.prod.google.com ([2002:aa7:991b:0:b0:87f:cff9:fb86])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ab8d:b0:87c:e6aa:30e4 with SMTP id d2e1a72fcca58-87e9dfaf9c3mr2791493b3a.48.1790271310316;
 Thu, 24 Sep 2026 10:35:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:49 +0000
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
Message-ID: <20260924173501.856380-4-dmatlack@google.com>
Subject: [PATCH 03/15] PCI: Lay out struct pci_saved_state by configuration
 space offset
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

Store a device's saved state as a bitmap of the configuration space DWORDs
that were saved plus their values, instead of a copy of the configuration
space header followed by a list of pci_cap_saved_data records.

The old layout is described entirely by the kernel: which capabilities have
a record, how large each record is, and what each word within a record
means are all properties of the code that happens to be saving them. That
makes the blob impossible to interpret outside the kernel that produced it,
which is a problem for VFIO, which needs to carry a device's saved state
across a Live Update kexec. The new layout is described by the device: a
value's position is the offset of its register in the device's own
configuration space.

Keep refusing state that the device has nowhere to put in
pci_load_saved_state(), the equivalent of the old check that the
capability existed and its record was the expected size. Use
pci_saved_cap_reserved() to ask the store that question without the WARN
that pci_saved_cap_slot() raises for an offset no capability reserved,
since here an unreserved offset means untrusted input rather than a
kernel bug.

No capability uses the store yet, and the patches that follow move them
into it one at a time, so keep appending the records of the capabilities
that still have their own buffer after the saved DWORDs. The blob
therefore continues to describe all of a device's saved state at every
step; the last patch of the series drops the records once there are none
left.

struct pci_saved_state is opaque to everything outside drivers/pci, so no
caller needs to change.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c        | 89 +++++++++++++++++++++++++++++++++++-----
 drivers/pci/pci.h        |  4 ++
 drivers/pci/saved-caps.c | 14 +++++++
 3 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..7be54751a5d3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1884,11 +1884,40 @@ void pci_restore_state(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_restore_state);
 
+/**
+ * struct pci_saved_state - a device's saved configuration space
+ * @dword_map: one bit per DWORD of configuration space, set if that DWORD
+ *	       was saved
+ * @dword_val: saved values, in ascending configuration space offset order
+ *
+ * Laid out so that the position of every value is described by the device's
+ * configuration space rather than by the kernel.
+ *
+ * Capabilities that have not moved to the saved capability store yet keep
+ * their own buffer, and their records trail @dword_val until the last of
+ * those buffers goes away. Both areas vary in length and only one of them
+ * can be a flexible array member, so the records are reached with
+ * pci_saved_state_records() rather than declared here.
+ */
 struct pci_saved_state {
-	u32 config_space[16];
-	struct pci_cap_saved_data cap[];
+	unsigned long	dword_map[BITS_TO_LONGS(PCI_CFG_SPACE_EXP_DWORDS)];
+	u32		dword_val[];
+	/* struct pci_cap_saved_data cap[] follows dword_val */
 };
 
+/*
+ * The records that follow the saved DWORDs, one per capability that still has
+ * its own save buffer, terminated by an empty record.
+ */
+static struct pci_cap_saved_data *
+pci_saved_state_records(struct pci_saved_state *state)
+{
+	unsigned int nr_dwords = bitmap_weight(state->dword_map,
+					       PCI_CFG_SPACE_EXP_DWORDS);
+
+	return (struct pci_cap_saved_data *)&state->dword_val[nr_dwords];
+}
+
 /**
  * pci_store_saved_state - Allocate and return an opaque struct containing
  *			   the device saved state.
@@ -1898,16 +1927,28 @@ struct pci_saved_state {
  */
 struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 {
-	struct pci_saved_state *state;
+	DECLARE_BITMAP(map, PCI_CFG_SPACE_EXP_DWORDS);
+	struct pci_saved_caps *caps = &dev->saved_caps;
 	struct pci_cap_saved_state *tmp;
 	struct pci_cap_saved_data *cap;
+	struct pci_saved_state *state;
+	unsigned int dword, nr_dwords, i = 0;
 	size_t size;
 
 	if (!dev->state_saved)
 		return NULL;
 
-	size = sizeof(*state) + sizeof(struct pci_cap_saved_data);
+	bitmap_zero(map, PCI_CFG_SPACE_EXP_DWORDS);
+	bitmap_set(map, 0, PCI_STD_HEADER_DWORDS);
+	if (caps->dword_val)
+		bitmap_or(map, map, caps->dword_map, PCI_CFG_SPACE_EXP_DWORDS);
+
+	nr_dwords = bitmap_weight(map, PCI_CFG_SPACE_EXP_DWORDS);
+
+	size = struct_size(state, dword_val, nr_dwords);
 
+	/* Room for the buffers that are left, and for the terminator */
+	size += sizeof(struct pci_cap_saved_data);
 	hlist_for_each_entry(tmp, &dev->saved_cap_space, next)
 		size += sizeof(struct pci_cap_saved_data) + tmp->cap.size;
 
@@ -1915,16 +1956,25 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 	if (!state)
 		return NULL;
 
-	memcpy(state->config_space, dev->saved_config_space,
-	       sizeof(state->config_space));
+	bitmap_copy(state->dword_map, map, PCI_CFG_SPACE_EXP_DWORDS);
 
-	cap = state->cap;
+	for_each_set_bit(dword, state->dword_map, PCI_CFG_SPACE_EXP_DWORDS) {
+		u32 *val = &state->dword_val[i++];
+
+		if (dword < PCI_STD_HEADER_DWORDS)
+			*val = dev->saved_config_space[dword];
+		else
+			pci_read_saved_cap_dword(dev, dword * sizeof(u32), val);
+	}
+
+	cap = pci_saved_state_records(state);
 	hlist_for_each_entry(tmp, &dev->saved_cap_space, next) {
 		size_t len = sizeof(struct pci_cap_saved_data) + tmp->cap.size;
+
 		memcpy(cap, &tmp->cap, len);
 		cap = (struct pci_cap_saved_data *)((u8 *)cap + len);
 	}
-	/* Empty cap_save terminates list */
+	/* Empty record terminates the list */
 
 	return state;
 }
@@ -1939,16 +1989,33 @@ int pci_load_saved_state(struct pci_dev *dev,
 			 struct pci_saved_state *state)
 {
 	struct pci_cap_saved_data *cap;
+	unsigned int dword, i = 0;
 
 	dev->state_saved = false;
 
 	if (!state)
 		return 0;
 
-	memcpy(dev->saved_config_space, state->config_space,
-	       sizeof(state->config_space));
+	for_each_set_bit(dword, state->dword_map, PCI_CFG_SPACE_EXP_DWORDS) {
+		unsigned int off = dword * sizeof(u32);
+		u32 val = state->dword_val[i++];
+
+		if (dword < PCI_STD_HEADER_DWORDS) {
+			dev->saved_config_space[dword] = val;
+			continue;
+		}
+
+		/*
+		 * Refuse state that the device has nowhere to put, e.g.
+		 * because it was saved from a different device.
+		 */
+		if (!pci_saved_cap_reserved(dev, off))
+			return -EINVAL;
+
+		pci_write_saved_cap_dword(dev, off, val);
+	}
 
-	cap = state->cap;
+	cap = pci_saved_state_records(state);
 	while (cap->size) {
 		struct pci_cap_saved_state *tmp;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 93916b0cdd21..e8e7bc8a63e7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -258,6 +258,9 @@ struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
 struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 						   u16 cap);
 
+/* DWORDs of the configuration space header, i.e. pci_dev.saved_config_space */
+#define PCI_STD_HEADER_DWORDS	(PCI_STD_HEADER_SIZEOF / sizeof(u32))
+
 void pci_saved_caps_finalize(struct pci_dev *dev);
 void pci_saved_caps_release(struct pci_dev *dev);
 int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int len);
@@ -269,6 +272,7 @@ void pci_restore_cap_dword(struct pci_dev *dev, unsigned int off);
 bool pci_read_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 *val);
 bool pci_read_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 *val);
 void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val);
+void pci_write_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 val);
 
 #define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
diff --git a/drivers/pci/saved-caps.c b/drivers/pci/saved-caps.c
index 649d2cd09e81..eaacc3b3ea74 100644
--- a/drivers/pci/saved-caps.c
+++ b/drivers/pci/saved-caps.c
@@ -218,6 +218,20 @@ void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val)
 	*slot |= (u32)val << shift;
 }
 
+/**
+ * pci_write_saved_cap_dword - change the saved value of a 32-bit register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @val: value to save
+ */
+void pci_write_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 val)
+{
+	u32 *slot = pci_saved_cap_slot(dev, off);
+
+	if (slot)
+		*slot = val;
+}
+
 /**
  * pci_restore_cap_dword - restore a 32-bit capability register
  * @dev: the PCI device
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


