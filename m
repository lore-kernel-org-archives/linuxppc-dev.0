Return-Path: <linuxppc-dev+bounces-19496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735FAFD5F7A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:01:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frM9y03m1z2yC9;
	Wed, 08 Apr 2026 22:01:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649717;
	cv=none; b=Zp2nkdzLo3WDxOKKC5PpNWiY4WTHHG1rc/hNq+DQdPz1JRdk2brkbXgr/SaSi/tZhUuVFAAIaLqMmdbR5Pujm2ptJQddNlJe+z8ZsdvKy7GL+PrYBbqZACkz1TE+BfCeTSsf4pE7iffDU/KIy/I3ozfMWfVes5w7uLeRLgu4SXAXJHPtWRxCDOYCBdlWs6SD1neoFTh/+WRjwxAefix3R5AHU/NIWH7YSDbOtiPkktUV/ntbQuYNkUcVkzy/1SYwp7K4FxvhJxQPAqWlls6onxvnCvWyoqDIENdCekmdG25Sl7U2J2L7QjLioDdlPydLwXFB4FTZVYvqXvRUGzWmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649717; c=relaxed/relaxed;
	bh=pnvGHSpp15w/tHy1Cf/xFMCrBRJ69orr/FbfdABrhL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZ/827mttz1lHIkE1XUm4FPJRQHIsO8CRPgbeMCg654M9vZ8EQ6PQHD02f3F6Ya7RYP3FtPLsK15Lcw63IEo0Ah59s9OOJfLTL3/aIY4deIwPbuhqPd9754J4XKoUWnpr9v08sqdXtyTfU69sp0Dg+fu0kPAEj2+Ovh+PLn2dxOf7EuuiqGHkoXOOMxFVelqIdMVwR8uxAsDyFvlYL4skS8q3utXBmoM/RbcYt1zj73tIqIBRWmeK/dOg+J+Yd1SrXKb0O99+KtHN7fvkjY6jqfrssVAehVGetTIW8DYucYu63lJjSXIIurijZG0DrgohYVuhMdLrEfvHVU3D5Lcbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LO7gkcoj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LO7gkcoj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frM9x0Yg5z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:01:56 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-82a7ebc729dso2669175b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649714; x=1776254514; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnvGHSpp15w/tHy1Cf/xFMCrBRJ69orr/FbfdABrhL4=;
        b=LO7gkcojQI3y/ha60qCObjj9We9MaybhMcwY/WgZlxTLMe6XG3H0XMluvzQokg5ijb
         WA0GH4DhQ7AkSFAKb1xxyst6vzP2w3GTMhxy3LC5ML7kmdjLSzApJew3TmFej0Jy6SsT
         nqEOTEu1r6zqwXDO0cFGGouKpd7x/ZGEVYr9CQOem5o1FYkVJIiQaCHLdN/1BG/0l2BS
         x/ny2bbTDZBOTkb4Wcvcja/1KaUXoekIrHQ8bjfBow7EuR9ZVGwAv3bXLf+LjPDCsP0f
         65PBmbH225LY9MjS1wE1a6vHXpcw/l7qakSrdXIGorfiRYZUYKLt+JF7SIADUPcfsI1Y
         QoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649714; x=1776254514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnvGHSpp15w/tHy1Cf/xFMCrBRJ69orr/FbfdABrhL4=;
        b=K00mi9O70KxSsWZM7eFTyRJY6URa76pxietaB/7z5ea0XzVQxL5XtbeU9o1ooVKpQG
         dUeOw2473rYx2BLlmf8kqjEVuEG4p+FQqZHF0Ej/56TlW5RJsuAQKIVESh5KH7alCfjE
         Brl8cszJ9qNMTM5ClaIxO/ybGi2WzyZuS4LHirTauH2LaXeRI1Iuck74qEsJpYOQawze
         Ot8+nSJHrUx1DR8shLkh4wgT5wXUuvMDAMiI26lpCYhpOvZa+Lx3l/OyRoPmfHrI8YjO
         zWBOa0v7ketH7gvcRAtu4y1eenz3KX6LvODEjURu1iKWcuU1JICs2g4Jxaax9ulvoN45
         82ug==
