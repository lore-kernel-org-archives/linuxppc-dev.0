Return-Path: <ego@in.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [59.145.155.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AD71B7C23
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 16:22:53 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp01.in.ibm.com (8.14.3/8.13.1) with ESMTP id n9U5MjGD006998
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2009 10:52:45 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9U5MjCI2564238
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2009 10:52:45 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9U5MiGj007126
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2009 10:52:45 +0530
Subject: [PATCH v5 0/4] pseries: Add cede support for cpu-offline
To: Nathan Fontenot <nfont@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
From: Gautham R Shenoy <ego@in.ibm.com>
Date: Fri, 30 Oct 2009 10:52:43 +0530
Message-ID: <20091030052106.25493.42109.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is version 5 of patch series that provides a framework to choose the
state a pseries CPU must be put to when it is offlined.

Previous versions can be found here:
Version 4: http://lkml.org/lkml/2009/10/9/59
Version 3: http://lkml.org/lkml/2009/9/15/164
Version 2: http://lkml.org/lkml/2009/8/28/102
Version 1: http://lkml.org/lkml/2009/8/6/236

Changes from the previous version include:
- Rebased against Nathan Fontenot's latest "pseries kernel handling of dynamic
  logical paritioning v4" patches found here:
  http://lkml.org/lkml/2009/10/21/98

- Added boot-time option to disable putting the offlined vcpus into an
  extended H_CEDE state.

- Addressed Ben's comments regarding the if-else sequencing in
  pseries_mach_cpu_die().

- Addition of comments for pseries_cpu_die() to distinguish it from
  pseries_mach_cpu_die()

Also,

- This approach addresses Peter Z's objections regarding layering
  violations. The user simply offlines the cpu and doesn't worry about what
  state the CPU should be put into. That part is automatically handled by the
  kernel.

- It does not add any additional sysfs interface instead uses the existing
  sysfs interface to offline CPUs.

- On platforms which do not have support for ceding the vcpu with a
  latency specifier value, the offlining mechanism defaults to the current
  method of calling rtas_stop_self().

The patchset has been tested on the available pseries platforms and it works
as per the expectations. I believe that the patch set is ready for inclusion.
---

Gautham R Shenoy (4):
      pseries: Serialize cpu hotplug operations during deactivate Vs deallocate
      pseries: Add code to online/offline CPUs of a DLPAR node.
      pSeries: Add hooks to put the CPU into an appropriate offline state
      pSeries: extended_cede_processor() helper function.


 Documentation/cpu-hotplug.txt                   |    6 +
 arch/powerpc/include/asm/lppaca.h               |    9 +
 arch/powerpc/platforms/pseries/dlpar.c          |  129 ++++++++++++++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |  182 ++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/offline_states.h |   18 ++
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   22 +++
 arch/powerpc/platforms/pseries/smp.c            |   19 ++
 arch/powerpc/xmon/xmon.c                        |    3 
 drivers/base/cpu.c                              |    2 
 include/linux/cpu.h                             |   13 ++
 10 files changed, 387 insertions(+), 16 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/offline_states.h

-- 
Thanks and Regards
gautham.
