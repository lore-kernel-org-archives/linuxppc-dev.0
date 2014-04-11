Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 322FE140217
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 20:36:16 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 11 Apr 2014 06:36:14 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 38571C90026
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 06:36:08 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3BAaC048913366
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 10:36:12 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3BAaBJi031100
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 06:36:12 -0400
Subject: [PATCH 3/3] ppc/kvm: Clear the runlatch bit of a vcpu before napping
To: linuxppc-dev@ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 11 Apr 2014 16:02:08 +0530
Message-ID: <20140411103207.27683.87113.stgit@preeti.in.ibm.com>
In-Reply-To: <20140411103030.27683.2107.stgit@preeti.in.ibm.com>
References: <20140411103030.27683.2107.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the guest cedes the vcpu or the vcpu has no guest to
run it naps. Clear the runlatch bit of the vcpu before
napping to indicate an idle cpu.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index b254075..b031f93 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -315,6 +315,11 @@ kvm_no_guest:
 	li	r0, KVM_HWTHREAD_IN_NAP
 	stb	r0, HSTATE_HWTHREAD_STATE(r13)
 kvm_do_nap:
+	/* Clear the runlatch bit before napping */
+	mfspr	r2, SPRN_CTRLF
+	clrrdi	r2, r2, 1
+	mtspr	SPRN_CTRLT, r2
+
 	li	r3, LPCR_PECE0
 	mfspr	r4, SPRN_LPCR
 	rlwimi	r4, r3, 0, LPCR_PECE0 | LPCR_PECE1
@@ -2005,8 +2010,13 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_206)
 
 	/*
 	 * Take a nap until a decrementer or external or doobell interrupt
-	 * occurs, with PECE1, PECE0 and PECEDP set in LPCR
+	 * occurs, with PECE1, PECE0 and PECEDP set in LPCR. Also clear the
+	 * runlatch bit before napping.
 	 */
+	mfspr	r2, SPRN_CTRLF
+	clrrdi	r2, r2, 1
+	mtspr	SPRN_CTRLT, r2
+
 	li	r0,1
 	stb	r0,HSTATE_HWTHREAD_REQ(r13)
 	mfspr	r5,SPRN_LPCR
