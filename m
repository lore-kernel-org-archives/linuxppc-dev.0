Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9260C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 10:26:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A2661019
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 10:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A2661019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fm5WQ0y4Vz3dj7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 20:26:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fm5S13RKSz3c2d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 20:23:45 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Fm5RP0yJGz9sVM;
 Thu, 20 May 2021 12:23:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lyORN56gO6fB; Thu, 20 May 2021 12:23:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Fm5RL6F4Hz9sVm;
 Thu, 20 May 2021 12:23:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C488C8B811;
 Thu, 20 May 2021 12:23:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id nd7usmZ46FH0; Thu, 20 May 2021 12:23:10 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.105])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 92A6C8B80D;
 Thu, 20 May 2021 12:23:10 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 7B6C164C44; Thu, 20 May 2021 10:23:10 +0000 (UTC)
Message-Id: <0945c155d6cb113431185fc1296ac127359fe29b.1621506159.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
References: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 11/12] powerpc/traps: Start using PPC_RAW_xx() macros
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Date: Thu, 20 May 2021 10:23:10 +0000 (UTC)
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

Start using PPC_RAW_xx() macros where relevant.

PPC_INST_SYNC is used to both represent the 'sync' instruction and
the family of synchronisation instructions. Keep it for the later,
maybe we'll change the name in the future to avoid confusion.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 1 -
 arch/powerpc/kernel/traps.c           | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 027af76db4bd..2e428ed7511a 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -256,7 +256,6 @@
 #define PPC_INST_LWSYNC			0x7c2004ac
 #define PPC_INST_SYNC			0x7c0004ac
 #define PPC_INST_SYNC_MASK		0xfc0007fe
-#define PPC_INST_ISYNC			0x4c00012c
 #define PPC_INST_MCRXR			0x7c000400
 #define PPC_INST_MCRXR_MASK		0xfc0007fe
 #define PPC_INST_MFSPR_PVR		0x7c1f42a6
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b4ab95c9e94a..c929d93c35d0 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -67,6 +67,7 @@
 #include <asm/kprobes.h>
 #include <asm/stacktrace.h>
 #include <asm/nmi.h>
+#include <asm/disassemble.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -537,11 +538,11 @@ static inline int check_io_access(struct pt_regs *regs)
 		 * For the debug message, we look at the preceding
 		 * load or store.
 		 */
-		if (*nip == PPC_INST_NOP)
+		if (*nip == PPC_RAW_NOP())
 			nip -= 2;
-		else if (*nip == PPC_INST_ISYNC)
+		else if (*nip == PPC_RAW_ISYNC())
 			--nip;
-		if (*nip == PPC_INST_SYNC || (*nip >> 26) == OP_TRAP) {
+		if (*nip == PPC_RAW_SYNC() || get_op(*nip) == OP_TRAP) {
 			unsigned int rb;
 
 			--nip;
-- 
2.25.0

