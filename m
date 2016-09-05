Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSKsn2PvyzDrn7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 16:42:37 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: add system_reset_exception
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160905064232.2CEB11A245A@localhost.localdomain>
Date: Mon,  5 Sep 2016 08:42:31 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the watchdog is in NMI mode, the system reset interrupt is
generated when the watchdog counter expires.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 2 +-
 arch/powerpc/kernel/traps.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 43ddaae..f7b8007 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -227,7 +227,7 @@ i##n:								\
 			  ret_from_except)
 
 /* System reset */
-	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
+	EXCEPTION(0x100, Reset, system_reset_exception, EXC_XFER_STD)
 
 /* Machine check */
 	. = 0x200
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2cb5892..f8fa11b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -269,7 +269,6 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	force_sig_info(signr, &info, current);
 }
 
-#ifdef CONFIG_PPC64
 void system_reset_exception(struct pt_regs *regs)
 {
 	/* See if any machine dependent calls */
@@ -287,6 +286,7 @@ void system_reset_exception(struct pt_regs *regs)
 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
 
+#ifdef CONFIG_PPC64
 /*
  * This function is called in real mode. Strictly no printk's please.
  *
-- 
2.1.0
