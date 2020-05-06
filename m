Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669E6C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 03:59:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325CA20752
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 03:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUlLUnKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325CA20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49H2sh1SsyzDr2F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 13:59:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=pUlLUnKD; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49H2X75l82zDqb1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2020 13:44:23 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id s18so174426pgl.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2020 20:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UZTktnDBzfmeSWNCUJYHZxeM/zuqQG6bPXTBZzsDXSE=;
 b=pUlLUnKDskGpBIdpNnzzezwFLMTWjrzqtjz2sCV2nIFs5/SSNwdbiuVrWCYAvjDzxV
 ZKNYhv+t/GVjz0XcJnZscM4XWFz3hLCJ0Iq6BCokKoGESenAMMrFiHHJyKQR+debA2XB
 JJmRMR3tzM11uLEA5AmiAwablOAO45fa2FCGeC+hMMZpJhYvBbSAi9modP9p3HpYo1Yf
 ivgh+6OoWtr6aRwRoQAgK0qv9HX9F5bnmeWYVSIZLSTbOIxmzkcDeyzNBRRgdIcUO1Md
 RI4thi3VmUFXmpUVy5JXKuxUAZYSME40bhKS39hT2nAiVePfNJce9KEEPmaSxQ/T8FJM
 8ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UZTktnDBzfmeSWNCUJYHZxeM/zuqQG6bPXTBZzsDXSE=;
 b=AYRGw+XlLwO47VQ72Wl4wxtKv+fI3e+b/K+m1Cf8EB9PjfOxdcVE5wI/ZKJun4dTQZ
 jMkj9bf682IhkAqIbLoW3T2t24ya2jVclqRR0QH7pe/404cCfh5ZVyK6rxspL9j3MQfg
 KUBpqjub8qWhlZWnGsynpnOMQVc6vgtNssrJEyAp6M8Gp1n1Wp/z93ye6omPdeoJT23E
 bjoHuKu6KYdB6GnO0Nkn8BEINzOLqdrG4+RBD2oCg9S4SukdMjdMxCGyKoYsW+wm+17z
 y24bAqCrUi3YWUFqAhuszBwpYieMU0Yf+/WLf4kr+q28yom8gcnratrKejLMMrk5kkwo
 b9JA==
X-Gm-Message-State: AGi0PuaBBRi5ATLENCFd/UAeAa2TG0hJB7sJ+ctHNENY3UIRORGTcKiN
 cfP213wb2FMXBSfBnvGa8HpCqQfxEGMDpQ==
X-Google-Smtp-Source: APiQypKT33DX1MlnuVLtYsTdwjVtTbs46N67suyCoJfl/Bk4JtwdHLmKzrwTAvVGgiG8CsKJG4ecrw==
X-Received: by 2002:aa7:8429:: with SMTP id q9mr6050831pfn.205.1588736661336; 
 Tue, 05 May 2020 20:44:21 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id k4sm465676pgg.88.2020.05.05.20.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 20:44:20 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 08/30] powerpc: Use a function for getting the instruction
 op code
Date: Wed,  6 May 2020 13:40:28 +1000
Message-Id: <20200506034050.24806-9-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506034050.24806-1-jniethe5@gmail.com>
References: <20200506034050.24806-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, npiggin@gmail.com, bala24@linux.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, Jordan Niethe <jniethe5@gmail.com>,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation for using a data type for instructions that can not be
directly used with the '>>' operator use a function for getting the op
code of an instruction.

Reviewed-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v4: New to series
v6: - Rename ppc_inst_primary() to ppc_inst_primary_opcode()
    - Use in vecemu.c, fault.c, sstep.c
    - Move this patch after the ppc_inst_val() patch
