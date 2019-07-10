Return-Path: <SRS0=3PCM=VH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF97C74A21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:31:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1320520844
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfXXMRTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1320520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kNSm37fKzDqLY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 01:31:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qfXXMRTS"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kNGr5QPmzDqJH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 01:22:44 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id t16so1251591pfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d0O1eCD7VCHEcOVCnDnzCnGh5JeTGwL0w7X9n9IIcAs=;
 b=qfXXMRTSWAL4BMhTpHKe5mo3tsJdxYrOANaUt9HBWVzOBSyiMsoLeHtmUONU7sB45f
 y2xw9ez87j8kpxQj1qMIZekJkNXltIqJVR31lb9iE7Uz2mbdDeh9yVWALbTsY/m5dHeW
 o/g+pHjY3Xufs3fzsg/xpv+8QAA1dljwQyFREllpTJl3zDvYU3NhPIF7giuVaF9irCfE
 irardFWJF6fOFmHFTsusjsFvFbIaDdKAns/vmOM0/9C/kVfJluPZsX4FdYASbdHeLKt1
 SAJnb8GLhVKiJZjtWcKGRjH0rufYQVKzTPsBFQ5fkkocX4+XxyV2ifhp4D2YYvMWrUfd
 A8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d0O1eCD7VCHEcOVCnDnzCnGh5JeTGwL0w7X9n9IIcAs=;
 b=Rw3mK9D0w896gi+dXhLAbKu74P6KMeTzdwmKb86nkk1Qa6XqospHgu3+BS//VRc/i8
 jtCWJ7h5GYUlvVfOnkXY88SCPv3vQQwQQdhlnlM01fgwRHLB+xDiWToeY94DSVkJdNgO
 IB3hjRwgzrjRv8SDRmaCGTY1HvqpKk80kDiPc42tH9OYiGDjfUoXSSftTWNnsCol0pUf
 aaARB/yDTGB8xCmNog67UKKfeSFaItvU0TFa3ymmCaEerUtVsJATARmTG7+yFJaijn2r
 dmqejFw0jvm9cADllXABMAOD93rvO/hTzRMOh48JRS3uWueubd5CBvlOnw+z/U5yr0iu
 K/zw==
X-Gm-Message-State: APjAAAWaBS2T/B8Ky9a5nOJdq6so7h+GHQUqQj5Pct5/pYPVs5a9H224
 FQzIOdyf4bxhEXY79j19HN9S8I5NWP4=
X-Google-Smtp-Source: APXvYqwpWQ7gFiIpjxdHmzOJEgZom+DHh19UVhJ/mnnCilptC/+D8+OjJyaiz97BV9CpRL9RC5dk5A==
X-Received: by 2002:a63:e0d:: with SMTP id d13mr3166078pgl.118.1562772160609; 
 Wed, 10 Jul 2019 08:22:40 -0700 (PDT)
Received: from bobo.local0.net (14-203-207-157.tpgi.com.au. [14.203.207.157])
 by smtp.gmail.com with ESMTPSA id
 s22sm2699212pfh.107.2019.07.10.08.22.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 08:22:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/16] powerpc/64s: machine check cleanup series
Date: Thu, 11 Jul 2019 01:19:34 +1000
Message-Id: <20190710151950.31906-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series is mostly unchanged from last time, except that it
adjusts the pseries machine check handler to use machine check events
for queueing, which fixes some corner cases and allows the interrupt
code to be consolidated nicely.

Thanks,
Nick

Nicholas Piggin (16):
  powerpc/64s/exception: machine check fwnmi remove HV case
  powerpc/64s/exception: machine check remove bitrotted comment
  powerpc/64s/exception: machine check fix KVM guest test
  powerpc/64s/exception: machine check adjust RFI target
  powerpc/64s/exception: machine check pseries should always run the
    early handler
  powerpc/64s/exception: machine check remove machine_check_pSeries_0
    branch
  powerpc/64s/exception: machine check use correct cfar for late handler
  powerpc/64s/powernv: machine check dump SLB contents
  powerpc/64s/pseries: machine check convert to use common event code
  powerpc/64s/exception: machine check pseries should skip the late
    handler for host kernel MCEs
  powerpc/64s/exception: machine check restructure to reuse common
    macros
  powerpc/64s/exception: machine check move tramp code
  powerpc/64s/exception: simplify machine check early path
  powerpc/64s/exception: machine check move unrecoverable handling out
    of line
  powerpc/64s/exception: untangle early machine check handler branch
  powerpc/64s/exception: machine check improve labels and comments

 arch/powerpc/include/asm/mce.h         |   6 +
 arch/powerpc/kernel/exceptions-64s.S   | 371 ++++++++++----------
 arch/powerpc/kernel/mce.c              |  40 ++-
 arch/powerpc/kernel/mce_power.c        |   4 +
 arch/powerpc/platforms/powernv/setup.c |   9 +
 arch/powerpc/platforms/pseries/ras.c   | 457 +++++++++++--------------
 arch/powerpc/platforms/pseries/setup.c |  24 +-
 7 files changed, 439 insertions(+), 472 deletions(-)

-- 
2.20.1

