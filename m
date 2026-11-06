Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7800606A31B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nKWeLJH9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL5205rDz3c2P;
	Fri, 06 Nov 2026 11:43:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925797;
	cv=none; b=L0BnrYq05XNAN8N3Ed1k70TPxu169wOL3KxVJ1XkmFn/aPJrtJwGYqgvU5hZgb3PzKEV8hBE/age16Hj/ZNYQAv8MH9bTROpWwRrb+P+W1rU10WFGfexgdhpL/+QPv8TanJFeEv8yVihV1L2Y60nP6g68IYOvN6VapaWkC7vY6CESLQceIIgrZhdLXpco7FTVyLKKtkxSk5Q9Amv6Xeck3/y2snVCPeoxZXzzW1WiiqC4PDzkBO7do67YnnVdyxhD3ZxdcmKoq2BWqV7mzoWAK0mHgC562Z512dW7ndSwTUguJqTZ3TsCRRDlBlY4XQobqGXfN+GSiVCK4ftLIWDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925797; c=relaxed/relaxed;
	bh=igzvOWA3gKLhxlMSFerj2bmXkcIdCtlOKBffMLwU+FU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P4vyolb4neAqfYOiwcprgaAHs2O5XqSe7xcu05tX3VUk7MvTDVLGZyVx3kgy5ipEU86PT6iQh7G3ScLefFubvc/f03/3bt5TFC5csmcXTK4iY9/gTwehaMqPIxX7+HV9yeNYUBI0fbd5LiizZJbndSb/DqZ6AHhD4of1UEToqQp77/832C5e/3Ccqt6S1F6RuEFTcp32FpNLOxJjWlJ8Z3ZbbvxyLBuvuxIP0gv/z5oqwT7Ihd3b5O7c6YB05BtikWq+tHMGFYaqKNi69Tn/+KJaFyafLPkGYFhIVvjttYVL9kutlQWJ4DQTacYa3JEEO+TGdZLzanq8fSKT1Nn/+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nKWeLJH9; dkim-atps=neutral; spf=pass (client-ip=209.85.167.198; helo=mail-oi1-f198.google.com; envelope-from=3osltaggkdpgirfyqfhplttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nKWeLJH9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=209.85.167.198; helo=mail-oi1-f198.google.com; envelope-from=3osltaggkdpgirfyqfhplttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL506d7Nz3c5m
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:16 +1100 (AEDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-54dbbf252cdso97089b6e.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925794; x=1794530594; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=igzvOWA3gKLhxlMSFerj2bmXkcIdCtlOKBffMLwU+FU=;
        b=nKWeLJH9bzmBxd4fALwIeDL1351eNa/jsKE2TeVfAU4n0tWdwsbeOlrelQ99Bv8riR
         T1oEY0kexGrTN11dRRYY54dDK2M23y9pq7DLGcMsV4CEe7clQtLhz43BItX0pSe5Rr54
         FESkgQew5d22bHOmYl6e93yMB2pzYXUAQgnobi2bbW1n0l2TmBGvPFSsFnZDosOjACII
         sf3hE121eeHEczTX6qqC8EGg8J0XyGQf4meXdVZcPLcKJRzShYste2z9JI/hOvsrsse+
         wqAjpjPYP5EGo3AWganU9UqmrlPN7XW3K8BiicVln4wz4D7BCmY7UT7/7mJrumbEYATb
         Y9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925794; x=1794530594;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=igzvOWA3gKLhxlMSFerj2bmXkcIdCtlOKBffMLwU+FU=;
        b=ILDSaRK3wtQGIXqSVJyDUm+F1zw2xZOdsc6DM89Y4ZDyGqO2hr8WH3mYfybseWqapj
         HvXBClac2acT3OBcb3yguoOAUUbg8iuR3hHxRBas1cvoCQ/IQyKrq7bgHEqA+HynErGG
         fEjEWC0pRaNuqaeue+DzXXOdrhhoMu8juFIdhq1c2kzDHQmIp/MJcRjNfrmwtoByfx4Y
         stbaqM9rgPJ0J8HJCvLHt9UXSniSncsjRHPgGvUGtdgcz+vmfXzQn8Ay6Ks6Wqde9psS
         1fx2kAoFZh7c+eUJc0I8PFUQWBbZbzcUvkIrlf067m2wFJIdiiH1Vj1f/UBmkwWmXGsQ
         bBaw==
X-Forwarded-Encrypted: i=1; AKwUvBzCt7OzmXCSubEQlQnCiVnHBBWwRHjsgTNmYKiTpnihu8sZy+HJDwYcStgrf36+AREfxjFnJTT6eAwzKx8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8sFE/W2hfDM6G9i3cKBTBdQ6vZyOFZYlxQDltgfKlArjoICaD4
	ITkV7Kt01k4ciF8NrKhXv9g6ISE1Mj6lDYEhnjz3I24GvKTYrqv7+GEv/3Uw8nqoK3dezG7NmRM
	rn+TDGY1HPCyh1Q==
X-Received: from jahl14-n2.prod.google.com ([2002:a05:6638:8c0e:20b0:620:17bd:8c69])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3509:b0:4e5:c2b4:33a4 with SMTP id 5614622812f47-567e1606dbamr662516b6e.50.1793925793840;
 Thu, 05 Nov 2026 16:43:13 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:15 +0000
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
Message-ID: <20261106004218.604799-15-dmatlack@google.com>
Subject: [PATCH v2 14/17] PCI/VC: Save VC state in the saved capability store
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

Save and restore the Virtual Channel registers, including the VC and Port
Arbitration Tables, through the per-device saved capability store instead
of a private pci_cap_saved_state buffer.

Walking VC configuration space is complicated, so sizing, saving and
restoring it were all folded into pci_vc_do_save_buffer() to guarantee they
agreed on the buffer layout. Keep the walk shared: because the store is
addressed by configuration space offset, the three passes now only have
to agree on which registers exist, not on where each one lands in a
buffer. Drop pci_vc_do_save_buffer()'s dual size/save/restore return
value, its running length, its buffer cursor, and the check that the
length matched the buffer size, and rename it to pci_vc_do_saved_caps().

Rename pci_allocate_vc_save_buffers() to pci_reserve_vc_state(), and
pci_allocate_cap_save_buffers() to pci_reserve_saved_caps(), and make
pci_save_vc_state() void, since none of them allocates anything now.

pci_save_state() therefore no longer fails with -ENOMEM when the VC state
cannot be saved, and the messages for a missing or mis-sized save buffer
go away. A failure to allocate the store is reported once during device
setup instead.

The arbitration table offsets and sizes come from the device, so what it
reports later need not match what was reserved during setup. Save or
restore a table only if all of it was reserved, so that hardware is only
asked to reload the VC Arbitration Table if it was actually restored, as
before.

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c   |  10 +-
 drivers/pci/pci.h   |   6 +-
 drivers/pci/probe.c |   4 +-
 drivers/pci/vc.c    | 230 +++++++++++++++++++++++---------------------
 4 files changed, 130 insertions(+), 120 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 977b7dbd19ce..402819ab046d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1949,7 +1949,9 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
 	pci_save_acs_state(dev);
-	return pci_save_vc_state(dev);
+	pci_save_vc_state(dev);
+
+	return 0;
 }
 EXPORT_SYMBOL(pci_save_state);
 
@@ -3727,16 +3729,16 @@ int pci_add_ext_cap_save_buffer(struct pci_dev *dev, u16 cap, unsigned int size)
 }
 
 /**
- * pci_allocate_cap_save_buffers - allocate buffers for saving capabilities
+ * pci_reserve_saved_caps - reserve room to save capability registers
  * @dev: the PCI device
  */
