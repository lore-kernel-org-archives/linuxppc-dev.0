Return-Path: <linuxppc-dev+bounces-28140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDC6C98321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:36:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZn5kGBz3c95;
	Fri, 25 Sep 2026 03:35:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271329;
	cv=none; b=YIadm0bb11vEdUX6UsKdbzvOfKjK5qoHkdk61II/DXBppXNvnvJKcIySmHGevNQ6DkeBr3zjCOnSytMd6DioefNZPM9f2Vzwcu+iDyMzseOwixwiBBCnE8/A6aNRMIhEgbZ04kfq5cHoHzG/VEQGtd5X0M1I+djGti1iJ0+9GO7Y2UbAog4YRBUqCAJG+MmFuzhHC3qI9rsbJs01GJJHDwW1guhY0N/3dj+D05kVNzQ3N1AX3yvfkfb07ILBgjdJ/GbojexsjBpNOHDZH+eIynDMkHLhHq5kJZ2qnxZD4hsqMXArAyL7w8NWSvJ30O8gx4ST3qphKKfx+WkOFb/9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271329; c=relaxed/relaxed;
	bh=wN4x2/2Y8YtjhePsWe2+zCDDn/F0Lmaj+a5mAyW1nkY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I9lkRE3ES7b4wIiD47yt1aFheQXsfqd7DbvbgyYiVAb+XhEycp9hyGpsiMPeFoGWVIlgUGbmzdwn71MYyl1oS/XJTfQSWns4WhW9BzBHhZQbTOFGq7bSa+pXbOpA0Rjd1NekLKL48dnKseRy6yARIT3bciLOhZBDnF/N9ffNf9UMdx/a1putsRH8cQVXcnARwhtJNkcnw//dh6VEpKfQm3Lifz+I6JmQ0RhYAlwtgLpXr7KEbxeMvyHsj6XdOTOYt1JIPhwkCDSu4JNmMXZHCPGWAM+Z8NALYwogL4jnzg7Mr/ZrAu/sK03IaSNlkZsAevqG+y/nrELa/TA4k1pQHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aK+90IIV; dkim-atps=neutral; spf=pass (client-ip=209.85.216.70; helo=mail-pj1-f70.google.com; envelope-from=3vl-1aggkdecmvj2ujltpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aK+90IIV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=209.85.216.70; helo=mail-pj1-f70.google.com; envelope-from=3vl-1aggkdecmvj2ujltpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZf3JdYz3bbW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:21 +1000 (AEST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so127530a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271319; x=1790876119; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wN4x2/2Y8YtjhePsWe2+zCDDn/F0Lmaj+a5mAyW1nkY=;
        b=aK+90IIVWfp6VGirkG+vbXbNwesBRMGCZl/7HpHFG2WVOtQsKHSM9D0Ertjx/e7x9/
         H19udZrtaInmkUwBpdHHVcU8d/RJzc+sBoRxAAEj6tcuk23g/V4A5qZigOgQBfX7Ub9/
         wVWUYwnFEu4nnvHbNxrMmXUWkpshjcDwmcxkhA/r0hxr2GyeaqbPm6aVkaKSwWnd2OnU
         8fRyE/4iEPXnzSxGcBOzC9FCja48CS717/lwCkQdwf+dU1XP+OU3Xp+js5mHfRfMl4wp
         RbwJu/qfu1m8zKVEWtKgE54fTSyb1E51FnEpd3FrB2qt0uMLjvmP/NofnLtsb6QG3LsB
         cbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271319; x=1790876119;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wN4x2/2Y8YtjhePsWe2+zCDDn/F0Lmaj+a5mAyW1nkY=;
        b=hRhh+x4h8LVMRqCJbRSj6fFJgcH27AqghTCskUR2exnXFGUfSFceM3VCrSJCCcKU5j
         gRNUsFeCl02AGsaE57Ve79PeqAzl15YYA3xr1T6x2BSKS/ZNe7bTiLO7zTJe7OCZrmYR
         OfT5NbYReWyRAsx//iGsySKJ/pZNiGA1PEFP101F5kUDzWIzAu/JTTVNMtZd+8/Al4wh
         N9MJqkoSqLJRrhwj71rnGt9p2GvZr5I9XNvMpYeLQY6zsLlrhcPEyChStPHIJ5YN7nm9
         k1p3H4n7/gPV47pjZ9R2XjoJF8k9DBu92IK9cWpb9kaqdvOYJSvHNEp61pSOJWdXw2gn
         FDMg==
