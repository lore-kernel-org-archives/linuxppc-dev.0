Return-Path: <SRS0=xkpp=IG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2294C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 09:53:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B531651B6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 09:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B531651B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DvDDd685nz3cnX
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 20:53:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=uaCe049I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431;
 helo=mail-pf1-x431.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=uaCe049I; dkim-atps=neutral
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DvDDC0JG5z30HF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Mar 2021 20:52:58 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id j12so6693916pfj.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Mar 2021 01:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AhT6gnEhqVWDZjbVZ4xMqIf0rYZ/6aqhPAYATeUwlKc=;
 b=uaCe049IQLTXl4hEee2niRhGTopyPNAH5t8rTHzM3scw6V1VDdXvO5NQlJOaqe/7Io
 gEp3s7+tNtL64bTXjYBRflhmrMbnxjJO28gWJKZvtGEjLI36gCJc+sXcqxZvDUdS2oo0
 Dru6CEiaIX4q8rba4p0TuUXeAAUUbAABWbps/VBK1SPLgGhe4yth3ByQi7sMFd5jQVNQ
 PGuNYWtd5BgsvWLsSAtGo+Zhq2AVqXDScEJfElka/tN+15yGkeG6CTcB4+V4eYpGKGt+
 bE/MPCC8cVmUfC+Sg/YG2o9psDTyRYtiue97Ep72KZXvUSr2G80X2F5K+kmN/7r8qHrl
 nKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AhT6gnEhqVWDZjbVZ4xMqIf0rYZ/6aqhPAYATeUwlKc=;
 b=Pr4lYARS4zfUYZYSDATfNp8XYILcozilHudImDcFw4stJ8bIZxL1dVOZyiD6i0Vuk2
 ZS0tMTMjqqAeBX82iVm4DdKhWYSadI+b/0OS522+nsUn9bGWLbpOJGP93aM90P9vETPE
 pPUnnGEsTFjhAsPPRswP7xTJGIhQvuzMqRk00ObF3b9FZBdciV9MoU57qB8Y6CnFVZlF
 2cAUJh3qM6FUzE+2ZTEeITxeTsdqmcV/z+TQYjiYhgOoyCjpEjswWtGKl1ux1J/sZuOe
 fKoyn1Le8/zrRwq3Rts5WHxs5AgGNnne1pW7Q2LHGD6kD3NOk4y7QWHij2CJ6DgRs95r
 jvtw==
X-Gm-Message-State: AOAM530dk371aBQcTIqFdAF7eHxHIonVkGjaIIQxm38H944yZSMp6bdh
 cehvf3qseg1xCYRVKFQ2EepeCj+Oe+Y=
X-Google-Smtp-Source: ABdhPJwR3TSwXe8iTTi4mEC5BqrMSsyTpmT8WGsTTd6wAXLuSEGUb4CqS5NMjP4S67o04sUqJhtqgQ==
X-Received: by 2002:a63:545e:: with SMTP id e30mr20165049pgm.13.1615197174357; 
 Mon, 08 Mar 2021 01:52:54 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id
 e63sm1326850pfe.208.2021.03.08.01.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 01:52:53 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/7] Move 64e to new interrupt return code
Date: Mon,  8 Mar 2021 19:52:36 +1000
Message-Id: <20210308095244.3195782-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Time to finally try removing the remaining old cruft left over
from the big interrupt return rewrite in C.

This series will clash lightly with Christophe's one to switch
ppc32 over. His should go in first because it's a lot bigger
and more mature at this stage. I will rebase this series on top
of his at some point but at the moment it's just based on upstream.

Patch 1 should go in as a fix, patch 5 is not required for this
series I'll drop it from non-rfc series and send it separately (it's
not tested at the moment).

Thanks,
Nick

Nicholas Piggin (7):
  powerpc/syscall: switch user_exit_irqoff and trace_hardirqs_off order
  powerpc/64e/interrupt: always save nvgprs on interrupt
  powerpc/64e/interrupt: use new interrupt return
  powerpc/64e/interrupt: reconcile irq soft-mask state in C
  KVM: PPC: Remove RECONCILE_IRQ_STATE from guest exit
  powerpc/64e/interrupt: handle bad_page_fault in C
  powerpc/64e/interrupt: Use new interrupt context tracking scheme

 arch/powerpc/include/asm/asm-prototypes.h |   2 -
 arch/powerpc/include/asm/interrupt.h      |  31 +-
 arch/powerpc/include/asm/irqflags.h       |  58 ----
 arch/powerpc/include/asm/kvm_ppc.h        |  22 --
 arch/powerpc/include/asm/ptrace.h         |   9 +-
 arch/powerpc/kernel/entry_64.S            |  40 +--
 arch/powerpc/kernel/exceptions-64e.S      | 394 ++--------------------
 arch/powerpc/kernel/interrupt.c           |  18 +-
 arch/powerpc/kernel/irq.c                 |  76 -----
 arch/powerpc/kvm/book3s_pr.c              |   8 +-
 arch/powerpc/kvm/booke.c                  |   9 +-
 arch/powerpc/kvm/bookehv_interrupts.S     |   9 -
 arch/powerpc/mm/fault.c                   |   4 +-
 13 files changed, 69 insertions(+), 611 deletions(-)

-- 
2.23.0

