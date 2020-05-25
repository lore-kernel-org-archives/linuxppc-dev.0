Return-Path: <SRS0=r5XJ=7H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B4BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 03:09:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F0C2076C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 03:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEMovI+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F0C2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Vhs72r6hzDqTK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 13:09:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=FEMovI+q; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Vhg56lPNzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2020 13:00:49 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id bg4so1649639plb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2020 20:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8f9rLKPOXO3acJmAZD+JK1wZc5KowTtzeo1kH+pCbF8=;
 b=FEMovI+q6Diy7VXBK5km4WvegGIL2NW5BKDTkyoXllNJicl0oYFrQ5yOYfcHIP8rUT
 +Qz9uxfg9NPUebvg0tF09gRnc/3Xzcuyxi64+7WZRBt3zp9TdvRBtEKSqvsNLNJ6cNZo
 uo3fxr4msVphNy4uhi2tjAArgKsZyZQn0K3MO8yL4j7LiAhnFub5EjWO5M6ELP++L/vo
 EOlqKc/odXIZmXZiE9ED2PehtmsqW/DQ2c+mFXsjRxahJG9fZl9zK4qyT/MIovdsN+i4
 j5TDrbeiW7B39sXZf75sULji5iEKR79TO9kRsc5glaysiNEB6VBMW/3z+c6mhFujVJ2a
 RVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8f9rLKPOXO3acJmAZD+JK1wZc5KowTtzeo1kH+pCbF8=;
 b=J5ouhAjUWvaIuNTSJZuJ+We2vMHqbjSMzcMzcUrVhrcwK3TR9nhkrYFfoMTnHp4ZWH
 6nWQoGzJT3/jg5eUWMu8qqPnXC6nGj/KCQSHw0f/U5p5v8f9+vqxrE2qhTufCUoBGfdm
 BLQQHAq9KYObL9CVh3El9+dbDBxNCooAZW9tmetuU4RhUKVF4bPJsDmsmswhk1+40mTq
 eJ7uLEi4vy+2I2fjX3YJs36IVYv7HGCWUu9HMOFP3FvqIZUjpW5JfOV9FYcq2A2AD9/n
 pnIc9bgosCUq5G9hW5l5jZZ6qpacJMq/PlfucZ631KsI2HKRfqakO7vl/Tbklgsxl7I7
 AmPg==
X-Gm-Message-State: AOAM532wmONuNp3WhUYNA1BuOfs7vwOanlIxbjvyCkFuU6ybnZiV531x
 zDSOEI0sUnVEqVyi4+k1LjCbtmZMvCw=
X-Google-Smtp-Source: ABdhPJwFRIn9Wz77QOtAejAd1oVkz/kna8Gy7akIet/XZhOh946c+2YsEKDYEC95EBmKXWNyq+cspg==
X-Received: by 2002:a17:90b:1104:: with SMTP id
 gi4mr16828191pjb.115.1590375647389; 
 Sun, 24 May 2020 20:00:47 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id p8sm10790452pgm.73.2020.05.24.20.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 20:00:47 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc sstep: Add tests for Prefixed Add Immediate
Date: Mon, 25 May 2020 12:59:23 +1000
Message-Id: <20200525025923.19843-5-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525025923.19843-1-jniethe5@gmail.com>
References: <20200525025923.19843-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, Jordan Niethe <jniethe5@gmail.com>,
 bala24@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use the existing support for testing compute type instructions to test
Prefixed Add Immediate (paddi).  The R bit of the paddi instruction
controls whether current instruction address is used. Add test cases for
when R=1 and for R=0. paddi has a 34 bit immediate field formed by
concatenating si0 and si1. Add tests for the extreme values of this
field.

Skip the paddi tests if ISA v3.1 is unsupported.

Some of these test cases were added by Balamuruhan S.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/lib/test_emulate_step.c          | 127 ++++++++++++++++++
 .../lib/test_emulate_step_exec_instr.S        |   1 +
 2 files changed, 128 insertions(+)

diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 579b5db80674..33a72b7d2764 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -105,6 +105,13 @@
 					___PPC_RA(a) | ___PPC_RB(b))
 #define TEST_ADDC_DOT(t, a, b)	ppc_inst(PPC_INST_ADDC | ___PPC_RT(t) |		\
 					___PPC_RA(a) | ___PPC_RB(b) | 0x1)
