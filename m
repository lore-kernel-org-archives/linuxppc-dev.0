Return-Path: <linuxppc-dev+bounces-25307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E38C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:14:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDXYq4X36z306N;
	Tue, 04 Aug 2026 09:14:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785793872;
	cv=none; b=CMaTMr77xAlVOK2ZLSkiRl1LHc2tNSwStbvZB0j/3TzYuN7ubkg2he7MiRsujGLUll1obGPoT/2oQvYRv2tt5j650WfdLH1L8l+dxfA3bVdBt/rLmMzUbMim0kazewtAcq7hQp3rWzhahMw7ls7uUjQ8f02Sn1u+VDnu3ygK5UjuVZhoKEQ46dPnJZB2iZe8263ljSK7+f2hjVbExPePdB+uT1Zo4F+106Sk73HbtEhKkIAbG7c+v7xbD569RJeL+VoAZuAc1MdEMCa+hyvUOgqIqcNCC5biSwlVknDhKLCtZ58a5+WSHNZQ4BIPSz2j2nl1gTB4B1CAuG7QQlSHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785793872; c=relaxed/relaxed;
	bh=3ueF7qsDhWv0EVJ6I0YWRQAEPyu9W9Hcp8n0Sycy3r8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b90eJOxEIXK2ZsDFOblwOuISjiT6+beBTrc73I3H4hfBuaj25xKd+h4Z0kdj1suCavLPS9B/jUp1iEsrJd9zpUabps6d0slFJqL6Gp+DAt6xu1x4o60Zpr4iigagovxYLiq5pbr4CGBY/CwM8W2CBbwAbfHT2piqbOFoGcIbyDa38sUroEf/XAeWlT00eSW07e0q2ea75ZZh7iVpGzRARcCb3AXGJBpaG+3+EbJAP38YiBRCPyjxnCVJQyNXYYyn2mgBUyXZ8qnNaxwEm9Uqw7yeA1/IrAfZKurMGEktlhCyZ+9YiTFOKn6fn/Frbj/WT2p3FICG13hbGR00/Tuxqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ywa0Q1ns; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3sg1xag0kdimyh0ovkwyp5hurnvvnsl.jvtspu14wwj-kl2spz0z.v6shiz.vyn@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ywa0Q1ns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3sg1xag0kdimyh0ovkwyp5hurnvvnsl.jvtspu14wwj-kl2spz0z.v6shiz.vyn@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDVjp6CwBz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 07:51:10 +1000 (AEST)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso2305674a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785793867; x=1786398667; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ueF7qsDhWv0EVJ6I0YWRQAEPyu9W9Hcp8n0Sycy3r8=;
        b=Ywa0Q1nsqYMce/ddIA6Skk97U42nvTnEc9Tvnm34rbOYcMiRJ9moAbVDlZ+Etwvbfd
         fx/Q9x4qN1T8v1uVcxQdvIj9t1xvy7XkFd3ZhRKCSVxJf1YNR9GscNOEJEmBFYe1NLVa
         U3tVgDpRfX4M9JY2tzo5CPdzDVn0BmvjNgmJ+qeYfUBE64nRkZnxbI/YA19h+zXw3M/9
         AL/wMakQs3pOYwUwStKkWPMpf18uAJM7wdgmr7/gc83lHb9q8rqtmOFDBAl47gV1PD8i
         peNsWm1rR9JNArG/diQ+sxAB7gZxHRafp1ZvOh9E1UjlCViQaZfYaUaG4EhMHq1p2PRv
         4FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793867; x=1786398667;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ueF7qsDhWv0EVJ6I0YWRQAEPyu9W9Hcp8n0Sycy3r8=;
        b=L7kLBoPtRLjv8X6n6sevVUG8nwM8XikKMUuW71En3WOkZyUMxcPl3oou7KJJs6oqDk
         F+7+cQlnunj32g+3w40q7vOYSKVyZx5e4AFvTHAf2fehyPskL4akwUypMu4C84cB+CoI
         5TtaxW2EDmkQdguQZXrKdECF9BKDMlPwbU8GyIkUDSwDLatfxorKyjK6jNe2wrtPfaO3
         leddABlUI8M/bUNAh44jlgqPEjX2EK0u46dsRopMMrkTk+1NY1ms4WFCseP6JfjMZmOa
         xnuK+YfkKxnbfTIh1DDMrQftWt2d8WmIql3Fdqudsb3P9Z1Q1L7AKFTmjQbHxo2hC9gS
         Gp8A==