X-Forwarded-Encrypted: i=1; AKwUvBzn1Y9RB9WtmBwIvTLqy6KlD8fvrrUCSCxvOrjppMHOvxkdNg0ajSqaolrdUERc/nHSTBLiiuPlTsTKuB8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lNKFN6KnHmdASTPMq8tFf3z2C/4frU0uMydv38pTqQehqOhYoB
	+0q9NPLG6VWe5Fa8AJFt4aG9/MsLj4IIXSBXAI+g1JihVZFki09PtcQbKhFKpmTNI9yxRKug4vp
	xxUgty5VzDdNQgw==
X-Received: from plw16.prod.google.com ([2002:a17:903:45d0:b0:2dd:7a32:2cd5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:51:b0:3a0:9640:8041 with SMTP id 98e67ed59e1d1-3a098728e4cmr2871511a91.36.1790271318637;
 Thu, 24 Sep 2026 10:35:18 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:59 +0000
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
Message-ID: <20260924173501.856380-14-dmatlack@google.com>
Subject: [PATCH 13/15] PCI/VC: Save VC state in the saved capability store
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

Save and restore the Virtual Channel registers, including the VC and Port
Arbitration Tables, through the per-device saved capability store instead
of a private pci_cap_saved_state buffer.

Walking VC configuration space is complicated, so sizing, saving and
restoring it were all folded into pci_vc_do_save_buffer() to guarantee they
agreed on the buffer layout. Keep the walk shared: because the store is
addressed by configuration space offset, the three passes now only have
to agree on which registers exist, not on where each one lands in a
buffer. Drop pci_vc_do_save_buffer()'s dual size/save/restore return
value, its running length, its buffer cursor, and the sanity check that
compared the two against each other, and rename it to
pci_vc_do_saved_caps().

Rename pci_allocate_vc_save_buffers() to pci_vc_reserve_saved_caps() and
make pci_save_vc_state() void, since neither allocates anything now.

The arbitration table offsets and sizes come from the device, so what it
reports later need not match what was reserved during setup. Save or
restore a table only if all of it was reserved, which keeps the request
for hardware to re-load the VC Arbitration Table tied to having actually
restored it, as the old code did by only walking the tables that were
present in the buffer.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c |   6 +-
 drivers/pci/pci.h |   4 +-
 drivers/pci/vc.c  | 225 ++++++++++++++++++++++++----------------------
 3 files changed, 122 insertions(+), 113 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e53bca1cb50f..171763f560b8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1777,7 +1777,9 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
-	return pci_save_vc_state(dev);
+	pci_save_vc_state(dev);
+
+	return 0;
 }
 EXPORT_SYMBOL(pci_save_state);
 
@@ -3589,7 +3591,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 			pci_err(dev, "unable to reserve LTR save state\n");
 	}
 
