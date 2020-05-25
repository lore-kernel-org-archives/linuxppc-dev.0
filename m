Return-Path: <SRS0=r5XJ=7H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375B6C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 05:51:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4BB2075F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 05:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rIekukJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4BB2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49VmRy5KPLzDqSQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 15:51:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49VmQ2473rzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2020 15:49:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=rIekukJH; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 49VmQ21FFKz9sSd; Mon, 25 May 2020 15:49:46 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49VmQ20HV4z9sSg; Mon, 25 May 2020 15:49:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1590385786;
 bh=KWjSOfqqI9h/ttyQwQourNPrF84xkR9tSSEw7GUTOVE=;
 h=From:To:Cc:Subject:Date:From;
 b=rIekukJHYv9tbBYvtC5o/oOTaoimO8Cifbfu7HoEmxdToZ5FBUF2z7b1H1FxkPc+a
 SdOeNX/Qmllf5Jz1bt5dfwZOQ18QDN5gADiPopsNgSXXBRYmWNq8XjF4i9/SZpAfJb
 7bIpxsIa2ZBnwELdDPHVZKslKFt07PLssd6uxCktkhghQbhmxL/JTsce/CCTtpqd8h
 ptr2gK72O0Xzy3Vaz3IfZbp7OlXt//4WiHRDbbaaxncUSZBPKvzBCJKADPO3wzo8YZ
 bgS3KFViv5SzHERvPt5CEPnqgmp4CO15F3ojzs9rR/qSEB1/GbPEIuLyxluq6JtD41
 1NS72HxsuNoog==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add ppc_inst_as_u64()
Date: Mon, 25 May 2020 15:50:04 +1000
Message-Id: <20200525055004.2182328-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Cc: jniethe5@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The code patching code wants to get the value of a struct ppc_inst as
a u64 when the instruction is prefixed, so we can pass the u64 down to
__put_user_asm() and write it with a single store.

This is a bit awkward because the value differs based on the CPU
endianness, so add a helper to do the conversion.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/inst.h  | 9 +++++++++
 arch/powerpc/kernel/optprobes.c  | 3 +--
 arch/powerpc/lib/code-patching.c | 8 +-------
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index d82e0c99cfa1..d61e07fb2937 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -100,6 +100,15 @@ static inline int ppc_inst_len(struct ppc_inst x)
 	return ppc_inst_prefixed(x) ? 8 : 4;
 }
 
+static inline u64 ppc_inst_as_u64(struct ppc_inst x)
+{
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	return (u64)ppc_inst_suffix(x) << 32 | ppc_inst_val(x);
+#else
+	return (u64)ppc_inst_val(x) << 32 | ppc_inst_suffix(x);
+#endif
+}
+
 int probe_user_read_inst(struct ppc_inst *inst,
 			 struct ppc_inst __user *nip);
 
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 3ac105e7faae..69bfe96884e2 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -283,8 +283,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	 * 3. load instruction to be emulated into relevant register, and
 	 */
 	temp = ppc_inst_read((struct ppc_inst *)p->ainsn.insn);
-	patch_imm64_load_insns(ppc_inst_val(temp) | ((u64)ppc_inst_suffix(temp) << 32),
-			       4, buff + TMPL_INSN_IDX);
+	patch_imm64_load_insns(ppc_inst_as_u64(temp), 4, buff + TMPL_INSN_IDX);
 
 	/*
 	 * 4. branch back from trampoline
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 64cf621e5b00..5ecf0d635a8d 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -27,13 +27,7 @@ static int __patch_instruction(struct ppc_inst *exec_addr, struct ppc_inst instr
 	if (!ppc_inst_prefixed(instr)) {
 		__put_user_asm(ppc_inst_val(instr), patch_addr, err, "stw");
 	} else {
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-		__put_user_asm((u64)ppc_inst_suffix(instr) << 32 |
-			       ppc_inst_val(instr), patch_addr, err, "std");
-#else
-		__put_user_asm((u64)ppc_inst_val(instr) << 32 |
-			       ppc_inst_suffix(instr), patch_addr, err, "std");
-#endif
+		__put_user_asm(ppc_inst_as_u64(instr), patch_addr, err, "std");
 	}
 
 	if (err)
-- 
2.25.1

