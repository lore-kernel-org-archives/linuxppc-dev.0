Return-Path: <linuxppc-dev+bounces-28349-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECBBC98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 22:19:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htJkh3PZHz2y2f;
	Mon, 28 Sep 2026 08:19:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790533229;
	cv=none; b=jooBv52/gDn0JNOMjx1aI6EjzwtYvQRD0v1GDLQZN/3PhTXjPcLMKdqZbcZfF/aH2Vry4A7E7K2DIwav0v1UlgRSOV+5ykrP/ZiSt6Mra/RdSjjzFdBLietGKc/Q1atX7igN0fjZbYEvfz5MVEmvOBFtPQ6H14uXbpMgNQ95A6uV2qevBeMdE0wA8I9wCzi9uO+tO2rAo4RYCvlXToTjx/a4zgSs7Q+c0o688KQRQryDYTFiZ17N3WB5gwfW4pY7dQd2TEpG+sAFDVusZC/he3eG+oSH3Wn1sHS8qQ6N1vCJavei+hJvpcd80t5udNMauiemf7cHYjEyGUyF9Cc6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790533229; c=relaxed/relaxed;
	bh=HuN5+KumXzfDF7N5B1L0sRY32M0tbe03+VKPfAOnEmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XL2YD6pUYoUdoqa/B87A1o8UIb281H83QI1c44C4uSdegCHZwehk4fmDCFzlQZyFDFMkd4SgQATwRpDnQb+aFdXE2RQF2RA0qpSo4XYG5DNSX5iZOrwlFOFBSInt34LHlK0wygSfhVp+wt5nqijZgZTSkcqLkGOVpWHTeB9rgpzp4doxnNAapO/oohZQYq7pj36KEI8IG9yAZJ7Lah7HqiENp265OfHcmX3H8qn+GYx3njNatfFg2Z1pdB0gaGhGhNeV5iVOgvDa604gV0W7ntWS7FWHZ9ZoL3KMde0vx77bEx8Z8S9PrjtkejAzf6QskhG2XDqjbrw3kVr4kK7S1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J13h4v6e; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J13h4v6e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htCRH1pdhz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:20:27 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49e66390995so12851245e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790533224; x=1791138024; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HuN5+KumXzfDF7N5B1L0sRY32M0tbe03+VKPfAOnEmE=;
        b=J13h4v6eGtnAe5/hZISE4wyI1Zk0YTC4GQpdM79eV1s64Ko8eCmsq4pUFkGFkA6XXD
         +ANvNWLKRm32CilWbvK9UwRROeyF8NCIWF+gMlrYT/uAzrgQ142mZw36ZKTLk94+7Zql
         ae6ZQ5j4g1iSxCiraU48TOq2YFucjMiLtv9SQX0V9/rbki9wfJ5Z8AaOs4SXp/ZAjX1E
         YUkHZKj4aaRLWfW+d9YguD1e0ySC1pH/5Bi8tt7Rm3zKg3WShLG73vbQbOjtLrh6q71U
         JS6Vq4DQHDFNKQRiwEhyNBwf96LZbUPLmZs6zHKu95cDGKA3foA/g3xUVNYClI7m+ENM
         QMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790533224; x=1791138024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuN5+KumXzfDF7N5B1L0sRY32M0tbe03+VKPfAOnEmE=;
        b=npzshmBA3VC/EVF7eiUnJKtifSuJyy8roSQrVekuFul6eWLpKDk38XUjpIsAhl0Naj
         RNzKVCnFzsJDmmGGdSbXBC3dIc9UqfS5TKJPEJ4Pf1vK4EA8aUvJTwRwHWo0S30HMlxa
         H/Ayz8HjBcXxHDCx+BGHKvDjN2Gl9tyTGndkul8/YuKPDalx9/WttqF9f/s9ZefWoBVB
         jiEpRgmNr/N1aoiSBZTjdsnpbE5GEK18p7CIyVMIsjT+QIVxnoKzR7a+o73aemvje8sz
         3Uv4V5ws9mYBOWTx2RvPgw7pO3tv+xnW3kwPbnrlkmvSko5CL3prq1c4ffd7Ade4QwHx
         7w2A==
