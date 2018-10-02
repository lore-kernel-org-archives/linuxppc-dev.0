Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B91C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:35:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C59B2082A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlPKJivq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C59B2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PhX51nJxzF3G3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 00:35:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KlPKJivq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KlPKJivq"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMT1SYJzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:04 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id w14-v6so1710930plp.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=8RzORxHANRsBL7sqnwfQ7L6l7nDCBBaApvmQbP8nfoA=;
 b=KlPKJivq1rAbMf1S7Y16mpgxPRfjQoonqXsTPxsXDlpfcblLvrzzUtrY4Kws/o4itP
 tIyMV7Jt14PP+7bCSpqsyOV5UWpgTl6fpUQ/uaQdR8IB9X9Uk5mlvOhB3a1HbcD5EkZP
 IQNopwh57q1kVb6HUqji6ZtiEEnCYVnbZmhadf8lOY2VnWfhcDSz3yRrRppNg8nU1wYU
 Gsf9lwISuS0x2IwHO9dksktYPGXJv9833Yo2icJBZu0j1qrNo1yUtC7U19A8qwTew+6q
 Z0kG/QRojxK3jXt51zVWtcYhtOOlD9739yQJ28XWuoAja5KH8Y/WQX17YRM7Cr8/D1Ze
 bPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8RzORxHANRsBL7sqnwfQ7L6l7nDCBBaApvmQbP8nfoA=;
 b=AmqRHgoA86ikTBgdP/d4mY7vld+SWyqDzFLi0BVwaowMLYR8HyAztCKcr5a1FKQ9yd
 Ahh0RcLgqBu+e4JIQejvMfyoLUW9zFXTxsYdtPwKheenp7Uw7k14RiWZD7iFp2n3zIwD
 8VzYh4vuYRhf35jKaRuHQjI9necFBHXAruEFAcH/7YE+0K9oFIYjKEeVMj0Ub8b7XsLv
 8S4bLluteMxkr9bmxAwXyPxbeag1RC/rGLIjJeHIqZK0Nl3Gw05Q+vEN6yJULUZG8IQt
 xw9EvaQfGsT8UsB4oXIBQdlrb1vEZULP2l3P34f7Ghf9fBXC5+a24y4VHGrgIJU2YxDB
 tJ9Q==
X-Gm-Message-State: ABuFfoiSGl9lYtE9MVwUwGjdGOwMCYA2C+5qVZcCdmtB2h+qeQQJ7xaa
 jtwSRYhc1qz55n2NdY4EAvvCRhqK
X-Google-Smtp-Source: ACcGV61UTjldfgX30D2u8sB5YagnxbxOdPVJkjh4VntIjEocnNm93qT/RrYkfqTW378AouYuu8SxCg==
X-Received: by 2002:a62:7d8d:: with SMTP id
 y135-v6mr16622230pfc.245.1538490482853; 
 Tue, 02 Oct 2018 07:28:02 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/9] Fixes for SLB to C series
Date: Wed,  3 Oct 2018 00:27:50 +1000
Message-Id: <20181002142759.6244-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is another spin of the fixes. Also painfully re-discovered
that we need https://patchwork.ozlabs.org/patch/962327/, as it
prevents POWER8 NUMA from booting (initial stack SLB for the
!0 node CPUs gets cleared by the initial TLB flush without it,
and the SLB handler now uses the stack...)

Question is whether to revert the series and try again next time.
I'm inclined to maybe say revert because it's been holdig up the
tree a bit and also some of these patches like the PPR fixes are
pretty complicated and should really be done as pre-requisites rather
than fixes.

Thanks,
Nick

Nicholas Piggin (9):
  Revert "powerpc/64s/hash: remove user SLB data from the paca"
  powerpc/64: add struct int_regs to save additional registers on stack
  powerpc/64: interrupts save PPR on stack rather than thread_struct
  powerpc/64s/hash: Fix preloading of SLB entries
  powerpc/64s/hash: add more barriers for slb preloading
  powerpc/64s/hash: SLB fix preemption issues
  powerpc/64s/hash: Fix false positive preempt warnings
  powerpc/64s/hash: slb_flush_and_rebolt simplify
  powerpc/64s/hash: add some slb debugging tests

 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   3 +-
 arch/powerpc/include/asm/exception-64s.h      |   9 +-
 arch/powerpc/include/asm/paca.h               |  16 ++
 arch/powerpc/include/asm/processor.h          |  12 +-
 arch/powerpc/include/asm/ptrace.h             |  18 +-
 arch/powerpc/kernel/asm-offsets.c             |  32 ++-
 arch/powerpc/kernel/entry_64.S                |  15 +-
 arch/powerpc/kernel/paca.c                    |  22 ++
 arch/powerpc/kernel/process.c                 |  54 ++---
 arch/powerpc/kernel/ptrace.c                  |   4 +-
 arch/powerpc/kernel/stacktrace.c              |   2 +-
 arch/powerpc/kernel/swsusp_asm64.S            |   2 +-
 arch/powerpc/mm/hash_utils_64.c               |  46 +++-
 arch/powerpc/mm/mmu_context.c                 |   3 +-
 arch/powerpc/mm/slb.c                         | 203 ++++++++++++------
 arch/powerpc/mm/slice.c                       |  29 ++-
 16 files changed, 314 insertions(+), 156 deletions(-)

-- 
2.18.0

