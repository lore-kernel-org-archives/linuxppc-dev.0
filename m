Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 539B4B7D53
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 21:48:42 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id o47Bmcti021608
	for <linuxppc-dev@ozlabs.org>; Fri, 7 May 2010 17:18:38 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o47BmcMZ3334166
	for <linuxppc-dev@ozlabs.org>; Fri, 7 May 2010 17:18:38 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o47Bmbja012698
	for <linuxppc-dev@ozlabs.org>; Fri, 7 May 2010 17:18:38 +0530
Subject: [RFC PATCH v2 0/2] powerpc: add support for new hcall H_BEST_ENERGY
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Fri, 07 May 2010 17:18:37 +0530
Message-ID: <20100507113907.5035.9794.stgit@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The following series adds a powerpc pseries platform module for
exporting platform energy management capabilities.

The module exports data from a new hypervisor call H_BEST_ENERGY.

Comments and suggestions made on the previous iteration of the patch
has been incorporated.

[RFC] powerpc: add support for new hcall H_BEST_ENERGY
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-March/080796.html

Changes from v1:

* Cleanup cpu/thread/core APIs
* Export APIs to module instead of threads_per_core
* Use of_find_node_by_path() instead of of_find_node_by_name()
* Error checking and whitespace cleanups

Please review and let me know your comments.  I will post the next
version ready for inclusion into powerpc/next tree along with test
reports.

The current patch series is on 2.6.34-rc6.

Thanks,
Vaidy
---

Vaidyanathan Srinivasan (2):
      powerpc: cleanup APIs for cpu/thread/core mappings
      powerpc: add support for new hcall H_BEST_ENERGY


 arch/powerpc/include/asm/cputhreads.h           |   15 +
 arch/powerpc/include/asm/hvcall.h               |    3 
 arch/powerpc/kernel/smp.c                       |   17 +-
 arch/powerpc/mm/mmu_context_nohash.c            |   12 +
 arch/powerpc/platforms/pseries/Kconfig          |   10 +
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/pseries_energy.c |  258 +++++++++++++++++++++++
 7 files changed, 301 insertions(+), 15 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/pseries_energy.c