X-Forwarded-Encrypted: i=1; AKwUvBxD062rjWfG2EXLda95nFHVSGUbz69QJ2YefHgU12ruewMNj8oH1AsXry4xmL/5zlJyND9eF62Uk4vQJcQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lyt2xhmwipNB6cmb8zY1TiiRxXNik5O9QMy0bPBB87w8ntHVes
	BZZNMtSd1Fj3CILwDNcYUNDknife7r5XLN66PgfEH/mUZkReob+r9m+N
X-Gm-Gg: AYBFou2uJHSMWiRDVxOOOzrVEq2ixYsZ3280sDcQ5vw5TEunArIm98W50LlpofOxqry
	uDgUm/4s2hZF+oGFjNdxB9C5NYxxl0Rg1ND58dvaPL1SFwNWy95YUctZrXVXNCP7eSOQOgmPuod
	m+w2xUmToAY5cCrNUHGJrpmCPGNbkdKc2Jo6aaFujRzVMxZPxuSQIwMjoOlCisHyET48EE5Z2gV
	3Qe2VQGI4rBl/GWHYRbg5aXT49GUSmx9vFEBLOE9h1t3T+lqY9g53C6/K5f4PlR76VsYkHIlsaB
	RVyExi7xXKnpwibnqReB2RYMUA2TlFmmI3pee9ooFXKtevrFvGMCYUxIyfLu3dbtssovMwS98wv
	xTpcIlnuw+KV8kHfZ9rvQAFVzFIJ40ilXRejWqT5CloZGv3IfvKG7WsNBpn0FBmaQoW+3AXuxtT
	vpOQ8i3Y0zCN2FM2PVpPWu1bvE/yRdGHj5f0g4puKLJou5oExmQGXook8T7sUrOpLnLP6z/JmuO
	AlHlXMdv0sCaWHtE1mVUD0kKKhDjGDmVX2ZtdvX/HYEDDi3Zu7ffmrz+13M7nENp0orxaOCih7R
	VQ==
X-Received: by 2002:a05:600c:a30b:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-49ffaa33f7amr58861175e9.13.1790533223658;
        Sun, 27 Sep 2026 11:20:23 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a002d1d8d5sm38371585e9.0.2026.09.27.11.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:20:23 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC v4 1/5] PCI: Report surprise removal event
Date: Sun, 27 Sep 2026 18:20:12 +0000
Message-ID: <20260927182017.938565-2-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927182017.938565-1-abhinjoses@gmail.com>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Michael S. Tsirkin" <mst@redhat.com>

At the moment, in case of a surprise removal, the regular remove
callback is invoked, exclusively.  This works well, because mostly,
the cleanup would be the same.

However, there's a race: imagine device removal was initiated by a user
action, such as driver unbind, and it in turn initiated some cleanup
and is now waiting for an interrupt from the device. If the device is
now surprise-removed, that never arrives and the remove callback hangs
forever.

For example, this was reported for virtio-blk:

	1. the graceful removal is ongoing in the remove() callback,
	    where disk deletion del_gendisk() is ongoing, which waits
	    for the requests to complete,

	2. Now few requests are yet to complete, and surprise removal
	    started.

	    At this point, virtio block driver will not get notified by
	   the driver core layer, because it is likely serializing
	   remove() happening by +user/driver unload and PCI hotplug
	   driver-initiated device removal.  So vblk driver doesn't
	   know that device is removed, block layer is waiting for
	   requests completions to arrive which it never gets.
	   So del_gendisk() gets stuck.

Drivers can artificially add timeouts to handle that, but it can be
flaky.

Instead, let's add a way for the driver to be notified about the
disconnect. It can then do any necessary cleanup, knowing that
the device is inactive.

Since cleanups can take a long time, this takes an approach of a work
struct that the driver initiates and enables on probe, and tears down on
remove.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/all/fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com/
[Abhin: adapted subject, serialize with a per-device spinlock]
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

---
Changes since RFC v2:
- Protect disconnect_work_enable with a per-device spinlock, held while
  testing it and scheduling the work, instead of lockless accesses and
  barriers.  pci_dev_set_disconnected() could otherwise test the flag,
  get preempted, and queue the work while a newly bound driver
  re-initializes it.  With the lock, cancel_work_sync() is sufficient
  again, so go back to it from disable_work_sync(). (Sashiko)

