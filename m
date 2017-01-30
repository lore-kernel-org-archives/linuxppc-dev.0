Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnJ4qbbzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:12 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 19/20] KVM: PPC: Book3S HV: Invalidate ERAT on guest
 entry/exit for POWER9 DD1
Date: Mon, 30 Jan 2017 21:21:52 +1100
Message-Id: <1485771713-24801-20-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9 DD1, we need to invalidate the ERAT (effective to real
address translation cache) when changing the PIDR register, which
we do as part of guest entry and exit.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index ab390bc..f8da957 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -877,6 +877,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_PID, r7
 	mtspr	SPRN_WORT, r8
 BEGIN_FTR_SECTION
+	PPC_INVALIDATE_ERAT
+END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1)
+BEGIN_FTR_SECTION
 	/* POWER8-only registers */
 	ld	r5, VCPU_TCSCR(r4)
 	ld	r6, VCPU_ACOP(r4)
@@ -1612,6 +1615,9 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_PSSCR, r6
 	mtspr	SPRN_PID, r7
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+BEGIN_FTR_SECTION
+	PPC_INVALIDATE_ERAT
+END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1)
 
 	/*
 	 * POWER7/POWER8 guest -> host partition switch code.
-- 
2.7.4
