Return-Path: <linuxppc-dev+bounces-29321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B274CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:59:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3Rbd6g1Wz30hC;
	Tue, 13 Oct 2026 05:59:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791831581;
	cv=none; b=ZB4tVqwWy09ArLFtAMetbmW48sZygjwjQwMIh+lEYLI383wLNYvQlZyRjVTjkyZX7gGIru6HOZkCq62jD8n3ZCPgKbVZy+HhugaUgei3sKi/3RX62vjOXoxmgbS0F/Ch2tpYB5S2x2711VAJLTCQTSpS/Nk2QoEtz6IDeCylpkxRab6RVZnrZJJjp0F3KQBDxbAOkppZ7UuhxGy6HFgIL9BiWLv1Gx6aC+TO+vORi+67oJGKyRriUWu973F16jetbuEuHIuwJWhLzsxy0qx3DYnQPR/cHBptPz2R5AR2CUDQTBbkwVeMCCztiTo5zQyUFRiBGMOUCfOrELCrrps4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791831581; c=relaxed/relaxed;
	bh=YHE/SGYcUV1OUJwt26eXa2xg6GrIMfRUdwuOqUARZ48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgofYZOPRozfN5QaXHImT6D42JEVQiHRsgMAxppb+VZPF40Wr7Chs9+mwnHCVthwGWvg59npJrj4tuFD9+9KL+vV4v1+/tFd2xO6/AQYb1i25M0TCKR3c6aLfUhe2ZIETNfAO+aCaFiA2AHzggMr1sXg8q02TePcCo6E47KvX4X+MPaYaol/HCyMEGu2fftCjVGttxDV+S3rg11VJl/CK9JsqIgoZXdcgztkJQNssamFzXbxGZ2Paa7ffcj/fSs3Wy1EF3XQwTbnc8cW0LE81xlLr/EWDRH7gHtH/+7vlLOCONGu7ET/QhCcn8sh3xKJC1wBOpdZWvTikruFqAYF6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M78lF7zK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M78lF7zK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3Rbc1mnZz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:59:39 +1100 (AEDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-48b060ec084so1364623f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791831577; x=1792436377; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YHE/SGYcUV1OUJwt26eXa2xg6GrIMfRUdwuOqUARZ48=;
        b=M78lF7zKAdUB9KgZ/4baDQM8sa/8nXuBtGbKlo4ExhplLFSzjhYbpaDKBXKGsbGs2+
         e6mH3+Qlsi5tM4HskMgUorykiNwChxiA0+WRGpvwoDtna5/IzdxJlQtT8tUcMyhUbg5X
         KW7N85TzFoDHQBvbDDSIIlEmDfoYc2yh7Za8Yby5N4dlwv/nPmVmd9gTJlpZvvDoMopM
         SuZuLA36v2kVK3slN5BZMWWF1M4v5XBGwsWjLEdxds0nxeELmw+UWWQ7nEjd/tFytU/p
         vHxrfIwfL+sF8K7gUTsLH9f+Is2a3ViHenwLCzXjUjMw1BXApgyIsasvqPf9KlpWSv99
         n1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831577; x=1792436377;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YHE/SGYcUV1OUJwt26eXa2xg6GrIMfRUdwuOqUARZ48=;
        b=Q6uC7l5WwOHyjMKzBuWMQw4Qaa2E0YTMRQs2CrA1aRM2Fnsx7Tc78aUb16qVTUKTTt
         3DhU7+qVKTDVtMGTPHTqfiLETKWiNta2NWcmCPkSy/OGXLRPZh6pDdEsy44+SpjhSJup
         MpxND17pOzTENW/Xs/hP3ARS2Wfd4kTdH65/J7hc0I0Hfqmb6uQDvChem1uzIEfMzKnQ
         mD8I/g7PPgB1Bpnw2zRX8ar2O5MAwX8h2FJf6NBI7YWiO+zA2viYn1Hh/TtPk54zTEup
         uEep19SUJnVI09iLkxffUOzSn/BSDblo8OWl2Z4MYTQX6qdPDe2liUy5K1lrwy161TYp
         2lgg==
X-Forwarded-Encrypted: i=1; AKwUvByyi2Oj25oRPrHPxHicIQm/rljWAStakm787Yz8xXSos6m76U8ZfAPvu4uCeWzmlhyuMbMbpGuw3lXmosw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJG3NffyMeY6LSAwccYEN2hPpr1VVEOUMlEOecuGQYfC+/ESTm7
	v38iPGfby8JlcMgFPqkiiJ7uSd2bhaojgKQHFpvsMthEB5ygjTKO2CRC
X-Gm-Gg: AYBFou2UFpEGdAASSg1SyDwngSR0Ppmgj0/ThFBD7247JD/Y+RW9Ltnzgv/MSnakMxZ
	sXnPL4IFcVrSYVP+E5X4dyaWlWzL9eeaWzfTo3e3S2OTFpo/BcmxqcrHIjD/hkOvtggdtD7eZa1
	6r/tTcBci1UZ/PR/4doUKDQkEAwCgbe3TDFHKTLrINrm0C6Zgo50NAxscqzZN81s1MyvbV7BmiM
	K+h0KjCOAlLVJ/mIz+ms9Ut03bTnJTacd/zxoxq9i+mZZvhbmLnNclDLWoNyEy4vOGIe9r/JhXq
	7FGD3j0xFN4w/14IP0nBP0fOL5zSUR1kxDKdnxpFs3q/Lxwx7DhHTub3wCd5LONvqs1s25WIfrf
	LbL1aFa4RbUchoski827waG7x4nLKY7R4eWOP9Sm4eH5V76xEcmJS5R6FHiw2KoCYEN9vu85SKU
	0lMYWalBuPFmhDmZW0JihOyJffeAqwqN/myNuC5j6umUEAshxTo+uwTdZuNpo3BNnGUly445v/g
	q0KduLlWTFO3Iql0t4jv93JC4kjq2x8LrymBiEFakcyyH1UXcQG/JJJb7za0NPRIQ==
X-Received: by 2002:a05:6000:4818:b0:48a:ffcc:5b50 with SMTP id ffacd0b85a97d-48dbace8c04mr18035952f8f.40.1791831576447;
        Mon, 12 Oct 2026 11:59:36 -0700 (PDT)
Received: from home-desktop (dynamic-002-214-019-128.2.214.pool.telefonica.de. [2.214.19.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5262sm871105f8f.22.2026.10.12.11.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:59:36 -0700 (PDT)
Date: Mon, 12 Oct 2026 20:59:33 +0200
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v4 0/5] PCI: pciehp: Report surprise removal during
 safe removal
Message-ID: <as0uFfzw83f9aPpn@home-desktop>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
 <asxylqif72Lcldx1@home-desktop>
 <20261012022556-mutt-send-email-mst@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012022556-mutt-send-email-mst@kernel.org>

On Mon, Oct 12, 2026 at 02:32:02AM -0400, Michael S. Tsirkin wrote:
> On Mon, Oct 12, 2026 at 07:39:34AM +0200, Abhin Parekadan Jose wrote:
> > Gentle ping on this RFC.
> >
> > Lukas, Bjorn, could you let me know whether the general direction is
> > acceptable before I work on a non-RFC version? Any comments on the
> > approach would help.
> >
> > Thanks,
> > Abhin
>
> I'd say, complete the picture. acpi,shpc,polling...

Ok.

>
> Maybe think about how this interacts with pci_ignore_hotplug
> (seems to weirdly check presence then ignore)?

Yeah, the order is wrong in v4. The presence read should come after
the `ignore_hotplug` check. Will fix.
(Need to still find out why this was introduced. Looks like only the GPU drivers
use it.)

>
> And test with virtio not with edu.

Bjorn had asked me to keep this puerly PCI[1], So I had decoupled it from the
virtio changes. I could post another series with those changes with a dependecy
to this series.

[1] https://lore.kernel.org/all/20260826194815.GA1552818@bhelgaas/

>
> > On Sun, Sep 27, 2026 at 06:20:11PM +0000, Abhin Parekadan Jose wrote:
> > > If a safe removal is already in progress when the device is surprise
> > > removed, pciehp cannot report the disconnect [1]. The removal blocks
> > > waiting on a device interrupt or status read, and pciehp's IRQ thread is
> > > single-threaded and is itself executing that removal, so it never runs
> > > again to report the device gone. The removal hangs indefinitely.
> > >
> > > pciehp_isr() does run while the IRQ thread is blocked, but pciehp_ist()
> > > must ignore link and presence changes caused by Secondary Bus Reset or
> > > DPC, and telling those apart takes seconds which cannot be spent in
> > > hardirq.
> > >
> > > Patch 4 does not do that work in hardirq. pciehp_isr() only checks
> > > whether the card is present or the link is active, and defers the rest
> > > to a work item in process context. The work item does not need to know
> > > why the link changed, only whether the card is gone: it waits for DPC
> > > recovery or a Secondary Bus Reset in progress to complete, then checks
> > > again under reset_lock, and if the card is absent and the link is down
> > > marks the devices below disconnected, which schedules the driver's
> > > disconnect work from patch 1. pciehp_ist() is unchanged and
> > > remains the only consumer of the one-shot flags PCI_DPC_RECOVERED and
> > > PCI_LINK_CHANGED, which tell it whether a link change can be ignored.
> > >
> > > Patches:
> > >
> > >   1/5 Michael's "PCI: Report surprise removal event" from his RFC v5,
> > >       which adds disconnect_work_enable and pdev->disconnect_work.
> > >       Changed to serialize disconnect_work_enable with a per-device
> > >       spinlock.
> > >
> > >   2/5 Add pci_hp_wait_link_change(), which awaits a Secondary Bus Reset
> > >       in progress without consuming PCI_LINK_CHANGED.
> > >
> > >   3/5 Add pci_dpc_wait_recovery(), which awaits DPC recovery without
> > >       consuming PCI_DPC_RECOVERED.
> > >
> > >   4/5 The pciehp change. Adds disconnect_work to struct controller,
> > >       scheduled from pciehp_isr() on PDC or DLLSC when neither Presence
> > >       Detect State nor Data Link Layer Link Active indicates a card.
>
>
> how about including the virtio patch? seems more relevant than
> fooling around with edu.
>
> > >   5/5 A POC driver for the QEMU edu device that blocks in remove()
> > >       waiting for an interrupt, standing in for del_gendisk() stuck in
> > >       blk_mq_freeze_queue_wait(). Not for merge -- included so the
> > >       hang can be reproduced.
> > >
> > > Changes since RFC v3 [5]:
> > >
> > >   - 5/5: Reinitialize the completion in remove() before requesting the
> > >     delayed interrupt, so that an earlier completion cannot let remove()
> > >     return while the interrupt is still pending. (Sashiko)
> > >   - 1/5 to 4/5: No changes.
> > >
> > > Changes since RFC v2 [4]:
> > >
> > >   - 1/5: Protect disconnect_work_enable with a per-device spinlock, held
> > >     while testing it and scheduling the work, instead of lockless
> > >     accesses and barriers.  pci_dev_set_disconnected() could otherwise
> > >     test the flag, get preempted, and queue the work while a newly bound
> > >     driver re-initializes it.  With the lock, cancel_work_sync() is
> > >     sufficient again, so go back to it from disable_work_sync().
> > >     (Sashiko)
> > >   - 2/5: Test PCI_LINK_CHANGING with test_bit_acquire(), so that the
> > >     caller's subsequent accesses are ordered after the end of the code
> > >     section even if wait_event() returns without sleeping. (Sashiko)
> > >   - 3/5, 4/5, 5/5: No changes.
> > >
> > > Changes since RFC v1 [2]:
> > >
> > >   - 1/5: Use disable_work_sync() instead of cancel_work_sync() in
> > >     pci_clear_disconnect_work(), so that a racing schedule_work() cannot
> > >     queue the work after remove() has returned. (Sashiko)
> > >   - 2/5, 3/5: New.
> > >   - 4/5: Drop schedule_notification_work(); pci_dev_set_disconnected()
> > >     schedules the driver's disconnect work for all callers again.
> > >     (Michael)
> > >   - 4/5: Don't consume PCI_DPC_RECOVERED and PCI_LINK_CHANGED in the
> > >     work item.  In v1 it ran the same spurious link change test as
> > >     pciehp_ist(), and whichever ran first took the flags, so pciehp_ist()
> > >     could tear down a device that was only reset. (Sashiko)
> > >   - 4/5: Check presence with pciehp_card_present_or_link_active() in
> > >     both pciehp_isr() and the work item, as pciehp_ist() does, so that a
> > >     port with Presence Detect State hardwired to zero is not mistaken
> > >     for an empty slot.
> > >   - 4/5: Return early from the work item if pciehp_ist() has already
> > >     taken the pending events, and treat a read error of the presence
> > >     check as "not present". (Sashiko)
> > >   - 4/5: In pciehp_isr(), check presence before dropping the runtime PM
> > >     reference on the port's parent.  In the work item, take a runtime PM
> > >     reference and check presence under reset_lock, since a slot reset
> > >     may make Presence Detect State and Link Active flap.
> > >   - 5/5: Build only with CONFIG_EDU_SRPOC, which depends on PCI; don't
> > >     claim the interrupt when the device reads all ones; clear bus
> > >     mastering on teardown. (Sashiko)
> > >
> > > Testing
> > >
> > > Reproducing this needs QEMU changes, since neither device_del nor the
> > > attention button produces a true surprise removal.  A branch with both
> > > is here [3]:
> > >
> > >   - a delayed-IRQ register on the edu device (BAR0 0x30, write N ms)
> > >   - a pcie_surprise_del monitor command that drops the device and
> > >     generates PDC=1, DLLSC=1, PDS=0
> > >
> > > Both tests use:
> > >
> > >   ./qemu-system-aarch64 -machine virt,gic-version=3 -cpu cortex-a57 \
> > >     -m 512 -smp 2 -kernel Image -initrd initramfs.cpio.gz \
> > >     -device pcie-root-port,id=rp1,chassis=1,slot=1 \
> > >     -device edu,bus=rp1,id=edu0 -append "console=ttyAMA0 rdinit=/init" \
> > >     -nographic -monitor unix:/tmp/qemu-mon.sock,server,nowait
> > >
> > >   and need a guest kernel with CONFIG_EDU_SRPOC=y.
> > >
> > > Test 1 (Hang in remove() on a user thread, then surprise removal):
> > >
> > >   guest# echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove &
> > >   host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock
> > >
> > >   This is the case patch 1 solves on its own: pciehp's IRQ thread is
> > >   free and handles the removal.
> > >
> > > Test 2 (Hang in remove() on pciehp's IRQ thread, then surprise removal):
> > >
> > >   guest# echo 0 > /sys/bus/pci/slots/1/power &
> > >   host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock
> > >
> > >   Without patch 4 the safe removal does not return until the delayed
> > >   interrupt fires 600 s later.  With it,
> > >   pciehp_isr() schedules ctrl->disconnect_work, which marks the device
> > >   disconnected; the POC driver's disconnect work completes the wait and
> > >   remove() proceeds.
> > >
> > > Open questions
> > >
> > >   - Is this a viable approach?
> > >
> > > [1] https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
> > > [2] https://lore.kernel.org/all/20260905183905.997833-1-abhinjoses@gmail.com/
> > > [3] https://gitlab.com/abhinkop/qemu/-/commits/suprise-removal
> > > [4] https://lore.kernel.org/all/20260927165459.829900-1-abhinjoses@gmail.com/
> > > [5] https://lore.kernel.org/all/20260927175203.928270-1-abhinjoses@gmail.com/
> > >
> > > Assisted-by: LLM
> > >
> > > Abhin Parekadan Jose (4):
> > >   PCI: pciehp: Add pci_hp_wait_link_change()
> > >   PCI/DPC: Add pci_dpc_wait_recovery()
> > >   PCI: pciehp: Report surprise removal from pciehp_isr()
> > >   misc: Add edu_srpoc surprise removal POC driver
> > >
> > > Michael S. Tsirkin (1):
> > >   PCI: Report surprise removal event
> > >
> > >  drivers/misc/Kconfig                   |  11 ++
> > >  drivers/misc/Makefile                  |   1 +
> > >  drivers/misc/edu_srpoc.c               | 172 +++++++++++++++++++++++++
> > >  drivers/pci/hotplug/pci_hotplug_core.c |  21 ++-
> > >  drivers/pci/hotplug/pciehp.h           |   1 +
> > >  drivers/pci/hotplug/pciehp_hpc.c       |  67 ++++++++++
> > >  drivers/pci/pci.h                      |  10 ++
> > >  drivers/pci/pcie/dpc.c                 |  54 ++++++--
> > >  drivers/pci/probe.c                    |   1 +
> > >  include/linux/pci.h                    |  57 ++++++++
> > >  10 files changed, 381 insertions(+), 14 deletions(-)
> > >  create mode 100644 drivers/misc/edu_srpoc.c
> > >
> > >
> > > base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
> > > --
> > > 2.51.1
> > >
>

