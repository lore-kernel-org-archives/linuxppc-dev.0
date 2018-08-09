Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mH2S661FzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 15:32:31 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w795So6O021735
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2018 01:32:29 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2krddpv5kx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 01:32:29 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 8 Aug 2018 23:32:28 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v6 0/2] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
Date: Thu,  9 Aug 2018 11:02:06 +0530
Message-Id: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
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

This is the fifth iteration of the patchset to add support for
big-core on POWER9. This patch also optimizes the task placement on
such big-core systems.

The previous versions can be found here:

v5: https://lkml.org/lkml/2018/8/6/587
v4: https://lkml.org/lkml/2018/7/24/79
v3: https://lkml.org/lkml/2018/7/6/255
v2: https://lkml.org/lkml/2018/7/3/401
v1: https://lkml.org/lkml/2018/5/11/245

Changes :

v5 --> v6:
   - Fixed the code to build without warnings for !CONFIG_SCHED_SMT.
   - While checking for shared caches on big-core system, use the
     smallcore_sibling_mask to compare with compare with
     l2_cache_mask, which will ensure that the CACHE level
     sched-domain is created.
   - Added benchmark results with hackbench to demonstrate the
     benefits of having the CACHE level sched-domain.

v4 --> v5:
   - Patch 2 is entirely different: Instead of using CPU_FTR_ASYM_SMT
     feature, use the small core siblings at the SMT level
     sched-domain. This was suggested by Nicholas Piggin and Michael
     Ellerman.

   - A more detailed description follows below.

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
threads, then the core is a big-core. Furthermore, on POWER9 the thread-ids of
such a big-core is obtained by interleaving the thread-ids of the
component SMT4 cores.

Eg: Threads in the pair of component SMT4 cores of an interleaved
big-core are numbered {0,2,4,6} and {1,3,5,7} respectively.

 	   -------------------------
	   |  	    L1 Cache       |
       ----------------------------------
       |L2|     |     |     |      |
       |  |  0  |  2  |  4  |  6   |Small Core0
       |C |     |     |     |      |
Big    |a --------------------------
Core   |c |     |     |     |      |
       |h |  1  |  3  |  5  |  7   | Small Core1
       |e |     |     |     |      |
       -----------------------------
	  |  	    L1 Cache       |
	  --------------------------

On such a big-core system, when multiple tasks are scheduled to run on
the big-core, we get the best performance when the tasks are spread
across the pair of SMT4 cores.

Eg: Suppose there 4 tasks {p1, p2, p3, p4} are run on a big core, then

An Example of Optimal Task placement:
	   --------------------------
           |     |     |     |      |
           |  0  |  2  |  4  |  6   |   Small Core0
           | (p1)| (p2)|     |      |
Big Core   --------------------------
           |     |     |     |      |
           |  1  |  3  |  5  |  7   |   Small Core1
           |     | (p3)|     | (p4) |
           --------------------------

An example of Suboptimal Task placement:
	   --------------------------
           |     |     |     |      |
           |  0  |  2  |  4  |  6   |   Small Core0
           | (p1)| (p2)|     |  (p4)|
Big Core   --------------------------
           |     |     |     |      |
           |  1  |  3  |  5  |  7   |   Small Core1
           |     | (p3)|     |      |
           --------------------------

In order to achieve optimal task placement, on big-core systems, we
define the SMT level sched-domain to consist of the threads belonging
to the small cores. The CACHE level sched domain will consist of all
the threads belonging to the big-core. With this, the Linux Kernel
load-balancer will ensure that the tasks are spread across all the
component small cores in the system, thereby yielding optimum
performance.

Furthermore, this solution works correctly across all SMT modes
(8,4,2), as the interleaved thread-ids ensures that when we go to
lower SMT modes (4,2) the threads are offlined in a descending order,
thereby leaving equal number of threads from the component small cores
online as illustrated below.

With Patches: (ppc64_cpu --smt=on) : SMT domain
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 CPU0 attaching sched-domain(s):
  domain-0: span=0,2,4,6 level=SMT
   groups: 0:{ span=0 cap=294 }, 2:{ span=2 cap=294 },
           4:{ span=4 cap=294 }, 6:{ span=6 cap=294 }
 CPU1 attaching sched-domain(s):
  domain-0: span=1,3,5,7 level=SMT
   groups: 1:{ span=1 cap=294 }, 3:{ span=3 cap=294 },
           5:{ span=5 cap=294 }, 7:{ span=7 cap=294 }

            Optimal Task placement (SMT 8)
	   --------------------------
           |     |     |     |      |
           |  0  |  2  |  4  |  6   |   Small Core0
           | (p1)| (p2)|     |      |
Big Core   --------------------------
           |     |     |     |      |
           |  1  |  3  |  5  |  7   |   Small Core1
           |     | (p3)|     | (p4) |
           --------------------------

With Patches : (ppc64_cpu --smt=4) : SMT domain
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 CPU0 attaching sched-domain(s):
  domain-0: span=0,2 level=SMT
   groups: 0:{ span=0 cap=589 }, 2:{ span=2 cap=589 }
 CPU1 attaching sched-domain(s):
  domain-0: span=1,3 level=SMT
   groups: 1:{ span=1 cap=589 }, 3:{ span=3 cap=589 }

            Optimal Task placement (SMT 4)
	   --------------------------
           |     |     |     |      |
           |  0  |  2  |  4  |  6   |   Small Core0
           | (p1)| (p2)| Off | Off  |
Big Core   --------------------------
           |     |     |     |      |
           |  1  |  3  |  5  |  7   |   Small Core1
           | (p4)| (p3)| Off | Off  |
           --------------------------

