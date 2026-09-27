Return-Path: <linuxppc-dev+bounces-28348-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E304C9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 22:19:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htJkW3L3Jz2y24;
	Mon, 28 Sep 2026 08:18:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790533229;
	cv=none; b=HsVf6BxwlDUzpX0FyNVg1MAFONdBbrgWC+0IoJPqo8q/yZPXQBbeNsn7JRXaSv55Q7sp1BGYCqOlzfl9vIXpO612ci8jQAxSadlF0XWivh38ywF99oXs8x/gxJ04LCr85lUkXWDVzvpFJxuB/j32iXxWKswRTswUtFw2Y6aCjezQ3iBjQ187BqWpF8UJ/pygyCcAes0PDCtKO7TZLF6WQQS7E4dF3IrFPohLgVaW/8EXaaacNNzakpCnMe+DxuCegU1PvjTPO/pFLlyt3RDBB+Po3X5w9yQdHAoPDNOtV55cFy1/U519wXqJdjgVANBXRp0XBoGnzWc4TZaFZqRJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790533229; c=relaxed/relaxed;
	bh=8DyMH8xCm6UAOKZ4ziM3bYEXT9IVU4WoapGwh9T8uhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SiSp8FzttjtUgQKRO+H5by4Iv0aHsRDfRWuwnWXGvIO/xpsVhF68F1S0YWzc3tOsjj7JMZq09/I0te26w6euQGzT+YV1Fl3J8c/3386ZraXO2Hw+cxhkr04cKh/crAev3gr4ozbqNihtxA0WtFv+g7o3gf4qdduu5lwve4Scmnj6OPbEV/MX9vYah1ye5Nj742GDGZfJCsFrEZkHRNFYyY0by/SJwhKylQDllsR4UiDJVfjGsqIreQN5pvpGi0lSaUxGfLO3JnTcSDAPy6LdNpZsfXExwXWW3p7Va9z1ticJBy5+7eXbxSUJJ7njctjWxcNL8wCs7O7EELQuhuHSBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j/lpGYeT; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j/lpGYeT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htCRH06l7z2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:20:26 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so8448285e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790533222; x=1791138022; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8DyMH8xCm6UAOKZ4ziM3bYEXT9IVU4WoapGwh9T8uhA=;
        b=j/lpGYeT6NVudaMFROmPcgn0Pell16ero1oPxKa+pUQotwq3iVt7MuwyekjWuwoc/T
         h2Y0RMxBpHXeIonem7VGPcwjSV0bEE4EQF0jo2St4SRpU+IORlVCrBy9xcN0gD41fglp
         fFmQ7ictJLZ8UHRuQWN8HNnikOTkzeoEYmHN5i6ojtqXgNCkhwDkwanrD8Y7R82qzzKs
         BDvScN62qfX4MQIZHeUbrbf9DnwkZtTMegZS7jSCn1RZvFhjfA+1hmYzq+Lue+THaaN+
         hdEDpY6GjTx53Ct7UvjdePGYVmR+QyFshbQYNH18DxTTJ8h5eApaZSifLkCcAlEzDKRn
         356g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790533222; x=1791138022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8DyMH8xCm6UAOKZ4ziM3bYEXT9IVU4WoapGwh9T8uhA=;
        b=CKzHS8sMXwdIBiq5hzxLHjJzRxhiHUUHjr6NMhNO5ZK93HkwW1xJf4qi5+WOBZPo3S
         FrbgQdYA0vPX0VIV4AgPPJecxuCYRT2MPr+0MozzRY5E3q6NVfLpnAo8V3Zxo3B5hXoD
         aMSEzhZHrLftGWWRldxyHJOz0VudXKvcD1V2oqo4z9+ZOU1gG/It+SzwcVo8XiGOZ82a
         EZU58uMA1z5O0fFviDEpmSf8p4xwkZc1e9VtsIK1fIl6SGUCs8GWxrOBRJuj+HzJCot6
         9HWYektnRlzdWfIsn8W0ayHZk3+xhyceD6BdwMwDC7jCRPgOqxKzc5fhyHep/N/tJFaO
         iTrg==
X-Forwarded-Encrypted: i=1; AKwUvBzxAhbTTNMfYdgIYFpfbIj8Dno+K2rnobOpeBDuy8vOMpM5UvSewHuR7dBJg4HddjlIB1dN71GMjTxhppw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lOf0CxL0Qv3/ZplSc6XIXnr3FRaij0M3KfoKXWj1LAZtC6baFi
	JeUjn7LuOTI1u5ghFb98ITHFPPBn9Lo00hQsBK6ePrgz8Bz+P/aYaFRy
