Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 51A6E2C031A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 21:36:34 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 6 Mar 2014 16:06:31 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 65289E0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 16:10:09 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s26AaTjQ57540682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Mar 2014 16:06:29 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s26AaPfR021188
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Mar 2014 16:06:25 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/2] KVM: PPC: Book3S HV: Fix register usage when
 loading/saving VRSAVE
Date: Thu,  6 Mar 2014 16:06:10 +0530
Message-Id: <1394102170-22126-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1394102170-22126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1394102170-22126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

Commit 595e4f7e697e ("KVM: PPC: Book3S HV: Use load/store_fp_state functions
in HV guest entry/exit") changed the register usage in kvmppc_save_fp() and
kvmppc_load_fp() but omitted changing the instructions that load and save VRSAVE.
The result is that the VRSAVE value was loaded from a constant address, and
saved to a location past the end of the vcpu struct, causing host kernel memory
corruption and various kinds of host kernel crashes.

This fixes the problem by using register r31, which contains the
vcpu pointer, instead of r3 and r4.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 557a47800ca1..6962d38c76f5 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2132,7 +2132,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	mfspr	r6,SPRN_VRSAVE
-	stw	r6,VCPU_VRSAVE(r3)
+	stw	r6,VCPU_VRSAVE(r31)
 	mtlr	r30
 	mtmsrd	r5
 	isync
@@ -2169,7 +2169,7 @@ BEGIN_FTR_SECTION
 	bl	.load_vr_state
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
-	lwz	r7,VCPU_VRSAVE(r4)
+	lwz	r7,VCPU_VRSAVE(r31)
 	mtspr	SPRN_VRSAVE,r7
 	mtlr	r30
 	mr	r4,r31
-- 
1.8.3.2