With Patches : (ppc64_cpu --smt=2) : SMT domain ceases to exist.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            Optimal Task placement (SMT 2)
	   --------------------------
           | (p2)|     |     |      |
           |  0  |  2  |  4  |  6   |   Small Core0
           | (p1)| Off | Off | Off  |
Big Core   --------------------------
           | (p3)|     |     |      |
           |  1  |  3  |  5  |  7   |   Small Core1
           | (p4)| Off | Off | Off  |
           --------------------------

Thus, as an added advantage in SMT=2 mode, we will only have 3 levels
in the sched-domain topology (CACHE, DIE and NUMA).

The SMT levels, without the patches are as follows.

Without Patches: (ppc64_cpu --smt=on) : SMT domain
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 CPU0 attaching sched-domain(s):
  domain-0: span=0-7 level=SMT
   groups: 0:{ span=0 cap=147 }, 1:{ span=1 cap=147 },
           2:{ span=2 cap=147 }, 3:{ span=3 cap=147 },
           4:{ span=4 cap=147 }, 5:{ span=5 cap=147 },
	   6:{ span=6 cap=147 }, 7:{ span=7 cap=147 }
 CPU1 attaching sched-domain(s):
  domain-0: span=0-7 level=SMT
   groups: 1:{ span=1 cap=147 }, 2:{ span=2 cap=147 },
           3:{ span=3 cap=147 }, 4:{ span=4 cap=147 },
	   5:{ span=5 cap=147 }, 6:{ span=6 cap=147 },
	   7:{ span=7 cap=147 }, 0:{ span=0 cap=147 }

Without Patches: (ppc64_cpu --smt=4) : SMT domain
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 CPU0 attaching sched-domain(s):
  domain-0: span=0-3 level=SMT
   groups: 0:{ span=0 cap=294 }, 1:{ span=1 cap=294 },
           2:{ span=2 cap=294 }, 3:{ span=3 cap=294 },
 CPU1 attaching sched-domain(s):
  domain-0: span=0-3 level=SMT
   groups: 1:{ span=1 cap=294 }, 2:{ span=2 cap=294 },
           3:{ span=3 cap=294 }, 0:{ span=0 cap=294 }

Without Patches: (ppc64_cpu --smt=2) : SMT domain
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 CPU0 attaching sched-domain(s):
  domain-0: span=0-1 level=SMT
   groups: 0:{ span=0 cap=589 }, 1:{ span=1 cap=589 },

 CPU1 attaching sched-domain(s):
  domain-0: span=0-1 level=SMT
   groups: 1:{ span=1 cap=589 }, 0:{ span=0 cap=589 },

This patchset contains two patches which on detecting the presence of
big-cores, defines the SMT level sched domain to correspond to the
threads of the small cores.

Patch 1: adds support to detect the presence of
big-cores and reports the small-core siblings of each CPU X
via the sysfs file "/sys/devices/system/cpu/cpuX/small_core_siblings".

Patch 2: Defines the SMT level sched domain to correspond to the
threads of the small cores.

Results:
~~~~~~~~~~~~~~~~~
1) 2 thread ebizzy
~~~~~~~~~~~~~~~~~~~~~~
Experimental results for ebizzy with 2 threads, bound to a single big-core
show a marked improvement with this patchset over the 4.18-rc5 vanilla
kernel.

The result of 100 such runs for 4.18-rc7 kernel and the 4.18-rc7 +
big-core-smt-patches are as follows

4.18.0-rc7 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[      0 - 1000000]  :      0      : #
[1000000 - 2000000]  :      3      : #
[2000000 - 3000000]  :      7      : ##
[3000000 - 4000000]  :      26     : ######
[4000000 - 5000000]  :      4      : #
[5000000 - 6000000]  :      60     : #############

4.18.0-rc7 + big-core-smt-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[      0 - 1000000]  :      0      : #
[1000000 - 2000000]  :      0      : #
[2000000 - 3000000]  :      11     : ###
[3000000 - 4000000]  :      0      : #
[4000000 - 5000000]  :      0      : #
[5000000 - 6000000]  :      89     : ##################

2) Hackbench (perf bench sched pipe)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
100 iterations of the hackbench run both on 4.18-rc7 vanilla kernel
and v.18-rc7 + big-core-smt-patches. All the values are time in
seconds (Lower the better)

4.18.0-rc7 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    N           Min           Max        Median           Avg        Stddev
x 100         4.225         9.754         6.174       6.00402    0.88311027

4.18.0-rc7 + big-core-smt-patches (v6 : the present version)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    N           Min           Max        Median           Avg        Stddev
x 100         4.069         6.745          6.08       5.72414    0.73853727

The presence of the CACHE level sched-domain in v6, which was absent
in v5 of the patches seems to be making a difference, as the median
and the average times taken by hackbench both drop.

4.18.0-rc7 + big-core-smt-patches (v5 : the previous version)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    N           Min           Max        Median           Avg        Stddev
x 100         4.972        10.123         6.177         6.323    0.68728617


Gautham R. Shenoy (2):
  powerpc: Detect the presence of big-cores via "ibm,thread-groups"
  powerpc: Use cpu_smallcore_sibling_mask at SMT level on bigcores

 Documentation/ABI/testing/sysfs-devices-system-cpu |   8 ++
 arch/powerpc/include/asm/cputhreads.h              |  22 +++
 arch/powerpc/include/asm/smp.h                     |   6 +
 arch/powerpc/kernel/setup-common.c                 | 154 +++++++++++++++++++++
 arch/powerpc/kernel/smp.c                          |  62 ++++++++-
 arch/powerpc/kernel/sysfs.c                        |  35 +++++
 6 files changed, 282 insertions(+), 5 deletions(-)

-- 
1.9.4
