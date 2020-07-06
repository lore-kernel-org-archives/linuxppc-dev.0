Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06160C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 04:38:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F43D20720
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 04:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkf1JzYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F43D20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0XrW4pDbzDqgf
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 14:38:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::443;
 helo=mail-wr1-x443.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Hkf1JzYh; dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0XnS5DZ6zDqWJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 14:35:56 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id z15so28033096wrl.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2020 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZKbw/z5L6V9QIy1x3CDqGbQPwSP3RR4H4VZhRPfsp8M=;
 b=Hkf1JzYh8wjUYolV0yaByArSjR1r/H4U8J4WcN5XtRtVGH5W1a+waY2FcTp6vNrLBv
 jUMpiNqYBpmtBNy0cshISgyAcM8ayGC//EhS4EYX7SaFkqXmDS7tGBDLg5gGMwx+RI0v
 rFOVnaVf/ZahbQA9k3IR3fBN0Nr5dbv8ZnaxhEiQ8cS4v1n7xBWwPFfjtuUabcwR3wgn
 Pn010T/J+8URF0VzurWA/Zg0X0kLeBB6VLgpir94tXXLt4ibfN8TCZXm0Uqe8IgWEk7r
 i10AkbH3ZRjLbsnoD+AFWUwuWz0ZGk7mbp96o/clHt9q62DneKcDYbkA09H3OaLiOHAV
 /a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZKbw/z5L6V9QIy1x3CDqGbQPwSP3RR4H4VZhRPfsp8M=;
 b=VKIPFQ7yuQCTiuHk3WeosDKct5xGRBkxuVAI2/VQyYM1zhdXGoyjyo+0eLAVx3pX44
 /l5w+OwqA2i9BArwyTToN1wu6RO4wWWh+XOVKzc3DMv4D72pZFFWUp52V2GxuXjl5xNM
 qZzU3lzG5z7x3+U71EPecrvezWGEKf/woSjqGgY+CvcudyTantradyEMNX/+S2r/iVve
 jQ6lwa9NOjXeqwRJKtjDrzTE53VahKGv5xDuCm6I2V24mxRsp2JtC676+sUUgqE+vFjr
 1DRfceSqDFssazqX5RhKvGAcR/cLVfVDmGummBpFJCOhqQVLbB4ZR+hrdSa4HMtC4dzd
 kigg==
X-Gm-Message-State: AOAM531WJ3yjqOkdgSjxDYz17g0C/qbbMySPR05p8DOgtxwp/bK3iJfk
 rk1Ghx6eyVtpZeTIASrx/1OiCQZ5
X-Google-Smtp-Source: ABdhPJzihhpFIjNtA4jYZFpWqPBLQzM2ItdHfjFiE1pNPdxZGN7QPxVTkIDKR3KTQMdZob9+J5kqVg==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr46431344wrp.299.1594010152557; 
 Sun, 05 Jul 2020 21:35:52 -0700 (PDT)
Received: from bobo.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
 by smtp.gmail.com with ESMTPSA id r10sm22202309wrm.17.2020.07.05.21.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 21:35:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Mon,  6 Jul 2020 14:35:34 +1000
Message-Id: <20200706043540.1563616-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, kvm-ppc@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

v3 is updated to use __pv_queued_spin_unlock, noticed by Waiman (thank you).

Thanks,
Nick

Nicholas Piggin (6):
  powerpc/powernv: must include hvcall.h to get PAPR defines
  powerpc/pseries: move some PAPR paravirt functions to their own file
  powerpc: move spinlock implementation to simple_spinlock
  powerpc/64s: implement queued spinlocks and rwlocks
  powerpc/pseries: implement paravirt qspinlocks for SPLPAR
  powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the
    lock hint

 arch/powerpc/Kconfig                          |  13 +
 arch/powerpc/include/asm/Kbuild               |   2 +
 arch/powerpc/include/asm/atomic.h             |  28 ++
 arch/powerpc/include/asm/paravirt.h           |  89 +++++
 arch/powerpc/include/asm/qspinlock.h          |  91 ++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |   7 +
 arch/powerpc/include/asm/simple_spinlock.h    | 292 +++++++++++++++++
 .../include/asm/simple_spinlock_types.h       |  21 ++
 arch/powerpc/include/asm/spinlock.h           | 308 +-----------------
 arch/powerpc/include/asm/spinlock_types.h     |  17 +-
 arch/powerpc/lib/Makefile                     |   3 +
 arch/powerpc/lib/locks.c                      |  12 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c |   1 +
 arch/powerpc/platforms/pseries/Kconfig        |   5 +
 arch/powerpc/platforms/pseries/setup.c        |   6 +-
 include/asm-generic/qspinlock.h               |   4 +
 16 files changed, 577 insertions(+), 322 deletions(-)
 create mode 100644 arch/powerpc/include/asm/paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h

-- 
2.23.0

