Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A40D2C0EE9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:48:03 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 23:38:30 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4CCE82BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:48:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDX54X61800636
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:33:05 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDlxsD018180
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:48:01 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 29/45] kvm/vmx: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:14:27 +0530
Message-ID: <20130623134423.19094.90107.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 Gleb Natapov <gleb@redhat.com>, x86@kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Ingo Molnar <mingo@redhat.com>, wangyun@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, netdev@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: Gleb Natapov <gleb@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kvm/vmx.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 260a919..4e1e966 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
+#include <linux/cpu.h>
 #include <linux/moduleparam.h>
 #include <linux/mod_devicetable.h>
 #include <linux/ftrace_event.h>
@@ -7164,12 +7165,12 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	if (!vmm_exclusive)
 		kvm_cpu_vmxoff();
 
-	cpu = get_cpu();
+	cpu = get_online_cpus_atomic();
 	vmx_vcpu_load(&vmx->vcpu, cpu);
 	vmx->vcpu.cpu = cpu;
 	err = vmx_vcpu_setup(vmx);
 	vmx_vcpu_put(&vmx->vcpu);
-	put_cpu();
+	put_online_cpus_atomic();
 	if (err)
 		goto free_vmcs;
 	if (vm_need_virtualize_apic_accesses(kvm)) {
@@ -7706,12 +7707,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 
 	vmx->nested.vmcs01_tsc_offset = vmcs_read64(TSC_OFFSET);
 
-	cpu = get_cpu();
+	cpu = get_online_cpus_atomic();
 	vmx->loaded_vmcs = vmcs02;
 	vmx_vcpu_put(vcpu);
 	vmx_vcpu_load(vcpu, cpu);
 	vcpu->cpu = cpu;
-	put_cpu();
+	put_online_cpus_atomic();
 
 	vmx_segment_cache_clear(vmx);
 
@@ -8023,12 +8024,12 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu)
 	leave_guest_mode(vcpu);
 	prepare_vmcs12(vcpu, vmcs12);
 
-	cpu = get_cpu();
+	cpu = get_online_cpus_atomic();
 	vmx->loaded_vmcs = &vmx->vmcs01;
 	vmx_vcpu_put(vcpu);
 	vmx_vcpu_load(vcpu, cpu);
 	vcpu->cpu = cpu;
-	put_cpu();
+	put_online_cpus_atomic();
 
 	vmx_segment_cache_clear(vmx);
 
