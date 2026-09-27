Return-Path: <linuxppc-dev+bounces-28326-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A28DC9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:52:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBpY6Cxjz30WJ;
	Mon, 28 Sep 2026 03:52:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790528132;
	cv=none; b=RAU3CWZgpO53h0LJkijAOfV1SqY+lmxIWRiEAtf9vxAW27OMFqvPYpV4b+QOZuaLp/xhEifdOgDkj8MG+VD+9Oo5cz6CPaLVd7b7XiVrkWHq+qnFsriJ5efXSTae3MXMhQTm9+7F6G5LUw6/vaUGbqfgx7rrQYFJrlCTb874audCS3V4J4sYBLRF2PJ9lz8gx4PCtYlYukZG6e+wd0vVn33ejDN+cAfe8rYEfQvl2p/x/iv8B8W4mG9QmrmJlz4ti81WZraDi5WeuIVMw5cTsXys8P1NOZfURyGAALDxRjm0Qt3FzQyDRRykXtgxmN1oSf8HqEk6BgU3V/91CpEQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790528132; c=relaxed/relaxed;
	bh=ym1diEOibk5xps77zZysxQ1bh4AhoR+8AInugu/q9zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWirVCd9D0Hl2a+kmcoCfagztP4duDhNZriF5QNa+yEzF2W1MyJCPPqKV842zTG/jY8eCt83WD/9E6tOyxPxy9KpFzp9vqk3Zvz4FMypUe8sz51QSm3n5vNQWufoqbQpIy41ksF9tixni5FHc8ip2IubeZb/OarcxAzbNq8RnT0ZGpE4vh39zgQ+a55yhuVDDnodzufxU2wKKn6BcMv63gdnBgEtBXeoTpG3t1SezTmObyfWnIT8PoAvlZ+D7F9jt6wXS95qUx35mSO6lsLyhkHWChJKZqGH4bPFWs+S5xmYqhAamJPhjG6PZehVdZVqdniHjP+g/vThuIBgcL0R4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PdOhoy0y; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PdOhoy0y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht9YG74dJz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 02:55:30 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so12542965e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528128; x=1791132928; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ym1diEOibk5xps77zZysxQ1bh4AhoR+8AInugu/q9zA=;
        b=PdOhoy0yEH8HZp9qeSJRrXnGKe/1S5CXfPWemy+ALqhMk8b+a6/oJxCWwpJa5kxgOX
         qhbbMZyJZk8Caj6QRmMqqHzoF38AwkJLIej70MyUMP9rF8S/cNeBLoLb3XBzXTx7Z4gU
         g1IXKLbX0QXbRhMys0QYQjAMutGDi4WrBM2Hcf2A5k/2ODPNrUyX0NnDpUyv91xnp/zt
         uvOkqbG0eUlPBbXBKrV2fsDhgzh+8hlydUxMzHcrsLE7o6wbbV4911Q/U0Waj53ZGJJn
         cBfUZh0qBjkLIgx15Wr+sThWCp6s5Lc3VCK6fSZ2hpPpPwHY9PG1q94Z2oBV9CzcNMMd
         oIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528128; x=1791132928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ym1diEOibk5xps77zZysxQ1bh4AhoR+8AInugu/q9zA=;
        b=h9bA7ZnxZh/DLcQRYpN+7CyacapBoQ6E4aDy1XybSreigxi3bbUVn17w69/q7GDGKk
         O7GZifxuCGO9uWlsZ1N+8TokjlmT5FbROwl171ok9NAZ3gAK3H+w8nUdJe/98AbDyQV1
         qsbxIvfLyZBb8kfI4cQoMrrQJaUdnL8X4JsEU/j0+/ds+YD1SkoKarQoazTsxGhTIM6p
         hFgMnpNCqkpIzXeKH8rUVGNu72YJwkkbVSekwBoHiV/WtXuQOkH/a7nIH/mRCNiULyZn
         ClsqL+vmHmLTCr+BnCXzc2IGP+ssDcnUU6eute3NNQBCwwuY/6sD/FwfIzzmbD6Yy6HX
         bqTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBWEy4x/u6iy5y4jmoDx8Pinv23hsivG/UT61qx2e+WxNHbP2s8SxP78DvdR+p/BoGzxi2dHCPY9DqKTs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k1DqqyAZCChwtljFsk6I9O11psw1i7FFSQnh5oPcrPbWqcl8je
	KBSyO+iyzPccxouNm+C1sd67SeVkvYfA7RBbQiRdPdoLASKTUcZxZA8u
