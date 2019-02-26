Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A294CC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:53:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B602147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvtThRQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B602147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447sz75fT0zDqVS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:53:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvtThRQx"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447sx94xnZzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:51:25 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id h8so5383140pgp.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 00:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=SAmHCxKuJ7OWDKhsmjPShsimt5XTuL0PIfsRlKLonTc=;
 b=IvtThRQxFu78MVTcPjdh9OxNzfdEWVmFoXHKYV5y9fneX1baOLUFDc+QE3DYKyKIq+
 5CWg1yMCu2tk74tNUE9iuZjrFyHeBiy16o9pcjozy5KsYUKuCfwFFdDY4oK+KVD8FLZV
 pxpN1IaVp0DTNIhE0ePswnCRzmBJYvJjEzrO4VH+gq/arPlCStVnRnQQU6P6XJ8x/FNg
 zyGF4YLN0wNI5dU+ZZlQ7cFrhwdHC8+sItbGhsWUk+qOOUBAUdGNntK7fq3ka8W183Ng
 9JQn59i6bA4IePkbdt34ElBfaw1SDKJWO7FtT71wHE1Y+r7gKEaAsiR9x1J8KdZ85Ndz
 CBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=SAmHCxKuJ7OWDKhsmjPShsimt5XTuL0PIfsRlKLonTc=;
 b=BDyOUUvGDsg034UTy3RZyn3CjauSbHANkXSDvqSAT0cR7IvK7VzNzHJv9JQ1IuKOUV
 yinTy1crHaYONVdRPI8iwbRyiRxOqv0rs57BH7mEFUenWaay2NIRwG1gr7iQo4BbIjiE
 zVXS7HchgPbkcswLyGh8Wgwtwgv6t/Quc0pdzsNlyIl+J2O/yyxEgPBBGoM2C9GdblgV
 mRKj8Jh08myYl5lMa7EYx3q8LSsQSmX69Co6zB8u0ek5nRoCBfBfn9QpEabyB6GSXzLW
 5aMh0vtWo9yTXnmskNFQpCdqlmHeZk63jk7yKUnrxXr7/YxOR1Ys+Ix4OibWNiRcrk51
 gzkg==
X-Gm-Message-State: AHQUAuaexKRdLma4qG8vMi1gWCGJ4WfdWat/KJwO8QJ1+Ow9WJz69NKh
 heXbTLGEY15s/hYXjWWEyj+CsmUo
X-Google-Smtp-Source: AHgI3IblH+Zdm1ZhijLOXHhDUW6eAj2CmqBdQZutbslJvmzyXY1E2h7CPpRF8gzrXl53ky4ymZL6NA==
X-Received: by 2002:a62:f54d:: with SMTP id n74mr24640877pfh.98.1551171081742; 
 Tue, 26 Feb 2019 00:51:21 -0800 (PST)
Received: from roar.local0.net ([125.254.1.96])
 by smtp.gmail.com with ESMTPSA id t10sm29217103pfa.151.2019.02.26.00.51.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 00:51:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/4] Fixes for 3 separate NMI reentrancy bugs
Date: Tue, 26 Feb 2019 18:51:06 +1000
Message-Id: <20190226085110.29653-1-npiggin@gmail.com>
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

Since v3:
- Fixed HPT crash due to use of PACA_EXGEN rather than EXSLB in
  the SLB interrupt handlers.

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

