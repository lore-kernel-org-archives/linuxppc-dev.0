Return-Path: <prvs=06277935a1=aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CKqs3ZqNzF1rw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 22:57:38 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2UBs1W5128762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 07:57:36 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h1jx749e7-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 07:57:36 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 30 Mar 2018 05:57:35 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/kvm: Fix guest boot issue DAWR cpu feature
Date: Fri, 30 Mar 2018 17:27:24 +0530
Message-Id: <20180330115724.23826-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SLOF check the 'sc 1' support by issuing a hcall with H_SET_DABR. With
recent patch to make the hcall return H_UNSUPPORTED, we get guest boot
failures. SLOF can work with the hcall failure H_HARDWARE for the above
hcall. Switch the return value to H_HARDWARE instead of H_UNSUPPORTED so that
we don't break the guest boot.

Fixes: e8ebedbf ("KVM: PPC: Book3S HV: Return error from h_set_dabr() on POWER9")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c4c1b169826a..fdd7350d6c87 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2576,7 +2576,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 2:
 BEGIN_FTR_SECTION
 	/* POWER9 with disabled DAWR */
-	li	r3, H_UNSUPPORTED
+	li	r3, H_HARDWARE
 	blr
 END_FTR_SECTION_IFCLR(CPU_FTR_DAWR)
 	/* Emulate H_SET_DABR/X on P8 for the sake of compat mode guests */
-- 
2.14.3
