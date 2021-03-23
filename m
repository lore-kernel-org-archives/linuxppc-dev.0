Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC91C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:07:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCEE6192E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCEE6192E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4Cs40SH0z3dMl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 12:07:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=oKMKoZdg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b;
 helo=mail-pg1-x52b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=oKMKoZdg; dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4Cmf3c8Qz30Lt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 12:03:46 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id o11so10036136pgs.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 18:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iRArmwHwr1TW/EUMAbr86c7nTk5KyXg+Q8BT8bAWL9c=;
 b=oKMKoZdgeHwZKUo4PRlD2Dzc7IhbEUC8mMjDI3zWI6qayRcFZ0kMCLzGyVTbNS4jIp
 REPS/XiU+8RlsfByynrWUE3UhQFoAd32MK/xEX7vdgua3YqClvwLM1D5iIXYSZMA6apI
 MoUC+5diufJPKJnQuRW6IUc3VDdw8u+Ry9TKY/OFonRoZQqvoJoltfMN6U7XR7s1N1Tb
 JlXxFvk0zQb89/mhh+cgrSz9xy1CChqivVksFQNmf5Gkquj0pbGaWQnobQ21heDgy6uW
 Q7RGqeK+qe0xIN8KxqghpsAAtvodH9vT6vY+Fu/KQrJk51WBdYuH72ALKdG33DHWp+0a
 CWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iRArmwHwr1TW/EUMAbr86c7nTk5KyXg+Q8BT8bAWL9c=;
 b=TZ9+0pTThoFYwmOFFjV5il3b0FUlBiiN6Sbmtt6XsBCIPuD6leo5XM0VN3BljRTS4W
 G3R1LAXOje2wKY7fZreGQIEU2AwnhpXiLnDCYWXNkOp4K+EF51SlLYmkfgFG4QD9H60c
 MT2awVlKx+pCN1dkqxcmZaWtdnGj2uffChadPzFlpYmD7R0Q9G6rTADGZo3aZm78Vc9x
 u9bzXyJSh/ScaT7PiUshFH+wafxYsiuCPdCqITjtZYJ0sKHcsHVgTrmO0yCoeOlYi/Er
 APJy5ecUQGmKdB//z5+WOX7RDyuyAN6xjj5SBpH3tK/M1nyxGsy6CcsLfVT4uyaHq/1m
 3OzA==
X-Gm-Message-State: AOAM530o/7IqgvxCxL1A9H8k1bmkQc8dW0L1u0tP6VEh+uoR1us1WNVp
 U/aOigtBxtxvq4M/GvfXDT8=
X-Google-Smtp-Source: ABdhPJzGGLMwTFHfxJ4kbBx1rf1nML+TaFzWPnx+5G4RmWW8X+78FVGC3rdNB0BbPO+Mb1X03nKx/g==
X-Received: by 2002:a17:902:d304:b029:e6:bab4:8df3 with SMTP id
 b4-20020a170902d304b02900e6bab48df3mr2303950plc.5.1616461424936; 
 Mon, 22 Mar 2021 18:03:44 -0700 (PDT)
Received: from bobo.ibm.com ([58.84.78.96])
 by smtp.gmail.com with ESMTPSA id e7sm14491894pfc.88.2021.03.22.18.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 18:03:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v4 09/46] powerpc/64s: remove KVM SKIP test from instruction
 breakpoint handler
Date: Tue, 23 Mar 2021 11:02:28 +1000
Message-Id: <20210323010305.1045293-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210323010305.1045293-1-npiggin@gmail.com>
References: <20210323010305.1045293-1-npiggin@gmail.com>
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
Cc: Fabiano Rosas <farosas@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The code being executed in KVM_GUEST_MODE_SKIP is hypervisor code with
MSR[IR]=0, so the faults of concern are the d-side ones caused by access
to guest context by the hypervisor.

Instruction breakpoint interrupts are not a concern here. It's unlikely
any good would come of causing breaks in this code, but skipping the
instruction that caused it won't help matters (e.g., skip the mtmsr that
sets MSR[DR]=0 or clears KVM_GUEST_MODE_SKIP).

Reviewed-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a0515cb829c2..c9c446ccff54 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2553,7 +2553,6 @@ EXC_VIRT_NONE(0x5200, 0x100)
 INT_DEFINE_BEGIN(instruction_breakpoint)
 	IVEC=0x1300
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
-	IKVM_SKIP=1
 	IKVM_REAL=1
 #endif
 INT_DEFINE_END(instruction_breakpoint)
-- 
2.23.0

