Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411hB620szzF34N
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 20:10:22 +1000 (AEST)
Message-Id: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] powerpc: make CPU selection logic generic in Makefile
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  7 Jun 2018 10:10:18 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the time being, when adding a new CPU for selection, both
Kconfig.cputype and Makefile have to be modified.

This patch moves into Kconfig.cputype the name of the CPU to me
passed to the -mcpu= argument.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile                  |  8 +-------
 arch/powerpc/platforms/Kconfig.cputype | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9704ab360d39..9a5642552abc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -175,13 +175,7 @@ ifdef CONFIG_MPROFILE_KERNEL
     endif
 endif
 
-CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
-CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
-CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
-CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
-CFLAGS-$(CONFIG_POWER8_CPU) += $(call cc-option,-mcpu=power8)
-CFLAGS-$(CONFIG_POWER9_CPU) += $(call cc-option,-mcpu=power9)
-CFLAGS-$(CONFIG_PPC_8xx) += $(call cc-option,-mcpu=860)
+CFLAGS-$(CONFIG_SPECIAL_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_SPECIAL_CPU))
 
 # Altivec option not allowed with e500mc64 in GCC.
 ifeq ($(CONFIG_ALTIVEC),y)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index cc892dcfa114..71ef559cc474 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -140,6 +140,21 @@ config E6500_CPU
 
 endchoice
 
+config SPECIAL_CPU_BOOL
+	bool
+	default !GENERIC_CPU
+
+config SPECIAL_CPU
+	string
+	depends on SPECIAL_CPU_BOOL
+	default "cell" if CELL_CPU
+	default "power5" if POWER5_CPU
+	default "power6" if POWER6_CPU
+	default "power7" if POWER7_CPU
+	default "power8" if POWER8_CPU
+	default "power9" if POWER9_CPU
+	default "860" if PPC_8xx
+
 config PPC_BOOK3S
 	def_bool y
 	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64
-- 
2.13.3
