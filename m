Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSck91G1FzDvp2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 19:52:17 +1100 (AEDT)
Message-Id: <8259e14796e5812af833c557ae5bab8b819cb92f.1480408630.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1480408630.git.christophe.leroy@c-s.fr>
References: <cover.1480408630.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc/32: Enable HW_BREAKPOINT on BOOK3S
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 Nov 2016 09:52:13 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BOOK3S also has DABR register and capability to handle data
breakpoints, so this patch enable it on all BOOK3S, not only 64 bits.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                 | 2 +-
 arch/powerpc/include/asm/processor.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d86643..5b736e4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -113,7 +113,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select SPARSE_IRQ
 	select IRQ_DOMAIN
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1ba8144..2053a4b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -225,6 +225,7 @@ struct thread_struct {
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumulated purr for process */
+#endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	struct perf_event *ptrace_bps[HBP_NUM];
 	/*
@@ -233,7 +234,6 @@ struct thread_struct {
 	 */
 	struct perf_event *last_hit_ubp;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
-#endif
 	struct arch_hw_breakpoint hw_brk; /* info on the hardware breakpoint */
 	unsigned long	trap_nr;	/* last trap # on this thread */
 	u8 load_fp;
-- 
2.10.1