-void pci_allocate_cap_save_buffers(struct pci_dev *dev)
+void pci_reserve_saved_caps(struct pci_dev *dev)
 {
 	pci_reserve_pcie_state(dev);
 	pci_reserve_pcix_state(dev);
 	pci_reserve_ltr_state(dev);
 	pci_reserve_acs_state(dev);
-	pci_allocate_vc_save_buffers(dev);
+	pci_reserve_vc_state(dev);
 }
 
 void pci_free_cap_save_buffers(struct pci_dev *dev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0daa2439db5e..7deaa8caf65e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -249,7 +249,7 @@ struct pci_cap_saved_state {
 	struct pci_cap_saved_data	cap;
 };
 
-void pci_allocate_cap_save_buffers(struct pci_dev *dev);
+void pci_reserve_saved_caps(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
 int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
 int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
@@ -359,9 +359,9 @@ void pci_vpd_init(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_vpd_attr_group;
 
 /* PCI Virtual Channel */
-int pci_save_vc_state(struct pci_dev *dev);
+void pci_save_vc_state(struct pci_dev *dev);
 void pci_restore_vc_state(struct pci_dev *dev);
-void pci_allocate_vc_save_buffers(struct pci_dev *dev);
+void pci_reserve_vc_state(struct pci_dev *dev);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 62ce1e461098..c04adf606ab9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2662,8 +2662,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_msi_init(dev);		/* Disable MSI */
 	pci_msix_init(dev);		/* Disable MSI-X */
 
-	/* Buffers for saving PCIe and PCI-X capabilities */
-	pci_allocate_cap_save_buffers(dev);
+	/* Room to save PCIe, PCI-X, LTR, ACS and VC state */
+	pci_reserve_saved_caps(dev);
 
 	pci_imm_ready_init(dev);	/* Immediate Readiness */
 	pci_pm_init(dev);		/* Power Management */
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 5b507207d56d..7f8c1c29603a 100644
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
@@ -361,86 +388,67 @@ static struct {
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
+ * pci_reserve_vc_state - Reserve room for VC capability registers
  * @dev: device
  *
- * For each type of VC capability, VC/VC9/MFVC, find the capability, size
- * it, and allocate a buffer for save/restore.
+ * For each type of VC capability, VC/VC9/MFVC, find the capability and
+ * reserve room to save every register it needs.
  */
-void pci_allocate_vc_save_buffers(struct pci_dev *dev)
+void pci_reserve_vc_state(struct pci_dev *dev)
 {
-	int i;
+	int i, rc;
 
 	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
-		int len, pos = pci_find_ext_capability(dev, vc_caps[i].id);
+		int pos = pci_find_ext_capability(dev, vc_caps[i].id);
 
 		if (!pos)
 			continue;
 
-		len = pci_vc_do_save_buffer(dev, pos, NULL, false);
-		if (pci_add_ext_cap_save_buffer(dev, vc_caps[i].id, len))
-			pci_err(dev, "unable to preallocate %s save buffer\n",
-				vc_caps[i].name);
+		rc = pci_vc_do_saved_caps(dev, pos, PCI_VC_RESERVE);
+		if (rc)
+			pci_err(dev, "unable to reserve %s save state (%pe)\n",
+				vc_caps[i].name, ERR_PTR(rc));
 	}
 }
-- 
2.56.0.455.g6c5a503b38-goog


