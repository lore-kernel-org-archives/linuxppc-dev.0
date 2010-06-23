Return-Path: <sv@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C07A6B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Jun 2010 01:35:57 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id o5NFZqKq018613
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2010 21:05:52 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NFZqMH3547352
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2010 21:05:52 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NFZqEH023387
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2010 21:05:52 +0530
Received: from dirshya.in.ibm.com ([9.77.65.72])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o5NFZkDK022761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2010 21:05:50 +0530
Resent-Message-ID: <20100623153543.GA508@dirshya.in.ibm.com>
Subject: [PATCH v3 0/2] powerpc: add support for new hcall H_BEST_ENERGY
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Wed, 23 Jun 2010 11:33:56 +0530
Message-ID: <20100623060122.4957.33819.stgit@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlab.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

The following series adds a kernel module for powerpc pseries platforms in
order to export platform energy management capabilities.

The module exports data from a new hypervisor call H_BEST_ENERGY.

Comments and suggestions made on the previous iteration of the patch
has been incorporated.

Changed in v3:

* Added more documentation in the cleanup patch
* Removed RFC tag, rebased and tested on 2.6.35-rc3
* Ready for inclusion in powerpc/next tree for further testing

Changes in v2:

[1] [RFC PATCH v2 0/2] powerpc: add support for new hcall H_BEST_ENERGY
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-May/082246.html

* Cleanup cpu/thread/core APIs
* Export APIs to module instead of threads_per_core
* Use of_find_node_by_path() instead of of_find_node_by_name()
* Error checking and whitespace cleanups

First version:
[2] [RFC] powerpc: add support for new hcall H_BEST_ENERGY
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-March/080796.html

Please review and include in powerpc/next tree for further testing.  I will
add the following enhancements incrementally:

* Detect h_call support from ibm,hypertas-functions
* Limit sysfs file creation only on hcall availability

This patch series will apply on 2.6.35-rc3 as well as powerpc/next tree.

Thanks,
Vaidy
---

Vaidyanathan Srinivasan (2):
      powerpc: cleanup APIs for cpu/thread/core mappings
      powerpc: add support for new hcall H_BEST_ENERGY


 arch/powerpc/include/asm/cputhreads.h           |   15 +
 arch/powerpc/include/asm/hvcall.h               |    3 
 arch/powerpc/kernel/smp.c                       |   19 +-
 arch/powerpc/mm/mmu_context_nohash.c            |   12 +
 arch/powerpc/platforms/pseries/Kconfig          |   10 +
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/pseries_energy.c |  258 +++++++++++++++++++++++
 7 files changed, 302 insertions(+), 16 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/pseries_energy.c

-- 
