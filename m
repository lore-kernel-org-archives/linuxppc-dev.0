Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RVNj4VH1zF222
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 17:04:53 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3J74Mev053213
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:04:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hennja245-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:04:50 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 19 Apr 2018 08:04:49 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: [PATCH v5 06/10] powerpc64/ftrace: Disable ftrace during kvm
 entry/exit
Date: Thu, 19 Apr 2018 12:34:05 +0530
In-Reply-To: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <62b77045b205b008946b793fe31effb155b335be.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During guest entry/exit, we switch over to/from the guest MMU context
and we cannot take exceptions in the hypervisor code.

Since ftrace may be enabled and since it can result in us taking a trap,
disable ftrace by setting paca->ftrace_enabled to zero. There are two
paths through which we enter/exit a guest:
1. If we are the vcore runner, then we enter the guest via
__kvmppc_vcore_entry() and we disable ftrace around this. This is always
the case for Power9, and for the primary thread on Power8.
2. If we are a secondary thread in Power8, then we would be in nap due
to SMT being disabled. We are woken up by an IPI to enter the guest. In
this scenario, we enter the guest through kvm_start_guest(). We disable
ftrace at this point. In this scenario, ftrace would only get re-enabled
on the secondary thread when SMT is re-enabled (via start_secondary()).

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c            | 4 ++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4d07fca5121c..f604cbd8fc34 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2911,8 +2911,12 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 
 	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
 
+	this_cpu_disable_ftrace();
+
 	trap = __kvmppc_vcore_entry();
 
+	this_cpu_enable_ftrace();
+
 	srcu_read_unlock(&vc->kvm->srcu, srcu_idx);
 
 	trace_hardirqs_off();
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index bd63fa8a08b5..2c3cbe0067b2 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -342,6 +342,9 @@ kvm_start_guest:
 
 	ld	r2,PACATOC(r13)
 
+	li	r0,0
+	stb	r0,PACA_FTRACE_ENABLED(r13)
+
 	li	r0,KVM_HWTHREAD_IN_KVM
 	stb	r0,HSTATE_HWTHREAD_STATE(r13)
 
-- 
2.17.0
