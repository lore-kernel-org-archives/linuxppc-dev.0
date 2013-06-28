Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 9/9] powerpc/pseries: Inform the hypervisor we are using EBB
 regs
Date: Fri, 28 Jun 2013 18:15:18 +1000
Message-Id: <1372407319-718-9-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372407319-718-1-git-send-email-michael@ellerman.id.au>
References: <1372407319-718-1-git-send-email-michael@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On LPAR systems we need to inform the hypervisor that we are using the
EBB registers. We do this by setting a bit in the Virtual Processor Area
(VPA) - formerly known as the lppaca.

For now we do this always, ie. we do not dynamically enable/disable.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/lppaca.h     |    3 ++-
 arch/powerpc/platforms/pseries/lpar.c |    3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index b1e7f2a..9b12f88 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -66,7 +66,8 @@ struct lppaca {
 
 	u8	reserved6[48];
 	u8	cede_latency_hint;
-	u8	reserved7[7];
+	u8	ebb_regs_in_use;
+	u8	reserved7[6];
 	u8	dtl_enable_mask;	/* Dispatch Trace Log mask */
 	u8	donate_dedicated_cpu;	/* Donate dedicated CPU cycles */
 	u8	fpregs_in_use;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index fd0f2f2..02d6e21 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -71,6 +71,9 @@ void vpa_init(int cpu)
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		lppaca_of(cpu).vmxregs_in_use = 1;
 
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		lppaca_of(cpu).ebb_regs_in_use = 1;
+
 	addr = __pa(&lppaca_of(cpu));
 	ret = register_vpa(hwcpu, addr);
 
-- 
1.7.10.4
