Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id E44C71A1E5F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 19:27:08 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/book3s32: Only select PPC_HAVE_PMU on e600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-Id: <20150903092704.2F4881A241D@localhost.localdomain>
Date: Thu,  3 Sep 2015 11:27:03 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC832x, perf record/report reports martian addresses

     2.62%  perf_reseau4  libpthread-2.18.so  [.] __libc_send
     2.56%  perf_reseau4  [kernel.kallsyms]   [k] __ip_make_skb
     1.62%  perf_reseau4  [kernel.kallsyms]   [k] __ip_append_data.isra.39
     1.55%  perf_reseau4  [kernel.kallsyms]   [k] ip_finish_output
     1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd94
     1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd95
     1.28%  perf_reseau4  [unknown]           [k] 0x7ffffd97
     1.26%  perf_reseau4  [unknown]           [k] 0x7ffffda3
     1.24%  perf_reseau4  [unknown]           [k] 0x7ffffd98
     1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd92
     1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd9b
     [.....]

This is due to function perf_instruction_pointer() reading SPR SIAR
which doesn't exist on e300 core. The perf_instruction_pointer() is
redefined in arch/powerpc/perf/core-book3s.c when CONFIG_PPC_PERF_CTRS
is selected.

This patch moves the selection of CONFIG_PPC_HAVE_PMU in 86xx section
so that CONFIG_PPC_PERF_CTRS won't be selected for other 6xx powerpc

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/86xx/Kconfig    | 1 +
 arch/powerpc/platforms/Kconfig.cputype | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 1afd1e4..bb24d2a 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -5,6 +5,7 @@ menuconfig PPC_86xx
 	select FSL_SOC
 	select ALTIVEC
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PPC_HAVE_PMU_SUPPORT
 	help
 	  The Freescale E600 SoCs have 74xx cores.
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d642cf9..aa63b12 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -143,7 +143,6 @@ config PPC_BOOK3E
 config 6xx
 	def_bool y
 	depends on PPC32 && PPC_BOOK3S
-	select PPC_HAVE_PMU_SUPPORT
 
 config TUNE_CELL
 	bool "Optimize for Cell Broadband Engine"
-- 
2.1.0
