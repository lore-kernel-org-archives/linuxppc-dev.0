Return-Path: <jslaby@suse.cz>
Received: from ip4-83-240-18-248.cust.nbox.cz (ip4-83-240-67-251.cust.nbox.cz
 [83.240.67.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E08D1A0C81
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 02:10:52 +1100 (AEDT)
From: Jiri Slaby <jslaby@suse.cz>
To: stable@vger.kernel.org
Subject: [patch added to the 3.12 stable tree] powerpc/powernv: Switch off MMU
 before entering nap/sleep/rvwinkle mode
Date: Wed, 14 Jan 2015 15:40:26 +0100
Message-Id: <1421246468-25187-14-git-send-email-jslaby@suse.cz>
In-Reply-To: <1421246468-25187-1-git-send-email-jslaby@suse.cz>
References: <1421246468-25187-1-git-send-email-jslaby@suse.cz>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Jiri Slaby <jslaby@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/powerpc/include/asm/reg.h    |  1 +
 arch/powerpc/kernel/idle_power7.S | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index cb9c1740cee0..390e09872b77 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -116,6 +116,7 @@
 
 /* Server variant */
 #define MSR_		(MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF |MSR_HV)
+#define MSR_IDLE	(MSR_ME | MSR_SF | MSR_HV)
 #define MSR_KERNEL	(MSR_ | MSR_64BIT)
 #define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
 #define MSR_USER64	(MSR_USER32 | MSR_64BIT)
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index e11863f4e595..df930727f73b 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -84,6 +84,22 @@ _GLOBAL(power7_nap)
 	std	r9,_MSR(r1)
 	std	r1,PACAR1(r13)
 
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
+power7_enter_nap_mode:
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	/* Tell KVM we're napping */
 	li	r4,KVM_HWTHREAD_IN_NAP
-- 
2.2.1
