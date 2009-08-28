Return-Path: <ego@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2E144B7C93
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 20:00:44 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7SA0aWw007042
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 15:30:36 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SA0aCO2224148
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 15:30:36 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7SA0YaK015733
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 15:30:36 +0530
Subject: [PATCH v2 0/2] cpu: pseries: Offline state framework.
To: Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Dipankar Sarma <dipankar@in.ibm.com>
From: Gautham R Shenoy <ego@in.ibm.com>
Date: Fri, 28 Aug 2009 15:30:11 +0530
Message-ID: <20090828095741.10641.32053.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is the version 2 of the patch series to provide a cpu-offline framework
that enables the administrators choose the state the offline CPU must be put
into when multiple such states are exposed by the underlying architecture.

Version 1 of the Patch can be found here:
http://lkml.org/lkml/2009/8/6/236

The patch-series exposes the following sysfs tunables to
allow the system-adminstrator to choose the state of a CPU:

To query the available hotplug states, one needs to read the sysfs tunable:
	/sys/devices/system/cpu/cpu<number>/available_hotplug_states
To query or set the current state, on needs to read/write the sysfs tunable:
	/sys/devices/system/cpu/cpu<number>/current_states

The patchset ensures that the writes to the "current_state" sysfs file are
serialized against the writes to the "online" file.

This patchset also contains the offline state driver implemented for
pSeries. For pSeries, we define three available_hotplug_states. They are:

	online: The processor is online.

	deallocate: This is the the default behaviour when the cpu is offlined
	even in the absense of this driver. The CPU would call make an
	rtas_stop_self() call and hand over the CPU back to the resource pool,
	thereby effectively deallocating that vCPU from the LPAR.
	NOTE: This would result in a configuration change to the LPAR
	which is visible to the outside world.

	deactivate: This cedes the vCPU to the hypervisor which
	in turn can put the vCPU time to the best use.
	NOTE: This option DOES NOT result in a configuration change
	and the vCPU would be still entitled to the LPAR to which it earlier
	belong to.

Awaiting your feedback.
---

Gautham R Shenoy (2):
      cpu: Implement cpu-offline-state driver for pSeries.
      cpu: Offline state Framework.


 arch/powerpc/platforms/pseries/Makefile         |    2 
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |   76 +++++++++-
 arch/powerpc/platforms/pseries/offline_driver.c |  161 +++++++++++++++++++++
 arch/powerpc/platforms/pseries/offline_driver.h |   20 +++
 arch/powerpc/platforms/pseries/smp.c            |   17 ++
 drivers/base/cpu.c                              |  176 ++++++++++++++++++++++-
 include/linux/cpu.h                             |   30 ++++
 7 files changed, 465 insertions(+), 17 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/offline_driver.c
 create mode 100644 arch/powerpc/platforms/pseries/offline_driver.h

-- 
Thanks and Regards
gautham.
