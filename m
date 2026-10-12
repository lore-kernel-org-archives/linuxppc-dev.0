Return-Path: <linuxppc-dev+bounces-29332-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15844CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:29:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3Tb24MSCz30RN;
	Tue, 13 Oct 2026 07:29:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791836958;
	cv=none; b=iXs882JLcIRKsoknAQQRlpxeZYDI+lgGTA7YbDewZKxjNR27NmLJLThlNmUznd6vHSq6nmnnahPUIYiVv/WOENSwHeU2UP2qseNe9EHhX70TP5OIcj4rPZuaIvpNKoANLKJAnHDAn6YFOMoLPz88ZGiyEsWeEMzI3IBeRc/vCmQfo+WsNiW4oTZNKj9kb6ctImCEa3krTSG/IvHJWpZZU/Prl3K1MCkW/s7KfInktQcf41XJziSG/XqBATa2Goi81djpPAqSMEvauqklX4xCqvgRN5+7M35048vF9CKrzx8J9k9QEczEjyUs0nwt3xf2J2LoFFysSZvBYOIFbvbHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791836958; c=relaxed/relaxed;
	bh=Q7xPBIsF6msFjcBPFQV3z4MewG9jXZq7/+SDCBWWB/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lc2GsM2kyGLqReoN/HRUidy9JZxCdfHntxiIk8V9OnuE3vl3SazZDpA8cvA6FcoIcJUPO7dh5s7wKzt+HGCamuPSYL+qf3VVTiOh0JJ6b1umkNf/8QJqd/IGzrEjKVww6mc3BX56xC8cKFzAOUkh0/yeUFwGhSvnBJxr+VglsDWuX6fKtuz/g28OGV3nB1uwctoODAOw0wv0TXVhhs6BJLJpkAlV2jmP9rpkJZuGjoq5OBoMT+r/qsATKI4brLj1/TkI0FDXvmvBJ7lrY2VJjykKsBldUi9JymmiircXJ+wXysdMdtlH42EvZFPIDxJUs7K+hKhYVNcq2PjL0HDWTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B83nw9M7; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B83nw9M7; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B83nw9M7; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B83nw9M7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B83nw9M7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B83nw9M7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3TZy6W0Wz304Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 07:29:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791836945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7xPBIsF6msFjcBPFQV3z4MewG9jXZq7/+SDCBWWB/g=;
	b=B83nw9M7c7a25vJRV8iJ3NQmCOVd5pAb8CdCQsKMMJBKuJHGNGxN1vDeoJw3267N9gIxG6
	jrBGqQbehjK+8VfPGshxFvedhvzd1kJA0qpXqbK5Zbyl2WPxodWSHnaYEY2UY9Q3f0jk9T
	8/zzDRzJfZkybwMXxiWBICkvYRUyciM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791836945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7xPBIsF6msFjcBPFQV3z4MewG9jXZq7/+SDCBWWB/g=;
	b=B83nw9M7c7a25vJRV8iJ3NQmCOVd5pAb8CdCQsKMMJBKuJHGNGxN1vDeoJw3267N9gIxG6
	jrBGqQbehjK+8VfPGshxFvedhvzd1kJA0qpXqbK5Zbyl2WPxodWSHnaYEY2UY9Q3f0jk9T
	8/zzDRzJfZkybwMXxiWBICkvYRUyciM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791836945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7xPBIsF6msFjcBPFQV3z4MewG9jXZq7/+SDCBWWB/g=;
	b=B83nw9M7c7a25vJRV8iJ3NQmCOVd5pAb8CdCQsKMMJBKuJHGNGxN1vDeoJw3267N9gIxG6
	jrBGqQbehjK+8VfPGshxFvedhvzd1kJA0qpXqbK5Zbyl2WPxodWSHnaYEY2UY9Q3f0jk9T
	8/zzDRzJfZkybwMXxiWBICkvYRUyciM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-zyWjsyzeM3amhgWsv6iTXw-1; Mon, 12 Oct 2026 20:29:02 +0000
X-MC-Unique: zyWjsyzeM3amhgWsv6iTXw-1
X-Mimecast-MFC-AGG-ID: zyWjsyzeM3amhgWsv6iTXw_1791836941
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso1743381f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 13:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836941; x=1792441741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7xPBIsF6msFjcBPFQV3z4MewG9jXZq7/+SDCBWWB/g=;
        b=GRQTrt1RZjcX+W2vgK4R2geAIY91ezgv5Lc3Z6lebhSKB86fR4c15KRB0XaEPUdG0j
         SR2CBKO28tcMq3tX5dVcGaLwjDLOeOcPtINaIbUkpZ27ztpzkMGNf0mkr86Qx2JRvuIc
         8eX/EyZ4JYZmHDidsnOx42Wp1cooH6WeJ7ItN9THkFoQVa058Ln8rwS/UZtQtqWNsi7t
         BbHPlDgdEAKqWJ75nkiLkmLr6CeGLh2RT+PIQPGsbgXVU3GljALV8Hvecx2utOqPMosi
         ks4b+XO8ogrKI4se+H7fxJoW2hJuY4LXzM3jDhVRfkH50rUQkYUSgfihcLMATguqR4g8
         ciQg==
