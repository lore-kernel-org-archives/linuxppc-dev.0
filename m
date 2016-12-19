Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8cH5xrdzDwNl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:39 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id g1so7405229pgn.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 06/10] powerpc: nmi_enter for system reset
Date: Tue, 20 Dec 2016 04:30:07 +1000
Message-Id: <20161219183011.28310-7-npiggin@gmail.com>
In-Reply-To: <20161219183011.28310-1-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

System reset is a non-maskable interrupt from Linux's point of view
(occurs under local_irq_disable()), so it should use nmi_enter/exit.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 802aa6bbe97b..c65c88fb6482 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -278,6 +278,14 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 
 void system_reset_exception(struct pt_regs *regs)
 {
+	/*
+	 * Avoid crashes in case of nested NMI exceptions. Recoverability
+	 * is determined by RI and in_nmi
+	 */
+	bool nested = in_nmi();
+	if (!nested)
+		nmi_enter();
+
 	/* See if any machine dependent calls */
 	if (ppc_md.system_reset_exception) {
 		if (ppc_md.system_reset_exception(regs))
@@ -296,6 +304,9 @@ void system_reset_exception(struct pt_regs *regs)
 	if (!(regs->msr & MSR_RI))
 		panic("Unrecoverable System Reset");
 
+	if (!nested)
+		nmi_exit();
+
 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
 
-- 
2.11.0
