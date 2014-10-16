Return-Path: <kernelfans@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 723031A055A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:25:55 +1100 (AEDT)
Received: by mail-pa0-f46.google.com with SMTP id fa1so2890419pad.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:25:53 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 04/11] powerpc: kvm: introduce a kthread on primary thread to
 anti tickless
Date: Thu, 16 Oct 2014 15:29:53 -0400
Message-Id: <1413487800-7162-5-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(This patch is a place holder.)

If there is only one vcpu thread is ready(the other vcpu thread can
wait for it to execute), the primary thread can enter tickless mode,
which causes the primary keeps running, so the secondary has no
opportunity to exit to host, even they have other tsk on them.

Introduce a kthread (anti_tickless) on primary, so when there is only
one vcpu thread on primary, the secondary can resort to anti_tickless
to keep the primary out of tickless mode.
(I thought that anti_tickless thread can goto NAP, so we can let the
secondary run).

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index a2595dd..f0b110e 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -575,9 +575,11 @@ static ssize_t __used store_kvm_enable(struct device *dev,
 	if (!test_bit(core, &kvm_on_core))
 		for (thr = 1; thr< threads_per_core; thr++)
 			if (cpu_online(thr * threads_per_core + thr))
-				cpumask_set_cpu(thr * threads_per_core + thr, &stop_cpus);
+				cpumask_set_cpu(core * threads_per_core + thr, &stop_cpus);
 
 	stop_machine(xics_migrate_irqs_away_secondary, NULL, &stop_cpus);
+	/* fixme, create a kthread on primary hwthread to handle tickless mode */
+	//kthread_create_on_cpu(prevent_tickless, NULL, core * threads_per_core, "ppckvm_prevent_tickless");
 	set_bit(core, &kvm_on_core);
 	return count;
 }
-- 
1.8.3.1