X-Forwarded-Encrypted: i=1; AKwUvBykoXYaJ4KM6+x0cHbL0QKdsbEPB4zU2+N62q91XGVztGJYDz7rjrE32WlRE6TtE4oihcdF4ab6vmd6rm8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI+EALS8TOnUDeQ/G2bqgqY/ywxN2ZP1UYALebQZVLRY++q6+RQ
	amIKNDCq9pbCSVqRq3gyFSPXQPFYdEP6Q2hkJ5sRvR7xxX6Xpzxo6WNvO0yrE91P+ULZ05D6lUS
	ok/LA2Xub1xUL0V0OKO6TO7hlWv3M84Nt+wE+z+sf2ckpTGx+Pc7KgE/2wc4knwDqPe8=
X-Gm-Gg: AYBFou00n8tzj/9x29ntRHd39sls6b7ZGB3Ud7VJ/D+VBLTGVQLzUPd+APS0O9i1dGt
	Fcx9eq1aX97fTgifCNr66PgAePPjmKmpv5dDjIlIz/+prTep/WucAz0p3HDzcFcwjf/DViC1N+E
	u4fkzI/oKpIZaPDqlONKx4kAxPiZPOWrfE2zPHJYYa3Q36ufHCCXPhyxv2k2//2woEOCQKAPDJS
	pKcsBxextTZZ9rHzqYAYfkRV94qvIom60Fn0FtmxZSB1vuguvHqZDEFWM0qG6tQxWGoGKc8p3Rq
	sST78SsGh6GsU87T1veRLJZlw3o5CFxsdwMEfVHcrenz/N1PENfy78a/h9UggRVJDkMzYw==
X-Received: by 2002:a05:6000:128b:b0:487:27f9:83d with SMTP id ffacd0b85a97d-48dbace43eemr14685529f8f.50.1791836940849;
        Mon, 12 Oct 2026 13:29:00 -0700 (PDT)
X-Received: by 2002:a05:6000:128b:b0:487:27f9:83d with SMTP id ffacd0b85a97d-48dbace43eemr14685501f8f.50.1791836940216;
        Mon, 12 Oct 2026 13:29:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab48a7sm1232865f8f.24.2026.10.12.13.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:28:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:28:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Abhin Parekadan Jose <abhinjoses@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v4 0/5] PCI: pciehp: Report surprise removal during
 safe removal
Message-ID: <20261012162837-mutt-send-email-mst@kernel.org>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
 <asxylqif72Lcldx1@home-desktop>
 <20261012022556-mutt-send-email-mst@kernel.org>
 <as0uFfzw83f9aPpn@home-desktop>
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
In-Reply-To: <as0uFfzw83f9aPpn@home-desktop>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r6nTWHmcaqDmaajP3t2auMtIzRZ1i6iKChJ2TWpEvIk_1791836941
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2026 at 08:59:33PM +0200, Abhin Parekadan Jose wrote:
> On Mon, Oct 12, 2026 at 02:32:02AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Oct 12, 2026 at 07:39:34AM +0200, Abhin Parekadan Jose wrote:
> > > Gentle ping on this RFC.
> > >
> > > Lukas, Bjorn, could you let me know whether the general direction is
> > > acceptable before I work on a non-RFC version? Any comments on the
> > > approach would help.
> > >
> > > Thanks,
> > > Abhin
> >
> > I'd say, complete the picture. acpi,shpc,polling...
> 
> Ok.
> 
> >
> > Maybe think about how this interacts with pci_ignore_hotplug
> > (seems to weirdly check presence then ignore)?
> 
> Yeah, the order is wrong in v4. The presence read should come after
> the `ignore_hotplug` check. Will fix.
> (Need to still find out why this was introduced. Looks like only the GPU drivers
> use it.)
> 
> >
> > And test with virtio not with edu.
> 
> Bjorn had asked me to keep this puerly PCI[1], So I had decoupled it from the
> virtio changes. I could post another series with those changes with a dependecy
> to this series.
> 
> [1] https://lore.kernel.org/all/20260826194815.GA1552818@bhelgaas/

yea sure.

