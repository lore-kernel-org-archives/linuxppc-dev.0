Return-Path: <linuxppc-dev+bounces-25310-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3D5C55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:15:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDXb25bL0z3080;
	Tue, 04 Aug 2026 09:15:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785794383;
	cv=none; b=koPJ+9f/Gpsur/j/RK+IqNaSDZCpoo30f3KPjTqMLHBRxszUbAG4UnjMUTkFjWF3zC/Ra9fm9Ez8TM/Fy2DJNDTtLg8TrjqtHZEmpL2nYODM7ckeLU1qZ6ekqe3iIWByw+gGN16384DBUxgkTZAqgYbogWt+yRnDwGqSLNcSQXFqgRFDMcQJSJdBrWsg0zxm8B/z3ivC2lCNCZghMakbfekE2rFN1O+HOa0LEUX9m1vrKYLknyMzEFzEsJ/MCM/8pr/KK4GNswYuiaVI62pif5dVCyeNG+mjQx/bngyJAPMD82xAgIljAbjNhv6Gn02tX11kx4kNkNdDrwMr6IKnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785794383; c=relaxed/relaxed;
	bh=uVEhXqZ2S4ZB77O3YdEcMlIVSh8TdZgWM5WFDU+zGjc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SS+Dace2KWB8EO5jWAV4gsziDzQrfxI8T65LKtjl8emtc5ngMaQwrMt/FpFdpQLhuRllbRwg0TONBlPZFKOAvrpranV6lEf+oXUImHbKOQVh3aeOkVC4eGt281ewy7eSb4T0zu6YONO36O0RR4io5tzanViubmwcfFnlNqcLwaXNawSXK9FwyJw/BIBGJOoDo0H7IJo1bo/g/AD/lo2vhcRw6mTmPBeeeRLrfGIez01QHh19iq052dOrI50pnf5mAanLzvQ4lbhWU01g8+cZ+9dHbhJnQwf14ljRnjXTb9kMuiS/wDxysoT+xwhAx45KzZ8ztapGX9t/0RO5kVRbSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K9Z6IYoO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3sw9xag0kdig3m5t0p13uamzws00sxq.o0yxuz6911o-pq7xu454.0bxmn4.03s@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K9Z6IYoO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3sw9xag0kdig3m5t0p13uamzws00sxq.o0yxuz6911o-pq7xu454.0bxmn4.03s@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDVvf4lWpz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 07:59:41 +1000 (AEST)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-c860544c077so9271699a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785794380; x=1786399180; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uVEhXqZ2S4ZB77O3YdEcMlIVSh8TdZgWM5WFDU+zGjc=;
        b=K9Z6IYoO+sZsC10QUvpXh+OVvpf109In5yTRD0dRST+OfqJTYr3MxaaOtb0ARErNIu
         5EgEnhOpgYkfsJN+ppfsaLhr9oYjeG595z8FUstnuxSie6gEIxrhdkJj1L0oMxMwV959
         veWJYODXriU+pAbaRee7ygJHouFFLFebVAYRAhN3YoiLTgxuBmU6dKCs8AChiBlCoy4A
         JamrnXqfaVX5oqEC7GUnYprrycpNx+R9BVZTwGvZIGgSC1/uhrOYEFQuvws0NXx/Uacg
         rjrBeM1BKB0K7RzlSRwd1kqanoslnDi07HZ97V95lm2peX8TniEW2LmQcvJp+nP+yjYm
         X16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794380; x=1786399180;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVEhXqZ2S4ZB77O3YdEcMlIVSh8TdZgWM5WFDU+zGjc=;
        b=Eb9SZAL1lc2nYTDx/Y3httYhSP1FFTEYfG1+kgbl2Pd1JccBGawGHaQpLFK4RKx3BQ
         QOYrm2kKaRIBhGhx62IvTDlPduu8+FSkYsVsNYHxNoB5QfuerQY3OIIjjBXBdkFawW7+
         4B43Ktb1KDpyRuhUsd4//MKaqWeMoWWRW19CDS5jtu8JzUR2+O0ywkUG9jDXqtsCeMKZ
         DhqTgriLtL1K0WImpLA8fYkGjq+B0W1FCzHtFU69rHcU27WjvNYCSRvdLMY+8XdmeLSJ
         RUZM/bbjuDzTdQhjsAgbcLnxicgH6KkerDgp7vIIE7eEOd5lN+vSZM8XeOSZLcMDc89v
         1B4w==
X-Gm-Message-State: AOJu0YzC2TB1/JX2ErIa15jvbuU2lFGVIZW1GH0cLkquVZipuICsftcG
	HFXreKJCNfhB+Vl+h3IONwY86XSIlf2QR9LcwKwRDGVtwo6OPGNSk++tmcNK6JZgurcB4Q7aZaO
	vWLBa95BVVaGVta1EkTHkEWqC48Jliq51LQ==
X-Received: from pgah3.prod.google.com ([2002:a05:6a02:4e83:b0:c9e:bb:ebaa])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3392:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3c92a59957dmr12749564637.17.1785794379417;
 Mon, 03 Aug 2026 14:59:39 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:59:37 +0000
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
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEkPcWoC/z2NSw6CQBBEr2J6bROYjxldeQ/DYoAWOnyG9BAiI
 dzdkYXLV6l6tUMkYYrwuOwgtHLkMCVQ1wvUnZ9aQm4Sg8rVLXe5xsrgmz/oSXCkcSDfR7TK+KJ
 qLDnnIC1nodQ5ra8yccdxCbKdJ2vxS/++wmlndWa0MvaOCsUvXWhm4c1P/bMNoR0oq8MI5XEcX wx5i6muAAAA
X-Change-Id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
Subject: [PATCH v2 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

When firmware reports PCIe Advanced Error Reporting (AER) events via ACPI
APEI GHES (ghes_handle_aer()), it allocates a snapshot buffer from
ghes_estatus_pool to store the aer_capability_regs registers before
enqueuing the error record into aer_recover_ring.

If the error record cannot be enqueued or if the dequeued record cannot be
processed, the pool memory allocated for aer_capability_regs must be released.
Otherwise, unhandled errors silently leak memory in ghes_estatus_pool,
eventually leading to pool exhaustion and breaking system-wide GHES hardware
error reporting.

This series fixes two memory leaks in PCIe AER error handling:

Patch 1: Fixes a memory leak in aer_recover_queue() when kfifo_in_spinlocked()
         fails due to a buffer overflow (aer_recover_ring capacity of 16 full).
         The rejected entry is immediately freed via ghes_estatus_pool_region_free().

Patch 2: Fixes a memory leak in aer_recover_work_func() when a dequeued entry
         cannot be mapped to an active PCI device (pdev is NULL). Refactors the
         loop so ghes_estatus_pool_region_free() is called unconditionally for
         every dequeued item.

Changes in v2:
  - Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
    is called unconditionally for every dequeued item.
  - Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
    buffer overflow.
  - Updated commit messages with detailed pool allocation and lifecycle explanations.

Priyank Rathod (2):
  PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
  PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing

 drivers/pci/pcie/aer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v2:
- Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
  is called unconditionally for every dequeued record.
- Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
  buffer overflow.
- Link to v1: https://lore.kernel.org/r/20260803183853.432459-2-rathodpriyank@google.com

---
Priyank Rathod (2):
      PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing

 drivers/pci/pcie/aer.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)
---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260803-b4-fix-aer-memleaks-524a1bd5e888

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


