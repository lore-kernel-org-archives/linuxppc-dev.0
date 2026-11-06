Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDF606EE9D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AZYkAn/n
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4n2MPXz2ygd;
	Fri, 06 Nov 2026 11:43:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::248"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925785;
	cv=none; b=E0uXgwzydP7x/dI9srss5V0D7QZ60ZKCBW7ytYYKC8xDQSzAzTjbIgShkEgY3pUBSVODJzosOE/IsP4s+5fjs6tuNNYJwBwgdOmcr4cKK/y0W+EYUnB6Tx9X1LEmqY11JGlj9fTM6TJ+SNqNJlbMDS6gnHwlmwqKnQycx7RDqY5jbQR9dON6BkaReUUGd7uee4r3z5+4RtvelOCpNrPtUlodIuWZSvdPOibLyQhvl9SrsNjgtEofE4MjjPpXdZWyNW20aOGaaPMsZYsHmk8kco+LfhlE8qmfQmCCE/N0s4vh1I6tIcYtJf/TdhbXXqjkut9EAnci1yukfQMJmRKqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925785; c=relaxed/relaxed;
	bh=7sjq9VdN6W+I9NBwFH2LvF9xugKaVKfSc0OTWV+x1HY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BVG2WPLgou55t1Yv1hkYVbYcKUT47l2w15VPUYqzhYi1BIpn1oKUGIwHg4qqACmZ87T332g9WKK8PCkcJj4rJjp1g8yRRCsD8sHTCYt+B8kNco04fQDAhIyT3l67EkNUZA6UXDu2ifXxzQP8sdyNzUI9WpnABr2iF0clSsYiiVYYXeJpYqdxWKzP5PcA5zjINElIvCaPKzGuiqec61z5lku+la6J4P1ZH9Ch5dr1/wZZf6gjSUaBdizfypKwRsvZl5pKlZzLZzdBldtP3Njp+Mw2GpY4sev7W3JGLOxk0MEJQIRXNsCe0GQ8m4vyk4em1OjR9rrj13hEBj8lLUvPDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AZYkAn/n; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::248; helo=mail-oi1-x248.google.com; envelope-from=3lcltaggkdosqzngynpxtbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AZYkAn/n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::248; helo=mail-oi1-x248.google.com; envelope-from=3lcltaggkdosqzngynpxtbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x248.google.com (mail-oi1-x248.google.com [IPv6:2607:f8b0:4864:20::248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4l03b7z2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:02 +1100 (AEDT)
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-4db3db8687fso127482b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925780; x=1794530580; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7sjq9VdN6W+I9NBwFH2LvF9xugKaVKfSc0OTWV+x1HY=;
        b=AZYkAn/nn2iBGM9tW0UKO4yjcCsblY0M6XNxicp7bP4CD3Tr2KDQoVKkr6YyGzEcHQ
         ZLAp3euPv7vOEqhjuzC53KPTznMCcP7LCjcPFS5dVF9ztj7yH9tBMGDK4wvl2FZkF4MX
         KdHWQVzxSO/ZW7IZ45VH5UD6WkjljsajCjXFOMq0EaEhyJp3YWzchD0huJyYLqPeclS+
         a9WWUC62g8K2/+beEir7GbO/s1qtVcZo6IF0ypTyQTiklLYvMMntOh3t1VBWx/EkFznU
         xczAXftLtMKe1Mnx3OAOCtrrUWuVCElQQA3FrDoha0hsRKtxKkJH9WpgF5xvuBMFZSh6
         Nu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925780; x=1794530580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7sjq9VdN6W+I9NBwFH2LvF9xugKaVKfSc0OTWV+x1HY=;
        b=W+zl3YfJrTGX/ilFIYsTNzLZPhQ7WWNywGWnxVVhKPrdmMlAh0208BjaVcMKNsMzry
         /r6YFtJJ0hpi+0CLqxYsBVBZk675CHayGHF60tn7eofz4VMet/dxZnq4tW+Hl7LRCyFb
         pSSaAUsG8jmMpUTBowNvmgmSGiTXMgqVAOiYYq+j8MaoXlgPNZGZLCSWyqNSl1KbYJwW
         Ed5dqPXnZlEej89UPz169tIJ7mUSoeMexjh5KvY7f000B3ehu+cfKxtGmtOzyrEFevAa
         mjc8UZUVS2gGV8B9Dx5svB72LL8crmTWnwwibWL1V7svnTrfDa07KV5EqFklBKgaJ2eT
         e8pg==
X-Forwarded-Encrypted: i=1; AKwUvBypi0f/y75b7VB5UubtkdVY805N7Cni7j0Q3faMS0dBRp3xrkd1coTkBE/jBV/2jODw0ilCL3xEvT5VdcI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9wxxX4z1QxcV3k8Wi8rP39R9q+sCgsyEPtTS2KYA82PPg4ZbPS
	K5PNz0ZE8DBKSFlpg+Iz/L+JWc8rb2ntXQo23GT6lHqRe6mD4Sq0uzEhilDDNW9ysR+GQkusMyi
	ghpSck7fDXeFwiQ==
X-Received: from jaan3-n1.prod.google.com ([2002:a05:6638:aac3:10b0:61c:f758:dde6])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6f92:b0:55c:6ea:3e3f with SMTP id 5614622812f47-567e1038164mr750724b6e.28.1793925780223;
 Thu, 05 Nov 2026 16:43:00 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:04 +0000
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
Message-ID: <20261106004218.604799-4-dmatlack@google.com>
Subject: [PATCH v2 03/17] PCI: Lay out struct pci_saved_state by configuration
 space offset
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

Store a device's saved state as a bitmap of the configuration space DWORDs
that were saved plus their values, instead of a copy of the configuration
space header followed by a list of pci_cap_saved_data records.

The old layout is described entirely by the kernel: which capabilities have
a record, how large each record is, and what each word within a record
means are all properties of the code that happens to be saving them. That
ties the blob to the kernel that produced it, so VFIO cannot carry a
device's saved state across a Live Update. The new layout is
described by the device: a value's position is the offset of its
register in the device's own configuration space.

Keep refusing state that the device has nowhere to put in
pci_load_saved_state(), the equivalent of the old check that the
capability existed and its record was the expected size. Use
pci_saved_cap_reserved() for the check, since state saved from another
device or kernel can legitimately name an offset that this device did
not reserve.

No capability uses the store yet, and the patches that follow move them
into it one at a time, so keep appending the records of the capabilities
that still have their own buffer after the saved DWORDs. The blob
therefore continues to describe all of a device's saved state at every
step; a later patch drops the records once there are none left.

struct pci_saved_state is opaque to everything outside drivers/pci, so no
caller needs to change.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c        | 89 +++++++++++++++++++++++++++++++++++-----
 drivers/pci/pci.h        |  4 ++
 drivers/pci/saved-caps.c | 14 +++++++
 3 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5b960ca26e6..007f9bb289d5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2032,11 +2032,40 @@ void pci_restore_state(struct pci_dev *dev)
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
@@ -2046,16 +2075,28 @@ struct pci_saved_state {
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
 
@@ -2063,16 +2104,25 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
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
@@ -2087,16 +2137,33 @@ int pci_load_saved_state(struct pci_dev *dev,
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
index 6676177706ba..206e0d04e06e 100644
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
index 92865891514e..4647ce59ce74 100644
--- a/drivers/pci/saved-caps.c
+++ b/drivers/pci/saved-caps.c
@@ -211,6 +211,20 @@ void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val)
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
2.56.0.455.g6c5a503b38-goog


