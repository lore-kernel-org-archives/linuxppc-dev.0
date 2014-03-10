Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A8BE12C00B9
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:34:09 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 06:34:07 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 538842CE8047
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:34:02 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKE21f9109854
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:14:02 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKY1Uc026379
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:34:02 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 00/52] CPU hotplug: Fix issues with callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:03:52 +0530
Message-ID: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com, tj@kernel.org,
 paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Many subsystems and drivers have the need to register CPU hotplug callbacks
from their init routines and also perform initialization for the CPUs that are
already online. But unfortunately there is no race-free way to achieve this
today.

For example, consider this piece of code:

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	register_cpu_notifier(&foobar_cpu_notifier);

	put_online_cpus();

This is not safe because there is a possibility of an ABBA deadlock involving
the cpu_add_remove_lock and the cpu_hotplug.lock.

          CPU 0                                         CPU 1
          -----                                         -----

   Acquire cpu_hotplug.lock
   [via get_online_cpus()]

                                              CPU online/offline operation
                                              takes cpu_add_remove_lock
                                              [via cpu_maps_update_begin()]

   Try to acquire
   cpu_add_remove_lock
   [via register_cpu_notifier()]

                                              CPU online/offline operation
                                              tries to acquire cpu_hotplug.lock
                                              [via cpu_hotplug_begin()]

                            *** DEADLOCK! ***


Other combinations of callback registration also don't work correctly.
Examples:

	register_cpu_notifier(&foobar_cpu_notifier);

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	put_online_cpus();

This can lead to double initialization if a hotplug operation occurs after
registering the notifier and before invoking get_online_cpus().

On the other hand, the following piece of code can miss hotplug events
altogether:

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	put_online_cpus();
              ^
              |   Race window; Can miss hotplug events here
              v
	register_cpu_notifier(&foobar_cpu_notifier);


To solve these issues and provide a race-free method to register CPU hotplug
callbacks, this patchset introduces new variants of the callback registration
APIs that don't hold the cpu_add_remove_lock, and exports the
cpu_add_remove_lock via 2 new APIs cpu_notifier_register_begin/done() for use
by various subsystems. With this in place, the following code snippet will
register a hotplug callback as well as initialize already online CPUs without
any race conditions.

	cpu_notifier_register_begin();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	/* This doesn't take the cpu_add_remove_lock */
	__register_cpu_notifier(&foobar_cpu_notifier);

	cpu_notifier_register_done();


In this patchset, patch 1 adds lockdep annotations to catch the above mentioned
deadlock scenario. Patch 2 introduces the new APIs and infrastructure necessary
for race-free callback registration. The remaining patches perform tree-wide
conversions (to use this model).

This patchset has been hosted in the below git tree. It applies cleanly on
v3.14-rc6.

git://github.com/srivatsabhat/linux.git cpuhp-registration-fixes-v3


Changes from v2:
* Collected more Acks from subsystem maintainers.
* Updated the xen-balloon patch and got Ack from Boris Ostrovsky.


Gautham R. Shenoy (1):
      CPU hotplug: Add lockdep annotations to get/put_online_cpus()

