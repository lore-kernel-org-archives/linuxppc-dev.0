Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B10606A33F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=alb4V+9f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4y160Zz3c2l;
	Fri, 06 Nov 2026 11:43:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925794;
	cv=none; b=DUV4hsMY+Hi74Fc6p0/hhhP6svDKX4kYYcTcKzoS2weZN5Z11jG/A9BNx8BCXZve1JIV0Y2OXGDI0+eFjTxzozprJ1m2h7wSVALrKISDDfIzHo0ktFrgbkK4pi2KcA07R5FnosHdXdNNpMmXSz5E508Z+k7mRGD/4KZ9QUkB8+oBB0T+iUkxdGp2w+djvfSWvgzBbp2h5cQ6RtR6ZnrGB/0xwFpEj7UgvqhR2D2ksPdMP/dGfE3kNHMiv/fQbivO9YYhMi5QXQ+d8cS0KMbocVKIbPXHaKHgtGKrEPIMxa/m9Gtu3usPhCnnUg7Q7DN/rfgebo6WhBV2pJRz5mNdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925794; c=relaxed/relaxed;
	bh=VfIh1JSY3MeIq0CEtKa0epmsvwLqQj8oYtgMnnQZzbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ht1tBkuHWCoPALWpotnJBqYEdG5zV9pkU1ZSGBgTZO3bmCn+ldCfawRdOgeROnZkUurTQE2YRjhKhnSg7M5G9YLT5RptFxVuHfBzO7WsguDXbvA08ByiHJHKx5uQSY1CexUuMYRg/BvgtNEB92+xDkVgVc6PC5ArEZI3z0CMB6fYX26MtcQAvmxKfPXYMv1r4cFdbYxiLkg8oJxLjn5uglzKj76qZrTgV7I/Af0ayFclu2/rg7VWLnxiNA1mYJXtF1mRkiR0gMoKmJDe6iHffl3yEsLZRL9e76BYzq/t0hFOMfy12EgzPCux+9QOab9WNrsnwLbe/iY6Ep263554Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=alb4V+9f; dkim-atps=neutral; spf=pass (client-ip=209.85.210.70; helo=mail-ot1-f70.google.com; envelope-from=3niltaggkdpuajxqixzhdlldib.zljifkrummz-absifpqp.lwixyp.lod@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=alb4V+9f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=209.85.210.70; helo=mail-ot1-f70.google.com; envelope-from=3niltaggkdpuajxqixzhdlldib.zljifkrummz-absifpqp.lwixyp.lod@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4x0Dx1z3c2P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:13 +1100 (AEDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-85d630e451aso263926a34.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925790; x=1794530590; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VfIh1JSY3MeIq0CEtKa0epmsvwLqQj8oYtgMnnQZzbo=;
        b=alb4V+9fwP11/uX4gosZzskruk1JxKLANkF12P3/VeEK+MHaMtiAMNbmaoRGIeQX21
         FlPVLbVlhSQ+VVFpyIIL26EelnKN+/u4zrAu3Rhtc+Un+fge65ZbZtpiJAiCIcQoEzMW
         /iTUiGpBLe+ijEJZ6M2IRF+zdjkb8NUIuhPwFiL5sNorYL8LNpT8O9BskceO0qS7CwgL
         E1h9AcwNxeraqGqzrH4+chgQw4JtMPDB9JoR8ZFvVqszPCTjITstWUaeRDABPYcfACN9
         ECup0X2Qo7W6dBPG05SrAscyugAkUfwUMH7BR8sKhEv8wgSi0L4PS84tieTOFB5EVC0H
         jJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925790; x=1794530590;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VfIh1JSY3MeIq0CEtKa0epmsvwLqQj8oYtgMnnQZzbo=;
        b=eZ8o+KD852A+EUEvOOpztyS2q46Fk13ISTPGQc/dSI+xBg0RrtzXLsBKs7Qa2StrCU
         6a7JzMKAv9Q3omY8anPyiv1xYUuXwrznQHEjUMT5R+cApnclm9PsHXcY0Ehh6fjnuwXP
         FZ7ZyBF2Q4mKqIFJc/BiOBKyhE+CM6A1XwnKK0ESuPT0vEsK4m7+MYGMzLNS4iUTPiRX
         oCgIkwSd8LQppf6KxAqeDfqrPrvK5vBjbCXaoWhNDUwX4GyJoHZQ5kpkoD5njkQp0M+I
         YbTci1X4PJGL43MPpnIvdaf3CgJNyDkKIdog0DhzIOHODdvLZ3u/dBY0xkyh8mo0mIwT
         vyJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeu2DV5iA3dmhQffnCf7E97thOT8DzGSvLX+cAlMwT4R6MIGEzuBLa+3r5uV8eY3rg00nJixf/G4H9W60=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9TnH/DI7+Bql9lA08foJfOzQY6yUfIaeltg3JWElDmTjZD1fvg
	7mklWCSlskeMbhvHGY76erlP46X/exjo4mS+GOZn5lEaLXVJxQVKn9LOP138BgwjqfN089rSYTB
	xaPrWX7niZ9Z6BA==
X-Received: from ioo11-n1.prod.google.com ([2002:a05:6602:864b:10b0:9e2:221a:fd83])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1a21:b0:561:fa43:1b2f with SMTP id 5614622812f47-567e0fc17c3mr657310b6e.20.1793925790093;
 Thu, 05 Nov 2026 16:43:10 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:12 +0000
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
Message-ID: <20261106004218.604799-12-dmatlack@google.com>
Subject: [PATCH v2 11/17] PCI/DPC: Save DPC state in the saved capability store
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

Save and restore the DPC Control register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Key the save and restore paths off pdev->dpc_cap rather than
pci_is_pcie(). The old code relied on the save buffer existing only when
the capability did, and the store has no per-capability entry to check.

Reserve the register in pci_reserve_dpc_state(), called from
pci_dpc_init().

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/dpc.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index b7f79266f66d..16203e9ef240 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -45,34 +45,18 @@ static const char * const rp_pio_error_string[] = {
 
 void pci_save_dpc_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
-	if (!save_state)
+	if (!dev->dpc_cap)
 		return;
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, cap);
+	pci_save_cap_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL);
 }
 
 void pci_restore_dpc_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
-	if (!save_state)
+	if (!dev->dpc_cap)
 		return;
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
+	pci_restore_cap_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL);
 }
 
 static DECLARE_WAIT_QUEUE_HEAD(dpc_completed_waitqueue);
@@ -400,6 +384,16 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+static void pci_reserve_dpc_state(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = pci_reserve_saved_cap(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, sizeof(u16));
+	if (rc)
+		pci_err(pdev, "unable to reserve DPC save state (%pe)\n",
+			ERR_PTR(rc));
+}
+
 void pci_dpc_init(struct pci_dev *pdev)
 {
 	u16 cap;
@@ -408,8 +402,7 @@ void pci_dpc_init(struct pci_dev *pdev)
 	if (!pdev->dpc_cap)
 		return;
 
-	if (pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16)))
-		pci_err(pdev, "unable to allocate suspend buffer for DPC\n");
+	pci_reserve_dpc_state(pdev);
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
 	if (!(cap & PCI_EXP_DPC_CAP_RP_EXT))
-- 
2.56.0.455.g6c5a503b38-goog


