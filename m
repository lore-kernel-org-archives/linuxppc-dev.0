Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vqDWS34wbzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 17:47:48 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel] KVM: PPC: Get rid of unused local variable
Date: Fri, 24 Mar 2017 17:47:13 +1100
Message-Id: <20170324064713.18258-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

@is_mmio has never been used since introduction in
commit 2f4cf5e42d13 ("Add book3s.c") from 2009.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_pr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index d4dfc0ca2a44..633502f52bbb 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -538,7 +538,6 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	int relocated;
 	int page_found = 0;
 	struct kvmppc_pte pte;
-	bool is_mmio = false;
 	bool dr = (kvmppc_get_msr(vcpu) & MSR_DR) ? true : false;
 	bool ir = (kvmppc_get_msr(vcpu) & MSR_IR) ? true : false;
 	u64 vsid;
@@ -616,8 +615,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		/* Page not found in guest SLB */
 		kvmppc_set_dar(vcpu, kvmppc_get_fault_dar(vcpu));
 		kvmppc_book3s_queue_irqprio(vcpu, vec + 0x80);
-	} else if (!is_mmio &&
-		   kvmppc_visible_gpa(vcpu, pte.raddr)) {
+	} else if (kvmppc_visible_gpa(vcpu, pte.raddr)) {
 		if (data && !(vcpu->arch.fault_dsisr & DSISR_NOHPTE)) {
 			/*
 			 * There is already a host HPTE there, presumably
-- 
2.11.0
