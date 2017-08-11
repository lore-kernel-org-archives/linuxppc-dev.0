Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTW2B4qY9zDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:40:02 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id p13so3885860pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:40:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v2 12/14] KVM: PPC: Book3S HV: POWER9 can execute stop without
 a sync sequence
Date: Sat, 12 Aug 2017 02:39:10 +1000
Message-Id: <20170811163912.28783-13-npiggin@gmail.com>
In-Reply-To: <20170811163912.28783-1-npiggin@gmail.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 3e024fd71fe8..edb47738a686 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2527,7 +2527,17 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
 kvm_nap_sequence:		/* desired LPCR value in r5 */
-BEGIN_FTR_SECTION
+BEGIN_FTR_SECTION	/* nap sequence */
+	mtspr	SPRN_LPCR,r5
+	isync
+	li	r0, 0
+	std	r0, HSTATE_SCRATCH0(r13)
+	ptesync
+	ld	r0, HSTATE_SCRATCH0(r13)
+1:	cmpd	r0, r0
+	bne	1b
+	nap
+FTR_SECTION_ELSE	/* stop sequence */
 	/*
 	 * PSSCR bits:	exit criterion = 1 (wakeup based on LPCR at sreset)
 	 *		enable state loss = 1 (allow SMT mode switch)
@@ -2539,18 +2549,8 @@ BEGIN_FTR_SECTION
 	li	r4, LPCR_PECE_HVEE@higher
 	sldi	r4, r4, 32
 	or	r5, r5, r4
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	mtspr	SPRN_LPCR,r5
-	isync
-	li	r0, 0
-	std	r0, HSTATE_SCRATCH0(r13)
-	ptesync
-	ld	r0, HSTATE_SCRATCH0(r13)
-1:	cmpd	r0, r0
-	bne	1b
-BEGIN_FTR_SECTION
-	nap
-FTR_SECTION_ELSE
+
 	PPC_STOP
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	b	.
-- 
2.13.3