X-Gm-Gg: AYBFou2eW/fi2DEsk3xbh+pPQbBp2Vfyh/q7SGfVqXmZtykGc7DHj7S83hKiNrV/b1j
	id/9VyPWkujhwzBecFyIJbmAX9gSWxn1cDmNb60UJr4SNayOtTlAS4z3/T7y0iVWiU+BNspIjtc
	vgAw1yMWH/G57/o7CLs15Dkf8iTPU6GJr4Ucfsl+UyLTtrAMpdqinQgei0/LSi4DGVNB+N+t4Ak
	jvpbPFwGh/SJky2i70qom1NTmxUiQDmcGYz8i9NS6dR60fPQTvgbC+p9aXD0VuVeIs0NkejdZlc
	lvVfxnCkpH0Wf8xfw1aFgJZFEnLPzpOj3nSILTzO7uVBZpkJOaWi2/6Dykvnc02UmXIJ+zYWmue
	u12BH06Xj3giO9wSzA7x0IDd1PRv1SWow2et9/WnMWeRwPuvUvhjLUA5fracfm2wxyEP1+Yw/3n
	nlnwIKtDOmoPz/0ln+XvsGhEbgh4mK1+cmd4S/gNPz6L080UrfXBvttV2SI+6eI0o2LFYX3gRyx
	gOlL3ZQ6cegmNV4ZK64kaIm7mePhTczAqRhEeJXa6TmPD+cszq8meqXKYHR5twt2POAwq7oy3m6
	MA==
X-Received: by 2002:a05:600c:1c21:b0:4a0:2dd:7573 with SMTP id 5b1f17b1804b1-4a002dd77demr29968615e9.33.1790528127654;
        Sun, 27 Sep 2026 09:55:27 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:27 -0700 (PDT)
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
Subject: [PATCH RFC v2 4/5] PCI: pciehp: Report surprise removal from pciehp_isr()
Date: Sun, 27 Sep 2026 16:54:57 +0000
Message-ID: <20260927165459.829900-5-abhinjoses@gmail.com>
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

A surprise removal during a safe removal cannot be reported: the
removal blocks waiting on a device interrupt or status read, and the
single-threaded IRQ thread is itself executing that removal, so it
cannot report that the device is gone. The removal hangs.

The hardirq handler pciehp_isr() still runs while the IRQ thread is
blocked, so it can report the disconnect. However, pciehp_ist()
deliberately ignores link and presence changes caused by a Secondary
Bus Reset or Downstream Port Containment, where the device is only
temporarily inaccessible. Distinguishing those normally requires
waiting for the SBR or DPC to conclude, which takes seconds and is not
possible in hardirq context.

Schedule a work item from pciehp_isr() when a PDC or DLLSC event
arrives and neither Presence Detect State nor Data Link Layer Link
Active indicates that a card is present.
This provides us a pathway to wait/block/sleep as we will not be
in pciehp_isr().

In pciehp_disconnect_work(), wait for the DPC recovery or SBR to complete
before checking presence and not consume the link change flags, so that
pciehp_ist() can still see them and ignore the link change if it was
caused by a DPC or SBR. Even after the DPC or SBR has completed, if the
device is really gone then pciehp_disconnect_work() will see that and
report the surprise removal. Like pciehp_ist(), it holds a runtime PM
reference on the port and checks presence under reset_lock, since a
slot reset may make Presence Detect State and Link Active flap.

Link: https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
Assisted-by: LLM

---
Changes since RFC v1:
- Drop schedule_notification_work(). pci_dev_set_disconnected() schedules
  the driver's disconnect_work again, as in patch 1, for all callers, and
  pciehp_disconnect_work() calls it through pci_walk_bus(). (Michael)
- Return early from pciehp_disconnect_work() if pending_events is zero.
  pciehp_ist() has then already taken the events and handles them itself.
  (Sashiko)
- Treat a read error of the presence check as "not present", both when
  scheduling the work in pciehp_isr() and when checking presence in
  pciehp_disconnect_work(). (Sashiko)
- Check presence with pciehp_card_present_or_link_active(), as
  pciehp_ist() does, so that a port with Presence Detect State hardwired
  to zero is not mistaken for an empty slot.
