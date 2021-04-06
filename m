Return-Path: <SRS0=CtgL=JD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1545C433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 09:40:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684DB61040
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 09:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684DB61040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FF2ZM1NJ1z3dqR
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 19:40:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FF2X25vHqz3clg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Apr 2021 19:38:24 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FF2Ws20CTz9txTJ;
 Tue,  6 Apr 2021 11:38:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 03pPQZ_PdaOp; Tue,  6 Apr 2021 11:38:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FF2Ws0tTZz9txTH;
 Tue,  6 Apr 2021 11:38:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 31CB78B79E;
 Tue,  6 Apr 2021 11:38:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KsXH1uIQ6ZeQ; Tue,  6 Apr 2021 11:38:18 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B9B068B796;
 Tue,  6 Apr 2021 11:38:17 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 76C066766B; Tue,  6 Apr 2021 09:38:17 +0000 (UTC)
Message-Id: <e1723a06c5a26398ff03cb669ec99de2516045a9.1617701875.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/2] powerpc/inst: ppc_inst_as_u64() becomes
 ppc_inst_as_ulong()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 naveen.n.rao@linux.vnet.ibm.com
Date: Tue,  6 Apr 2021 09:38:17 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In order to simplify use on PPC32, change ppc_inst_as_u64()
into ppc_inst_as_ulong() that returns the 32 bits instruction
on PPC32.

Will be used when porting OPTPROBES to PPC32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/inst.h  | 13 +++++++------
 arch/powerpc/kernel/optprobes.c  |  2 +-
 arch/powerpc/lib/code-patching.c |  2 +-
 arch/powerpc/xmon/xmon.c         |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index cc73c1267572..8ea0b503f32f 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -113,13 +113,14 @@ static inline struct ppc_inst *ppc_inst_next(void *location, struct ppc_inst *va
 	return location + ppc_inst_len(tmp);
 }
 
-static inline u64 ppc_inst_as_u64(struct ppc_inst x)
+static inline unsigned long ppc_inst_as_ulong(struct ppc_inst x)
 {
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-	return (u64)ppc_inst_suffix(x) << 32 | ppc_inst_val(x);
-#else
-	return (u64)ppc_inst_val(x) << 32 | ppc_inst_suffix(x);
-#endif
+	if (IS_ENABLED(CONFIG_PPC32))
+		return ppc_inst_val(x);
+	else if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
+		return (u64)ppc_inst_suffix(x) << 32 | ppc_inst_val(x);
+	else
+		return (u64)ppc_inst_val(x) << 32 | ppc_inst_suffix(x);
 }
 
 #define PPC_INST_STR_LEN sizeof("00000000 00000000")
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 7f7cdbeacd1a..58fdb9f66e0f 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -264,7 +264,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	 * 3. load instruction to be emulated into relevant register, and
 	 */
 	temp = ppc_inst_read((struct ppc_inst *)p->ainsn.insn);
-	patch_imm64_load_insns(ppc_inst_as_u64(temp), 4, buff + TMPL_INSN_IDX);
+	patch_imm64_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
 
 	/*
 	 * 4. branch back from trampoline
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 65aec4d6d9ba..870b30d9be2f 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -26,7 +26,7 @@ static int __patch_instruction(struct ppc_inst *exec_addr, struct ppc_inst instr
 
 		__put_kernel_nofault(patch_addr, &val, u32, failed);
 	} else {
-		u64 val = ppc_inst_as_u64(instr);
+		u64 val = ppc_inst_as_ulong(instr);
 
 		__put_kernel_nofault(patch_addr, &val, u64, failed);
 	}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3fe37495f63d..ff10a357d41d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2980,7 +2980,7 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
 		if (!ppc_inst_prefixed(inst))
 			dump_func(ppc_inst_val(inst), adr);
 		else
-			dump_func(ppc_inst_as_u64(inst), adr);
+			dump_func(ppc_inst_as_ulong(inst), adr);
 		printf("\n");
 	}
 	return adr - first_adr;
-- 
2.25.0

