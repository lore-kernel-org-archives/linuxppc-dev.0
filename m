Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CACF91007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 06:58:53 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id nAQJwnwl032248
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2009 06:58:49 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAQJtO3f1745136
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2009 06:55:24 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAQJwp6U021035
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2009 06:58:52 +1100
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH v6 0/2] pseries: Add cede support for cpu-offline
To: Nathan Fontenot <nfont@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Date: Fri, 27 Nov 2009 01:28:45 +0530
Message-ID: <20091126195121.29159.66098.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
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

This is version 6 of patch series that provides a framework to choose the state
a pseries CPU must be put to when it is offlined.

Previous versions can be found here:
Version 5: http://lkml.org/lkml/2009/10/30/6
Version 4: http://lkml.org/lkml/2009/10/9/59
Version 3: http://lkml.org/lkml/2009/9/15/164
Version 2: http://lkml.org/lkml/2009/8/28/102
Version 1: http://lkml.org/lkml/2009/8/6/236

Changes from the previous version include:

- Built on Nathan Fontenot's v3 of "Kernel handling of Dynamic
  Logical Partitioning" http://lkml.org/lkml/2009/11/25/21

- Rebased to powerpc.git tree and hence dropped 1st and 2nd patch in
  the stack since they are already in the powerpc.git tree:

  With reference to previous version,

  Dropped:
  1/4 pSeries: extended_cede_processor() helper function
  2/4 pSeries: Add hooks to put the CPU into an appropriate offline state

  Posting only:
  3/4 pseries: Add code to online/offline CPUs of a DLPAR node
  4/4 pseries: Serialize cpu hotplug operations during deactivate Vs deallocate

  Minor changes in the above patchs due to changes in Nathan's routines.

Also,

- This approach addresses Peter Z's objections regarding layering
  violations. The user simply offlines the cpu and doesn't worry about what
  state the CPU should be put into. That part is automatically handled by the
  kernel.

  Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
  http://lkml.org/lkml/2009/11/11/328

- It does not add any additional sysfs interface instead uses the existing
  sysfs interface to offline CPUs.

- On platforms which do not have support for ceding the vcpu with a
  latency specifier value, the offlining mechanism defaults to the current
  method of calling rtas_stop_self().

This patchset is based on powerpc.git + Nathan's patches and has been built and
tested on pseries platforms.  This series can be applied to powerpc.git after
Nathan's patches.

Thanks,
Vaidy

---

Gautham R Shenoy (2):
      pseries: Serialize cpu hotplug operations during deactivate Vs deallocate
      pseries: Add code to online/offline CPUs of a DLPAR node


 arch/powerpc/platforms/pseries/dlpar.c |  144 ++++++++++++++++++++++++++++++--
 drivers/base/cpu.c                     |    2 
 include/linux/cpu.h                    |   13 +++
 3 files changed, 150 insertions(+), 9 deletions(-)

-- 
