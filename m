Return-Path: <ego@in.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F57FB7BB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Oct 2009 19:30:52 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id n998RqVd022342
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 19:27:52 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n998SN3A1433814
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 19:28:23 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n998Un9P025883
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 19:30:50 +1100
Subject: [PATCH v4 0/4] pseries: Add cede support for cpu-offline
To: Nathan Fontenot <nfont@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org
From: Gautham R Shenoy <ego@in.ibm.com>
Date: Fri, 09 Oct 2009 14:00:45 +0530
Message-ID: <20091009082952.32381.32794.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is version 4 of patch series that provides a framework to choose the
state a pseries CPU must be put to when it is offlined.

Previous versions can be found here:
Version 3: http://lkml.org/lkml/2009/9/15/164
Version 2: http://lkml.org/lkml/2009/8/28/102
Version 1: http://lkml.org/lkml/2009/8/6/236

This patch series differs considerably from the previous iterations in that:
- It is based on top of Nathan Fontenot's
  "pseries kernel handling of dynamic logical partitioning v2" patches
  found here: http://lkml.org/lkml/2009/9/18/173

- It does away with the sysfs tunables "available_hotplug_states" and
  "currrent_hotplug_state", thereby refraining from exposing any platform
  specific option to the userspace.

- It provides a framework that discovers the support for ceding the vcpu
  to the hypervisor with a latency specifier value. When such a support is
  present, it would put the offlined CPUs into a ceded state while
  setting the cede   latency specifier value in the VPA indicating
  the latency expectation of the   guest OS. Hypervisor may use this for
  better energy savings.

- On platforms which don't have support for ceding with a latency specifier
  hint, it puts the offlined CPUs into the rtas_stop_self() state.

- Currently, Nathan's patches have provided sysfs interfaces
	/sys/devices/system/cpu/{probe, release}
  to dynamically allocate and deallocate resources respectively. The current
  process of allocating and deallocating CPUs would require two steps,
  namely:
	- Write to the "probe/release" file
	- Write to the "online" file.

  This patch-series combines these two operations such that when the user
  writes to the "probe", the CPUs would not only get allocated to the
  partition but also onlined. Similarly, when the user writes to "release",
  the CPUs would be offlined before they are deallocated.

  Thus, the user will now have to play with only one set of sysfs tunables
  for performing deallocate and the sysfs tunable "online" can be used for
  the purpose of deactivating the CPU while still letting the LPAR own it.

- It provides serializations for handling the writes the the "online" file
  against the writes to "probe/release" pair so that at any given instant,
  the user could either be deallocating the CPUs or deactivating it, but
  not both.

With this approach, I hope that the objection regarding the layering
violation that was raised by Peter for previous approaches is
addressed, while also providing clean interfaces for the userspace tools
to distinguish between the deallocation and deactivation without exposing
any platform specific details.

The patchset has been tested on the available pseries platforms and it
works as per the expectations.

Comments are very much appreciated.
---

Gautham R Shenoy (4):
      pseries: Serialize cpu hotplug operations during deactivate Vs deallocate
      pseries: Add code to online/offline CPUs of a DLPAR node.
      pSeries: Add hooks to put the CPU into an appropriate offline state
      pSeries: extended_cede_processor() helper function.


 arch/powerpc/include/asm/lppaca.h               |    9 +
 arch/powerpc/platforms/pseries/dlpar.c          |  129 ++++++++++++++++++-
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |  157 ++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/offline_states.h |   18 +++
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   22 +++
 arch/powerpc/platforms/pseries/smp.c            |   19 +++
 arch/powerpc/xmon/xmon.c                        |    3 
 drivers/base/cpu.c                              |    2 
 include/linux/cpu.h                             |   13 ++
 9 files changed, 356 insertions(+), 16 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/offline_states.h

-- 
Thanks and Regards
gautham.
