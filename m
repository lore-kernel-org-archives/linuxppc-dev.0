Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9941B1A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 15:47:07 +1100 (AEDT)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Save/restore PPR for KVM hypercalls
Date: Mon,  3 Nov 2014 15:46:42 +1100
Message-Id: <1414990003-6104-1-git-send-email-paulus@samba.org>
Cc: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>

The system call FLIH (first-level interrupt handler) at 0xc00
unconditionally sets hardware priority to medium. For hypercalls, this
means we lose guest OS priority. The front end (do_kvm_0x**) to the
KVM interrupt handler always assumes that PPR priority is saved in
PACA exception save area, so it copies this to the kvm_hstate
structure. For hypercalls, this would be the saved priority from any
previous exception. Eventually, the guest gets resumed with an
incorrect priority.

The fix is to save the PPR priority in PACA exception save area before
switching HMT priorities in the FLIH so that existing code described above
in the KVM interrupt handler can copy it from there into the VCPU's saved
context.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 72e783e..f67d909 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -292,15 +292,26 @@ decrementer_pSeries:
 	. = 0xc00
 	.globl	system_call_pSeries
 system_call_pSeries:
-	HMT_MEDIUM
+	/*
+	 * Switch to HMT medium priority on systems where we don't support
+	 * saving/restoring PPR or if CONFIG_KVM_BOOK3S_64_HANDLER is not
+	 * set. Otherwise, we save PPR in the CONFIG_KVM_BOOK3S_64_HANDLER
+	 * path before switching priority.
+	 */
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	std	r9,PACA_EXGEN+EX_R9(r13)
+	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);
+	HMT_MEDIUM;
 	std	r10,PACA_EXGEN+EX_R10(r13)
+	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r9, CPU_FTR_HAS_PPR);
 	mfcr	r9
 	KVMTEST(0xc00)
 	GET_SCRATCH0(r13)
+#else
+	HMT_MEDIUM;
 #endif
 	SYSCALL_PSERIES_1
 	SYSCALL_PSERIES_2_RFID
-- 
2.1.1
