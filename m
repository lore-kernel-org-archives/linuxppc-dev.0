Return-Path: <linuxppc-dev+bounces-23462-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EABC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 07:50:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs5WZ6pbyz2xdb;
	Fri, 03 Jul 2026 17:50:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783065002;
	cv=none; b=bXLyTufdD6KPBmSsoEQbA40RqTR9vjCzFypk45urkH/uNlN2lDVY3JQ3jufit6WRVE6Vba86V7aqjFPh70Ip0bZD27z3z6aXs2rW2HCFw8zNy0HFvdE8PIALxOk8D+glLlQZWjPQ4uW/Rwjh9CfZVCMqnpco4abP6Hp3sOpnL7ZLHx8bALylP4dMA42K4KzziLYu+eKyIRxR244QeTnUTWMLGc8tSJxlU5ffxXwIrPgiNrBOSlJOfsVrLfV9bk2+wI37hzZEIhk3cmqMK+rhbC70Q5r/dXt1si0LIwv0NJdv8BZisc148NRoQ+UXif9GTLDaHTTf9+Q8q1ABOiMwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783065002; c=relaxed/relaxed;
	bh=0Q1uVx5PijZunmvRx9NUm8EnpzPRRoelOh/GwaVLzAw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PpOWyzX3i8x3dUuxiOKC/WQKrKk/6ph4EhamiKx6sxmExnWCcg8VW2k4leG/Qx9xJ1588w0/zfZDvHRGt1OG874Wl6Mkyd89bwQsqqCp29a2f3iKMTdltStiSMM2LUiXfPA+sQdIBywbxNLZx0j/gw1imLFbSx981RFtM2sR5vzZ3LqfE5CeN9ua0IJPYXuoxuruWFQ1RZi9aFT6xjHCh5libtu+5rFDFKJT9Ux/8YWXx+debph/Miox1qK6DiNp6ho5bcn1cD7CmEOaWud6aW/7gAZufcB/g59mv+/nRfw5PkKrYUJxJBU3MmIzeftpwXzXaQM4enigNzmYWZbwfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HMx9yUNT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HMx9yUNT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs5WZ0mYBz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 17:50:01 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c8894387780so137534a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783064998; x=1783669798; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Q1uVx5PijZunmvRx9NUm8EnpzPRRoelOh/GwaVLzAw=;
        b=HMx9yUNTGHie/v5g4lI22Mwd269CH+Xzkjv6Dix6scaTggMKSBOzZsBapWO98IfXq4
         stSHp1LphGwv6FEAcx8ltNfeqPgOCzpuifJZEVFbKWaPfi7SVIl5W4gp+kQ+r/OzkaeZ
         9m3/VPjDFHggMiGpSK4lF1ljtQT/NJcQDixuedNqpGWadivrqui8qsek3ogjcdoeNk24
         YzhAkCFUJ5TZwn6ayQvjaqiZTtcQ4lyj4fm93kjSwVC7HTMDhNP72W+ZHiIPH1E5cgVX
         zfoaGDiu8PKxRPZDnKyXiqYzJ/6r6ptG+Q4oSn3dAEzBKFNnwKf/BlPhaEEiukCuWUpP
         oGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783064998; x=1783669798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0Q1uVx5PijZunmvRx9NUm8EnpzPRRoelOh/GwaVLzAw=;
        b=BQiYvwRtC9kw9zoQaHbUAwxKvXf/tP1CJaX7hySsJINZrLnFwkyKxJF9CjAU2CO5fU
         AkjQ407A7Xqn5ORNbv1pQb0a+x0NLWh7ZlQvdATYyQsfpF9dZInLw1oCoLQYzM2C5LGn
         auVZHacn53C6Oin2t8ehtKMoEAFufllLrUAn6m3MWxlDMAQcW6bQSfV22FG5GDD2j6z2
         eDKN5M8ckUB2W1ei/QN5mwGoZlmvlJUiu+ZeujpzRKmSjNnwQQMJii+aManlK4+iLbDk
         wMTR7x9M5nYKNZOahp60sMVhNzQPnsepH4TdUPc747vVv/auq4Ihi1oSLagnnF8iRqB+
         EdLA==
X-Forwarded-Encrypted: i=1; AFNElJ+NUtEtmr6HKCfDT78DRDUnVOJcd1Qk1XxiBr8m+0BnYFg7L3J2td6gSUIq7vQB5wjwYCB2U15Tr4sDnaA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzOve8Bs86ypQYioJHv6dQcCCE99AKQdljtezsUiegXO/lJjK5q
	HbpIexklZWfkqkRput0s8NEbpa1oW7CiuHEM5V0Dth5Tfjn8I1g65gt5
X-Gm-Gg: AfdE7ck2P9Q3LTCkxCT+DYEqQKYhrzjmmdmFZxDQWwUtoZ3M8oyNBV8X9iBtqzYUt+/
	QKoUf7xoysLfRTCzD4BkP0zh0rnR2Uy1Hvjs1cFWvlHK+qqvIXnAN2frVvD2o7eG+r4muQFMCSy
	NxpPmp+PWZdEvV2wY5JpSIMRmMY3O57tB8JjazimizFSEKoYqFGSyAOjXXDxIhf+H4WRI0dfC6K
	sbASvM/2WKR+ADK1Z+mZCBOPffsazd+CQn+dvAewDEpzNMByhNGOOE/J4Ga9agIaV4uUeIP3vBN
	W0p37kCJGoAX3uS3IK2CmylgY8wK7m6qHL5xoqFAYvlmdIlKv5JagazQ63bwJg1ILlNXoeBYsRM
	Erlp+6cMFN2QhpM/Sf3bCVG2zm3hGGDrpShtlG4qTfaTwHHqm5VPnYhlNZiU08lz7XfEMK8cEn2
	ytRj6mdDfehZ3vm8VMMj8I3RAFr8Wyr6DFhaQtwNQawYQ8qtOnH/VpYs6QdtnTy4Ok9Mk5O0B/W
	6sB
X-Received: by 2002:a05:6a20:728c:b0:3bf:6011:550 with SMTP id adf61e73a8af0-3bff4100839mr9905959637.24.1783064998300;
        Fri, 03 Jul 2026 00:49:58 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm25635112eec.15.2026.07.03.00.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:49:58 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	mkchauras@linux.ibm.com,
	sshegde@linux.ibm.com,
	mkchauras@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ptrace: Add offsetof check for exit_flags in pt_regs_check()
Date: Fri,  3 Jul 2026 13:19:48 +0530
Message-ID: <20260703074948.1668744-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
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

pt_regs_check() verifies that fields shared between struct pt_regs and
struct user_pt_regs sit at the same offset, to catch any accidental
layout divergence between the kernel and uapi structures.

Add the missing check for exit_flags, following the same pattern as the
existing checks for result, dsisr, dar and the other shared fields.

Fixes: d7a6797e0bc1 ("powerpc: add exit_flags field in pt_regs")
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/kernel/ptrace/ptrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 316d4f5ead8e..fb3fec73f66a 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -235,6 +235,8 @@ void __init pt_regs_check(void)
 		     offsetof(struct user_pt_regs, dsisr));
 	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
 		     offsetof(struct user_pt_regs, result));
+	BUILD_BUG_ON(offsetof(struct pt_regs, exit_flags) !=
+		     offsetof(struct user_pt_regs, exit_flags));
 
 	BUILD_BUG_ON(sizeof(struct user_pt_regs) > sizeof(struct pt_regs));
 
-- 
2.55.0