X-Gm-Gg: AYBFou3+h27WNAyHYrjigrECPA+pN6PECd7tZ3QKS6TEuvvJOswpqY9MoAoQN3Imv4+
	8sQ4UgQ5aLOURVk7zCKDVora1geGTVHdNjWK3eWma7jA4BVs+3TRzSjC6E5e7LKBhlDGKVwDisI
	plXneHzZQbgwJvrh81I84VSWCOZ5K5IR+Y3PKQAYffwlTTGvDj0l7KUnMns2pGErzGc2wrJY70k
	op5mw4QZ+guKlLkisHqhac7IDYe3bdzk2WOrEWMZ86EhIaE41bGyGFgCON82/UAmlIQG+FXdyXf
	h9bbc3TJ9qY2VgAdcDtGQw27iN4u8+0YoRjduUIognbE5b8wsJOBcQSBZNj/3C4gv5wuDjzJF31
	Q6m8jo3KVPzZKvdJxb18mBgLThmyze26S8vBQqsm8E1KkYg9cgJuHAsAeiATrzkUOlm6xjAcWDb
	ZZerLioJRn6Ye4MuyuMFnPpRxOfTWnWi8iKdkzf73UvEB3w9MQAj9fORz8CUbm0sev93ffEZZQ9
	hpb2NPTFBFm50r7VWskc/s7AVb2s/xSBZN2kVerTmoZHrRkloDZTUENdkktR4r9n9idiGTEKGOr
	Ng==
X-Received: by 2002:a05:600c:4eca:b0:49d:2450:68ac with SMTP id 5b1f17b1804b1-49fe66caac9mr208265845e9.5.1790533222192;
        Sun, 27 Sep 2026 11:20:22 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a002d1d8d5sm38371585e9.0.2026.09.27.11.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:20:21 -0700 (PDT)
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
Subject: [PATCH RFC v4 0/5] PCI: pciehp: Report surprise removal during safe removal
Date: Sun, 27 Sep 2026 18:20:11 +0000
Message-ID: <20260927182017.938565-1-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
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

If a safe removal is already in progress when the device is surprise
removed, pciehp cannot report the disconnect [1]. The removal blocks
waiting on a device interrupt or status read, and pciehp's IRQ thread is
single-threaded and is itself executing that removal, so it never runs
again to report the device gone. The removal hangs indefinitely.

pciehp_isr() does run while the IRQ thread is blocked, but pciehp_ist()
must ignore link and presence changes caused by Secondary Bus Reset or
DPC, and telling those apart takes seconds which cannot be spent in
hardirq.

Patch 4 does not do that work in hardirq. pciehp_isr() only checks
whether the card is present or the link is active, and defers the rest
to a work item in process context. The work item does not need to know
why the link changed, only whether the card is gone: it waits for DPC
recovery or a Secondary Bus Reset in progress to complete, then checks
again under reset_lock, and if the card is absent and the link is down
marks the devices below disconnected, which schedules the driver's
disconnect work from patch 1. pciehp_ist() is unchanged and
remains the only consumer of the one-shot flags PCI_DPC_RECOVERED and
PCI_LINK_CHANGED, which tell it whether a link change can be ignored.

Patches:

  1/5 Michael's "PCI: Report surprise removal event" from his RFC v5,
      which adds disconnect_work_enable and pdev->disconnect_work.
      Changed to serialize disconnect_work_enable with a per-device
      spinlock.

  2/5 Add pci_hp_wait_link_change(), which awaits a Secondary Bus Reset
      in progress without consuming PCI_LINK_CHANGED.

  3/5 Add pci_dpc_wait_recovery(), which awaits DPC recovery without
      consuming PCI_DPC_RECOVERED.

  4/5 The pciehp change. Adds disconnect_work to struct controller,
      scheduled from pciehp_isr() on PDC or DLLSC when neither Presence
      Detect State nor Data Link Layer Link Active indicates a card.

  5/5 A POC driver for the QEMU edu device that blocks in remove()
      waiting for an interrupt, standing in for del_gendisk() stuck in
      blk_mq_freeze_queue_wait(). Not for merge -- included so the
      hang can be reproduced.

Changes since RFC v3 [5]:

  - 5/5: Reinitialize the completion in remove() before requesting the
    delayed interrupt, so that an earlier completion cannot let remove()
    return while the interrupt is still pending. (Sashiko)
  - 1/5 to 4/5: No changes.

Changes since RFC v2 [4]:

  - 1/5: Protect disconnect_work_enable with a per-device spinlock, held
    while testing it and scheduling the work, instead of lockless
    accesses and barriers.  pci_dev_set_disconnected() could otherwise
    test the flag, get preempted, and queue the work while a newly bound
    driver re-initializes it.  With the lock, cancel_work_sync() is
    sufficient again, so go back to it from disable_work_sync().
    (Sashiko)
  - 2/5: Test PCI_LINK_CHANGING with test_bit_acquire(), so that the
    caller's subsequent accesses are ordered after the end of the code
    section even if wait_event() returns without sleeping. (Sashiko)
  - 3/5, 4/5, 5/5: No changes.

