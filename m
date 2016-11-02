Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7x900rFPzDvPd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 16:14:11 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA25DQiA106887
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 01:14:10 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26f5q57exj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 01:14:10 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 15:14:07 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5CEEE2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 16:14:05 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA25E52d60752096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 16:14:05 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA25E3bQ008447
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 16:14:05 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM,
 dave@stgolabs.net, konrad.wilk@oracle.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v7 08/11] x86, kvm/x86.c: support vcpu preempted check
Date: Wed,  2 Nov 2016 05:08:35 -0400
In-Reply-To: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1478077718-37424-9-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support the vcpu_is_preempted() functionality under KVM. This will
enhance lock performance on overcommitted hosts (more runnable vcpus
than physical cpus in the system) as doing busy waits for preempted
vcpus will hurt system performance far worse than early yielding.

Use one field of struct kvm_steal_time ::preempted to indicate that if
one vcpu is running or not.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  4 +++-
 arch/x86/kvm/x86.c                   | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 94dc8ca..1421a65 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -45,7 +45,9 @@ struct kvm_steal_time {
 	__u64 steal;
 	__u32 version;
 	__u32 flags;
-	__u32 pad[12];
+	__u8  preempted;
+	__u8  u8_pad[3];
+	__u32 pad[11];
 };
 
 #define KVM_STEAL_ALIGNMENT_BITS 5
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e375235..f06e115 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2057,6 +2057,8 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
 		return;
 
+	vcpu->arch.st.steal.preempted = 0;
+
 	if (vcpu->arch.st.steal.version & 1)
 		vcpu->arch.st.steal.version += 1;  /* first time write, random junk */
 
@@ -2810,8 +2812,22 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 }
 
+static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
+		return;
+
+	vcpu->arch.st.steal.preempted = 1;
+
+	kvm_write_guest_offset_cached(vcpu->kvm, &vcpu->arch.st.stime,
+			&vcpu->arch.st.steal.preempted,
+			offsetof(struct kvm_steal_time, preempted),
+			sizeof(vcpu->arch.st.steal.preempted));
+}
+
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	kvm_steal_time_set_preempted(vcpu);
 	kvm_x86_ops->vcpu_put(vcpu);
 	kvm_put_guest_fpu(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
-- 
2.4.11
