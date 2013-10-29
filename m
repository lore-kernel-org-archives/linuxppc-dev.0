Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD6C62C010C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 14:11:00 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix PPC_EMULATED_STATS build break with sync patch
Date: Mon, 28 Oct 2013 22:10:52 -0500
Message-ID: <1383016252-9024-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, James Yang <James.Yang@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Kumar Gala <galak@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9863c28a2af90a56c088f5f6288d7f6d2c923c14 ("powerpc: Emulate sync
instruction variants") introduced a build breakage with
CONFIG_PPC_EMULATED_STATS enabled.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Kumar Gala <galak@kernel.org>
Cc: James Yang <James.Yang@freescale.com>
---
---
 arch/powerpc/include/asm/emulated_ops.h | 1 +
 arch/powerpc/kernel/traps.c             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/emulated_ops.h b/arch/powerpc/include/asm/emulated_ops.h
index 5a8b82a..4358e30 100644
--- a/arch/powerpc/include/asm/emulated_ops.h
+++ b/arch/powerpc/include/asm/emulated_ops.h
@@ -43,6 +43,7 @@ extern struct ppc_emulated {
 	struct ppc_emulated_entry popcntb;
 	struct ppc_emulated_entry spe;
 	struct ppc_emulated_entry string;
+	struct ppc_emulated_entry sync;
 	struct ppc_emulated_entry unaligned;
 #ifdef CONFIG_MATH_EMULATION
 	struct ppc_emulated_entry math;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ad20dcf..62c3dd8 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1820,6 +1820,7 @@ struct ppc_emulated ppc_emulated = {
 	WARN_EMULATED_SETUP(popcntb),
 	WARN_EMULATED_SETUP(spe),
 	WARN_EMULATED_SETUP(string),
+	WARN_EMULATED_SETUP(sync),
 	WARN_EMULATED_SETUP(unaligned),
 #ifdef CONFIG_MATH_EMULATION
 	WARN_EMULATED_SETUP(math),
-- 
1.8.1.2
