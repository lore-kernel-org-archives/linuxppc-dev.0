Return-Path: <SRS0=8MEZ=VA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E796C5B578
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 07:59:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C765921882
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 07:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6SQkpLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C765921882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45dtmt4rNGzDqQb
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 17:59:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="b6SQkpLR"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45dthJ3y2jzDqNZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2019 17:55:44 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id g15so790768pgi.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jul 2019 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gJqecc7z/Wt3DHiADBssOtE0uLDjQM8bKcxpApRr0MA=;
 b=b6SQkpLRqkH0NEHju3bo+Zm79fTLWfD/RCe2hlIQCEKY1BWnh/4KgmuLt3ZqfbQ+4h
 G8BgjOefvQ6IU0vZC1wGa/VQgPmYWZcThpa6uwp9/THF8SGyMuUpvcVNuILFkUSzqzJK
 oLaVOFRIfd2FgJijeW4o5TWxEe1lwLQ2C0u9H6g6PV7wMxRArroFgEQEQjyM3xOt/3LH
 fNbKSQAcrbRW4q+KJpGKnanFvaTKIwLRMcuxadFDz8iXVJym2dUySDaaBdQaLDsMedjI
 aI+NKPufQDOGb8yCSXKxSm/9wcIZgOBMPo5+ZxQIJyRpGXsn/cF9BfmWsvCKTM2lRVok
 W7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gJqecc7z/Wt3DHiADBssOtE0uLDjQM8bKcxpApRr0MA=;
 b=dsTQ43HMy/b0EW5X2AVteoWYxC75biAwRdCUOn0b6ODoW/uHrWg2tsvRooZXoKNk2g
 grki1TWDtdnEw5cpl76mSMC7RTt/rX5RAVwO2JbyicXhH6Z40b1xHod/WJop6rWR2aS8
 T3qPkNnEXFSM0PdtjxKVOZd0hXkpAX0JZ4gUVCo/HsDGd1uwJEi5WvwIyZb6slODTX+r
 MOi56V5at5yvg5/JHBwMQCLVmQiB/uxCMQclmi5Q1dVeM84Lks0DTYr64IRCeAkGiuh6
 oRLf3tAeu1ECHQYJOsCykw2AmeknIof1vyg4XGAAZEZISfTdyWDPrQ4ieFLAJNoIE4hf
 Ldag==
X-Gm-Message-State: APjAAAWX4tDhin/Y5CE2yfqpt2pCqidb3qEgifVnZUxZBiHfL6vlus5A
 AVHoXNAvSOZuJyh7jdbGFhi1tJR2
X-Google-Smtp-Source: APXvYqzZzqjfysRDhjQDaqomxDDOoafuMGprTMAH79rAWE7vKYddcyuptimMa3Dm2A0zX9S+Bz94nA==
X-Received: by 2002:a63:c34c:: with SMTP id e12mr34653666pgd.195.1562140542082; 
 Wed, 03 Jul 2019 00:55:42 -0700 (PDT)
Received: from bobo.local0.net (193-116-88-34.tpgi.com.au. [193.116.88.34])
 by smtp.gmail.com with ESMTPSA id p68sm2955849pfb.80.2019.07.03.00.55.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 00:55:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/14] powerpc/64s/exception: machine check fwnmi remove HV
 case
Date: Wed,  3 Jul 2019 17:54:31 +1000
Message-Id: <20190703075444.19005-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703075444.19005-1-npiggin@gmail.com>
References: <20190703075444.19005-1-npiggin@gmail.com>
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
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

fwnmi does not trigger in HV mode, so remove always-true feature test.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 53c1b0a2ebce..db7ef8c8566f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1026,9 +1026,8 @@ TRAMP_REAL_BEGIN(machine_check_pSeries)
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
 	EXCEPTION_PROLOG_0 PACA_EXMC
-BEGIN_FTR_SECTION
 	b	machine_check_common_early
-END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
+
 machine_check_pSeries_0:
 	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXMC, 1, 0x200, 1, 1, 0
 	/*
-- 
2.20.1

