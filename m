Return-Path: <linuxppc-dev+bounces-28329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D35C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:54:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBrm5Vqtz30Wd;
	Mon, 28 Sep 2026 03:54:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790531535;
	cv=none; b=eU1mRBhdmnlvqHMBlV6yN2PaX+Qmx0O5raAiPsbM+Nyj4ZHLVTdl9CFUzVZtjXoW0mpFykX15fK0cITTeA6YXVKbPZ6IIbeTrQqlw5RLmdQHBanvR0fZNlFk8xj7jmK/MUQNQtaimgXeEfd5HrZ8QGfKa3Wx1Mwu0pk8ZpCI7meMCu+vkfFAWdiJJyr1r0eu86DBN6txCYL+U6i7mXwoFbfCOdA7TIuCQVAs6Yj4nlZ4zpYi4pr8VEYuBvk68tWTR13uUNEJEkwCnU+tZ1kAqv1gCAKRRI9KL880jYlm11UteEs2BeAE3Few7DN8NXtVPME6IX0ltITYuQXQf3saXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790531535; c=relaxed/relaxed;
	bh=HuN5+KumXzfDF7N5B1L0sRY32M0tbe03+VKPfAOnEmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcPXRyaGrGEnZeSRaZc0mSaaNqxEgiGAPJ4Uv/ftXcxA+kYJ2aVNYDECQyUHOAJa0SI2VJzaEo2ySlmPeFr+u4uUU5DHfdiviqdJcuSUBTlNTuxmzN5t1aXJdgd3PByHNqGwArj1keiPQuQeh98GE+hzEdNlu/DknLgCAlh01qBIIdhvZT21C3nyQwyX9aTCjVzWwjfS85UFz+bw5y5hIpTqtid23oV4f/p4O7b68oKHZh/8A7WYSxVTFykoA4txdUJODpaN70PBS2ng8HZCSlP0XaGmwuSKK9im1HRMTfLBPXPfr8+renTrDFo889nhCs3LhMJfiMVd0j9bHn6oEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SVeYAxdX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SVeYAxdX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htBpk1Rjpz3bbW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:52:13 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so27112785e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531531; x=1791136331; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HuN5+KumXzfDF7N5B1L0sRY32M0tbe03+VKPfAOnEmE=;
        b=SVeYAxdXG9RxdbAH/Cq59XGImKB+sc5lJ0yG2F7ULbWzSAg3bbnkREdQKIwKlFXxik
         hAkB37VsTm5d/hIMyGnDVjp1lUgn37BAbKY6MLtCBRKM5eHXs+5mP2wcuoOElSjYMwvN
         hekcFQJJ4LFG3mn8wVaMnVsSQdnTJ+AtiDolexl12pou3fXDjkXXukPSp6BOtHLelZch
         wrIFVZWZOlMAYxXJxJGqMW2puGAO2a35DwY+b4CWgotYXGDu/dCYUunhfAFrhljhboos
         QV0BtxZj6mFilYfrnHUat6QNBVvmP9L4WPTRGJQ74Rtdv7ckWobu4zMbQ/Y7F5qlWMF2
         QPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531531; x=1791136331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuN5+KumXzfDF7N5B1L0sRY32M0tbe03+VKPfAOnEmE=;
        b=TuVD6diozuT1K0XekFrx2CwxRe3ZjoNFm2XRhKUOBxTFmmOCfngEijpCRtLmWIzDYZ
         pM6aq6uxhM9yE+mrCzSB8942vIsI3oFWaCgzu3VSd57yjPmg8Qf574J0R+PZkGs6VcSB
         2rZtEC9gOHKDb02QNKAI0nreD9MY4MzrQSK7LqzwiFnNs79WAMrI+M4PZe7q7LFcpCoP
         RxBMNd1wdhPZTuLpN7SjKC+uQ7PZN1Y/SJ6YuZ2RODWXfjuNW2C8hsbgUNt2CD4p5CI5
         FIhQjDeMK6t6NX5EdcBKuhMPCkHXmxrv/86wMvBMh30tfUP8gzGa9UjgkjJtb2Pf8RhN
         2goQ==
X-Forwarded-Encrypted: i=1; AKwUvBwv+h31p2cQRbds8Br68zQJKD2f2ZwA0rgB457D1UFK+Gs7X4YuXnIE7fi9grq1JIkzj9jF0TCJ/SVW4yQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++no6eL57wJY7G/3wDgHfdYNNkrdx7ivPeXHHEyRWTR67jMCte3b
	WttEzjz09Ht84XPYrnbNskvBo4InCYhtkVzX4LaDK38i7/WyNPvHsxmj
X-Gm-Gg: AYBFou106C7mbYnzyE8N+dp7pqlorwlAeY1LmAERFyw6xpmKZ3eo5ygoMtfX5xg1kSE
	1Na96nnA1uOV71YlKhFXi2+gPNuDtOowITdyw7tRc1TYfV74HZ/FNP3b6D+Ak0/Me1AuPlNwIYW
	9o9NYrQRjcqJwUwwwyutdHfJQX82Ax9lCrigD0+fntcu4XBzJwNVgwGopt1Ht9QkEHcOkGLlhsX
	a8KrSUKyDn3HHm+YVpEAh2/P6mjvdnfiAi9JuzIP3ykqNIvl74nPAPy2GpqUMrbHKejrR5i4yXv
	7LRkZt9zos7a1tG59CdmddLcrUQSqNgP1ejDniiUwQ/j/Vz0P/Uoi/kt8EwI5dmKe2j1YdFzCba
	+OtsovJBiia4+k10oirPxjg5XInhDvnuKXSfhyhIgQ/GI5EvpAbR38djd9x6ZLq8cNI3ajoonko
	CqKNMgnV1aC35ueKmrPEcvltq4slXhTZ6n1YkaSa2j6GQgTpPJa+Ie2032CVJ0OmcZawBwcDR2Z
	663ji9iqs+MR0dUpX1mVPX17A9SmnZjyVj+iFLztwLV5Y1FFemNYWUJbILl2Keahrg=
X-Received: by 2002:a05:600c:8484:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49fe66d8135mr188402975e9.20.1790531530505;
        Sun, 27 Sep 2026 10:52:10 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcc4sm22563923f8f.1.2026.09.27.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:52:10 -0700 (PDT)
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
Subject: [PATCH RFC v3 1/5] PCI: Report surprise removal event
Date: Sun, 27 Sep 2026 17:51:58 +0000
Message-ID: <20260927175203.928270-2-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927175203.928270-1-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
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