> >
> > > On Sun, Sep 27, 2026 at 06:20:11PM +0000, Abhin Parekadan Jose wrote:
> > > > If a safe removal is already in progress when the device is surprise
> > > > removed, pciehp cannot report the disconnect [1]. The removal blocks
> > > > waiting on a device interrupt or status read, and pciehp's IRQ thread is
> > > > single-threaded and is itself executing that removal, so it never runs
> > > > again to report the device gone. The removal hangs indefinitely.
> > > >
> > > > pciehp_isr() does run while the IRQ thread is blocked, but pciehp_ist()
> > > > must ignore link and presence changes caused by Secondary Bus Reset or
> > > > DPC, and telling those apart takes seconds which cannot be spent in
> > > > hardirq.
> > > >
> > > > Patch 4 does not do that work in hardirq. pciehp_isr() only checks
> > > > whether the card is present or the link is active, and defers the rest
> > > > to a work item in process context. The work item does not need to know
> > > > why the link changed, only whether the card is gone: it waits for DPC
> > > > recovery or a Secondary Bus Reset in progress to complete, then checks
> > > > again under reset_lock, and if the card is absent and the link is down
> > > > marks the devices below disconnected, which schedules the driver's
> > > > disconnect work from patch 1. pciehp_ist() is unchanged and
> > > > remains the only consumer of the one-shot flags PCI_DPC_RECOVERED and
> > > > PCI_LINK_CHANGED, which tell it whether a link change can be ignored.
> > > >
> > > > Patches:
> > > >
> > > >   1/5 Michael's "PCI: Report surprise removal event" from his RFC v5,
> > > >       which adds disconnect_work_enable and pdev->disconnect_work.
> > > >       Changed to serialize disconnect_work_enable with a per-device
> > > >       spinlock.
> > > >
> > > >   2/5 Add pci_hp_wait_link_change(), which awaits a Secondary Bus Reset
> > > >       in progress without consuming PCI_LINK_CHANGED.
> > > >
> > > >   3/5 Add pci_dpc_wait_recovery(), which awaits DPC recovery without
> > > >       consuming PCI_DPC_RECOVERED.
> > > >
> > > >   4/5 The pciehp change. Adds disconnect_work to struct controller,
> > > >       scheduled from pciehp_isr() on PDC or DLLSC when neither Presence
> > > >       Detect State nor Data Link Layer Link Active indicates a card.
> >
> >
> > how about including the virtio patch? seems more relevant than
> > fooling around with edu.
> >
> > > >   5/5 A POC driver for the QEMU edu device that blocks in remove()
> > > >       waiting for an interrupt, standing in for del_gendisk() stuck in
> > > >       blk_mq_freeze_queue_wait(). Not for merge -- included so the
> > > >       hang can be reproduced.
> > > >
> > > > Changes since RFC v3 [5]:
> > > >
> > > >   - 5/5: Reinitialize the completion in remove() before requesting the
> > > >     delayed interrupt, so that an earlier completion cannot let remove()
> > > >     return while the interrupt is still pending. (Sashiko)
> > > >   - 1/5 to 4/5: No changes.
> > > >
> > > > Changes since RFC v2 [4]:
> > > >
> > > >   - 1/5: Protect disconnect_work_enable with a per-device spinlock, held
> > > >     while testing it and scheduling the work, instead of lockless
> > > >     accesses and barriers.  pci_dev_set_disconnected() could otherwise
> > > >     test the flag, get preempted, and queue the work while a newly bound
> > > >     driver re-initializes it.  With the lock, cancel_work_sync() is
> > > >     sufficient again, so go back to it from disable_work_sync().
> > > >     (Sashiko)
> > > >   - 2/5: Test PCI_LINK_CHANGING with test_bit_acquire(), so that the
> > > >     caller's subsequent accesses are ordered after the end of the code
> > > >     section even if wait_event() returns without sleeping. (Sashiko)
> > > >   - 3/5, 4/5, 5/5: No changes.
> > > >
> > > > Changes since RFC v1 [2]:
> > > >
> > > >   - 1/5: Use disable_work_sync() instead of cancel_work_sync() in
> > > >     pci_clear_disconnect_work(), so that a racing schedule_work() cannot
> > > >     queue the work after remove() has returned. (Sashiko)
> > > >   - 2/5, 3/5: New.
> > > >   - 4/5: Drop schedule_notification_work(); pci_dev_set_disconnected()
> > > >     schedules the driver's disconnect work for all callers again.
> > > >     (Michael)
> > > >   - 4/5: Don't consume PCI_DPC_RECOVERED and PCI_LINK_CHANGED in the
> > > >     work item.  In v1 it ran the same spurious link change test as
> > > >     pciehp_ist(), and whichever ran first took the flags, so pciehp_ist()
> > > >     could tear down a device that was only reset. (Sashiko)
> > > >   - 4/5: Check presence with pciehp_card_present_or_link_active() in
> > > >     both pciehp_isr() and the work item, as pciehp_ist() does, so that a
> > > >     port with Presence Detect State hardwired to zero is not mistaken
> > > >     for an empty slot.
> > > >   - 4/5: Return early from the work item if pciehp_ist() has already
> > > >     taken the pending events, and treat a read error of the presence
> > > >     check as "not present". (Sashiko)
> > > >   - 4/5: In pciehp_isr(), check presence before dropping the runtime PM
> > > >     reference on the port's parent.  In the work item, take a runtime PM
> > > >     reference and check presence under reset_lock, since a slot reset
> > > >     may make Presence Detect State and Link Active flap.
> > > >   - 5/5: Build only with CONFIG_EDU_SRPOC, which depends on PCI; don't
> > > >     claim the interrupt when the device reads all ones; clear bus
> > > >     mastering on teardown. (Sashiko)
> > > >
> > > > Testing
> > > >
> > > > Reproducing this needs QEMU changes, since neither device_del nor the
> > > > attention button produces a true surprise removal.  A branch with both
> > > > is here [3]:
> > > >
> > > >   - a delayed-IRQ register on the edu device (BAR0 0x30, write N ms)
> > > >   - a pcie_surprise_del monitor command that drops the device and
> > > >     generates PDC=1, DLLSC=1, PDS=0
> > > >
> > > > Both tests use:
> > > >
> > > >   ./qemu-system-aarch64 -machine virt,gic-version=3 -cpu cortex-a57 \
> > > >     -m 512 -smp 2 -kernel Image -initrd initramfs.cpio.gz \
> > > >     -device pcie-root-port,id=rp1,chassis=1,slot=1 \
> > > >     -device edu,bus=rp1,id=edu0 -append "console=ttyAMA0 rdinit=/init" \
> > > >     -nographic -monitor unix:/tmp/qemu-mon.sock,server,nowait
> > > >
> > > >   and need a guest kernel with CONFIG_EDU_SRPOC=y.
> > > >
> > > > Test 1 (Hang in remove() on a user thread, then surprise removal):
> > > >
> > > >   guest# echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove &
> > > >   host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock
> > > >
> > > >   This is the case patch 1 solves on its own: pciehp's IRQ thread is
> > > >   free and handles the removal.
> > > >
> > > > Test 2 (Hang in remove() on pciehp's IRQ thread, then surprise removal):
> > > >
> > > >   guest# echo 0 > /sys/bus/pci/slots/1/power &
> > > >   host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock
> > > >
> > > >   Without patch 4 the safe removal does not return until the delayed
> > > >   interrupt fires 600 s later.  With it,
> > > >   pciehp_isr() schedules ctrl->disconnect_work, which marks the device
> > > >   disconnected; the POC driver's disconnect work completes the wait and
> > > >   remove() proceeds.
> > > >
> > > > Open questions
> > > >
> > > >   - Is this a viable approach?
> > > >
> > > > [1] https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
> > > > [2] https://lore.kernel.org/all/20260905183905.997833-1-abhinjoses@gmail.com/
> > > > [3] https://gitlab.com/abhinkop/qemu/-/commits/suprise-removal
> > > > [4] https://lore.kernel.org/all/20260927165459.829900-1-abhinjoses@gmail.com/
> > > > [5] https://lore.kernel.org/all/20260927175203.928270-1-abhinjoses@gmail.com/
> > > >
> > > > Assisted-by: LLM
> > > >
> > > > Abhin Parekadan Jose (4):
> > > >   PCI: pciehp: Add pci_hp_wait_link_change()
> > > >   PCI/DPC: Add pci_dpc_wait_recovery()
> > > >   PCI: pciehp: Report surprise removal from pciehp_isr()
> > > >   misc: Add edu_srpoc surprise removal POC driver
> > > >
> > > > Michael S. Tsirkin (1):
> > > >   PCI: Report surprise removal event
> > > >
> > > >  drivers/misc/Kconfig                   |  11 ++
> > > >  drivers/misc/Makefile                  |   1 +
> > > >  drivers/misc/edu_srpoc.c               | 172 +++++++++++++++++++++++++
> > > >  drivers/pci/hotplug/pci_hotplug_core.c |  21 ++-
> > > >  drivers/pci/hotplug/pciehp.h           |   1 +
> > > >  drivers/pci/hotplug/pciehp_hpc.c       |  67 ++++++++++
> > > >  drivers/pci/pci.h                      |  10 ++
> > > >  drivers/pci/pcie/dpc.c                 |  54 ++++++--
> > > >  drivers/pci/probe.c                    |   1 +
> > > >  include/linux/pci.h                    |  57 ++++++++
> > > >  10 files changed, 381 insertions(+), 14 deletions(-)
> > > >  create mode 100644 drivers/misc/edu_srpoc.c
> > > >
> > > >
> > > > base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
> > > > --
> > > > 2.51.1
> > > >
> >