Changes since RFC v1:
- Use disable_work_sync() instead of cancel_work_sync() in
  pci_clear_disconnect_work() as schedule_work() on a
  disabled work item is a no-op. (Sashiko)

RFC v2: https://lore.kernel.org/all/20260927165459.829900-2-abhinjoses@gmail.com/
Sashiko review of v2: https://lore.kernel.org/all/20260927170707.6F9241F000FF@smtp.kernel.org/
RFC v1: https://lore.kernel.org/all/20260905183905.997833-2-abhinjoses@gmail.com/
Sashiko review of v1: https://lore.kernel.org/all/20260905184649.E8F621F00A3A@smtp.kernel.org/
---
 drivers/pci/pci.h   |  7 ++++++
 drivers/pci/probe.c |  1 +
 include/linux/pci.h | 57 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc23..175273756c183 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -802,9 +802,16 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
+	unsigned long flags;
+
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	spin_lock_irqsave(&dev->disconnect_lock, flags);
+	if (dev->disconnect_work_enable)
+		schedule_work(&dev->disconnect_work);
+	spin_unlock_irqrestore(&dev->disconnect_lock, flags);
+
 	return 0;
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..3a05ad32bfd54 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2515,6 +2515,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	};
 
 	spin_lock_init(&dev->pcie_cap_lock);
+	spin_lock_init(&dev->disconnect_lock);
 #ifdef CONFIG_PCI_MSI
 	raw_spin_lock_init(&dev->msi_lock);
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1ef..aed62ae709f59 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -592,6 +592,10 @@ struct pci_dev {
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
 	struct gpio_desc *wake;		/* WAKE# GPIO */
+	/* Report disconnect events. 0x0 - disable, 0x1 - enable */
+	u8 disconnect_work_enable;
+	spinlock_t disconnect_lock;	/* Protects disconnect_work_enable */
+	struct work_struct disconnect_work;
 
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
@@ -2123,6 +2127,59 @@ pci_release_mem_regions(struct pci_dev *pdev)
 			    pci_select_bars(pdev, IORESOURCE_MEM));
 }
 
+/*
+ * Run this first thing after getting a disconnect work, to prevent it from
+ * running multiple times.
+ * Returns: true if disconnect was enabled, proceed. false if disabled, abort.
+ */
+static inline bool pci_test_and_clear_disconnect_enable(struct pci_dev *pdev)
+{
+	unsigned long flags;
+	bool enabled;
+
+	spin_lock_irqsave(&pdev->disconnect_lock, flags);
+	enabled = pdev->disconnect_work_enable;
+	pdev->disconnect_work_enable = 0x0;
+	spin_unlock_irqrestore(&pdev->disconnect_lock, flags);
+
+	return enabled;
+}
+
+/*
+ * Caller must initialize @pdev->disconnect_work before invoking this.
+ * The work function must run and check pci_test_and_clear_disconnect_enable.
+ * Note that device can go away right after this call.
+ */
+static inline void pci_set_disconnect_work(struct pci_dev *pdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->disconnect_lock, flags);
+	pdev->disconnect_work_enable = 0x1;
+	spin_unlock_irqrestore(&pdev->disconnect_lock, flags);
+
+	/* check the device did not go away meanwhile. */
+	if (pci_device_is_present(pdev))
+		return;
+
+	spin_lock_irqsave(&pdev->disconnect_lock, flags);
+	if (pdev->disconnect_work_enable)
+		schedule_work(&pdev->disconnect_work);
+	spin_unlock_irqrestore(&pdev->disconnect_lock, flags);
+}
+
+static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->disconnect_lock, flags);
+	pdev->disconnect_work_enable = 0x0;
+	spin_unlock_irqrestore(&pdev->disconnect_lock, flags);
+
+	/* No one can queue the work any more; wait for a queued or running one */
+	cancel_work_sync(&pdev->disconnect_work);
+}
+
 bool pci_suspend_retains_context(struct pci_dev *pdev);
 
 #else /* CONFIG_PCI is not enabled */
-- 
2.51.1


