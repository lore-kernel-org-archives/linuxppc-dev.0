Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9F9D2C08AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:33:58 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 01:55:16 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0BD851258051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:02:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PKYBoP23724206
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:04:12 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PKXoYo005731
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 20:33:52 GMT
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 28/45] KVM: Use get/put_online_cpus_atomic() to prevent CPU
 offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Wed, 26 Jun 2013 02:00:36 +0530
Message-ID: <20130625203036.16593.50377.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 Gleb Natapov <gleb@redhat.com>, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
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
Cc: kvm@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 virt/kvm/kvm_main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 302681c..5bbfa30 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -174,7 +174,7 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
 
 	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
 
-	me = get_cpu();
+	me = get_online_cpus_atomic();
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_make_request(req, vcpu);
 		cpu = vcpu->cpu;
@@ -192,7 +192,7 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
 		smp_call_function_many(cpus, ack_flush, NULL, 1);
 	else
 		called = false;
-	put_cpu();
+	put_online_cpus_atomic();
 	free_cpumask_var(cpus);
 	return called;
 }
@@ -1707,11 +1707,11 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 		++vcpu->stat.halt_wakeup;
 	}
 
-	me = get_cpu();
+	me = get_online_cpus_atomic();
 	if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
 		if (kvm_arch_vcpu_should_kick(vcpu))
 			smp_send_reschedule(cpu);
-	put_cpu();
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_kick);
 #endif /* !CONFIG_S390 */
