Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F9BC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:12:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A912173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YILjxdUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A912173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447pQ725SZzDqSx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 17:12:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YILjxdUL"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447pLD0GPszDqNl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 17:09:23 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id g37so2892486plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 22:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=HeuDIDQgvC4kZerdUWQf+UdXqo/TJXGsN3mE9Eqz6SY=;
 b=YILjxdULW/8Fdays5U9aMAwY8sa1FWyElggt20AO1HnBcpZkhB+3Vj/Km7hIW1eSAp
 Z3yTnj1NaDY+tfj1wNYXZOTAn/AHIgyAaGEUwZwd5fmlW9neCO83mUCcDpQFopwJPieY
 hhC/RZIbXxeWqN5Y3/tDiEgrMHZZ3peW6jONF/AvTFpYo+Pa34nrwgfpem7/uYU6vzzk
 vzDGbLnlD2lkDyyPtoyBEvPd0dy5Nj+RRQAis45V5QNIJRM4q5EZWMqAiQpS05JYdjHH
 9aDfSRBFK0wEcG4duMVt8P8ijspV/ash6PbV5JxvIK5Evj0Ij9h+uVBI3f3ueuZ/vvmz
 cOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HeuDIDQgvC4kZerdUWQf+UdXqo/TJXGsN3mE9Eqz6SY=;
 b=Onn2duohkckEHPWDoy/3C3WTeGs1rKL8l8PLebVb2YE2+8/rx/6P/XmusX2rt2yk6+
 ZMgwTbGkKgHW9RHQkJpGWcapb0SyqYLXhto5cPaMZyoqzNiP4E6wX5X0FN2IxzkvjsSh
 qQWMlLo0uJmymJ4PMMJ5bENZLaDMmTLqrdCpDu1Jt63sz7UDyv+Qk/C3FP0ve07/gUvF
 qOOxNAEjSFdRj8LXbAkKZ5J9ntPcVEiNlbs7olQIFe91ziRPEFISFM1TQQbTiq2ku27E
 9B64nx/kf+D4HtrfbsfWpC4Dn7I/UfTT10FoNPEHnOGlNEu6jkmSX2KyG0i3EGK6MOIS
 wHWw==
X-Gm-Message-State: AHQUAuYRlTIZ1hw3tFYsPlGeGwEpRJkXQgMUrWtjYgAV1o3an07sWua4
 bgZ3TFqjgk9vzJPPP4MVopkzvaDN
X-Google-Smtp-Source: AHgI3IZmH5zxxfWJDlLual90UsdcYBqf7sX9/Gm9Sqb0k+GbP1KFDuDm2iUrzNWOTAxG1GhKTTzEKA==
X-Received: by 2002:a17:902:b70b:: with SMTP id
 d11mr25015104pls.178.1551161358185; 
 Mon, 25 Feb 2019 22:09:18 -0800 (PST)
Received: from roar.local0.net ([125.254.1.96])
 by smtp.gmail.com with ESMTPSA id s6sm18478814pgm.90.2019.02.25.22.09.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 22:09:17 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/4] Fixes for 3 separate NMI reentrancy bugs
Date: Tue, 26 Feb 2019 16:08:57 +1000
Message-Id: <20190226060901.18715-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series fixes several similar but unrelated bugs with NMIs
clobbering live registers without noticing it, because MSR[RI] is set.
Pretty rare bugs, but serious silent corruption consequences.

For the most part these can be observed and tested quite easily
with the mambo simulator, except that it does not seem to follow
the architecture wrt leaving MSR[RI] unchanged for HV interrupts.
Mambo clears MSR[RI], so you have to account for that manually.

Since v1:
- Fixed several build bugs.

Since v2:
- Improved changelog and comments.
- Fixed the NIA test for virt mode interrupts.

Nicholas Piggin (4):
  powerpc/64s: Fix HV NMI vs HV interrupt recoverability test
  powerpc/64s: system reset interrupt preserve HSRRs
  powerpc/64s: Prepare to handle data interrupts vs d-side MCE
    reentrancy
  powerpc/64s: Fix data interrupts vs d-side MCE reentrancy

 arch/powerpc/include/asm/asm-prototypes.h |  8 ++
 arch/powerpc/include/asm/nmi.h            |  2 +
 arch/powerpc/kernel/exceptions-64s.S      | 92 +++++++++++++++++++----
 arch/powerpc/kernel/mce.c                 |  3 +
 arch/powerpc/kernel/traps.c               | 91 +++++++++++++++++++++-
 5 files changed, 179 insertions(+), 17 deletions(-)

-- 
2.18.0

