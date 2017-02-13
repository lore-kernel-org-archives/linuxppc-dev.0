Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMZYX5hdgzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 05:57:36 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1DImvmv099795
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 13:57:33 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28keajkyxk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 13:57:33 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 04:57:30 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 92E6B2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 05:57:28 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1DIvKpL38338648
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 05:57:28 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1DIuu9w003873
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 05:56:56 +1100
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: [PATCH] KVM: PPC: Book3S: Ratelimit copy data failure error messages
Date: Tue, 14 Feb 2017 00:26:30 +0530
Message-Id: <1487012190-19830-1-git-send-email-vipin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kvm_ppc_mmu_book3s_32/64 xlat() log "KVM can't copy data" error
upon failing to copy user data to kernel space. This floods kernel
log once such fails occur in short time period. Ratelimit this
error to avoid flooding kernel logs upon copy data failures.

Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_32_mmu.c | 3 ++-
 arch/powerpc/kvm/book3s_64_mmu.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index a2eb6d3..ca8f960 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -224,7 +224,8 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct kvm_vcpu *vcpu, gva_t eaddr,
 	ptem = kvmppc_mmu_book3s_32_get_ptem(sre, eaddr, primary);
 
 	if(copy_from_user(pteg, (void __user *)ptegp, sizeof(pteg))) {
-		printk(KERN_ERR "KVM: Can't copy data from 0x%lx!\n", ptegp);
+		if (printk_ratelimit())
+			printk(KERN_ERR "KVM: Can't copy data from 0x%lx!\n", ptegp);
 		goto no_page_found;
 	}
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index b9131aa..b420aca 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -265,7 +265,8 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 		goto no_page_found;
 
 	if(copy_from_user(pteg, (void __user *)ptegp, sizeof(pteg))) {
-		printk(KERN_ERR "KVM can't copy data from 0x%lx!\n", ptegp);
+		if (printk_ratelimit())
+			printk(KERN_ERR "KVM can't copy data from 0x%lx!\n", ptegp);
 		goto no_page_found;
 	}
 
-- 
2.7.4