+#define TEST_PADDI(t, a, i, pr)	ppc_inst_prefix(PPC_PREFIX_MLS | __PPC_PRFX_R(pr) |	\
+					IMM_H(i),			\
+					PPC_INST_ADDI |			\
+					___PPC_RT(t) | ___PPC_RA(a) |	\
+					IMM_L(i))
+
+
 
 #define MAX_SUBTESTS	16
 
@@ -699,6 +706,11 @@ struct compute_test {
 	} subtests[MAX_SUBTESTS + 1];
 };
 
+/* Extreme values for si0||si1 (the MLS:D-form 34 bit immediate field) */
+#define SI_MIN BIT(33)
+#define SI_MAX (BIT(33) - 1)
+#define SI_UMAX (BIT(34) - 1)
+
 static struct compute_test compute_tests[] = {
 	{
 		.mnemonic = "nop",
@@ -1071,6 +1083,121 @@ static struct compute_test compute_tests[] = {
 				}
 			}
 		}
+	},
+	{
+		.mnemonic = "paddi",
+		.cpu_feature = CPU_FTR_ARCH_31,
+		.subtests = {
+			{
+				.descr = "RA = LONG_MIN, SI = SI_MIN, R = 0",
+				.instr = TEST_PADDI(21, 22, SI_MIN, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = LONG_MIN,
+				}
+			},
+			{
+				.descr = "RA = LONG_MIN, SI = SI_MAX, R = 0",
+				.instr = TEST_PADDI(21, 22, SI_MAX, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = LONG_MIN,
+				}
+			},
+			{
+				.descr = "RA = LONG_MAX, SI = SI_MAX, R = 0",
+				.instr = TEST_PADDI(21, 22, SI_MAX, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = LONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, SI = SI_UMAX, R = 0",
+				.instr = TEST_PADDI(21, 22, SI_UMAX, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = ULONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, SI = 0x1, R = 0",
+				.instr = TEST_PADDI(21, 22, 0x1, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = ULONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, SI = SI_MIN, R = 0",
+				.instr = TEST_PADDI(21, 22, SI_MIN, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = INT_MIN,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, SI = SI_MAX, R = 0",
+				.instr = TEST_PADDI(21, 22, SI_MAX, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = INT_MIN,
+				}
+			},
+			{
+				.descr = "RA = INT_MAX, SI = SI_MAX, R = 0",
+				.instr = TEST_PADDI(21, 22, SI_MAX, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = INT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, SI = 0x1, R = 0",
+				.instr = TEST_PADDI(21, 22, 0x1, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = UINT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, SI = SI_MAX, R = 0",
+				.instr = TEST_PADDI(21, 22, SI_MAX, 0),
+				.regs = {
+					.gpr[21] = 0,
+					.gpr[22] = UINT_MAX,
+				}
+			},
+			{
+				.descr = "RA is r0, SI = SI_MIN, R = 0",
+				.instr = TEST_PADDI(21, 0, SI_MIN, 0),
+				.regs = {
+					.gpr[21] = 0x0,
+				}
+			},
+			{
+				.descr = "RA = 0, SI = SI_MIN, R = 0",
+				.instr = TEST_PADDI(21, 22, SI_MIN, 0),
+				.regs = {
+					.gpr[21] = 0x0,
+					.gpr[22] = 0x0,
+				}
+			},
+			{
+				.descr = "RA is r0, SI = 0, R = 1",
+				.instr = TEST_PADDI(21, 0, 0, 1),
+				.regs = {
+					.gpr[21] = 0,
+				}
+			},
+			{
+				.descr = "RA is r0, SI = SI_MIN, R = 1",
+				.instr = TEST_PADDI(21, 0, SI_MIN, 1),
+				.regs = {
+					.gpr[21] = 0,
+				}
+			}
+		}
 	}
 };
 
diff --git a/arch/powerpc/lib/test_emulate_step_exec_instr.S b/arch/powerpc/lib/test_emulate_step_exec_instr.S
index 1580f34f4f4f..aef53ee77a43 100644
--- a/arch/powerpc/lib/test_emulate_step_exec_instr.S
+++ b/arch/powerpc/lib/test_emulate_step_exec_instr.S
@@ -81,6 +81,7 @@ _GLOBAL(exec_instr)
 
 	/* Placeholder for the test instruction */
 1:	nop
+	nop
 	patch_site 1b patch__exec_instr
 
 	/*
-- 
2.17.1

