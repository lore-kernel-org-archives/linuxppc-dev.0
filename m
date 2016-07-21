Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw45X2dlfzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:44:48 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id h186so4887846pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:44:48 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 02/14] powerpc/pseries: remove cross-fixup branches in
 exception code
Date: Thu, 21 Jul 2016 16:44:01 +1000
Message-Id: <1469083453-9279-3-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation for reworking the alternate feature patching code,
remove a case of cross-fixup branching in the exception code. That
is, a branch from one alt feature section targeting another alt
feature section.

We have the following:

BEGIN_FTR_SECTION
b	do_kvm_0x502
...
do_kvm_0x502:
...
FTR_SECTION_ELSE
b	do_kvm_0x500
...
do_kvm_0x500:
...
ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)


BEGIN_FTR_SECTION
b	do_kvm_0x502
FTR_SECTION_ELSE
b	do_kvm_0x500
ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)

This somehow manages to work today. The first branch to do_kvm_0x500 works
as expected and branches to the do_kvm_0x500 code that is moved to the
destination location. The second branch to it branches to the linked
location of the do_kvm_0x500 code. Two copies of the code are being
executed.

A subsequent patch moves the patchcode far away and discards it after
boot, so this type of branch doesn't work.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c94406..18befa5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -257,13 +257,18 @@ hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
 		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
 					    EXC_HV, SOFTEN_TEST_HV)
-		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
 	FTR_SECTION_ELSE
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
 					    EXC_STD, SOFTEN_TEST_PR)
-		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 
+	/*
+	 * Relon code jumps to these KVM handlers too so can't put them
+	 * in the feature sections.
+	 */
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
+
 	STD_EXCEPTION_PSERIES(0x600, alignment)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x600)
 
-- 
2.8.1
