Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Fix hardware IRQs with MMU on exceptions when HV=0
Date: Fri, 26 Apr 2013 11:30:57 +1000
Message-ID: <8698.1366939857@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Nishanth Aravamudan <nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER8 allows us to take interrupts with the MMU on.  This gives us a
second set of vectors offset at 0x4000.  

Unfortunately when coping these vectors we missed checking for MSR HV
for hardware interrupts (0x500).  This results in us trying to use
HSRR0/1 when HV=0, rather than SRR0/1 on HW IRQs

The below fixes this to check CPU_FTR_HVMODE when patching the code at
0x4500.  

Also we remove the check for CPU_FTR_ARCH_206 since relocation on IRQs
are only available in arch 2.07 and beyond.

Thanks to benh for helping find this.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@kernel.org

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 56bd923..3bbe7ed 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -797,7 +797,7 @@ hardware_interrupt_relon_hv:
 		_MASKABLE_RELON_EXCEPTION_PSERIES(0x502, hardware_interrupt, EXC_HV, SOFTEN_TEST_HV)
 	FTR_SECTION_ELSE
 		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt, EXC_STD, SOFTEN_TEST_PR)
-	ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_206)
+	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	STD_RELON_EXCEPTION_PSERIES(0x4600, 0x600, alignment)
 	STD_RELON_EXCEPTION_PSERIES(0x4700, 0x700, program_check)
 	STD_RELON_EXCEPTION_PSERIES(0x4800, 0x800, fp_unavailable)