Srivatsa S. Bhat (51):
      CPU hotplug: Provide lockless versions of callback registration functions
      Doc/cpu-hotplug: Specify race-free way to register CPU hotplug callbacks
      CPU hotplug, perf: Fix CPU hotplug callback registration
      ia64, salinfo: Fix hotplug callback registration
      ia64, palinfo: Fix CPU hotplug callback registration
      ia64, topology: Fix CPU hotplug callback registration
      ia64, err-inject: Fix CPU hotplug callback registration
      arm, hw-breakpoint: Fix CPU hotplug callback registration
      arm, kvm: Fix CPU hotplug callback registration
      s390, cacheinfo: Fix CPU hotplug callback registration
      s390, smp: Fix CPU hotplug callback registration
      sparc, sysfs: Fix CPU hotplug callback registration
      powerpc, sysfs: Fix CPU hotplug callback registration
      x86, msr: Fix CPU hotplug callback registration
      x86, cpuid: Fix CPU hotplug callback registration
      x86, vsyscall: Fix CPU hotplug callback registration
      x86, intel, uncore: Fix CPU hotplug callback registration
      x86, mce: Fix CPU hotplug callback registration
      x86, therm_throt.c: Fix CPU hotplug callback registration
      x86, therm_throt.c: Remove unused therm_cpu_lock
      x86, amd, ibs: Fix CPU hotplug callback registration
      x86, intel, cacheinfo: Fix CPU hotplug callback registration
      x86, intel, rapl: Fix CPU hotplug callback registration
      x86, amd, uncore: Fix CPU hotplug callback registration
      x86, hpet: Fix CPU hotplug callback registration
      x86, pci, amd-bus: Fix CPU hotplug callback registration
      x86, oprofile, nmi: Fix CPU hotplug callback registration
      x86, kvm: Fix CPU hotplug callback registration
      arm64, hw_breakpoint.c: Fix CPU hotplug callback registration
      arm64, debug-monitors: Fix CPU hotplug callback registration
      powercap, intel-rapl: Fix CPU hotplug callback registration
      scsi, bnx2i: Fix CPU hotplug callback registration
      scsi, bnx2fc: Fix CPU hotplug callback registration
      scsi, fcoe: Fix CPU hotplug callback registration
      zsmalloc: Fix CPU hotplug callback registration
      acpi-cpufreq: Fix CPU hotplug callback registration
      drivers/base/topology.c: Fix CPU hotplug callback registration
      clocksource, dummy-timer: Fix CPU hotplug callback registration
      intel-idle: Fix CPU hotplug callback registration
      oprofile, nmi-timer: Fix CPU hotplug callback registration
      octeon, watchdog: Fix CPU hotplug callback registration
      thermal, x86-pkg-temp: Fix CPU hotplug callback registration
      hwmon, coretemp: Fix CPU hotplug callback registration
      hwmon, via-cputemp: Fix CPU hotplug callback registration
      xen, balloon: Fix CPU hotplug callback registration
      trace, ring-buffer: Fix CPU hotplug callback registration
      profile: Fix CPU hotplug callback registration
      mm, vmstat: Fix CPU hotplug callback registration
      mm, zswap: Fix CPU hotplug callback registration
      net/core/flow.c: Fix CPU hotplug callback registration
      net/iucv/iucv.c: Fix CPU hotplug callback registration

 Documentation/cpu-hotplug.txt                 |   45 +++++++++
 arch/arm/kernel/hw_breakpoint.c               |    8 +-
 arch/arm/kvm/arm.c                            |    7 +
 arch/arm64/kernel/debug-monitors.c            |    6 +
 arch/arm64/kernel/hw_breakpoint.c             |    7 +
 arch/ia64/kernel/err_inject.c                 |   15 +++
 arch/ia64/kernel/palinfo.c                    |    6 +
 arch/ia64/kernel/salinfo.c                    |    6 +
 arch/ia64/kernel/topology.c                   |    6 +
 arch/powerpc/kernel/sysfs.c                   |    8 +-
 arch/s390/kernel/cache.c                      |    5 +
 arch/s390/kernel/smp.c                        |   13 ++-
 arch/sparc/kernel/sysfs.c                     |    6 +
 arch/x86/kernel/cpu/intel_cacheinfo.c         |   13 ++-
 arch/x86/kernel/cpu/mcheck/mce.c              |    8 +-
 arch/x86/kernel/cpu/mcheck/therm_throt.c      |   18 +---
 arch/x86/kernel/cpu/perf_event_amd_ibs.c      |    6 +
 arch/x86/kernel/cpu/perf_event_amd_uncore.c   |    7 +
 arch/x86/kernel/cpu/perf_event_intel_rapl.c   |    9 +-
 arch/x86/kernel/cpu/perf_event_intel_uncore.c |    6 +
 arch/x86/kernel/cpuid.c                       |   15 ++-
 arch/x86/kernel/hpet.c                        |    4 +
 arch/x86/kernel/msr.c                         |   16 ++-
 arch/x86/kernel/vsyscall_64.c                 |    6 +
 arch/x86/kvm/x86.c                            |    7 +
 arch/x86/oprofile/nmi_int.c                   |   15 +++
 arch/x86/pci/amd_bus.c                        |    5 +
 drivers/base/topology.c                       |   12 ++
 drivers/clocksource/dummy_timer.c             |   11 ++
 drivers/cpufreq/acpi-cpufreq.c                |    7 +
 drivers/hwmon/coretemp.c                      |   14 +--
 drivers/hwmon/via-cputemp.c                   |   14 +--
 drivers/idle/intel_idle.c                     |   12 ++
 drivers/oprofile/nmi_timer_int.c              |   23 +++--
 drivers/powercap/intel_rapl.c                 |   10 ++
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c             |   12 ++
 drivers/scsi/bnx2i/bnx2i_init.c               |   12 ++
 drivers/scsi/fcoe/fcoe.c                      |   15 +++
 drivers/thermal/x86_pkg_temp_thermal.c        |   14 +--
 drivers/watchdog/octeon-wdt-main.c            |   11 ++
 drivers/xen/balloon.c                         |   36 +++++--
 include/linux/cpu.h                           |   47 ++++++++++
 include/linux/perf_event.h                    |   16 +++
 kernel/cpu.c                                  |   38 +++++++-
 kernel/profile.c                              |   20 +++-
 kernel/trace/ring_buffer.c                    |   19 ++--
 mm/vmstat.c                                   |    6 +
 mm/zsmalloc.c                                 |   17 +++-
 mm/zswap.c                                    |    8 +-
 net/core/flow.c                               |    8 +-
 net/iucv/iucv.c                               |  121 ++++++++++++-------------
 51 files changed, 550 insertions(+), 226 deletions(-)


Regards,
Srivatsa S. Bhat
IBM Linux Technology Center
