Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409JCK2hVpzF27q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:37:33 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 david@gibson.dropbear.id.au, npiggin@gmail.com,
 pedromfc@linux.vnet.ibm.com, kvm-ppc@vger.kernel.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: [PATCH v3 6/8] KVM: PPC: Book3S HV: Handle migration with POWER9
 disabled DAWR
Date: Tue, 27 Mar 2018 15:37:22 +1100
Message-Id: <20180327043724.13862-7-mikey@neuling.org>
In-Reply-To: <20180327043724.13862-1-mikey@neuling.org>
References: <20180327043724.13862-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 with the DAWR disabled causes problems for partition
migration. Either we have to fail the migration (since we lose the
DAWR) or we silently drop the DAWR and allow the migration to pass.

This patch does the latter and allows the migration to pass (at the
cost of silently losing the DAWR). This is not ideal but hopefully the
best overall solution. This approach has been acked by Paulus.

With this patch kvmppc_set_one_reg() will store the DAWR in the vcpu
but won't actually set it on POWER9 hardware.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 13e23a5275..8ba20b11ba 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -886,8 +886,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	ld	r6, VCPU_DAWRX(r4)
 	ld	r7, VCPU_CIABR(r4)
 	ld	r8, VCPU_TAR(r4)
+	/*
+	 * Handle broken DAWR case by not writing it. This means we
+	 * can still store the DAWR register for migration.
+	 */
+BEGIN_FTR_SECTION
 	mtspr	SPRN_DAWR, r5
 	mtspr	SPRN_DAWRX, r6
+END_FTR_SECTION_IFSET(CPU_FTR_DAWR)
 	mtspr	SPRN_CIABR, r7
 	mtspr	SPRN_TAR, r8
 	ld	r5, VCPU_IC(r4)
@@ -1834,6 +1840,10 @@ BEGIN_FTR_SECTION
 	ld	r6, STACK_SLOT_DAWR(r1)
 	ld	r7, STACK_SLOT_DAWRX(r1)
 	mtspr	SPRN_CIABR, r5
+	/*
+	 * If the DAWR doesn't work, it's ok to write these here as
+	 * this value should always be zero
+	*/
 	mtspr	SPRN_DAWR, r6
 	mtspr	SPRN_DAWRX, r7
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
-- 
2.14.1
