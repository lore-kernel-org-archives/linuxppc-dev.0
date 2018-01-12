Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHn7C1DrdzDr53
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:41:10 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v4 4/6] powerpc/kvm/xive: Check DR not IR to chose real vs
 virt mode MMIOs
Date: Fri, 12 Jan 2018 13:37:14 +1100
Message-Id: <20180112023716.9963-4-benh@kernel.crashing.org>
In-Reply-To: <20180112023716.9963-1-benh@kernel.crashing.org>
References: <20180112023716.9963-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 327f5e6a1e4d..506a1c775370 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1442,7 +1442,7 @@ guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 	li	r7, TM_SPC_PULL_OS_CTX
 	li	r6, TM_QW1_OS
 	mfmsr	r0
-	andi.	r0, r0, MSR_IR		/* in real mode? */
+	andi.	r0, r0, MSR_DR		/* in real mode? */
 	beq	2f
 	ld	r10, HSTATE_XIVE_TIMA_VIRT(r13)
 	cmpldi	cr0, r10, 0
-- 
2.14.3
