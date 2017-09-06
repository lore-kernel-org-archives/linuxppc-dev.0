Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnBkk3TxFzDrJQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 15:21:02 +1000 (AEST)
Message-ID: <1504675255.15183.1.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/kvm/xive: Don't access TIMA using byte accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
Date: Wed, 06 Sep 2017 15:20:55 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TIMA only supports byte stores to the CPPR, for everything else,
we need to do a 32-bit or 64-bit load.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: 2c4fb78f78b6e420604ee1b05bdfb5c1d637869f
---
 arch/powerpc/kvm/book3s_hv_rm_xive.c    | 1 -
 arch/powerpc/kvm/book3s_xive.c          | 1 -
 arch/powerpc/kvm/book3s_xive_template.c | 7 ++++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_xive.c b/arch/powerpc/kvm/book3s_hv_rm_xive.c
index abf5f01b6eb1..5b81a807d742 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xive.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xive.c
@@ -38,7 +38,6 @@ static inline void __iomem *get_tima_phys(void)
 #define __x_tima		get_tima_phys()
 #define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_page))
 #define __x_trig_page(xd)	((void __iomem *)((xd)->trig_page))
-#define __x_readb	__raw_rm_readb
 #define __x_writeb	__raw_rm_writeb
 #define __x_readw	__raw_rm_readw
 #define __x_readq	__raw_rm_readq
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 08b200a0bbce..13304622ab1c 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -48,7 +48,6 @@
 #define __x_tima		xive_tima
 #define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_mmio))
 #define __x_trig_page(xd)	((void __iomem *)((xd)->trig_mmio))
-#define __x_readb	__raw_readb
 #define __x_writeb	__raw_writeb
 #define __x_readw	__raw_readw
 #define __x_readq	__raw_readq
diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index d1ed2c41b5d2..c7a5deadd1cc 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -28,7 +28,8 @@ static void GLUE(X_PFX,ack_pending)(struct kvmppc_xive_vcpu *xc)
 	 * bit.
 	 */
 	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		u8 pipr = __x_readb(__x_tima + TM_QW1_OS + TM_PIPR);
+		__be64 qw1 = __x_readq(__x_tima + TM_QW1_OS);
+		u8 pipr = be64_to_cpu(qw1) & 0xff;
 		if (pipr >= xc->hw_cppr)
 			return;
 	}
@@ -336,7 +337,6 @@ X_STATIC unsigned long GLUE(X_PFX,h_ipoll)(struct kvm_vcpu *vcpu, unsigned long
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
 	u8 pending = xc->pending;
 	u32 hirq;
-	u8 pipr;
 
 	pr_devel("H_IPOLL(server=%ld)\n", server);
 
@@ -353,7 +353,8 @@ X_STATIC unsigned long GLUE(X_PFX,h_ipoll)(struct kvm_vcpu *vcpu, unsigned long
 		pending = 0xff;
 	} else {
 		/* Grab pending interrupt if any */
-		pipr = __x_readb(__x_tima + TM_QW1_OS + TM_PIPR);
+		__be64 qw1 = __x_readq(__x_tima + TM_QW1_OS);
+		u8 pipr = be64_to_cpu(qw1) & 0xff;
 		if (pipr < 8)
 			pending |= 1 << pipr;
 	}
