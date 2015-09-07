Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 8E2721A2A7D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 00:24:50 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc32: memcpy: only use dcbz once cache is enabled
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com, sojkam1@fel.cvut.cz
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20150907142444.CA8F31A241A@localhost.localdomain>
Date: Mon,  7 Sep 2015 16:24:44 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memcpy() uses instruction dcbz to speed up copy by not wasting time
loading cache line with data that will be overwritten.
Some platform like mpc52xx do no have cache active at startup and
can therefore not use memcpy(). Allthough no part of the code
explicitly uses memcpy(), GCC makes calls to it.

This patch modifies memcpy() such that at startup, the 'dcbz'
instruction is replaced by 'dcbt' which is harmless if cache is not
enabled, and which helps a bit (allthough not as much as dcbz) if
cache is already enabled.

Once the initial MMU is setup, in machine_init() we patch memcpy()
by replacing the temporary 'dcbt' by 'dcbz'

Reported-by: Michal Sojka <sojkam1@fel.cvut.cz>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
@Michal, can you please test it ?

 arch/powerpc/kernel/setup_32.c | 12 ++++++++++++
 arch/powerpc/lib/copy_32.S     | 11 ++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 07831ed..93715f3 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -39,6 +39,7 @@
 #include <asm/udbg.h>
 #include <asm/mmu_context.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/code-patching.h>
 
 #define DBG(fmt...)
 
@@ -108,6 +109,15 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
 	return KERNELBASE + offset;
 }
 
+extern unsigned int ppc32_memcpy_dcbz;
+notrace void __init patch_memcpy(void)
+{
+	unsigned int instr = ppc32_memcpy_dcbz;
+
+	instr &= 0x001ff800; /* keep only RA and RB */
+	instr |= 0x7c0007ec; /* dcbz */
+	patch_instruction(&ppc32_memcpy_dcbz, instr);
+}
 
 /*
  * Find out what kind of machine we're on and save any data we need
@@ -122,6 +132,8 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
+	patch_memcpy();
+
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 2ef50c6..05b3096 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -172,7 +172,16 @@ _GLOBAL(memcpy)
 	mtctr	r0
 	beq	63f
 53:
-	dcbz	r11,r6
+	/*
+	 * During early init, cache might not be active yet, so dcbz cannot be
+	 * used. We put dcbt instead of dcbz. If cache is not active, it's just
+	 * like a not. If cache is active, at least it prefetchs the line to be
+	 * overwritten.
+	 * Will be replaced by dcbz in machine_init()
+	 */
+_GLOBAL(ppc32_memcpy_dcbz)
+	dcbt	r11,r6
+
 	COPY_16_BYTES
 #if L1_CACHE_BYTES >= 32
 	COPY_16_BYTES
-- 
2.1.0
