Return-Path: <linuxppc-dev+bounces-28322-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429F5C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:51:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBnV2s9Gz2yLY;
	Mon, 28 Sep 2026 03:51:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790528122;
	cv=none; b=lt2SKErBhTjKDBduMpzlB4SGt2uXhsYb8C639r4Y3B51ReqGwxgA/nKdDfCcILpbw1ikinKapJCyH1zRbEq0HRF79aONH+czsELQ1v+SUBctwey50+mM2+Rx7PiPmi6dysT5VwtSAvf3d4FqeNpScRexVlWBKMKmRpfxtdLNj9e+gI6oaqJKmbg9oFW53imMIRo9Vq+8l95qXM8sPG0gMHw+L8bx6MgwYvhYLQ8+n5Qb1BHrrirPNp995Cdx+hwvIf2hsMcF9Ny65DBkgUkc18EM53vS3G8HgM902wr9dK6mByyA2j82KsQLdbK1yCdzhjnWhdBCjhBkPXYS8dtu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790528122; c=relaxed/relaxed;
	bh=Yz1PsHl1EK/dk/I6+GFSPEAqum820kPR3CBi6PfY1Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWsIRbb+kVnSfYlxV4eWG2CHSmqM895GIGpyglvObOy+HO0UDmi6Xx3x7bfZkcrB2yad05XFGlVMBgqOSdfCLM/88YE1hmkFXDFVMZbIM4haDDHFtsJmPJLPD2p9qkWaDTfe/zqXpIn3DqxWzk0HnVEMgEklmwwswUECUuRPWo9W0vEyk2ZnpeXc9kO39tVMfoO6gCC1MbXT43LD5yKtA36Nl0I6JcRG88nmkioGg+xZSk5JjcOJtYGNv5kFgkT0AuyzQpCy6jWluO0viQGJXxk9SLRZttqpHkUwyaXRbbhKwy/paDAobGvFAugin+Q7+ZbwbmoOFwZrERvQXyW6Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b1N9+Zk9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b1N9+Zk9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht9Y36tvjz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 02:55:19 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso25404915e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528111; x=1791132911; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yz1PsHl1EK/dk/I6+GFSPEAqum820kPR3CBi6PfY1Qg=;
        b=b1N9+Zk9AHA6mHxhIDYuvkv0pU6CQdSwAQtg4uM+9nkqErj5ZOzoiLlj8P52jPt32x
         v5M3uNjgk1phVaTV2AxFiDSqpkvU/aF2KljGJVLzIg7cZgA8Md279H8zjKvI6bGoUbtH
         k4Q8yhsxGqofbuMWso3nxTmWhkQMB7C3YH6qpU/kGKojTwLGc5gf/A+VS+sEw2L/5Toc
         0vx9JYR+vQOLOB9LMTYAyoTVLl5QyNJ42VwPd0hCITt0p6piZm2kaaOHxFFXcV0PsG03
         0b99KdqW/kZNHdcK5/cBTWKH375rbeUnLhVWoCjuQ4dnHQ4uz42Scy6s1pleE3+yGJD3
         ZVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528111; x=1791132911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yz1PsHl1EK/dk/I6+GFSPEAqum820kPR3CBi6PfY1Qg=;
        b=i2OVcxrQrSIqP7ExJLkra1AIdAJK39nJGwPRC07rPZsytEl6a3PjXvemw7N+zrlnjt
         5GDdnvN3nxNHzRPtRG1Rzdrwy03xAy5JvXo5xZ0Eez+GTS5Lb09KW6FcV0TMEs54fi5f
         smoY9F6H6B+2HeKcEiHmCfH5NQ4x+R8Ng8r0Jv+RXRkil2OkIWODrxtXFdonk4U3JRcU
         y3fSJSqBd2wOeF1UyY79c6piP4tzaUppv+iJ2d2XmEsZ8bNMpud4hB/430/UP01CrHm/
         PSjFatn5AHYcYNJV0PbLgkFKrSglRUwaeiS/JO980uhP1nL6EEq5dv9BpCUdrT60TS1d
         matA==
X-Forwarded-Encrypted: i=1; AKwUvBwmpgqCDc+rF0ZTrn+nSa14In1SqatBo03CKyKSbsBXOJWXguxRu4cBfVTQFDP4d0y91Z8zaefHO/j4FAQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lbmOO084VbfJY6jsyHFzCAfnmvB0ZvvnaT0epW18pCL/eRX7vs
	7KT8rNl6s4rDEDffaUjUq3D5gMFBzmMhcIPb0AHtssZyh4OXGcNiKAZk
X-Gm-Gg: AYBFou3mavRbbIpEUr3aWCHqsCr+C4ddbVeUAC2T2zz8qwF0+X3EfXj0e09hnuQTNLU
	E2BNdSG6qnDIKjo41eKdVWiatYFnHXR+dV4OcuEQnEOsFx31AYrLmvERFFlYXgFhegG5q8PMvPk
	dQjMbDPd9leTLLRhMw7FP+vZT/dqraYNLMXI3BqQdPtiET2+RvZ5gDT+x+v1qhBWJJoWFkPIute
	r+P90ooXBbCgd5w6GW72Tio/jDIsQgpWDuVpjCl20zkixWj3erQYnG799Lp4yyzFFPRwq8bAa03
	X9Ye1G+YwAK4FaWPSG2DayKqxRSZWkOd9WPqDveClIEyRmq5EBzjrEKd2BY5OS0p0AU+vcPl53w
	feibuwPdqHmWsClp3xYpMBw0/uw+RQTIOerkYsUOme4yLP07hJwWGySdnAIY1t8FOsPbBz4l3yO
	kEGkzDl2B8mrV8eBWybpUmlfq3ejE0dlsbSULYDDAs8tTbL9qMIi6ORYrDlTi5uGPQLZUb9Vd+y
	hy76t1NwkNWvuep7QTNHKO7bIQBhhZTnjUZuwuU1O7UUBFrfdc2YcGKoyG3t3L929FwHISToDPJ
	RA==
X-Received: by 2002:a05:600c:5492:b0:49f:ffd0:4039 with SMTP id 5b1f17b1804b1-49fffd04049mr56203615e9.32.1790528110862;
        Sun, 27 Sep 2026 09:55:10 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:09 -0700 (PDT)
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
Subject: [PATCH RFC v2 0/5] PCI: pciehp: Report surprise removal during safe removal
Date: Sun, 27 Sep 2026 16:54:53 +0000
Message-ID: <20260927165459.829900-1-abhinjoses@gmail.com>
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
      Changed to use disable_work_sync() on teardown.

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
 drivers/pci/pci.h                      |   9 ++
 drivers/pci/pcie/dpc.c                 |  54 ++++++--
 include/linux/pci.h                    |  46 +++++++
 9 files changed, 367 insertions(+), 14 deletions(-)
 create mode 100644 drivers/misc/edu_srpoc.c


base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
--
2.51.1


