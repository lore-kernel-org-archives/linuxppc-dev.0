Return-Path: <linuxppc-dev+bounces-28323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C91DC98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:51:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBp06zFdz2yMn;
	Mon, 28 Sep 2026 03:51:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790528121;
	cv=none; b=HOXuPQjmlKSHMwnlTJT3YG/f7f6ojsFUk+oXYerSg1zsdcTHblXi1qwp6FVIbtd0Wv8dbHEf/D/xtZXmSGEyZ2srCuUgXaZv1xsUQfl6gAqpHpAPWj9frKyCpPe9DFbPC/d1OXxRY/VSIGq30E7jMgv3pJpiDbYwgXC0xKp5cVOOpFuviVQlUyKwywpe4CCjrCnKk14TxrDPPZcqPMGfkktL9S/dkjQnqlhzpbuxTV/izcT6EjschUo/h1K/sEpr6NjV9p8pCTSa4tbYoq1bqAovd6zbB15z3pd0MMosQKWovkwFjxkqasa5kQtSkO6XzrJQOHlfbME59iOjdEGpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790528121; c=relaxed/relaxed;
	bh=NENXEnJkmEcvTpyI0fSgIXQlrSrcmqG3oVoD7VhdCTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHZhUEDkFOUQaiMKzhIKoHTCHmxCEofojRVFyMF7dglIjyhpXY6W51+WBCX0BaV8coJGaEN6RYUDRX1WHAm6zXvxhRMjdYefscjniZ8ZWDGAKNu5bw+p+67Mcq9AQGeGNVr47ll7PwdauduUV7o6KvTmAGnfgToGoIFQZvIh6VTNpy4Mgy05Jx+0xy1LN7WpQyTJKZ24aTIvkoS4no1zryNBqCOJ76lRqfW6Vb0CoXeSJGJ/wl9URvSlNnusBflefWR8KIWoUi9sLuGi5+wCKo2YBzSR3Q5SNaLHfCuTbh26S80brPYohqsG9iS/sCehShMZv83UhiXiSjQ+F0xz/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwUBJgF2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::f; helo=mail-wr2-x0f.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwUBJgF2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::f; helo=mail-wr2-x0f.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com [IPv6:2a00:1450:4864:30::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht9Y36zGjz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 02:55:19 +1000 (AEST)
Received: by mail-wr2-x0f.google.com with SMTP id ffacd0b85a97d-48882c1f261so717246f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528115; x=1791132915; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NENXEnJkmEcvTpyI0fSgIXQlrSrcmqG3oVoD7VhdCTw=;
        b=PwUBJgF2QXlvoRu5XtktWhE5daRQ6zm/ItKuAaFwrjnlzIpyF1JA8k1b66q2PiS2Gk
         PxMgp6dV9/BRUA/4F8BPdyKIqBGvNF+pIjsTrm9BPopPaGGIZzGXg+RlcFjUOS8mX32I
         rmZxBAeli5mzfqtWTsAoAxYLdiUNGNlqnIWejYrvr4W8pxr/i6gP5eCNiNaCQazw6/CX
         ofuZnjPG4BvLyyE+vnr8kPr7QXKiEiQXHK7BeNsGJ35oEDrJodoVgg4he6EiUJkRKzSo
         wQJgL0hBK0AAoLHcyNuDNSjuwehG3fIXfteSQ9892x58BtZpEa1ssKrZFjfFFd94aUMs
         4Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528115; x=1791132915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NENXEnJkmEcvTpyI0fSgIXQlrSrcmqG3oVoD7VhdCTw=;
        b=xfO9OmG/8nD3gPvN65CCnMlRLEM04ZR2UY+pIVZGyRBSBnd5mI9HgHvTBpRXRBLMwm
         EH3QeBTUmjUuL4WRSy8nYeTUQ1nvaFFElqN1mW6Y0YovHqHdFWGWjSPVsZEoDWLx8X1k
         7DqPg/46S8hcSsMTqCPgWNnMd0qx53qUFjqCUnw15HQGV+jB2mocqWdJKXNJQyr47PMr
         ZQQpUe6PGf6QRLXbDOdOAHtJ+9MRXaOfIiUv8qwU4AvETARVopMLlkIDCSomKiBlFa65
         u4+P1Ef28j1l7nTFS8dlj8gPQHMgQfjs91+f3u2NtX6R4iJCRhWA1+PzcvtDjOkLQhXa
         /3oQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrfkYwfj542pWLmLYU2f2aH7BgEQvBifKFgVimceUl9zDbQ73qGNJJeRpVDva5nw6/eP9Eyu+KpP/XiLE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nHDmRwH75w5c93l/KuyT+8mqip5/jedphDnv0BFlZ+OTvdqIVr
	TyRLn/3Eb8mqXmV9wTr2mHKU6AE3lxDoe0vT09TwMHxX5NRCb4m3ssrO
X-Gm-Gg: AYBFou0VgR/mGWYoP06Ao77WwOWwW/GGhYH7YN+RZSGDL7eNuOvjiLqlKOfDZg3yM7M
	8PEnW0N/C20eJAg8VA07djSFZhHGn3MCfKp3VSSEpNbzzyA4Exib9JimcnQDq+JAhbNhnDlHO3v
	G1C521Q34aQb4NS0S+y2GQYxw1yNTDGeU16suUXcPaDt0KtPjgctGMrCf0iCW1rv/FEBLtSgWye
	2j9A8mzE0mXs/C2gNi7VcnRff3xinZjmfw6hdSXONmkeKVCOgYMRohHhhIBtfiamQAdeBt0174l
	WkLilH1Anc4lSJEovX1wn+Si5kXI2wsHTeCdlU7irGbySLw1uS32Zt3jLUCagmLzxMehehxaUEm
	chEfTcMFTx/4ofdozaDM7FH3v/UaC6CpNK1FttVwR9cZ89WYf+BxJVYHZEVRJ31LcJBsJs/g7EB
	R4YOovoMEXGx0FMMj+soTjWdzoDCb8r3umIbz1nwy0frvTDzsnGr5/hP+/5ZLua+onF9/KEcaxK
	+xPcsfWoOgF62VikKzjVq+NTPSO6HCFr9cSbNwy2yXbguLpFFJZ/s0SqOoTHIOB3wU=
X-Received: by 2002:a05:600c:8b82:b0:49f:fefc:7d01 with SMTP id 5b1f17b1804b1-49ffefc7e4dmr65435835e9.15.1790528115192;
        Sun, 27 Sep 2026 09:55:15 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:14 -0700 (PDT)
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
Subject: [PATCH RFC v2 1/5] PCI: Report surprise removal event
Date: Sun, 27 Sep 2026 16:54:54 +0000
Message-ID: <20260927165459.829900-2-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927165459.829900-1-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
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
[Abhin: adapted subject, switched to disable_work_sync()]
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

---
Changes since RFC v1:
- Use disable_work_sync() instead of cancel_work_sync() in
  pci_clear_disconnect_work() as schedule_work() on a
  disabled work item is a no-op. (Sashiko)

RFC v1: https://lore.kernel.org/all/20260905183905.997833-2-abhinjoses@gmail.com/
Sashiko review: https://lore.kernel.org/all/20260905184649.E8F621F00A3A@smtp.kernel.org/
---
 drivers/pci/pci.h   |  6 ++++++
 include/linux/pci.h | 46 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc23..23b1605e783a3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -805,6 +805,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	if (READ_ONCE(dev->disconnect_work_enable)) {
+		/* Make sure work is up to date. */
+		smp_rmb();
+		schedule_work(&dev->disconnect_work);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1ef..f4c0240b62dc8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -592,6 +592,9 @@ struct pci_dev {
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
 	struct gpio_desc *wake;		/* WAKE# GPIO */
+	/* Report disconnect events. 0x0 - disable, 0x1 - enable */
+	u8 disconnect_work_enable;
+	struct work_struct disconnect_work;
 
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
@@ -2123,6 +2126,49 @@ pci_release_mem_regions(struct pci_dev *pdev)
 			    pci_select_bars(pdev, IORESOURCE_MEM));
 }
 
+/*
+ * Run this first thing after getting a disconnect work, to prevent it from
+ * running multiple times.
+ * Returns: true if disconnect was enabled, proceed. false if disabled, abort.
+ */
+static inline bool pci_test_and_clear_disconnect_enable(struct pci_dev *pdev)
+{
+	u8 enable = 0x1;
+	u8 disable = 0x0;
+
+	return try_cmpxchg(&pdev->disconnect_work_enable, &enable, disable);
+}
+
+/*
+ * Caller must initialize @pdev->disconnect_work before invoking this.
+ * The work function must run and check pci_test_and_clear_disconnect_enable.
+ * Note that device can go away right after this call.
+ */
+static inline void pci_set_disconnect_work(struct pci_dev *pdev)
+{
+	/* Make sure WQ has been initialized already */
+	smp_wmb();
+
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
+
+	/* check the device did not go away meanwhile. */
+	mb();
+
+	if (!pci_device_is_present(pdev))
+		schedule_work(&pdev->disconnect_work);
+}
+
+static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
+{
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
+
+	/* Make sure to stop using work from now on. */
+	smp_wmb();
+
+	/* Leaves the work disabled, so a racing schedule_work() is a no-op. */
+	disable_work_sync(&pdev->disconnect_work);
+}
+
 bool pci_suspend_retains_context(struct pci_dev *pdev);
 
 #else /* CONFIG_PCI is not enabled */
-- 
2.51.1


