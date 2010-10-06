Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3E604B70D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 05:37:22 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o96IbJ3F007246
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Oct 2010 05:37:19 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o96IbJj72535428
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Oct 2010 05:37:19 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o96IbI7O021417
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Oct 2010 05:37:19 +1100
Subject: [PATCH v5 0/2] powerpc: add support for new hcall H_BEST_ENERGY
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Thu, 07 Oct 2010 00:06:49 +0530
Message-ID: <20101006182948.7006.75088.stgit@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

The following series adds a new kernel module for powerpc pseries
platforms in order to export platform energy management capabilities.

The module exports data from a new hypervisor call H_BEST_ENERGY.

Comments and suggestions made on the previous iteration of the
patch related to function naming has been incorporated.

Changes in v5:

* Renamed cpu_{left,right}most_thread_sibling() to 
				cpu_{first,last}_thread_sibling()

* Renamed cpu_core_of_thread() to cpu_core_index_of_thread()  
  (these function work on core index)

* Rebased to 2.6.36-rc6 and tested on a supported platform

Changes in v4:

[4] [PATCH v4 0/2] powerpc: add support for new hcall H_BEST_ENERGY
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-July/084217.html

* Added more documentation
* Added check_for_h_best_energy() to look in ibm,hypertas-functions so
  that sysfs entries are not created in an unsupported platform
* Added cleaner error checks and correct of_node_put()
* Rebased and tested on 2.6.35-rc5

Changed in v3:

[3] [PATCH v3 0/2] powerpc: add support for new hcall H_BEST_ENERGY
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-June/083414.html

* Added more documentation in the cleanup patch
* Removed RFC tag, rebased and tested on 2.6.35-rc3
* Ready for inclusion in powerpc/next tree for further testing

Changes in v2:

[2] [RFC PATCH v2 0/2] powerpc: add support for new hcall H_BEST_ENERGY
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-May/082246.html

* Cleanup cpu/thread/core APIs
* Export APIs to module instead of threads_per_core
* Use of_find_node_by_path() instead of of_find_node_by_name()
* Error checking and whitespace cleanups

First version:
[1] [RFC] powerpc: add support for new hcall H_BEST_ENERGY
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-March/080796.html

This patch series will apply on 2.6.36-rc6 as well as powerpc/next
tree.  Please review and include in powerpc/next tree for further
testing.  

I could incrementally reduce some of the error checks as suggested by
Michael Neuling as next steps.  This patch series is conservative and
has more error checking in device tree parsing and drc index matching
code than what may be required.

Thanks,
Vaidy
---

Vaidyanathan Srinivasan (2):
      powerpc: cleanup APIs for cpu/thread/core mappings
      powerpc: add support for new hcall H_BEST_ENERGY


 arch/powerpc/include/asm/cputhreads.h           |   15 +
 arch/powerpc/include/asm/hvcall.h               |    3 
 arch/powerpc/kernel/smp.c                       |   19 +
 arch/powerpc/mm/mmu_context_nohash.c            |   12 -
 arch/powerpc/platforms/pseries/Kconfig          |   10 +
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/pseries_energy.c |  326 +++++++++++++++++++++++
 7 files changed, 370 insertions(+), 16 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/pseries_energy.c
