Return-Path: <linuxppc-dev+bounces-28328-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC96C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:53:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBrQ2Hzjz2yMn;
	Mon, 28 Sep 2026 03:53:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790531534;
	cv=none; b=JifXc41n+L/cbgcoWMtHcUqDnnfvL1l/yORaQ917o+ANBy0jVk2ENg+CScV9CI0GDSDIk6sNeq0AmbgPXgwF1zBPFXIqiIC9S/smt43P5g5YWN3JhQVAcFxVyJFi93orJ/REjWMRQ+XWQ2ppbBRrEKGIe2GTwLB6c4eDsUtH/DdypMsWGl9RQA+teqU/GRAJ13nUyZEZon4CFvd4psrOjHEH+wGelpPWRxGw6txNwOA9IbMk9ZncdbpnHp0i5a/F+pG5fObJKc88mSRDtEUepjHIijAMPwrvn76aBYE8+q+RyISZ7JWBZ8WR8VeZKuAKwnYDqap1WCgicQBFwb1Chg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790531534; c=relaxed/relaxed;
	bh=A69PJQ7Nmi5xcTUI4BotLtqEyRQMpUL1rHDBHvcBg3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdhl8b67Blam9RwR4fq9acPZw8EfJxZnm/rN0SNqi4TTWGvjsxd1xKyNKTMCbfgrJPYqKhT20DMrL7EyRvogSM33DAFSsiiQ7nnATszy46k8lvoWbSVwCaGjctGuWjW56hSqlcgjnj7VFsIkX0ZKG+d2bIAvVZd4xUoUGb0EEnsTj5YPFPrAbvK/Z9Vb3wda7Fl7oWe9GG2shuRxRIlddbb/hNdFsqeESLmdr6rXZI8zsA2HsbKpbhpiwLnZg/uINaWGBXGkN8+YfvjxK/2PAVaS/BxVbtGu8STsRmxAt6e5+cr0J3Eq8aaRhm2/t3qf8EoHzAopOMLmvxcEdN1Piw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=og+dbLfI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=og+dbLfI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htBph61CJz30WT
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:52:12 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so5095605e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531529; x=1791136329; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A69PJQ7Nmi5xcTUI4BotLtqEyRQMpUL1rHDBHvcBg3M=;
        b=og+dbLfI0X8WdjILz3M72c9dHii4A2Z8DS+aLJqb7QsG6AXSj1n9irfiAT5FlqnFoA
         ceWH8HVkdV1HK5ojsQh1s11qiq6mpWTGHRZqBRWR26nEKIl7aIfMxaqnjxUX5GWGBQpF
         9O87o2WJ3909Lc2jWQaORiUgFIwz1YdISei5suP59WYhJiIlQaIgp7BIB5v9f48P6kX+
         QBh9PvW8TQVIRFBz9Dm16n/UUIRkPty8OObgwaVKBxJRoGlZM4NQha1DWSA1DiJK1Wcr
         Xo4toKDALJg5kc8ZbIszmVQFtJn93lO+PctPWRcOeR0CMAhsFBlJAqfuzWurTeiOxHUO
         0aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531529; x=1791136329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A69PJQ7Nmi5xcTUI4BotLtqEyRQMpUL1rHDBHvcBg3M=;
        b=LLmSxLHgDiMYihJ935+Sv3tbVvNk4VxEcZ6J8e7HYTCeQ3L8rSg0ydOEwtmg7rwAdW
         IuIM8VSd9xePXoO3yToVXQKg+IzzQnuYrpaIrCGRuftwBGO8vQLxDigzwql0TGrLhQJK
         PKhAj7EpyQcI+kTUJwkkuxlCB5rysIMy78Kh1yBWzUvU0q8LHaJk8sK85IGOVOPC4sxe
         HRk4wLneUNyH/qhn1bhFXY1tifs5JbYrC6fpo4o7duQZEgoi6aLLxsmeMU/14iaWNbO2
         Ef+I3sJ64Sr9X+g2eiNE33eAdRK3uaPzNbQDpA/OGMcL9+rzbQ2gVQvAKjZDVJ7MY/G2
         8EUw==
X-Forwarded-Encrypted: i=1; AKwUvBwtF9yGKo6Lhhs6Hm1UeJptM374f7pj+C7qxLz+UWkWoGQSxLXWdkQfY5m8Q3CcwGrMapXBlsalNlAh6qQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kbrOb6rdynWqOUQK6YFBLIW5/nirKUCbEDc/aipEaT9HNohG6Y
	JbTs8qdb2SONUANeFmpsZS/7xK4v1BkMw3FC1uFPoPsQlLPW9zCNaS5tkF74/l+w
X-Gm-Gg: AYBFou1qjoBFbZaY3vEIKYxhVtf76P1GJjujJoYpfFAo2A9y5Dd6Z44lfTaKYsBOxVX
	0u0Bs1nXh4LiZTIU0HMWH8/XSvL+9euN+dWkojajjGKe6C6nJcSl2RY2/gsBtcsyn4lMDJFRnpv
	h32eKnCjWtP8mYOLpe3+HJ4U1xYwkx4V0SivMyH4F7MLKA5aV2ziJWxPkbujihJBg+6wuEeKi6o
	LW70/n3YzxeFRAgzD2aLLMEIWYZmpuUTWjjwzQmB9UakpXIdYbzvdDcjjk+5dFOUHpX/8Y5BL1+
	iWyzEsbhTThseoCEpEjpIXWVIP+26s4QWUMWSSXvVrltBy8ISBc6TbTB2ynDkGJFiMdSdbsIiUp
	Q2Vx7glIEOwImQGKXS6TTfPwZ+nDR5SJzIT16QdOvHNVth7pXTOVlh76/dGuSm+3pjtIwlIpyPd
	F8D/TEjC0s9Se0I3xBwe/2C8LOY2PWuuuQfw2+6pBlvjKmubHLn5NiXUQPcOyfcAXfsw5tPZr1I
	R32lMrwn3PdwYx9g4+BnSHFobezNix7rvdVPq7G0glBJrkDE+Toee9RgzTRbm2x7ek=
X-Received: by 2002:a05:600c:19c9:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-49fe7ae84a9mr187353025e9.0.1790531529031;
        Sun, 27 Sep 2026 10:52:09 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcc4sm22563923f8f.1.2026.09.27.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:52:08 -0700 (PDT)
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
Subject: [PATCH RFC v3 0/5] PCI: pciehp: Report surprise removal during safe removal
Date: Sun, 27 Sep 2026 17:51:57 +0000
Message-ID: <20260927175203.928270-1-abhinjoses@gmail.com>
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
 drivers/misc/edu_srpoc.c               | 171 +++++++++++++++++++++++++
 drivers/pci/hotplug/pci_hotplug_core.c |  21 ++-
 drivers/pci/hotplug/pciehp.h           |   1 +
 drivers/pci/hotplug/pciehp_hpc.c       |  67 ++++++++++
 drivers/pci/pci.h                      |  10 ++
 drivers/pci/pcie/dpc.c                 |  54 ++++++--
 drivers/pci/probe.c                    |   1 +
 include/linux/pci.h                    |  57 +++++++++
 10 files changed, 380 insertions(+), 14 deletions(-)
 create mode 100644 drivers/misc/edu_srpoc.c


base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
--
2.51.1


