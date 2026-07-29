Return-Path: <linuxppc-dev+bounces-25041-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ACAC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 20:58:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9PnH5SG9z2ySg;
	Thu, 30 Jul 2026 06:58:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785358707;
	cv=none; b=RKouYQriDoKaKO1XHJbjv708URqdzYRcqlQlZWI3b1TL0G4x354jPd6qzzWp95bRy1mIKVMqT5aRrYndLzDr6ruXZpUrdEIAPqYqmLnJvXjtlti+zkVcceJNQU6R+Bnb2+YXQml5FtGjlZIPnOWf8EyaJvXCir4gi+3blyHKaqHjRFLIreP5y1TzI1crBldTIRBszaa3ku3YqXvCk5bskJkzX4zodEWslMV2y/0Fb6JqvFJKmiF1QX9+ABEWtcLbs8igAVWjZkRabSvyBYZdYFOYE71iV6FC9Az3I8qVxcAIdXShJmC/n4Np5hG0sLpcl1nijHdrCshXzRHB+3ow5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785358707; c=relaxed/relaxed;
	bh=eRwMXLUiKlItt58QVFLV9xyj7xuj/HykkTNxWl054u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ++80SvGKbuTiclah9+uyN2Ty8euU1ELWQ0Xx0JG/kr4dj+1uBuEK1cz1VVHouJC+ytHjSAQ56gsf4QCMCifjUyCgnwhnMVxrQFbsqqNCM/4rwMeSpjyuqdMoWLktpS727pTTLQ+Vyup0uyZZVS6Q6zJSHuu7OiHhRYaHTlOwZjT49taGvF35HIXnWGSi73ECcppTXP1hEm4BmBAvKkc0gLbUHsjiBpzmJ+zJV93Vg1p64BNyHSlWeAXZYxag+OfEHXA3fdJrsUtuZqTbjZmRpY2lVN0TD+ra0P6W4qCIMbKm95TJ+eFb+rZdFG+mlP+wQrtwNy+PNKd3pPjwfTGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9PnG5m4fz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 06:58:26 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 872AC70932E4; Wed, 29 Jul 2026 22:50:03 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH 1/2] powerpc/sstep: Consistently use one define to check arch bit width
Date: Wed, 29 Jul 2026 22:49:55 +0200
Message-ID: <20260729204958.755143-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729204958.755143-1-linkmauve@linkmauve.fr>
References: <20260729204958.755143-1-linkmauve@linkmauve.fr>
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

Previously, both CONFIG_PPC64 and __powerpc64__ were being used to check
whether we were on 32-bit or on 64-bit PowerPC, sometimes in a single
function.

I picked __powerpc64__ since it was used six times as much as
CONFIG_PPC64 in this file, but could be convinced to use the other one
if there is any reason to prefer it.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 arch/powerpc/lib/sstep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index f0d6aa657c1a..597a0d841fe8 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -15,7 +15,7 @@
 #include <asm/cputable.h>
 #include <asm/disassemble.h>
 
-#ifdef CONFIG_PPC64
+#ifdef __powerpc64__
 /* Bits in SRR1 that are copied from MSR */
 #define MSR_MASK	0xffffffff87c0ffffUL
 #else
@@ -1256,7 +1256,7 @@ static nokprobe_inline void do_popcnt(const struct pt_regs *regs,
 	op->val = out;	/* popcntd */
 }
 
-#ifdef CONFIG_PPC64
+#ifdef __powerpc64__
 static nokprobe_inline void do_bpermd(const struct pt_regs *regs,
 				      struct instruction_op *op,
 				      unsigned long v1, unsigned long v2)
@@ -1273,7 +1273,7 @@ static nokprobe_inline void do_bpermd(const struct pt_regs *regs,
 	}
 	op->val = perm;
 }
-#endif /* CONFIG_PPC64 */
+#endif /* __powerpc64__ */
 /*
  * The size parameter adjusts the equivalent prty instruction.
  * prtyw = 32, prtyd = 64
@@ -1340,7 +1340,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
 int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		  ppc_inst_t instr)
 {
-#ifdef CONFIG_PPC64
+#ifdef __powerpc64__
 	unsigned int suffixopcode, prefixtype, prefix_r;
 #endif
 	unsigned int opcode, ra, rb, rc, rd, spr, u;
@@ -1739,7 +1739,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->reg = rd;
 			op->val = 0xffffffff & ~(MSR_ME | MSR_LE);
 			return 0;
-#ifdef CONFIG_PPC64
+#ifdef __powerpc64__
 		case 178:	/* mtmsrd */
 			if (user_mode(regs))
 				goto priv;
@@ -2054,7 +2054,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 186:	/* prtyd */
 			do_prty(regs, op, regs->gpr[rd], 64);
 			goto logical_done_nocc;
-#ifdef CONFIG_PPC64
+#ifdef __powerpc64__
 		case 252:	/* bpermd */
 			do_bpermd(regs, op, regs->gpr[rd], regs->gpr[rb]);
 			goto logical_done_nocc;
@@ -2082,7 +2082,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 476:	/* nand */
 			op->val = ~(regs->gpr[rd] & regs->gpr[rb]);
 			goto logical_done;
-#ifdef CONFIG_PPC64
+#ifdef __powerpc64__
 		case 506:	/* popcntd */
 			do_popcnt(regs, op, regs->gpr[rd], 64);
 			goto logical_done_nocc;
@@ -3247,7 +3247,7 @@ void emulate_update_regs(struct pt_regs *regs, struct instruction_op *op)
 		case BARRIER_EIEIO:
 			eieio();
 			break;
-#ifdef CONFIG_PPC64
+#ifdef __powerpc64__
 		case BARRIER_LWSYNC:
 			asm volatile("lwsync" : : : "memory");
 			break;
-- 
2.55.0


