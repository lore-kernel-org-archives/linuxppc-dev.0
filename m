Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews03.kpnxchange.com (cpsmtpb-ews03.kpnxchange.com
 [213.75.39.6])
 by lists.ozlabs.org (Postfix) with ESMTP id 5BD5F1A04BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 05:59:47 +1000 (EST)
Message-ID: <1400615982.4912.62.camel@x220>
Subject: [PATCH] powerpc: fix typo 'CONFIG_PPC_CPU'
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Tue, 20 May 2014 21:59:42 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit cd64d1697cf0 ("powerpc: mtmsrd not defined") added a check for
CONFIG_PPC_CPU were a check for CONFIG_PPC_FPU was clearly intended.

Fixes: cd64d1697cf0 ("powerpc: mtmsrd not defined")
Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Entirely untested. This typo was introduced in v2.6.37. Did no one
notice? Anyhow, this really needs some testing.

 arch/powerpc/lib/sstep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index c0511c27a733..412dd46dd0b7 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1470,7 +1470,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 				regs->gpr[rd] = byterev_4(val);
 			goto ldst_done;
 
-#ifdef CONFIG_PPC_CPU
+#ifdef CONFIG_PPC_FPU
 		case 535:	/* lfsx */
 		case 567:	/* lfsux */
 			if (!(regs->msr & MSR_FP))
-- 
1.9.0
