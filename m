Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Kh8V6TbxzF1Rp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 21:04:26 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w63B4EVL086848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2018 07:04:23 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k06t5jvcq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 07:04:20 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 3 Jul 2018 07:04:02 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH 0/2] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
Date: Tue,  3 Jul 2018 16:33:49 +0530
Message-Id: <cover.1530609795.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Hi,

This is the second iteration of the patchset to add support for big-core on POWER9.

The earlier version can be found here: https://lkml.org/lkml/2018/5/11/245.

The changes from the previous version:
    - Added comments explaining the "ibm,thread-groups" device tree property.
    - Uses cleaner device-tree parsing functions to parse the u32 arrays.
    - Adds a sysfs file listing the small-core siblings for every CPU.
    - Enables the scheduler optimization by setting the CPU_FTR_ASYM_SMT bit
      in the cur_cpu_spec->cpu_features on detecting the presence
      of interleaved big-core.
    - Handles the corner case where there is only a single thread-group
      or when there is a single thread in a thread-group.


Description:
~~~~~~~~~~~~~~~~~~~~
A pair of IBM POWER9 SMT4 cores can be fused together to form a
big-core with 8 SMT threads. This can be discovered via the
"ibm,thread-groups" CPU property in the device tree which will
indicate which group of threads that share the L1 cache, translation
cache and instruction data flow.  If there are multiple such group of
threads, then the core is a big-core. Furthermore, the thread-ids of
such a big-core is obtained by interleaving the thread-ids of the
component SMT4 cores.

Eg: Threads in the pair of component SMT4 cores of an interleaved
big-core are numbered {0,2,4,6} and {1,3,5,7} respectively.
    
On such a big-core, when multiple tasks are scheduled to run on the
big-core, we get the best performance when the tasks are spread across
the pair of SMT4 cores.

The Linux scheduler supports a flag called "SD_ASYM_PACKING" which
when set in the SMT sched-domain, biases the load-balancing of the
tasks on the smaller numbered threads in the core. On an big-core
whose threads are interleavings of the threads of the small cores,
enabling SD_ASYM_PACKING in the SMT sched-domain automatically results
in spreading the tasks uniformly across the associated pair of SMT4
cores, thereby yielding better performance.

This patchset contains two patches which on detecting the presence of
interleaved big-cores will enable the the CPU_FTR_ASYM_SMT bit in the
cur_cpu_spec->cpu_feature.

Patch 1: adds support to detect the presence of
big-cores and reports the small-core siblings of each CPU X
via the sysfs file "/sys/devices/system/cpu/cpuX/big_core_siblings".

Patch 2: checks if the thread-ids of the component small-cores are
interleaved, in which case we enable the the CPU_FTR_ASYM_SMT bit in
the cur_cpu_spec->cpu_features which results in the SD_ASYM_PACKING
flag being set at the SMT level sched-domain.

Results:
~~~~~~~~~~~~~~~~~
Experimental results for ebizzy with 2 threads, bound to a single big-core
show a marked improvement with this patchset over the 4.18-rc3 vanilla
kernel.

The result of 100 such runs for 4.18-rc3 kernel and the 4.18-rc3 +
big-core-patches are as follows

4.18-rc3:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
[0 -       1000000]  :      0      : #
[1000000 - 2000000]  :      3      : #
[2000000 - 3000000]  :      16     : ####
[3000000 - 4000000]  :      11     : ###
[4000000 - 5000000]  :      0      : #
[5000000 - 6000000]  :      70     : ###############

4.18-rc3 + big-core-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
[0 -       1000000]  :      0      : #
[1000000 - 2000000]  :      0      : #
[2000000 - 3000000]  :      6      : ##
[3000000 - 4000000]  :      0      : #
[4000000 - 5000000]  :      2      : #
[5000000 - 6000000]  :      92     : ###################



Gautham R. Shenoy (2):
  powerpc: Detect the presence of big-cores via "ibm,thread-groups"
  powerpc: Enable CPU_FTR_ASYM_SMT for interleaved big-cores

 Documentation/ABI/testing/sysfs-devices-system-cpu |   8 +
 arch/powerpc/include/asm/cputhreads.h              |  22 +++
 arch/powerpc/kernel/setup-common.c                 | 177 ++++++++++++++++++++-
 arch/powerpc/kernel/sysfs.c                        |  35 ++++
 4 files changed, 241 insertions(+), 1 deletion(-)

-- 
1.9.4
