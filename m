Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA528B7107
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 09:54:26 +1100 (EST)
Subject: [PATCH] powerpc: Fix call to flush_ptrace_hw_breakpoint()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 09:54:13 +1100
Message-ID: <1297032853.14982.3.camel@pasglop>
Mime-Version: 1.0
Cc: "K.Prasad" <prasad@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A typo in the #ifdef statement makes us never call it
in flush_thread()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 7a1d5cb..c4e4eab 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -670,11 +670,11 @@ void flush_thread(void)
 {
 	discard_lazy_cpu_state();
 
-#ifdef CONFIG_HAVE_HW_BREAKPOINTS
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
 	flush_ptrace_hw_breakpoint(current);
-#else /* CONFIG_HAVE_HW_BREAKPOINTS */
+#else /* CONFIG_HAVE_HW_BREAKPOINT */
 	set_debug_reg_defaults(&current->thread);
-#endif /* CONFIG_HAVE_HW_BREAKPOINTS */
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 }
 
 void
