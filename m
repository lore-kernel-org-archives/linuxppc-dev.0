Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A174C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 13:52:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA99610CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 13:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA99610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmB4J1j63z3cDp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 23:52:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmB306zNhz3bs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 23:50:52 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FmB2r0gBWz9sTj;
 Thu, 20 May 2021 15:50:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkUNlopGdymH; Thu, 20 May 2021 15:50:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FmB2m4ZnSz9sTN;
 Thu, 20 May 2021 15:50:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 776178B808;
 Thu, 20 May 2021 15:50:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QyH_CX4cZUSU; Thu, 20 May 2021 15:50:40 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.105])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 360E68B814;
 Thu, 20 May 2021 15:50:40 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2B85E64C40; Thu, 20 May 2021 13:50:40 +0000 (UTC)
Message-Id: <fb097fda78cc6852905ef00f8f7bf371b6cc66f7.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 03/12] powerpc/inst: Improve readability of
 get_user_instr() and friends
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Date: Thu, 20 May 2021 13:50:40 +0000 (UTC)
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

Remove unneeded line splits.

And remove unneeded local variable initialisation.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Don't use get_op() for now as including asm/disassemble.h conflicts with drivers/staging/rtl8723bs/include/wifi.h
---
 arch/powerpc/include/asm/inst.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 57c31e712e67..fc6adef528a5 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -8,7 +8,7 @@
 
 #define ___get_user_instr(gu_op, dest, ptr)				\
 ({									\
-	long __gui_ret = 0;						\
+	long __gui_ret;							\
 	unsigned int __user *__gui_ptr = (unsigned int __user *)ptr;	\
 	struct ppc_inst __gui_inst;					\
 	unsigned int __prefix, __suffix;				\
@@ -18,8 +18,7 @@
 	if (__gui_ret == 0) {						\
 		if ((__prefix >> 26) == OP_PREFIX) {			\
 			__gui_ret = gu_op(__suffix, __gui_ptr + 1);	\
-			__gui_inst = ppc_inst_prefix(__prefix,		\
-						     __suffix);		\
+			__gui_inst = ppc_inst_prefix(__prefix, __suffix); \
 		} else {						\
 			__gui_inst = ppc_inst(__prefix);		\
 		}							\
@@ -36,11 +35,9 @@
 })
 #endif /* CONFIG_PPC64 */
 
-#define get_user_instr(x, ptr) \
-	___get_user_instr(get_user, x, ptr)
+#define get_user_instr(x, ptr) ___get_user_instr(get_user, x, ptr)
 
-#define __get_user_instr(x, ptr) \
-	___get_user_instr(__get_user, x, ptr)
+#define __get_user_instr(x, ptr) ___get_user_instr(__get_user, x, ptr)
 
 /*
  * Instruction data type for POWER
@@ -75,13 +72,12 @@ static inline u32 ppc_inst_suffix(struct ppc_inst x)
 
 static inline bool ppc_inst_prefixed(struct ppc_inst x)
 {
-	return (ppc_inst_primary_opcode(x) == 1) && ppc_inst_suffix(x) != 0xff;
+	return ppc_inst_primary_opcode(x) == OP_PREFIX && ppc_inst_suffix(x) != 0xff;
 }
 
 static inline struct ppc_inst ppc_inst_swab(struct ppc_inst x)
 {
-	return ppc_inst_prefix(swab32(ppc_inst_val(x)),
-			       swab32(ppc_inst_suffix(x)));
+	return ppc_inst_prefix(swab32(ppc_inst_val(x)), swab32(ppc_inst_suffix(x)));
 }
 
 static inline struct ppc_inst ppc_inst_read(const struct ppc_inst *ptr)
-- 
2.25.0

