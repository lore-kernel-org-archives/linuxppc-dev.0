Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A6B0FB7004
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:49 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 28/37] KVM: PPC: bookehv: remove SET_VCPU
Date: Fri, 24 Feb 2012 15:26:22 +0100
Message-Id: <1330093591-19523-29-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SET_VCPU macro is a leftover from times when the vcpu struct wasn't
stored in the thread on vcpu_load/put. It's not needed anymore. Remove it.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/bookehv_interrupts.S |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index c5a0796..469bd3f 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -35,9 +35,6 @@
 #define GET_VCPU(vcpu, thread)	\
 	PPC_LL	vcpu, THREAD_KVM_VCPU(thread)
 
-#define SET_VCPU(vcpu)		\
-        PPC_STL	vcpu, (THREAD + THREAD_KVM_VCPU)(r2)
-
 #define LONGBYTES		(BITS_PER_LONG / 8)
 
 #define VCPU_GPR(n)     	(VCPU_GPRS + (n * LONGBYTES))
@@ -517,11 +514,6 @@ lightweight_exit:
 	lwz	r3, VCPU_GUEST_PID(r4)
 	mtspr	SPRN_PID, r3
 
-	/* Save vcpu pointer for the exception handlers
-	 * must be done before loading guest r2.
-	 */
-//	SET_VCPU(r4)
-
 	PPC_LL	r11, VCPU_SHARED(r4)
 	/* Save host mas4 and mas6 and load guest MAS registers */
 	mfspr	r3, SPRN_MAS4
-- 
1.6.0.2
