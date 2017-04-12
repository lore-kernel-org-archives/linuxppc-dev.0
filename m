Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w347f5zGZzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 23:11:42 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 79so5286953pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 06:11:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/64s: catch external interrupts going to host in POWER9
Date: Wed, 12 Apr 2017 23:11:23 +1000
Message-Id: <20170412131123.17445-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After setting LPES0 in the host on POWER9, the host external interrupt
handler no longer works correctly, because it's set to HV mode (HSRR)
for POWER7/8 with LPES0 clear. We don't expect to get any EE in the host
with XIVE, but it seems preferable to catch unexpected interrupts in case
there are bugs or unexpected behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Hi,

I was testing the LPES0 code on POWER9 under mambo, which exploded
because I didn't use --enable-xive_interrupts so the host was getting
EEs.

Errant 0x500 in the host will end up hrfid'ing to uninitialized HSRR[01]
which ends up dying in interesting ways. Should we add this patch to
Ben's xive topic branch that sets LPES0? (Or do you rebase topic branches?
It could be rolled up with that particular patch if so).

Thanks,
Nick

 arch/powerpc/kernel/exceptions-64s.S | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 857bf7c5b946..2f26a0553a4a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -718,9 +718,21 @@ hardware_interrupt_hv:
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
 					    EXC_HV, SOFTEN_TEST_HV)
 	FTR_SECTION_ELSE
+		/*
+		 * The POWER9 XIVE interrupt controller should be configured
+		 * to send all interrupts to the host as HVI, even with the
+		 * OPAL XICS emulation, so HVMODE should never see a 0x500
+		 * interrupt. However we catch it in case of a bug.
+		 *
+		 * POWER9 sets the LPES0 LPCR bit in the host, which
+		 * delivers external interrupts to SRR[01] with MSR_HV
+		 * unchanged (intended for guest delivery), so these need
+		 * to be caught as EXC_STD interrupts in the host.
+		 */
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
 					    EXC_STD, SOFTEN_TEST_PR)
-	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+	ALT_FTR_SECTION_END(CPU_FTR_HVMODE|CPU_FTR_ARCH_206|CPU_FTR_ARCH_300,
+			    CPU_FTR_HVMODE|CPU_FTR_ARCH_206)
 EXC_REAL_END(hardware_interrupt, 0x500, 0x100)
 
 EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
@@ -730,13 +742,21 @@ hardware_interrupt_relon_hv:
 		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
 	FTR_SECTION_ELSE
 		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
-	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+	ALT_FTR_SECTION_END(CPU_FTR_HVMODE|CPU_FTR_ARCH_206|CPU_FTR_ARCH_300,
+			    CPU_FTR_HVMODE|CPU_FTR_ARCH_206)
 EXC_VIRT_END(hardware_interrupt, 0x4500, 0x100)
 
 TRAMP_KVM(PACA_EXGEN, 0x500)
 TRAMP_KVM_HV(PACA_EXGEN, 0x500)
-EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 
+EXC_COMMON_BEGIN(hardware_interrupt_common)
+BEGIN_FTR_SECTION
+	/* See POWER9 comment above */
+	b	unknown_host_ee_common
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_300)
+	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt_common, do_IRQ)
+
+EXC_COMMON_ASYNC(unknown_host_ee_common, 0x500, unknown_exception)
 
 EXC_REAL(alignment, 0x600, 0x100)
 EXC_VIRT(alignment, 0x4600, 0x100, 0x600)
-- 
2.11.0
