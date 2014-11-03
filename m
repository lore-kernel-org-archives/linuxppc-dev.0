Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85BE01A0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 03:08:53 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 09:08:51 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5B8F51FF0039
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 08:57:33 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA3G8mre1900974
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 17:08:48 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA3G8lHb026417
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 09:08:48 -0700
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] powerpc: powernv: Switch off MMU before entering
 nap/sleep/rvwinkle mode
Date: Mon,  3 Nov 2014 21:38:27 +0530
Message-Id: <1415030910-5799-2-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1415030910-5799-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1415030910-5799-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

Currently, when going idle, we set the flag indicating that we are in
nap mode (paca->kvm_hstate.hwthread_state) and then execute the nap
(or sleep or rvwinkle) instruction, all with the MMU on.  This is bad
for two reasons: (a) the architecture specifies that those instructions
must be executed with the MMU off, and in fact with only the SF, HV, ME
and possibly RI bits set, and (b) this introduces a race, because as
soon as we set the flag, another thread can switch the MMU to a guest
context.  If the race is lost, this thread will typically start looping
on relocation-on ISIs at 0xc...4400.

This fixes it by setting the MSR as required by the architecture before
setting the flag or executing the nap/sleep/rvwinkle instruction.

[ shreyas@linux.vnet.ibm.com: Edited to handle LE ]
Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/reg.h    |  2 ++
 arch/powerpc/kernel/idle_power7.S | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c998279..a68ee15 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -118,8 +118,10 @@
 #define __MSR		(MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF |MSR_HV)
 #ifdef __BIG_ENDIAN__
 #define MSR_		__MSR
+#define MSR_IDLE	(MSR_ME | MSR_SF | MSR_HV)
 #else
 #define MSR_		(__MSR | MSR_LE)
+#define MSR_IDLE	(MSR_ME | MSR_SF | MSR_HV | MSR_LE)
 #endif
 #define MSR_KERNEL	(MSR_ | MSR_64BIT)
 #define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index c0754bb..283c603 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -101,7 +101,23 @@ _GLOBAL(power7_powersave_common)
 	std	r9,_MSR(r1)
 	std	r1,PACAR1(r13)
 
-_GLOBAL(power7_enter_nap_mode)
+	/*
+	 * Go to real mode to do the nap, as required by the architecture.
+	 * Also, we need to be in real mode before setting hwthread_state,
+	 * because as soon as we do that, another thread can switch
+	 * the MMU context to the guest.
+	 */
+	LOAD_REG_IMMEDIATE(r5, MSR_IDLE)
+	li	r6, MSR_RI
+	andc	r6, r9, r6
+	LOAD_REG_ADDR(r7, power7_enter_nap_mode)
+	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
+	mtspr	SPRN_SRR0, r7
+	mtspr	SPRN_SRR1, r5
+	rfid
+
+	.globl	power7_enter_nap_mode
+power7_enter_nap_mode:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	/* Tell KVM we're napping */
 	li	r4,KVM_HWTHREAD_IN_NAP
-- 
1.9.3
