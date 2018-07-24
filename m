Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZSkF4Q4qzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 16:14:28 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6O6E4DD126773
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 02:14:27 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kdwy3sy5q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 02:14:26 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 24 Jul 2018 00:14:26 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v4 0/2] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
Date: Tue, 24 Jul 2018 11:44:06 +0530
Message-Id: <1532412848-9826-1-git-send-email-ego@linux.vnet.ibm.com>
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

This is the fourth iteration of the patchset to add support for
big-core on POWER9.

The previous versions can be found here:

v3: https://lkml.org/lkml/2018/7/6/255
v2: https://lkml.org/lkml/2018/7/3/401
v1: https://lkml.org/lkml/2018/5/11/245

Changes :
v3 --> v4:
   - Build fix for powerpc-g5 : Enable CPU_FTR_ASYM_SMT only on
     CONFIG_PPC_POWERNV and CONFIG_PPC_PSERIES.
   - Fixed a minor error in the ABI description.

v2 --> v3
    - Set sane values in the tg->property, tg->nr_groups inside
    parse_thread_groups before returning due to an error.
    - Define a helper function to determine whether a CPU device node
      is a big-core or not.
    - Updated the comments around the functions to describe the
      arguments passed to them.

v1 --> v2
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
show a marked improvement with this patchset over the 4.18-rc5 vanilla
kernel.

The result of 100 such runs for 4.18-rc5 kernel and the 4.18-rc5 +
big-core-patches are as follows

4.18-rc5 vanilla:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0 - 1000000]        :      0      : #
[1000000 - 2000000]  :      7      : ##
[2000000 - 3000000]  :      17     : ####
[3000000 - 4000000]  :      18     : ####
[4000000 - 5000000]  :      3      : #
[5000000 - 6000000]  :      55     : ############

4.8-rc5 + big-core-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0 - 1000000]        :      0      : #
[1000000 - 2000000]  :      0      : #
[2000000 - 3000000]  :      8      : ##
[3000000 - 4000000]  :      0      : #
[4000000 - 5000000]  :      0      : #
[5000000 - 6000000]  :      92     : ###################


Gautham R. Shenoy (2):
  powerpc: Detect the presence of big-cores via "ibm,thread-groups"
  powerpc: Enable CPU_FTR_ASYM_SMT for interleaved big-cores

 Documentation/ABI/testing/sysfs-devices-system-cpu |   8 +
 arch/powerpc/include/asm/cputhreads.h              |  22 ++
 arch/powerpc/kernel/setup-common.c                 | 229 ++++++++++++++++++++-
 arch/powerpc/kernel/sysfs.c                        |  35 ++++
 4 files changed, 293 insertions(+), 1 deletion(-)

-- 
1.9.4
