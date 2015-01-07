Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBF9B1A0BA8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 21:31:55 +1100 (AEDT)
From: Luis Henriques <luis.henriques@canonical.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [3.16.y-ckt stable] Patch "powerpc/powernv: Switch off MMU before
 entering nap/sleep/rvwinkle mode" has been added to staging queue
Date: Wed,  7 Jan 2015 10:32:06 +0000
Message-Id: <1420626726-29545-1-git-send-email-luis.henriques@canonical.com>
Cc: Luis Henriques <luis.henriques@canonical.com>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, kernel-team@lists.ubuntu.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a note to let you know that I have just added a patch titled

    powerpc/powernv: Switch off MMU before entering nap/sleep/rvwinkle mode

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt4.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 8a4ec5805ab7292f0c05d9b052aa343af57e7015 Mon Sep 17 00:00:00 2001
From: Paul Mackerras <paulus@samba.org>
Date: Wed, 10 Dec 2014 00:26:50 +0530
Subject: powerpc/powernv: Switch off MMU before entering nap/sleep/rvwinkle
 mode

commit 8117ac6a6c2fa0f847ff6a21a1f32c8d2c8501d0 upstream.

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/powerpc/include/asm/reg.h    |  2 ++
 arch/powerpc/kernel/idle_power7.S | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index bffd89d27301..e73cdadab785 100644
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
index 5cf3d367190d..a29f5b0f9d3e 100644
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
2.1.4
