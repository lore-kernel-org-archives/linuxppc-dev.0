Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405mdV3dxVzDrCq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 21:44:30 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LAiGQZ136096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 06:44:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gumn4bcab-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 06:44:20 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 10:43:45 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
Subject: [PATCH v2 2/5] powerpc64/ftrace: Disable ftrace during kvm guest
 entry/exit
Date: Wed, 21 Mar 2018 16:13:19 +0530
In-Reply-To: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <34fe9a40948bb5063dd09b9361fe5e0400427292.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
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
disable ftrace by setting paca->ftrace_disabled. Once we exit the guest
and restore host MMU context, we re-enable ftrace.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f31f357b8c5a..9292087adb68 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -600,6 +600,10 @@ kvmppc_hv_entry:
 	/* Save R1 in the PACA */
 	std	r1, HSTATE_HOST_R1(r13)
 
+	/* Disable ftrace since we can't take a trap any more */
+	li	r6, 1
+	stb	r6, PACA_FTRACE_DISABLED(r13)
+
 	li	r6, KVM_GUEST_MODE_HOST_HV
 	stb	r6, HSTATE_IN_GUEST(r13)
 
@@ -2048,6 +2052,8 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	/* Unset guest mode */
 	li	r0, KVM_GUEST_MODE_NONE
 	stb	r0, HSTATE_IN_GUEST(r13)
+	li	r0, 0
+	stb	r0, PACA_FTRACE_DISABLED(r13)
 
 	ld	r0, SFS+PPC_LR_STKOFF(r1)
 	addi	r1, r1, SFS
@@ -3379,6 +3385,8 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	ld	r8, KVM_HOST_LPCR(r10)
 	mtspr	SPRN_LPCR, r8
 	isync
+	li	r0, 0
+	stb	r0, PACA_FTRACE_DISABLED(r13)
 	li	r0, KVM_GUEST_MODE_NONE
 	stb	r0, HSTATE_IN_GUEST(r13)
 
-- 
2.16.2