X-Gm-Message-State: AOJu0Yz0/20cQII4qMsup4dASQgUEekW9bzHMlxJmeOAu5bOBJ8m9Lco
	PxjvsSOysrEqJ3mxyifTfmC4pekoBnE7/Lo/AgE1zB/wft8n4WKeSYxFdj3SuIXaFCQOwb922t+
	Rr459tUGOILTmxH5TFBNdSwKns1SHFav5Zw==
X-Received: from pgcp20.prod.google.com ([2002:a63:7414:0:b0:c99:aff5:707b])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:468a:b0:3c4:1c9f:d91 with SMTP id adf61e73a8af0-3c92aa7d0cdmr12901949637.59.1785793866780;
 Mon, 03 Aug 2026 14:51:06 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:51:04 +0000
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
X-B4-Tracking: v=1; b=H4sIAEgNcWoC/22OywqDMBBFf0Wy7khMosSu+h+li8RMNfiIJBIq4
 r83uigIXZ7L3HNnIwG9xUDu2UY8RhusmxLwW0aaTk0tgjWJCaOsopJy0ALe9gMKPYw4Dqj6ACU
 TqtCmRCklSc3ZY7o5rc9X4s6Gxfn1HInFkf58heSy5LngTJQ1MPBq6ZyZvV3V1D9a59oB88aN5 PBEdun+/SUyoGCYRspNLSuhL5J937+3l1k48wAAAA==
X-Change-Id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
Subject: [PATCH v3 0/2] (no cover subject)
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

Changes in v3:
- Updated cover letter and auto-populated maintainer To/Cc trailers.
- Updated commit formatting per checkpatch guidelines.
- Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-0-d2be03d9864b@google.com

PCI/AER: Fix ghes_estatus_pool memory leaks in error handling

This series addresses two memory leaks in PCIe Advanced Error Reporting (AER)
handling where memory snapshot buffers allocated from ghes_estatus_pool
are not released back to the pool.

When firmware reports PCIe errors via ACPI APEI GHES (ghes_handle_aer()), it
allocates a buffer from ghes_estatus_pool for aer_capability_regs and
enqueues it into aer_recover_ring. If errors are dropped or skipped, these
buffers must be freed to prevent ghes_estatus_pool memory exhaustion.

Patch 1: Fixes memory leak in aer_recover_queue() when kfifo_in_spinlocked()
         fails due to a buffer overflow (ring capacity of 16 entries full).
Patch 2: Fixes memory leak in aer_recover_work_func() when a dequeued entry
         cannot be mapped to a PCI device (pdev is NULL).

Changes in v2:
  - Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
    is called unconditionally for every dequeued record.
  - Added Patch 2 to fix related memory leak in aer_recover_queue() on
    kfifo buffer overflow.
  - Updated commit messages with detailed pool lifetime explanations.

Priyank Rathod (2):
  PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
  PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing

 drivers/pci/pcie/aer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v3:
- Updated cover letter and auto-populated maintainer To/Cc trailers.
- Updated commit formatting per checkpatch guidelines.
- Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-0-d2be03d9864b@google.com

Changes in v2:
- Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
  is called unconditionally for every dequeued record.
- Added Patch 2 to fix related memory leak in aer_recover_queue() on
  kfifo buffer overflow.
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


