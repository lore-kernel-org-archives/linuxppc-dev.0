Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DA1F1A05B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 20:56:54 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 27 May 2014 16:26:47 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8AC37E0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 16:27:29 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4RAusN164028810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 16:26:54 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4RAugLi004069
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 16:26:43 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] powerpc,
 kexec: Fix "Processor X is stuck" issue during kexec from ST mode
To: benh@kernel.crashing.org, paulus@samba.org, ebiederm@xmission.com,
 vgoyal@redhat.com
Date: Tue, 27 May 2014 16:25:34 +0530
Message-ID: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: ego@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki@in.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we try to perform a kexec when the machine is in ST (Single-Threaded) mode
(ppc64_cpu --smt=off), the kexec operation doesn't succeed properly, and we
get the following messages during boot:

[    0.089866] POWER8 performance monitor hardware support registered
[    0.089985] power8-pmu: PMAO restore workaround active.
[    5.095419] Processor 1 is stuck.
[   10.097933] Processor 2 is stuck.
[   15.100480] Processor 3 is stuck.
[   20.102982] Processor 4 is stuck.
[   25.105489] Processor 5 is stuck.
[   30.108005] Processor 6 is stuck.
[   35.110518] Processor 7 is stuck.
[   40.113369] Processor 9 is stuck.
[   45.115879] Processor 10 is stuck.
[   50.118389] Processor 11 is stuck.
[   55.120904] Processor 12 is stuck.
[   60.123425] Processor 13 is stuck.
[   65.125970] Processor 14 is stuck.
[   70.128495] Processor 15 is stuck.
[   75.131316] Processor 17 is stuck.

Note that only the sibling threads are stuck, while the primary threads (0, 8,
16 etc) boot just fine. Looking closer at the previous step of kexec, we observe
that kexec tries to wakeup (bring online) the sibling threads of all the cores,
before performing kexec:

[ 9464.131231] Starting new kernel
[ 9464.148507] kexec: Waking offline cpu 1.
[ 9464.148552] kexec: Waking offline cpu 2.
[ 9464.148600] kexec: Waking offline cpu 3.
[ 9464.148636] kexec: Waking offline cpu 4.
[ 9464.148671] kexec: Waking offline cpu 5.
[ 9464.148708] kexec: Waking offline cpu 6.
[ 9464.148743] kexec: Waking offline cpu 7.
[ 9464.148779] kexec: Waking offline cpu 9.
[ 9464.148815] kexec: Waking offline cpu 10.
[ 9464.148851] kexec: Waking offline cpu 11.
[ 9464.148887] kexec: Waking offline cpu 12.
[ 9464.148922] kexec: Waking offline cpu 13.
[ 9464.148958] kexec: Waking offline cpu 14.
[ 9464.148994] kexec: Waking offline cpu 15.
[ 9464.149030] kexec: Waking offline cpu 17.

Instrumenting this piece of code revealed that the cpu_up() operation actually
fails with -EBUSY. Thus, only the primary threads of all the cores are online
during kexec, and hence this is a sure-shot receipe for disaster, as explained
in commit e8e5c2155b (powerpc/kexec: Fix orphaned offline CPUs across kexec),
as well as in the comment above wake_offline_cpus().

It turns out that cpu_up() was returning -EBUSY because the variable
'cpu_hotplug_disabled' was set to 1; and this disabling of CPU hotplug was done
by migrate_to_reboot_cpu() inside kernel_kexec().

Now, migrate_to_reboot_cpu() was originally written with the assumption that
any further code will not need to perform CPU hotplug, since we are anyway in
the reboot path. However, kexec is clearly not such a case, since we depend on
onlining CPUs, atleast on powerpc.

So re-enable cpu-hotplug after returning from migrate_to_reboot_cpu() in the
kexec path, to fix this regression in kexec on powerpc.

Also, wrap the cpu_up() in powerpc kexec code within a WARN_ON(), so that we
can catch such issues more easily in the future.

Fixes: c97102ba963 (kexec: migrate to reboot cpu)
Cc: stable@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/machine_kexec_64.c |    2 +-
 kernel/kexec.c                         |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 59d229a..879b3aa 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -237,7 +237,7 @@ static void wake_offline_cpus(void)
 		if (!cpu_online(cpu)) {
 			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",
 			       cpu);
-			cpu_up(cpu);
+			WARN_ON(cpu_up(cpu));
 		}
 	}
 }
diff --git a/kernel/kexec.c b/kernel/kexec.c
index c8380ad..28c5706 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1683,6 +1683,14 @@ int kernel_kexec(void)
 		kexec_in_progress = true;
 		kernel_restart_prepare(NULL);
 		migrate_to_reboot_cpu();
+
+		/*
+		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
+		 * no further code needs to use CPU hotplug (which is true in
+		 * the reboot case). However, the kexec path depends on using
+		 * CPU hotplug again; so re-enable it here.
+		 */
+		cpu_hotplug_enable();
 		printk(KERN_EMERG "Starting new kernel\n");
 		machine_shutdown();
 	}
