Return-Path: <linuxppc-dev+bounces-28352-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A57C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 22:19:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htJl13mSJz2ygK;
	Mon, 28 Sep 2026 08:19:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790533232;
	cv=none; b=bTVhOmS853Aajoe3aigUlOjS6bbAyeYfGOKTHNsy/dXlVAe3hrgjQ8MRa1aZBVd3Rp5x4ELl0x43r4gc8hTpM9bDDC42L9HqEUq7//GJeiuowaFQUqTmYrmPTmMxmuj6blN5L7GbvgZGR7TFtiN1dlgvyK9WzHcX/YHDj15OctH5Xhw2i9lm4O5kkY4ZRgUKCu39NpD/EnyZ2VurU/6PJaC6TSISTm5Uj/ut+/ePdAcWm1tQlY1qn9P+eEDiUu0CQOrOpmLKwpiVPWOU8QXh87prhcImWsB6XXaO4N9yPgJD/J6ysoiJ7bPusd3Jwd7wC7zbmwAVq+dp0rq+hu2E8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790533232; c=relaxed/relaxed;
	bh=ym1diEOibk5xps77zZysxQ1bh4AhoR+8AInugu/q9zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSpQ4kr1+u+bRuLKnqZgXEcQOJurO6doqv1YiP7G8M0n770z/O8EWhJm5Kkn2u4LirKZDFqgYxR49uT6KuhGOU0BIg2IXK7gkkm4XX8KsRwtP86gYDif5v9z/r9ffnIoEEkTxrNxHy2+KTDLuv+Xqrp34309AGwg9PWqPm1X8yTbO4mgfFLmOggqEhZtRm1QwnGZ7vZkQLq/nW5PtUVIY6ukG0fCOiNopCU3HeCMMT3doo5XFHLJrQLIzqI82fCBXnGTeurzJEiyDcaQkmUaT15IJDbHMUYtujTD2AlaIKbTYKPXZs9rYxYhW4+OUCCPeHxMvHz5HqIZsCOJEG2AXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G65QS06P; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G65QS06P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htCRM5VDLz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:20:31 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49ff23af865so17283935e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790533229; x=1791138029; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ym1diEOibk5xps77zZysxQ1bh4AhoR+8AInugu/q9zA=;
        b=G65QS06PNnzpgXFNFMhL6V9hQ/LBH+pUsvtQHlRo7kzlYOISRHaj4mi4Gb8QzWxteP
         RQ8QJaXd+lzNv89ZKuMcGxSqlGKUG5SqDWaqf68mO5vxu+mAaOdRIyzif9ctxGdaOkUa
         ZpNO2sbjJ5l6sDOJTKgMCeXPcsTXnsIyEa5MVSIXof+Q6v9uZStlsOrSDhvRL8NM49AF
         IH7xPsAkaO7LIGHxIBHD1gL0sz5gJLAvhnF92Ps6DASVUhoXsXHIhijcqqsVgrszmRai
         2QGwof3t5DxtZjYEM659/bYD1MqaLjtGSaXAfUHnmEimxENORV3g7Tfu8oh7pX2NpOk9
         lsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790533229; x=1791138029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ym1diEOibk5xps77zZysxQ1bh4AhoR+8AInugu/q9zA=;
        b=bw7xVtV82nZBGvUiENR3qd9XQw04+k497zZoo8B025pzsisnFO3SsiUTJ8C2MkAeCl
         gzOfgX3WBpCu0qbPcH0+mHj/8tOmI1Z8B2lsHskQ+v5SDk+Jl+1g1TUdCwbj8FwjhxoE
         i0v6I82Z/meR698gwUlRNoYFZLvwgUL9Qn0Zdvo6r8H/kkGSQ5OL/Xvc+FFXvSz4UfRs
         Mqq9QsPUtfoz5ZqJfpL3vgNnaA55ie7+1oxP6Lie855tRVKTCHfRmE7iU832gorD76kG
         GmnMt7eospNwoEnJf850JSYp0wJvBUlf1M+oqW0BJxOEKgTpNKwlgVE2vQdOq9SBrU7x
         l1kA==
X-Forwarded-Encrypted: i=1; AKwUvBwCTHuXp7uv/lhOmGFqhDGAuSBp7n+gewIZoUio82mWk57lq9UlpuZrGk1S6VcAA1MAe/i9Rfd4bIp64vM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nMlluAOzLASaac1ImOsGzb0KL079gB3pe8WWQCWVxCA3EGAxo+
	cBatt4dcnsZ0+3KpuKtyqN+1SdWOnsAzSOiyNKJ+F/8BaeH3rI1zRMeW
X-Gm-Gg: AYBFou1yHlb2l1+Zp9tGFwz2XIjHhR1pgSHhvOzT6IcY1AkdoW/uC0qmoBjnOah9YF+
	bas1duQeJKitOXv0s8iaQakhhZuPQ7838T/zMS7K4UJuTTBnSkKXrg65IKdmtA//SQdfgbP8yl1
	AKYq+MDBtKt4ZPM7eJJbkDwwFEdf8XmRKEW1ggfXNSWMuBlymBHi6JNwrtfYnv1zLMoZS8WTI1g
	fOm1GrlQzcIWnA9bf7lEYumnzwZvgTFtieKiirZa88i/Fq6TjJWvRszi7FSp685ZYKVBHuVtA2+
	INCu3BhsyKIwS/yBQn8QxBWt4KbwySZhTYNKN+NVcE6H7UXaLavv8Gj9ISoZyeeRjxVwr+Y6y82
	MsPvemzrnWDckUQY0+qfpvPFVildxez8EMGfWwFt88mJ6W8aurthLEMJ79LIcePhTpuNV9B7me+
	UxeB2umD7AaCdFUltFpDAnfMv3JPtLi7S/G4xfy5VSty3JHnj/sibeJkcX4yAy9cejcyNbw47lX
	QcGqetwk7pXT+hzkWNrPL1lWxvoKIQScecDLGKAU8JBj0P8voL8CrvuOi3B5aB1nrQ=
X-Received: by 2002:a05:600c:8b86:b0:49f:ce73:7a9 with SMTP id 5b1f17b1804b1-49fe6701ed1mr198408685e9.34.1790533228572;
        Sun, 27 Sep 2026 11:20:28 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a002d1d8d5sm38371585e9.0.2026.09.27.11.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:20:28 -0700 (PDT)
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
Subject: [PATCH RFC v4 4/5] PCI: pciehp: Report surprise removal from pciehp_isr()
Date: Sun, 27 Sep 2026 18:20:15 +0000
Message-ID: <20260927182017.938565-5-abhinjoses@gmail.com>
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