-	pci_allocate_vc_save_buffers(dev);
+	pci_vc_reserve_saved_caps(dev);
 }
 
 void pci_free_cap_save_buffers(struct pci_dev *dev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e8e7bc8a63e7..68c19f5025de 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -359,9 +359,9 @@ void pci_vpd_init(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_vpd_attr_group;
 
 /* PCI Virtual Channel */
-int pci_save_vc_state(struct pci_dev *dev);
+void pci_save_vc_state(struct pci_dev *dev);
 void pci_restore_vc_state(struct pci_dev *dev);
-void pci_allocate_vc_save_buffers(struct pci_dev *dev);
+void pci_vc_reserve_saved_caps(struct pci_dev *dev);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 5b507207d56d..d72d67dae78e 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -16,25 +16,74 @@
 
 #include "pci.h"
 
+/* What to do with the registers of a VC capability */
+enum pci_vc_op {
+	PCI_VC_RESERVE,		/* Reserve room to save them */
+	PCI_VC_SAVE,		/* Copy them into the saved capabilities */
+	PCI_VC_RESTORE,		/* Write the saved capabilities back */
+};
+
 /**
- * pci_vc_save_restore_dwords - Save or restore a series of dwords
+ * pci_vc_do_word - Reserve, save, or restore a word
+ * @dev: device
+ * @pos: config space position
+ * @op: what to do with it
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+static int pci_vc_do_word(struct pci_dev *dev, int pos, enum pci_vc_op op)
+{
+	switch (op) {
+	case PCI_VC_RESERVE:
+		return pci_reserve_saved_cap(dev, pos, sizeof(u16));
+	case PCI_VC_SAVE:
+		pci_save_cap_word(dev, pos);
+		break;
+	case PCI_VC_RESTORE:
+		if (!pci_saved_cap_reserved(dev, pos))
+			return -ENOENT;
+
+		pci_restore_cap_word(dev, pos);
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * pci_vc_do_dwords - Reserve, save, or restore a series of dwords
  * @dev: device
  * @pos: starting config space position
- * @buf: buffer to save to or restore from
- * @dwords: number of dwords to save/restore
- * @save: whether to save or restore
+ * @dwords: number of dwords
+ * @op: what to do with them
+ *
+ * Return: 0 on success, negative errno otherwise.
  */
-static void pci_vc_save_restore_dwords(struct pci_dev *dev, int pos,
-				       u32 *buf, int dwords, bool save)
+static int pci_vc_do_dwords(struct pci_dev *dev, int pos, int dwords,
+			    enum pci_vc_op op)
 {
 	int i;
 
-	for (i = 0; i < dwords; i++, buf++) {
-		if (save)
-			pci_read_config_dword(dev, pos + (i * 4), buf);
+	if (op == PCI_VC_RESERVE)
+		return pci_reserve_saved_cap(dev, pos, dwords * sizeof(u32));
+
+	/*
+	 * The device supplies the table offsets and sizes, so what it reports
+	 * now may not match what was reserved during setup, e.g. if it is no
+	 * longer responding. Save or restore all of the table, or none of it.
+	 */
+	for (i = 0; i < dwords; i++)
+		if (!pci_saved_cap_reserved(dev, pos + i * sizeof(u32)))
+			return -ENOENT;
+
+	for (i = 0; i < dwords; i++, pos += sizeof(u32)) {
+		if (op == PCI_VC_SAVE)
+			pci_save_cap_dword(dev, pos);
 		else
-			pci_write_config_dword(dev, pos + (i * 4), *buf);
+			pci_restore_cap_dword(dev, pos);
 	}
+
+	return 0;
 }
 
 /**
@@ -173,13 +222,14 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
  * @dev: device
  * @pos: starting position of VC capability (VC/VC9/MFVC)
  * @res: VC resource number, ie. VCn (0-7)
- * @ctrl: saved VC Resource Control Register
  */
-static void pci_vc_restore_res_ctrl(struct pci_dev *dev, int pos, int res,
-				    u32 ctrl)
+static void pci_vc_restore_res_ctrl(struct pci_dev *dev, int pos, int res)
 {
 	int ctrl_pos = pos + PCI_VC_RES_CTRL + (res * PCI_CAP_VC_PER_VC_SIZEOF);
-	u32 tmp;
+	u32 ctrl, tmp;
+
+	if (!pci_read_saved_cap_dword(dev, ctrl_pos, &ctrl))
+		return;
 
 	/*
 	 * For an FLR case, the VC config may remain.  Preserve enable bit,
@@ -200,34 +250,22 @@ static void pci_vc_restore_res_ctrl(struct pci_dev *dev, int pos, int res,
 }
 
 /**
- * pci_vc_do_save_buffer - Size, save, or restore VC state
+ * pci_vc_do_saved_caps - Reserve, save, or restore VC state
  * @dev: device
  * @pos: starting position of VC capability (VC/VC9/MFVC)
- * @save_state: buffer for save/restore
- * @save: if provided a buffer, this indicates what to do with it
+ * @op: what to do with the registers found along the way
+ *
+ * Walking Virtual Channel config space is complicated, so reserving, saving
+ * and restoring it are all driven from one function to reduce code and
+ * guarantee that they agree on which registers are involved.
  *
- * Walking Virtual Channel config space to size, save, or restore it
- * is complicated, so we do it all from one function to reduce code and
- * guarantee ordering matches in the buffer.  When called with NULL
- * @save_state, return the size of the necessary save buffer.  When called
- * with a non-NULL @save_state, @save determines whether we save to the
- * buffer or restore from it.
+ * Return: 0 on success, negative errno otherwise.
  */
-static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
-				 struct pci_cap_saved_state *save_state,
-				 bool save)
+static int pci_vc_do_saved_caps(struct pci_dev *dev, int pos, enum pci_vc_op op)
 {
 	u32 cap1;
 	char evcc, lpevcc, parb_size;
-	int i, len = 0;
-	u8 *buf = save_state ? (u8 *)save_state->cap.data : NULL;
-
-	/* Sanity check buffer size for save/restore */
-	if (buf && save_state->cap.size !=
-	    pci_vc_do_save_buffer(dev, pos, NULL, save)) {
-		pci_err(dev, "VC save buffer size does not match @0x%x\n", pos);
-		return -ENOMEM;
-	}
+	int i, ret;
 
 	pci_read_config_dword(dev, pos + PCI_VC_PORT_CAP1, &cap1);
 	/* Extended VC Count (not counting VC0) */
@@ -243,16 +281,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 	 * therefore save/restore it first, as only VC0 should be enabled
 	 * after device reset.
 	 */
-	if (buf) {
-		if (save)
-			pci_read_config_word(dev, pos + PCI_VC_PORT_CTRL,
-					     (u16 *)buf);
-		else
-			pci_write_config_word(dev, pos + PCI_VC_PORT_CTRL,
-					      *(u16 *)buf);
-		buf += 4;
-	}
-	len += 4;
+	ret = pci_vc_do_word(dev, pos + PCI_VC_PORT_CTRL, op);
+	if (ret)
+		return ret;
 
 	/*
 	 * If we have any Low Priority VCs and a VC Arbitration Table Offset
@@ -278,21 +309,20 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 			/* Fixed 4 bits per phase per lpevcc (plus VC0) */
 			size = ((lpevcc + 1) * vcarb_phases * 4) / 8;
 
-			if (size && buf) {
-				pci_vc_save_restore_dwords(dev,
-							   pos + vcarb_offset,
-							   (u32 *)buf,
-							   size / 4, save);
+			if (size) {
+				int off = pos + vcarb_offset;
+
+				ret = pci_vc_do_dwords(dev, off, size / 4, op);
+				if (ret)
+					return ret;
+
 				/*
 				 * On restore, we need to signal hardware to
 				 * re-load the VC Arbitration Table.
 				 */
-				if (!save)
+				if (op == PCI_VC_RESTORE)
 					pci_vc_load_arb_table(dev, pos);
-
-				buf += size;
 			}
-			len += size;
 		}
 	}
 
@@ -325,32 +355,29 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 
 			size = (parb_size * parb_phases) / 8;
 
-			if (size && buf) {
-				pci_vc_save_restore_dwords(dev,
-							   pos + parb_offset,
-							   (u32 *)buf,
-							   size / 4, save);
-				buf += size;
+			if (size) {
+				int off = pos + parb_offset;
+
+				ret = pci_vc_do_dwords(dev, off, size / 4, op);
+				if (ret)
+					return ret;
 			}
-			len += size;
 		}
 
 		/* VC Resource Control Register */
-		if (buf) {
+		if (op == PCI_VC_RESTORE) {
+			pci_vc_restore_res_ctrl(dev, pos, i);
+		} else {
 			int ctrl_pos = pos + PCI_VC_RES_CTRL +
-						(i * PCI_CAP_VC_PER_VC_SIZEOF);
-			if (save)
-				pci_read_config_dword(dev, ctrl_pos,
-						      (u32 *)buf);
-			else
-				pci_vc_restore_res_ctrl(dev, pos, i,
-							*(u32 *)buf);
-			buf += 4;
+				       (i * PCI_CAP_VC_PER_VC_SIZEOF);
+
+			ret = pci_vc_do_dwords(dev, ctrl_pos, 1, op);
+			if (ret)
+				return ret;
 		}
-		len += 4;
 	}
 
-	return buf ? 0 : len;
+	return 0;
 }
 
 static struct {
@@ -361,86 +388,66 @@ static struct {
 		{ PCI_EXT_CAP_ID_VC9, "VC9" } };
 
 /**
- * pci_save_vc_state - Save VC state to pre-allocate save buffer
+ * pci_save_vc_state - Save VC state to the saved capability store
  * @dev: device
  *
  * For each type of VC capability, VC/VC9/MFVC, find the capability and
- * save it to the pre-allocated save buffer.
+ * save it to the previously reserved capability store.
  */
-int pci_save_vc_state(struct pci_dev *dev)
+void pci_save_vc_state(struct pci_dev *dev)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
-		int pos, ret;
-		struct pci_cap_saved_state *save_state;
+		int pos = pci_find_ext_capability(dev, vc_caps[i].id);
 
-		pos = pci_find_ext_capability(dev, vc_caps[i].id);
 		if (!pos)
 			continue;
 
-		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
-		if (!save_state) {
-			pci_err(dev, "%s buffer not found in %s\n",
-				vc_caps[i].name, __func__);
-			return -ENOMEM;
-		}
-
-		ret = pci_vc_do_save_buffer(dev, pos, save_state, true);
-		if (ret) {
-			pci_err(dev, "%s save unsuccessful %s\n",
-				vc_caps[i].name, __func__);
-			return ret;
-		}
+		pci_vc_do_saved_caps(dev, pos, PCI_VC_SAVE);
 	}
-
-	return 0;
 }
 
 /**
- * pci_restore_vc_state - Restore VC state from save buffer
+ * pci_restore_vc_state - Restore VC state from the saved capability store
  * @dev: device
  *
  * For each type of VC capability, VC/VC9/MFVC, find the capability and
- * restore it from the previously saved buffer.
+ * restore it from the saved capability store.
  */
 void pci_restore_vc_state(struct pci_dev *dev)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
-		int pos;
-		struct pci_cap_saved_state *save_state;
+		int pos = pci_find_ext_capability(dev, vc_caps[i].id);
 
-		pos = pci_find_ext_capability(dev, vc_caps[i].id);
-		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
-		if (!save_state || !pos)
+		if (!pos)
 			continue;
 
-		pci_vc_do_save_buffer(dev, pos, save_state, false);
+		pci_vc_do_saved_caps(dev, pos, PCI_VC_RESTORE);
 	}
 }
 
 /**
- * pci_allocate_vc_save_buffers - Allocate save buffers for VC caps
+ * pci_vc_reserve_saved_caps - Reserve room for VC capability registers
  * @dev: device
  *
- * For each type of VC capability, VC/VC9/MFVC, find the capability, size
- * it, and allocate a buffer for save/restore.
+ * For each type of VC capability, VC/VC9/MFVC, find the capability and
+ * reserve room to save every register it needs.
  */
-void pci_allocate_vc_save_buffers(struct pci_dev *dev)
+void pci_vc_reserve_saved_caps(struct pci_dev *dev)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
-		int len, pos = pci_find_ext_capability(dev, vc_caps[i].id);
+		int pos = pci_find_ext_capability(dev, vc_caps[i].id);
 
 		if (!pos)
 			continue;
 
-		len = pci_vc_do_save_buffer(dev, pos, NULL, false);
-		if (pci_add_ext_cap_save_buffer(dev, vc_caps[i].id, len))
-			pci_err(dev, "unable to preallocate %s save buffer\n",
+		if (pci_vc_do_saved_caps(dev, pos, PCI_VC_RESERVE))
+			pci_err(dev, "unable to reserve %s save state\n",
 				vc_caps[i].name);
 	}
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


