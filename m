Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G0dK4VltzF2B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 06:12:53 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33KAeCg044033
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 16:12:50 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h4fuqhrhn-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 16:12:50 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 21:12:48 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH v4 02/10] powerpc64/ftrace: Disable ftrace during kvm guest
 entry/exit
Date: Wed,  4 Apr 2018 01:42:17 +0530
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <d1441dc20f7a1a9b52bcb8342e9c8b0f5b1e7819.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During guest entry/exit, we switch over to/from the guest MMU context.
While doing so, we set our state to KVM_GUEST_MODE_HOST_HV to note down
the fact that we cannot take any exceptions in the hypervisor code.

Since ftrace may be enabled and since it can result in us taking a trap,
disable ftrace by setting paca->ftrace_enabled to zero. Once we exit the
guest and restore host MMU context, we re-enable ftrace.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index bd63fa8a08b5..6f2d7206a12b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -598,6 +598,10 @@ kvmppc_hv_entry:
 	/* Save R1 in the PACA */
 	std	r1, HSTATE_HOST_R1(r13)
 
+	/* Disable ftrace since we can't take a trap any more */
+	li	r6, 0
+	stb	r6, PACA_FTRACE_ENABLED(r13)
+
 	li	r6, KVM_GUEST_MODE_HOST_HV
 	stb	r6, HSTATE_IN_GUEST(r13)
 
@@ -2078,6 +2082,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	/* Unset guest mode */
 	li	r0, KVM_GUEST_MODE_NONE
 	stb	r0, HSTATE_IN_GUEST(r13)
+	li	r0, 1
+	stb	r0, PACA_FTRACE_ENABLED(r13)
 
 	lwz	r12, STACK_SLOT_TRAP(r1)	/* return trap # in r12 */
 	ld	r0, SFS+PPC_LR_STKOFF(r1)
@@ -3547,6 +3553,8 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	ld	r8, KVM_HOST_LPCR(r10)
 	mtspr	SPRN_LPCR, r8
 	isync
+	li	r0, 1
+	stb	r0, PACA_FTRACE_ENABLED(r13)
 	li	r0, KVM_GUEST_MODE_NONE
 	stb	r0, HSTATE_IN_GUEST(r13)
 
-- 
2.16.2