Changes since RFC v1 [2]:

  - 1/5: Use disable_work_sync() instead of cancel_work_sync() in
    pci_clear_disconnect_work(), so that a racing schedule_work() cannot
    queue the work after remove() has returned. (Sashiko)
  - 2/5, 3/5: New.
  - 4/5: Drop schedule_notification_work(); pci_dev_set_disconnected()
    schedules the driver's disconnect work for all callers again.
    (Michael)
  - 4/5: Don't consume PCI_DPC_RECOVERED and PCI_LINK_CHANGED in the
    work item.  In v1 it ran the same spurious link change test as
    pciehp_ist(), and whichever ran first took the flags, so pciehp_ist()
    could tear down a device that was only reset. (Sashiko)
  - 4/5: Check presence with pciehp_card_present_or_link_active() in
    both pciehp_isr() and the work item, as pciehp_ist() does, so that a
    port with Presence Detect State hardwired to zero is not mistaken
    for an empty slot.
  - 4/5: Return early from the work item if pciehp_ist() has already
    taken the pending events, and treat a read error of the presence
    check as "not present". (Sashiko)
  - 4/5: In pciehp_isr(), check presence before dropping the runtime PM
    reference on the port's parent.  In the work item, take a runtime PM
    reference and check presence under reset_lock, since a slot reset
    may make Presence Detect State and Link Active flap.
  - 5/5: Build only with CONFIG_EDU_SRPOC, which depends on PCI; don't
    claim the interrupt when the device reads all ones; clear bus
    mastering on teardown. (Sashiko)

Testing

Reproducing this needs QEMU changes, since neither device_del nor the
attention button produces a true surprise removal.  A branch with both
is here [3]:

  - a delayed-IRQ register on the edu device (BAR0 0x30, write N ms)
  - a pcie_surprise_del monitor command that drops the device and
    generates PDC=1, DLLSC=1, PDS=0

Both tests use:

  ./qemu-system-aarch64 -machine virt,gic-version=3 -cpu cortex-a57 \
    -m 512 -smp 2 -kernel Image -initrd initramfs.cpio.gz \
    -device pcie-root-port,id=rp1,chassis=1,slot=1 \
    -device edu,bus=rp1,id=edu0 -append "console=ttyAMA0 rdinit=/init" \
    -nographic -monitor unix:/tmp/qemu-mon.sock,server,nowait

  and need a guest kernel with CONFIG_EDU_SRPOC=y.

Test 1 (Hang in remove() on a user thread, then surprise removal):

  guest# echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove &
  host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock

  This is the case patch 1 solves on its own: pciehp's IRQ thread is
  free and handles the removal.

Test 2 (Hang in remove() on pciehp's IRQ thread, then surprise removal):

  guest# echo 0 > /sys/bus/pci/slots/1/power &
  host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock

  Without patch 4 the safe removal does not return until the delayed
  interrupt fires 600 s later.  With it,
  pciehp_isr() schedules ctrl->disconnect_work, which marks the device
  disconnected; the POC driver's disconnect work completes the wait and
  remove() proceeds.

Open questions

  - Is this a viable approach?

[1] https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
[2] https://lore.kernel.org/all/20260905183905.997833-1-abhinjoses@gmail.com/
[3] https://gitlab.com/abhinkop/qemu/-/commits/suprise-removal
[4] https://lore.kernel.org/all/20260927165459.829900-1-abhinjoses@gmail.com/
[5] https://lore.kernel.org/all/20260927175203.928270-1-abhinjoses@gmail.com/

Assisted-by: LLM

Abhin Parekadan Jose (4):
  PCI: pciehp: Add pci_hp_wait_link_change()
  PCI/DPC: Add pci_dpc_wait_recovery()
  PCI: pciehp: Report surprise removal from pciehp_isr()
  misc: Add edu_srpoc surprise removal POC driver

Michael S. Tsirkin (1):
  PCI: Report surprise removal event

 drivers/misc/Kconfig                   |  11 ++
 drivers/misc/Makefile                  |   1 +
 drivers/misc/edu_srpoc.c               | 172 +++++++++++++++++++++++++
 drivers/pci/hotplug/pci_hotplug_core.c |  21 ++-
 drivers/pci/hotplug/pciehp.h           |   1 +
 drivers/pci/hotplug/pciehp_hpc.c       |  67 ++++++++++
 drivers/pci/pci.h                      |  10 ++
 drivers/pci/pcie/dpc.c                 |  54 ++++++--
 drivers/pci/probe.c                    |   1 +
 include/linux/pci.h                    |  57 ++++++++
 10 files changed, 381 insertions(+), 14 deletions(-)
 create mode 100644 drivers/misc/edu_srpoc.c


base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
--
2.51.1


