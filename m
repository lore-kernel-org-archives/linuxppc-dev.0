Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMfnq0G80zDvj0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 18:08:14 +1100 (AEDT)
Message-ID: <1479712085.10230.31.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Set missing wakeup bit in LPCR on POWER9
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Neuling
 <michael.neuling@au1.ibm.com>
Date: Mon, 21 Nov 2016 18:08:05 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a new bit, LPCR_PECEu0, which controls wakeup from STOP
states on Hypervisor Virtualization Interrupts (which happen to
also be all external interrupts in host or bare metal mode).

It needs to be set or we will miss wakeups.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Paul, I haven't fixed KVM. You probably should include such a fix
as part of your KVM-on-power9 series.

Michael: That should probably go to -stable as far as P9 support goes.

 arch/powerpc/include/asm/reg.h        | 2 ++
 arch/powerpc/kernel/cpu_setup_power.S | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 9cd4e8c..decef22 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -341,6 +341,8 @@
 #define   LPCR_VRMA_L		ASM_CONST(0x0008000000000000)
 #define   LPCR_VRMA_LP0		ASM_CONST(0x0001000000000000)
 #define   LPCR_VRMA_LP1		ASM_CONST(0x0000800000000000)
+#define   LPCR_PECEu		ASM_CONST(0x0000700000000000)   /* P9 PECE "upper" */
+#define   LPCR_PECEu0		ASM_CONST(0x0000400000000000)   /* P9 Wakeup on HV interrupts" */
 #define   LPCR_RMLS		0x1C000000	/* Implementation dependent RMO limit sel */
 #define   LPCR_RMLS_SH		26
 #define   LPCR_ILE		ASM_CONST(0x0000000002000000)   /* !HV irqs set MSR:LE */
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 52ff3f0..cbf3375 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -98,8 +98,8 @@ _GLOBAL(__setup_cpu_power9)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
-	ori	r3, r3, LPCR_PECEDH
-	ori	r3, r3, LPCR_HVICE
+	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECEu0 | LPCR_HVICE)
+	or	r3, r3, r4
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
@@ -118,8 +118,8 @@ _GLOBAL(__restore_cpu_power9)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr   r3,SPRN_LPCR
-	ori	r3, r3, LPCR_PECEDH
-	ori	r3, r3, LPCR_HVICE
+	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECEu0 | LPCR_HVICE)
+	or	r3, r3, r4
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
