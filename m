Return-Path: <SRS0=krmN=CO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C33AC433E2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2020 17:47:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1CA20760
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2020 17:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCDx+YiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1CA20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BkMS51G1tzDqdt
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Sep 2020 03:47:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=dCDx+YiD; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BkMNR3ZLYzDqdM
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Sep 2020 03:43:48 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 2so4654798pjx.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2020 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QVEafzz2OAHgTyyYpHpI3ib5F3DU9WXpuJ+M8mZXv/0=;
 b=dCDx+YiDK6f4WpKNiuRmA+x3nbWZbN6C9O9Dk23UOVvETFKk0vd1Sh1sReQH4VZ7DO
 tQCssF1638aYXDWAZ4s3hi78LPkypSNNvOQX1mdqfLrKKmq77PrAlfuJ7B1T8AdS4cgt
 Wth3eMuvtVPdtr5zaDtxAsG6NU06gHl1phGVQhINi89pPPePUCKlYNSmQGJtopwwkaYa
 h/DxMA6nicAQGjwfLXAYWw4bH8/zu/a8TmAtr7TlNZRXmGVjeP+POT8DvQPjCe/qvuqv
 4+LEP4YdeCiZNGWjwqnJT8NedPB1QRsWqQRQTOsTHC+KGTmPxSA3mPclIXo52ASubTFu
 f+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QVEafzz2OAHgTyyYpHpI3ib5F3DU9WXpuJ+M8mZXv/0=;
 b=QF3tMEsImDchSkGh6BuM/TwUZ+Su80eqBAwkecxcNCaTe8Pz3HLihhGaLnPP2oudSv
 baKcyT9wNJv+ffbAsx2OdEsVE0OHjfTI++6AxR9qd5hzGU7Oaa3T9kihGhhRIXNH2J1V
 jssw3QXD22+MqH1VIWFiOSRCYd4umc4fP1CoQ2zoZzZV6qosWuEVAUi+WTM1m5t+bdkM
 jvhBB/roUk4dpKQce1KvKmEpVe0KHYdRk6Gj9WVPM3XC+sP/1wp+6t+cc2n+yM7RyASy
 lZQ2fhw7huH02xOh3DPiffCIldIN6aemAFIr2xqyaPskXjQBwouLovCgWSaMEFHxJ3AY
 MPbg==
X-Gm-Message-State: AOAM531lRjbqsEszUekAw4t6U2KliQJfSkoKquaXXbpo9hVNWJTL1ADC
 S1z/4RBBhXwJIcaJdc19yvE=
X-Google-Smtp-Source: ABdhPJxcDSMIYwFzzCRT0nqP5TpESWSYeLJ9z2TVPDF+VlmuB8oRUvZ0Amch5JFWMnAhx0dG7t6SCQ==
X-Received: by 2002:a17:902:758d:: with SMTP id
 j13mr12487071pll.160.1599327825074; 
 Sat, 05 Sep 2020 10:43:45 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.185.249.227])
 by smtp.gmail.com with ESMTPSA id i1sm10405317pfk.21.2020.09.05.10.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 10:43:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: 
Subject: [RFC PATCH 00/12] interrupt entry wrappers
Date: Sun,  6 Sep 2020 03:43:23 +1000
Message-Id: <20200905174335.3161229-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series moves more stuff to C, and fixes context tracking on
64s.

Nicholas Piggin (12):
  powerpc/64s: move the last of the page fault handling logic to C
  powerpc: remove arguments from interrupt handler functions
  powerpc: interrupt handler wrapper functions
  powerpc: add interrupt_cond_local_irq_enable helper
  powerpc/64s: Do context tracking in interrupt entry wrapper
  powerpc/64s: reconcile interrupts in C
  powerpc/64: move account_stolen_time into its own function
  powerpc/64: entry cpu time accounting in C
  powerpc: move NMI entry/exit code into wrapper
  powerpc/64s: move NMI soft-mask handling to C
  powerpc/64s: runlatch interrupt handling in C
  powerpc/64s: power4 nap fixup in C

 arch/powerpc/Kconfig                      |   2 +-
 arch/powerpc/include/asm/asm-prototypes.h |  28 --
 arch/powerpc/include/asm/bug.h            |   2 +-
 arch/powerpc/include/asm/cputime.h        |  15 +
 arch/powerpc/include/asm/hw_irq.h         |   9 -
 arch/powerpc/include/asm/interrupt.h      | 316 ++++++++++++++++++++++
 arch/powerpc/include/asm/ppc_asm.h        |  24 --
 arch/powerpc/include/asm/processor.h      |   1 +
 arch/powerpc/include/asm/thread_info.h    |   6 +
 arch/powerpc/include/asm/time.h           |   2 +
 arch/powerpc/kernel/dbell.c               |   3 +-
 arch/powerpc/kernel/exceptions-64e.S      |   3 -
 arch/powerpc/kernel/exceptions-64s.S      | 307 ++-------------------
 arch/powerpc/kernel/idle_book3s.S         |   4 +
 arch/powerpc/kernel/irq.c                 |   3 +-
 arch/powerpc/kernel/mce.c                 |  17 +-
 arch/powerpc/kernel/ptrace/ptrace.c       |   4 -
 arch/powerpc/kernel/signal.c              |   4 -
 arch/powerpc/kernel/syscall_64.c          |  24 +-
 arch/powerpc/kernel/tau_6xx.c             |   2 +-
 arch/powerpc/kernel/time.c                |   3 +-
 arch/powerpc/kernel/traps.c               | 198 ++++++--------
 arch/powerpc/kernel/watchdog.c            |  15 +-
 arch/powerpc/kvm/book3s_hv_builtin.c      |   1 +
 arch/powerpc/mm/book3s64/hash_utils.c     |  82 ++++--
 arch/powerpc/mm/book3s64/slb.c            |  12 +-
 arch/powerpc/mm/fault.c                   |  74 ++++-
 arch/powerpc/platforms/powernv/idle.c     |   1 +
 28 files changed, 608 insertions(+), 554 deletions(-)
 create mode 100644 arch/powerpc/include/asm/interrupt.h

-- 
2.23.0

