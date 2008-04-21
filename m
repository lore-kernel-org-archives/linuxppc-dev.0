Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 646B2DE34F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 06:07:29 +1000 (EST)
Date: Mon, 21 Apr 2008 15:03:18 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] [POWERPC] ppc32: Fix errata for 603 CPUs
Message-ID: <Pine.LNX.4.64.0804211502530.13547@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

603 CPUs have the same issue that some 750 CPUs have in that they can crash
in funny ways if a store from an FPU register instruction is executed on a
register that has never been initialized since power on.  This patch fixes
it by making sure all FP registers have been properly initialized at kernel
boot.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Becky pointed out that I had a copy/paste issue (duplicated the call to
__init_fpu_registers).  Going to find the brown paper bag now.

Paul, (the update) is also in my powerpc-tree since its a pretty trivial patch.

- k

 arch/powerpc/kernel/cpu_setup_6xx.S |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index f1ee0b3..72d1d73 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -17,7 +17,13 @@
 #include <asm/cache.h>

 _GLOBAL(__setup_cpu_603)
-	b	setup_common_caches
+	mflr	r4
+BEGIN_FTR_SECTION
+	bl	__init_fpu_registers
+END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
+	bl	setup_common_caches
+	mtlr	r4
+	blr
 _GLOBAL(__setup_cpu_604)
 	mflr	r4
 	bl	setup_common_caches
-- 
1.5.4.1
