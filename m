Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A49B22C0105
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:35:54 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:05:52 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E82D23940023
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:05:50 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKZk4Q2359750
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:05:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKZj95025505
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:05:47 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 10/52] arm, kvm: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:05:38 +0530
Message-ID: <20140310203538.10746.25364.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 Russell King <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-pm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linuxppc-dev@ozlabs.org, linux-arm-kernel@lists.infradead.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, paulmck@linux.vnet.ibm.com,
 Ingo Molnar <mingo@kernel.org>, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subsystems that want to register CPU hotplug callbacks, as well as perform
initialization for the CPUs that are already online, often do it as shown
below:

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	register_cpu_notifier(&foobar_cpu_notifier);

	put_online_cpus();

This is wrong, since it is prone to ABBA deadlocks involving the
cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
with CPU hotplug operations).

Instead, the correct and race-free way of performing the callback
registration is:

	cpu_notifier_register_begin();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	/* Note the use of the double underscored version of the API */
	__register_cpu_notifier(&foobar_cpu_notifier);

	cpu_notifier_register_done();


Fix the kvm code in arm by using this latter form of callback registration.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/arm/kvm/arm.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index bd18bb8..f0e50a0 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1051,21 +1051,26 @@ int kvm_arch_init(void *opaque)
 		}
 	}
 
+	cpu_notifier_register_begin();
+
 	err = init_hyp_mode();
 	if (err)
 		goto out_err;
 
-	err = register_cpu_notifier(&hyp_init_cpu_nb);
+	err = __register_cpu_notifier(&hyp_init_cpu_nb);
 	if (err) {
 		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
 		goto out_err;
 	}
 
+	cpu_notifier_register_done();
+
 	hyp_cpu_pm_init();
 
 	kvm_coproc_table_init();
 	return 0;
 out_err:
+	cpu_notifier_register_done();
 	return err;
 }
 
