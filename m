Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hFPM2XS6zF2RZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 11:04:39 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id z70-v6so196415pgz.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 18:04:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/64: change softe to irqmask in show_regs and xmon
Date: Thu, 10 May 2018 11:04:24 +1000
Message-Id: <20180510010424.16854-2-npiggin@gmail.com>
In-Reply-To: <20180510010424.16854-1-npiggin@gmail.com>
References: <20180510010424.16854-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the soft enabled flag was changed to a soft disable mask, xmon
and register dump code was not updated to reflect that, which is
confusing ('SOFTE: 1' previously meant interrupts were soft enabled,
currently it means the opposite, the general interrupt type has been
disabled).

Fix this by using the name irqmask, and printing it in hex.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/process.c | 2 +-
 arch/powerpc/xmon/xmon.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1237f13fed51..52b1c379d618 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1437,7 +1437,7 @@ void show_regs(struct pt_regs * regs)
 		pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
 #endif
 #ifdef CONFIG_PPC64
-	pr_cont("SOFTE: %ld ", regs->softe);
+	pr_cont("IRQMASK: %lx ", regs->softe);
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (MSR_TM_ACTIVE(regs->msr))
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0842f1ff72c..05f648a55fa3 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1636,7 +1636,7 @@ static void excprint(struct pt_regs *fp)
 
 	printf("  current = 0x%lx\n", current);
 #ifdef CONFIG_PPC64
-	printf("  paca    = 0x%lx\t softe: %d\t irq_happened: 0x%02x\n",
+	printf("  paca    = 0x%lx\t irqmask: 0x%02x\t irq_happened: 0x%02x\n",
 	       local_paca, local_paca->irq_soft_mask, local_paca->irq_happened);
 #endif
 	if (current) {
-- 
2.17.0
