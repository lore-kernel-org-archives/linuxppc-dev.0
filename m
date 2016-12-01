Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTpY75tpnzDvyw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 18:18:35 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id x23so3770501pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 23:18:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Alexander Graf <agraf@suse.com>,
 kvm-ppc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] KVM: PPC: Book3S: Move 64-bit KVM interrupt handler out
 from alt section
Date: Thu,  1 Dec 2016 18:18:11 +1100
Message-Id: <20161201071812.23258-3-npiggin@gmail.com>
In-Reply-To: <20161201071812.23258-1-npiggin@gmail.com>
References: <20161201071812.23258-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A subsequent patch to make KVM handlers relocation-safe makes them
unusable from within alt section "else" cases (due to the way fixed
addresses are taken from within fixed section head code).

Stop open-coding the KVM handlers, and add them both as normal. A more
optimal fix may be to allow some level of alternate feature patching in
the exception macros themselves, but for now this will do.

The TRAMP_KVM handlers must be moved to the "virt" fixed section area
(name is arbitrary) in order to be closer to .text and avoid the dreaded
"relocation truncated to fit" error.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1ba82ea..5faff1c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -717,13 +717,9 @@ hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
 					    EXC_HV, SOFTEN_TEST_HV)
-do_kvm_H0x500:
-		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
 	FTR_SECTION_ELSE
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
 					    EXC_STD, SOFTEN_TEST_PR)
-do_kvm_0x500:
-		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 EXC_REAL_END(hardware_interrupt, 0x500, 0x600)
 
@@ -737,6 +733,8 @@ hardware_interrupt_relon_hv:
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 EXC_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
 
+TRAMP_KVM(PACA_EXGEN, 0x500)
+TRAMP_KVM_HV(PACA_EXGEN, 0x500)
 EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 
 
-- 
2.10.2
