Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC52C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 10:23:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37156101D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 10:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37156101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fm5Rb3xZhz308T
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 20:23:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fm5RF07pDz2xtn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 20:23:03 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Fm5R86kxbz9sVZ;
 Thu, 20 May 2021 12:23:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ngyOS56h54P6; Thu, 20 May 2021 12:23:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Fm5R85VQBz9sVM;
 Thu, 20 May 2021 12:23:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 991348B811;
 Thu, 20 May 2021 12:23:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id JEWw6BsujQTs; Thu, 20 May 2021 12:23:00 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.105])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C7DC8B80D;
 Thu, 20 May 2021 12:23:00 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 3D58964C44; Thu, 20 May 2021 10:23:00 +0000 (UTC)
Message-Id: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 01/12] powerpc: Rework PPC_RAW_xxx() macros for prefixed
 instructions
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Date: Thu, 20 May 2021 10:23:00 +0000 (UTC)
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

At the time being, we have PPC_RAW_PLXVP() and PPC_RAW_PSTXVP() which
provide a 64 bits value, and then it gets split by open coding to
format it into a 'struct ppc_inst' instruction.

Instead, define a PPC_RAW_xxx_P() and a PPC_RAW_xxx_S() to be used
as is.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 8 ++++----
 arch/powerpc/lib/test_emulate_step.c  | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index ac41776661e9..403067ba170e 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -404,10 +404,10 @@
 #define PPC_RAW_STXVP(xsp, a, i)	(0x18000001 | __PPC_XSP(xsp) | ___PPC_RA(a) | IMM_DQ(i))
 #define PPC_RAW_LXVPX(xtp, a, b)	(0x7c00029a | __PPC_XTP(xtp) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_STXVPX(xsp, a, b)	(0x7c00039a | __PPC_XSP(xsp) | ___PPC_RA(a) | ___PPC_RB(b))
-#define PPC_RAW_PLXVP(xtp, i, a, pr) \
-	((PPC_PREFIX_8LS | __PPC_PRFX_R(pr) | IMM_D0(i)) << 32 | (0xe8000000 | __PPC_XTP(xtp) | ___PPC_RA(a) | IMM_D1(i)))
-#define PPC_RAW_PSTXVP(xsp, i, a, pr) \
-	((PPC_PREFIX_8LS | __PPC_PRFX_R(pr) | IMM_D0(i)) << 32 | (0xf8000000 | __PPC_XSP(xsp) | ___PPC_RA(a) | IMM_D1(i)))
+#define PPC_RAW_PLXVP_P(xtp, i, a, pr)	(PPC_PREFIX_8LS | __PPC_PRFX_R(pr) | IMM_D0(i))
+#define PPC_RAW_PLXVP_S(xtp, i, a, pr)	(0xe8000000 | __PPC_XTP(xtp) | ___PPC_RA(a) | IMM_D1(i))
+#define PPC_RAW_PSTXVP_P(xsp, i, a, pr)	(PPC_PREFIX_8LS | __PPC_PRFX_R(pr) | IMM_D0(i))
+#define PPC_RAW_PSTXVP_S(xsp, i, a, pr)	(0xf8000000 | __PPC_XSP(xsp) | ___PPC_RA(a) | IMM_D1(i))
 #define PPC_RAW_NAP			(0x4c000364)
 #define PPC_RAW_SLEEP			(0x4c0003a4)
 #define PPC_RAW_WINKLE			(0x4c0003e4)
diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 783d1b85ecfe..f7c74f4f684b 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -824,8 +824,7 @@ static void __init test_plxvp_pstxvp(void)
 	 * XTp = 32xTX + 2xTp
 	 * let RA=3 R=0 D=d0||d1=0 R=0 Tp=1 TX=1
 	 */
-	instr = ppc_inst_prefix(PPC_RAW_PLXVP(34, 0, 3, 0) >> 32,
-			PPC_RAW_PLXVP(34, 0, 3, 0) & 0xffffffff);
+	instr = ppc_inst_prefix(PPC_RAW_PLXVP_P(34, 0, 3, 0), PPC_RAW_PLXVP_S(34, 0, 3, 0));
 
 	stepped = emulate_step(&regs, instr);
 	if (stepped == 1 && cpu_has_feature(CPU_FTR_VSX)) {
@@ -853,8 +852,7 @@ static void __init test_plxvp_pstxvp(void)
 	 * XSp = 32xSX + 2xSp
 	 * let RA=3 D=d0||d1=0 R=0 Sp=1 SX=1
 	 */
-	instr = ppc_inst_prefix(PPC_RAW_PSTXVP(34, 0, 3, 0) >> 32,
-			PPC_RAW_PSTXVP(34, 0, 3, 0) & 0xffffffff);
+	instr = ppc_inst_prefix(PPC_RAW_PSTXVP_P(34, 0, 3, 0), PPC_RAW_PSTXVP_S(34, 0, 3, 0));
 
 	stepped = emulate_step(&regs, instr);
 
-- 
2.25.0