- In pciehp_isr(), check presence before dropping the runtime PM
  reference on the port's parent.  In pciehp_disconnect_work(), take a
  runtime PM reference and check presence under reset_lock.
- Don't call the spurious link change test from pciehp_disconnect_work().
  It consumes the one-shot flags PCI_DPC_RECOVERED and PCI_LINK_CHANGED,
  so pciehp_ist() could miss them and tear down a device that was only
  reset. Await DPC recovery and Secondary Bus Reset with the new
  pci_dpc_wait_recovery() and pci_hp_wait_link_change() (patches 2 and 3)
  instead, without consuming the flags. pciehp_is_spurious_link_change()
  is dropped and pciehp_ist() is unchanged. (Sashiko)

RFC v1: https://lore.kernel.org/all/20260905183905.997833-3-abhinjoses@gmail.com/
Michael's review: https://lore.kernel.org/all/20260912115420-mutt-send-email-mst@kernel.org/
Sashiko review: https://lore.kernel.org/all/20260905185217.E9BC21F00A3A@smtp.kernel.org/
---
 drivers/pci/hotplug/pciehp.h     |  1 +
 drivers/pci/hotplug/pciehp_hpc.c | 67 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb2..c8ceb9320e2e9 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -116,6 +116,7 @@ struct controller {
 	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
+	struct work_struct disconnect_work;
 };
 
 /**
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb44..470cc16d4a828 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -620,12 +620,64 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
 	up_read(&ctrl->reset_lock);
 }
 
+/*
+ * Workaround to not wait in the isr.
+ */
+static void pciehp_disconnect_work(struct work_struct *work)
+{
+	struct pci_bus *bus;
+	struct controller *ctrl = container_of(work, struct controller,
+					       disconnect_work);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u32 events;
+	int present;
+
+	events = atomic_read(&ctrl->pending_events);
+
+	/*
+	 * Zero means pciehp_ist() has already consumed the events with
+	 * atomic_xchg() and is handling them itself, with the full event
+	 * mask available for the spurious link change test.  Leave it to
+	 * the IRQ thread: acting here would override its decision, and a
+	 * zero carries no information about the device.
+	 *
+	 * The events only stay pending for us when the IRQ thread is
+	 * blocked and cannot drain them, e.g. in pciehp_unconfigure_device()
+	 * during a safe removal.  That is the case this work item exists
+	 * for.
+	 */
+	if (!events)
+		return;
+
+	pci_config_pm_runtime_get(pdev);
+
+	/* Wait for DPC recovery or a SBR to complete */
+	pci_dpc_wait_recovery(pdev);
+	pci_hp_wait_link_change(pdev);
+
+	/* Presence Detect State and Link Active may flap during a slot reset */
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
+	present = pciehp_card_present_or_link_active(ctrl);
+	up_read(&ctrl->reset_lock);
+
+	pci_config_pm_runtime_put(pdev);
+
+	bus = ctrl->pcie->port->subordinate;
+
+	/* The card may have returned */
+	if (!bus || present > 0)
+		return;
+
+	pci_walk_bus(bus, pci_dev_set_disconnected, NULL);
+}
+
 static irqreturn_t pciehp_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	struct device *parent = pdev->dev.parent;
 	u16 status, events = 0;
+	int present = 1;
 
 	/*
 	 * Interrupts only occur in D3hot or shallower and only if enabled
@@ -697,6 +749,14 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	}
 
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
+
+	/*
+	 * Check presence while the port is kept accessible.  This may race
+	 * with a slot reset, so pciehp_disconnect_work() checks again.
+	 */
+	if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
+		present = pciehp_card_present_or_link_active(ctrl);
+
 	if (parent)
 		pm_runtime_put(parent);
 
@@ -722,6 +782,11 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
+
+	/* The card may be gone, let process context decide */
+	if (present <= 0)
+		schedule_work(&ctrl->disconnect_work);
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -1036,6 +1101,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
 	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
+	INIT_WORK(&ctrl->disconnect_work, pciehp_disconnect_work);
 	dbg_ctrl(ctrl);
 
 	down_read(&pci_bus_sem);
@@ -1096,6 +1162,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 void pciehp_release_ctrl(struct controller *ctrl)
 {
 	cancel_delayed_work_sync(&ctrl->button_work);
+	cancel_work_sync(&ctrl->disconnect_work);
 	kfree(ctrl);
 }
 
-- 
2.51.1