---
 arch/powerpc/include/asm/inst.h  | 5 +++++
 arch/powerpc/kernel/align.c      | 2 +-
 arch/powerpc/kernel/vecemu.c     | 3 ++-
 arch/powerpc/lib/code-patching.c | 4 ++--
 arch/powerpc/lib/sstep.c         | 2 +-
 arch/powerpc/mm/fault.c          | 3 ++-
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 8a9e73bfbd27..442a95f20de7 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -13,4 +13,9 @@ static inline u32 ppc_inst_val(u32 x)
 	return x;
 }
 
+static inline int ppc_inst_primary_opcode(u32 x)
+{
+	return ppc_inst_val(x) >> 26;
+}
+
 #endif /* _ASM_INST_H */
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 44921001f84a..47dbba81a227 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -314,7 +314,7 @@ int fix_alignment(struct pt_regs *regs)
 	}
 
 #ifdef CONFIG_SPE
-	if ((ppc_inst_val(instr) >> 26) == 0x4) {
+	if (ppc_inst_primary_opcode(instr) == 0x4) {
 		int reg = (ppc_inst_val(instr) >> 21) & 0x1f;
 		PPC_WARN_ALIGNMENT(spe, regs);
 		return emulate_spe(regs, reg, instr);
diff --git a/arch/powerpc/kernel/vecemu.c b/arch/powerpc/kernel/vecemu.c
index 1f5e3b4c8ae4..a544590b90e5 100644
--- a/arch/powerpc/kernel/vecemu.c
+++ b/arch/powerpc/kernel/vecemu.c
@@ -10,6 +10,7 @@
 #include <asm/processor.h>
 #include <asm/switch_to.h>
 #include <linux/uaccess.h>
+#include <asm/inst.h>
 
 /* Functions in vector.S */
 extern void vaddfp(vector128 *dst, vector128 *a, vector128 *b);
@@ -268,7 +269,7 @@ int emulate_altivec(struct pt_regs *regs)
 		return -EFAULT;
 
 	word = ppc_inst_val(instr);
-	if ((word >> 26) != 4)
+	if (ppc_inst_primary_opcode(instr) != 4)
 		return -EINVAL;		/* not an altivec instruction */
 	vd = (word >> 21) & 0x1f;
 	va = (word >> 16) & 0x1f;
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index baa849b1a1f9..f5c6dcbac44b 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -231,7 +231,7 @@ bool is_offset_in_branch_range(long offset)
  */
 bool is_conditional_branch(unsigned int instr)
 {
-	unsigned int opcode = instr >> 26;
+	unsigned int opcode = ppc_inst_primary_opcode(instr);
 
 	if (opcode == 16)       /* bc, bca, bcl, bcla */
 		return true;
@@ -289,7 +289,7 @@ int create_cond_branch(unsigned int *instr, const unsigned int *addr,
 
 static unsigned int branch_opcode(unsigned int instr)
 {
-	return (instr >> 26) & 0x3F;
+	return ppc_inst_primary_opcode(instr) & 0x3F;
 }
 
 static int instr_is_branch_iform(unsigned int instr)
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 14c93ee4ffc8..7f7be154da7e 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1175,7 +1175,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	word = ppc_inst_val(instr);
 	op->type = COMPUTE;
 
-	opcode = instr >> 26;
+	opcode = ppc_inst_primary_opcode(instr);
 	switch (opcode) {
 	case 16:	/* bc */
 		op->type = BRANCH;
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 9364921870df..0e7e145d5cad 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -41,6 +41,7 @@
 #include <asm/siginfo.h>
 #include <asm/debug.h>
 #include <asm/kup.h>
+#include <asm/inst.h>
 
 /*
  * Check whether the instruction inst is a store using
@@ -52,7 +53,7 @@ static bool store_updates_sp(unsigned int inst)
 	if (((ppc_inst_val(inst) >> 16) & 0x1f) != 1)
 		return false;
 	/* check major opcode */
-	switch (inst >> 26) {
+	switch (ppc_inst_primary_opcode(inst)) {
 	case OP_STWU:
 	case OP_STBU:
 	case OP_STHU:
-- 
2.17.1

