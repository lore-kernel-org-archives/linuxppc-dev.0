Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0E5C1A029B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 20:58:53 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 6 May 2015 16:28:50 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 51C2BE0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 16:31:40 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t46Awm2k2949516
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 16:28:48 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t46APBUs030617
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 15:55:12 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
Subject: [PATCH 3/3] kvm/powerpc: report guest steal time in host
Date: Wed,  6 May 2015 16:28:45 +0530
Message-Id: <38967aead35e9772f2f49ef80a069476dccdbe5d.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: mingo@redhat.com, paulus@samba.org, agraf@suse.de, ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc, kvm tracks both the guest steal time as well as the time
when guest was idle and this gets sent in to the guest through DTL. The
guest accounts these entries as either steal time or idle time based on
the last running task. Since the true guest idle status is not visible
to the host, we can't accurately expose the guest steal time in the
host.

However, tracking the guest vcpu cede status can get us a reasonable
(within 5% variation) vcpu steal time since guest vcpus cede the
processor on entering the idle task. To do this, we introduce a new
field ceded_st in kvm_vcpu_arch structure to accurately track the guest
vcpu cede status (this is needed since the existing ceded field is
modified before we can use it). During DTL entry creation, we check this
flag and account the time as stolen if the guest vcpu had not ceded.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Tests show that the steal time being reported in the host with this approach is
around 5% higher than the steal time shown in guest. I'd be interested to know
if there are ways to achieve better accounting of the guest steal time in host.

 arch/powerpc/include/asm/kvm_host.h     | 1 +
 arch/powerpc/kernel/asm-offsets.c       | 1 +
 arch/powerpc/kvm/book3s_hv.c            | 2 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 +++
 4 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 8ef0512..7db48c4 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -655,6 +655,7 @@ struct kvm_vcpu_arch {
 	u64 busy_preempt;
 
 	u32 emul_inst;
+	u8 ceded_st;
 #endif
 };
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4717859..765c7c4 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -521,6 +521,7 @@ int main(void)
 	DEFINE(VCPU_DEC_EXPIRES, offsetof(struct kvm_vcpu, arch.dec_expires));
 	DEFINE(VCPU_PENDING_EXC, offsetof(struct kvm_vcpu, arch.pending_exceptions));
 	DEFINE(VCPU_CEDED, offsetof(struct kvm_vcpu, arch.ceded));
+	DEFINE(VCPU_CEDED_ST, offsetof(struct kvm_vcpu, arch.ceded_st));
 	DEFINE(VCPU_PRODDED, offsetof(struct kvm_vcpu, arch.prodded));
 	DEFINE(VCPU_MMCR, offsetof(struct kvm_vcpu, arch.mmcr));
 	DEFINE(VCPU_PMC, offsetof(struct kvm_vcpu, arch.pmc));
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de74756..ad7c0e3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -545,6 +545,8 @@ static void kvmppc_create_dtl_entry(struct kvm_vcpu *vcpu,
 	spin_lock_irq(&vcpu->arch.tbacct_lock);
 	stolen += vcpu->arch.busy_stolen;
 	vcpu->arch.busy_stolen = 0;
+	if (!vcpu->arch.ceded_st && stolen)
+		(pid_task(vcpu->pid, PIDTYPE_PID))->gstime += stolen;
 	spin_unlock_irq(&vcpu->arch.tbacct_lock);
 	if (!dt || !vpa)
 		return;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 6cbf163..28f304e 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -873,6 +873,7 @@ deliver_guest_interrupt:
 fast_guest_return:
 	li	r0,0
 	stb	r0,VCPU_CEDED(r4)	/* cancel cede */
+	stb	r0,VCPU_CEDED_ST(r4)	/* cancel cede */
 	mtspr	SPRN_HSRR0,r10
 	mtspr	SPRN_HSRR1,r11
 
@@ -1889,6 +1890,7 @@ _GLOBAL(kvmppc_h_cede)
 	std	r11,VCPU_MSR(r3)
 	li	r0,1
 	stb	r0,VCPU_CEDED(r3)
+	stb	r0,VCPU_CEDED_ST(r3)
 	sync			/* order setting ceded vs. testing prodded */
 	lbz	r5,VCPU_PRODDED(r3)
 	cmpwi	r5,0
@@ -2052,6 +2054,7 @@ kvm_cede_prodded:
 	stb	r0,VCPU_PRODDED(r3)
 	sync			/* order testing prodded vs. clearing ceded */
 	stb	r0,VCPU_CEDED(r3)
+	stb	r0,VCPU_CEDED_ST(r3)
 	li	r3,H_SUCCESS
 	blr
 
-- 
2.3.5
