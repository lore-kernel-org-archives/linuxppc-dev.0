Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9B1C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:08:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0978E64F04
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0978E64F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F21NG5YvDz3bwH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 22:08:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F21LW4B4jz302r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 22:06:57 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F21LQ0rPfz9tx8y;
 Fri, 19 Mar 2021 12:06:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 0VCYq4XgH91C; Fri, 19 Mar 2021 12:06:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LP6nRPz9tx8s;
 Fri, 19 Mar 2021 12:06:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 83E5C8B975;
 Fri, 19 Mar 2021 12:06:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VTg0wwmbtZAW; Fri, 19 Mar 2021 12:06:54 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F14668B974;
 Fri, 19 Mar 2021 12:06:53 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id CD3EA675FB; Fri, 19 Mar 2021 11:06:53 +0000 (UTC)
Message-Id: <8cef43607e5b35a7fd0829dec812d88beb570df2.1616151715.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 04/10] powerpc/signal32: Rename save_user_regs_unsafe() and
 save_general_regs_unsafe()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 cmr@codefail.de
Date: Fri, 19 Mar 2021 11:06:53 +0000 (UTC)
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

Convention is to prefix functions with __unsafe_ instead of
suffixing it with _unsafe.

Rename save_user_regs_unsafe() and save_general_regs_unsafe()
accordingly, that is respectively __unsafe_save_general_regs() and
__unsafe_save_user_regs().

Suggested-by: Christopher M. Riedl <cmr@codefail.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index c505b444a613..3b78748d6d85 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -94,7 +94,7 @@ static inline int get_sigset_t(sigset_t *set,
 #define from_user_ptr(p)	compat_ptr(p)
 
 static __always_inline int
-save_general_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame)
+__unsafe_save_general_regs(struct pt_regs *regs, struct mcontext __user *frame)
 {
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int val, i;
@@ -151,7 +151,7 @@ static inline int get_sigset_t(sigset_t *set, const sigset_t __user *uset)
 #define from_user_ptr(p)	((void __user *)(p))
 
 static __always_inline int
-save_general_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame)
+__unsafe_save_general_regs(struct pt_regs *regs, struct mcontext __user *frame)
 {
 	WARN_ON(!FULL_REGS(regs));
 	unsafe_copy_to_user(&frame->mc_gregs, regs, GP_REGS_SIZE, failed);
@@ -177,7 +177,7 @@ static inline int restore_general_regs(struct pt_regs *regs,
 #endif
 
 #define unsafe_save_general_regs(regs, frame, label) do {	\
-	if (save_general_regs_unsafe(regs, frame))	\
+	if (__unsafe_save_general_regs(regs, frame))		\
 		goto label;					\
 } while (0)
 
@@ -260,8 +260,8 @@ static void prepare_save_user_regs(int ctx_has_vsx_region)
 #endif
 }
 
-static int save_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
-				 struct mcontext __user *tm_frame, int ctx_has_vsx_region)
+static int __unsafe_save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
+				   struct mcontext __user *tm_frame, int ctx_has_vsx_region)
 {
 	unsigned long msr = regs->msr;
 
@@ -338,7 +338,7 @@ static int save_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *f
 }
 
 #define unsafe_save_user_regs(regs, frame, tm_frame, has_vsx, label) do { \
-	if (save_user_regs_unsafe(regs, frame, tm_frame, has_vsx))	\
+	if (__unsafe_save_user_regs(regs, frame, tm_frame, has_vsx))	\
 		goto label;						\
 } while (0)
 
@@ -350,7 +350,7 @@ static int save_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *f
  * We also save the transactional registers to a second ucontext in the
  * frame.
  *
- * See save_user_regs_unsafe() and signal_64.c:setup_tm_sigcontexts().
+ * See __unsafe_save_user_regs() and signal_64.c:setup_tm_sigcontexts().
  */
 static void prepare_save_tm_user_regs(void)
 {
@@ -441,7 +441,7 @@ static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/* SPE regs are not checkpointed with TM, so this section is
-	 * simply the same as in save_user_regs_unsafe().
+	 * simply the same as in __unsafe_save_user_regs().
 	 */
 	if (current->thread.used_spe) {
 		unsafe_copy_to_user(&frame->mc_vregs, current->thread.evr,
-- 
2.25.0

