Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GNpn3t1KzF3Mw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 03:22:57 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8KHEoJJ057286
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 13:22:55 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mmcrh0ufy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 13:22:54 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 20 Sep 2018 11:22:53 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
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
Subject: [PATCH v8 0/3] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
Date: Thu, 20 Sep 2018 22:52:36 +0530
Message-Id: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
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

This is the eight iteration of the patchset to add support for
big-core on POWER9. This patch also optimizes the task placement on
such big-core systems.

The previous versions can be found here:

v7: https://lkml.org/lkml/2018/8/20/52
v6: https://lkml.org/lkml/2018/8/9/119
v5: https://lkml.org/lkml/2018/8/6/587
v4: https://lkml.org/lkml/2018/7/24/79
v3: https://lkml.org/lkml/2018/7/6/255
v2: https://lkml.org/lkml/2018/7/3/401
v1: https://lkml.org/lkml/2018/5/11/245

Changes :

v7 --> v8:
   - Reorganized the patch series into three patches :

     	- First one discovers the big-cores and initializes a per-cpu
     	  cpumask with its small-core siblings.

        - The second patch uses the small-core siblings at the SMT
     	  level sched-domains on the big-core systems and also
     	  activates the CACHE domain that corresponds to the big-core
     	  where all the threads share L2 cache.

	- The third patch creates a pair of sysfs attributes named
	  /sys/devices/system/cpu/cpuN/topology/smallcore_thread_siblings
	  and
	  /sys/devices/system/cpu/cpuN/topology/smallcore_thread_siblings_list

   - The third patch addresses Michael Neuling's review comment for
     the previous iteration.

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
show a marked improvement with this patchset over the 4.19-rc4 vanilla
kernel.

The result of 100 such runs for 4.19-rc4 kernel and the
4.19-rc4 + big-core-smt-patches are as follows

4.19.0-rc4 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0000000 - 1000000]  :      0      : #
[1000000 - 2000000]  :      1      : #
[2000000 - 3000000]  :      2      : #
[3000000 - 4000000]  :      17     : ####
[4000000 - 5000000]  :      9      : ##
[5000000 - 6000000]  :      5      : ##
[6000000 - 7000000]  :      66     : ##############
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

4.19-rc4 + big-core-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0000000 - 1000000]  :      0      : #
[1000000 - 2000000]  :      0      : #
[2000000 - 3000000]  :      5      : ##
[3000000 - 4000000]  :      9      : ##
[4000000 - 5000000]  :      0      : #
[5000000 - 6000000]  :      2      : #
[6000000 - 7000000]  :      84     : #################
=================================================

2) Hackbench (perf bench sched pipe)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
500 iterations of the hackbench run both on 4.19-rc4 vanilla kernel
and v4.19-rc4 + big-core-smt-patches. There isn't a significant
difference between the two.

The values for Min, Max, Median, Avg below are in seconds. Lower the
better.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			4.19-rc4 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    N           Min           Max        Median           Avg        Stddev
  500         4.603         9.438         6.165      5.921446    0.47448034
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			4.19-rc4 + big-core-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    N           Min           Max        Median           Avg        Stddev
  500         4.532         6.476         6.224      5.982098    0.43021891
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Gautham R. Shenoy (3):
  powerpc: Detect the presence of big-cores via "ibm,thread-groups"
  powerpc: Use cpu_smallcore_sibling_mask at SMT level on bigcores
  powerpc/sysfs: Add topology/smallcore_thread_siblings[_list]

 Documentation/ABI/testing/sysfs-devices-system-cpu |  14 ++
 arch/powerpc/include/asm/cputhreads.h              |   2 +
 arch/powerpc/include/asm/smp.h                     |   6 +
 arch/powerpc/kernel/smp.c                          | 240 ++++++++++++++++++++-
 arch/powerpc/kernel/sysfs.c                        |  88 ++++++++
 5 files changed, 349 insertions(+), 1 deletion(-)

-- 
1.9.4
