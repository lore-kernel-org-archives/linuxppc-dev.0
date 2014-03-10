Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B85D72C076A
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:38:17 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 06:38:17 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9184E2CE8047
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:37:44 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKHZHS3408258
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:17:35 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKbg38020528
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:37:44 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 21/52] x86, therm_throt.c: Remove unused therm_cpu_lock
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:07:28 +0530
Message-ID: <20140310203728.10746.58165.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, tj@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
 Ingo Molnar <mingo@kernel.org>, linux-edac@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After fixing the CPU hotplug callback registration code, the callbacks
invoked for each online CPU, during the initialization phase in
thermal_throttle_init_device(), can no longer race with the actual CPU
hotplug notifier callbacks (in thermal_throttle_cpu_callback). Hence the
therm_cpu_lock is unnecessary now. Remove it.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-edac@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kernel/cpu/mcheck/therm_throt.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index e05dfa3..d921b7e 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -271,9 +271,6 @@ static void thermal_throttle_remove_dev(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &thermal_attr_group);
 }
 
-/* Mutex protecting device creation against CPU hotplug: */
-static DEFINE_MUTEX(therm_cpu_lock);
-
 /* Get notified when a cpu comes on/off. Be hotplug friendly. */
 static int
 thermal_throttle_cpu_callback(struct notifier_block *nfb,
@@ -289,18 +286,14 @@ thermal_throttle_cpu_callback(struct notifier_block *nfb,
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
-		mutex_lock(&therm_cpu_lock);
 		err = thermal_throttle_add_dev(dev, cpu);
-		mutex_unlock(&therm_cpu_lock);
 		WARN_ON(err);
 		break;
 	case CPU_UP_CANCELED:
 	case CPU_UP_CANCELED_FROZEN:
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
-		mutex_lock(&therm_cpu_lock);
 		thermal_throttle_remove_dev(dev);
-		mutex_unlock(&therm_cpu_lock);
 		break;
 	}
 	return notifier_from_errno(err);
@@ -321,17 +314,11 @@ static __init int thermal_throttle_init_device(void)
 
 	cpu_notifier_register_begin();
 
-#ifdef CONFIG_HOTPLUG_CPU
-	mutex_lock(&therm_cpu_lock);
-#endif
 	/* connect live CPUs to sysfs */
 	for_each_online_cpu(cpu) {
 		err = thermal_throttle_add_dev(get_cpu_device(cpu), cpu);
 		WARN_ON(err);
 	}
-#ifdef CONFIG_HOTPLUG_CPU
-	mutex_unlock(&therm_cpu_lock);
-#endif
 
 	__register_hotcpu_notifier(&thermal_throttle_cpu_notifier);
 	cpu_notifier_register_done();