X-Gm-Message-State: AOJu0Yx+xZH/QAfb4tUzt/ZVxGZCGO6oqTr0myFYk1zHagaEKireBdx6
	cw8M8LXdHM8QWtnwPzue6vGe9Awrc1jEDY/9UJyWbc2FaHcUpKaeF9oKhzEwbA==
X-Gm-Gg: AeBDietz55jzsG5Jx1Qc1M4EpoSbDWLEYRty+T4miJDYCPCq39If8ElqBIZrnQsBDv6
	slyWFvO7bPK0qljV/fwjkciFlELeGlwr/5Tdw/HDlcejeCFdz3v1g1XeL435UqS26lPpG5aRdBv
	NWIj0T1nytqKanAXRmEJJ7UbjLRBs+VzoQQxNfosL6f0JDABIVzkXdOCgtxOARggDhpvQpe7jFZ
	IVl7FatSX/Laiiyz1DKmE35CTFL3ZH5h/bQU+2U/sbZTWJszA6aips16dI0YTLQtCiJlRPElLlQ
	ObRLCsC6jvE0bSTFgOXgdB0CpV/OrzX7Nwweco6kpBXlwTizm7VSeEa3DnxpAyXE0PsUEF+PQ5c
	hhn+H4BZnR+9Sx+Ft/+r4fArmqzh7Tum6ct3l6RZ5HiTF0MBUglbnpbc5DtvUL3ABbQNngIIB8D
	lOiYCf/37rpH2FLLKrQ2JjC1wiGLHaAGjwBtgJTVOvpamA
X-Received: by 2002:a05:6a00:414b:b0:82c:d8c3:6983 with SMTP id d2e1a72fcca58-82d0dbcfdd5mr20758886b3a.51.1775649713927;
        Wed, 08 Apr 2026 05:01:53 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.01.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:01:52 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 00/10] pseries/papr-hvpipe: Fix deadlock, races and misc cleanups
Date: Wed,  8 Apr 2026 17:31:30 +0530
Message-ID: <cover.1775648406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
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

While going over papr-hvpipe code, there were a few races & a possible
recursive deadlock identified. This patch series is an attempt to fix those
along with some misc cleanups.  The changes are looking sane to me in v2, so I
would appreciate any reviews, however it still hasn't been tested on the real
HW, which I will test and update.

v1->v2:
========
1. Fix a possible deadlock due to use of spin_lock instead of spin_lock_irqsave.
2. Prevent kernel stack uninit memory leak to userspace
3. Fix the race condition in null-ptr-deref case where there may be an
   msg pending to be consumed from the hvpipe.
4. Fixed error handling in init routine in patch-10

[v1]: https://lore.kernel.org/linuxppc-dev/cover.1775569027.git.ritesh.list@gmail.com/#t

Ritesh Harjani (IBM) (10):
  pseries/papr-hvpipe: Fix race with interrupt handler
  pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
  pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle()
  pseries/papr-hvpipe: Fix the usage of copy_to_user()
  pseries/papr-hvpipe: Simplify spin unlock usage in papr_hvpipe_handle_release()
  pseries/papr-hvpipe: Kill task_struct pointer from struct hvpipe_source_info
  pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
  pseries/papr-hvpipe: Simplify error handling in papr_hvpipe_init()
  pseries/papr-hvpipe: Fix style and checkpatch issues in enable_hvpipe_IRQ()
  pseries/papr-hvpipe: Fix error handling in case of init routine fails

 arch/powerpc/platforms/pseries/papr-hvpipe.c | 181 ++++++++++---------
 arch/powerpc/platforms/pseries/papr-hvpipe.h |   1 -
 2 files changed, 97 insertions(+), 85 deletions(-)

--
2.39.5


