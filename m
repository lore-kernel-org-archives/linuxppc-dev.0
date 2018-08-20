Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v2kH4gQfzDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 15:41:59 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7K5caIR024724
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 01:41:57 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kynm73f6b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 01:41:57 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Sun, 19 Aug 2018 23:41:56 -0600
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
Subject: [PATCH v7 0/2] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
Date: Mon, 20 Aug 2018 11:11:42 +0530
Message-Id: <1534743704-4760-1-git-send-email-ego@linux.vnet.ibm.com>
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

This is the seventh iteration of the patchset to add support for
big-core on POWER9. This patch also optimizes the task placement on
such big-core systems.

The previous versions can be found here:

v6: https://lkml.org/lkml/2018/8/9/119
v5: https://lkml.org/lkml/2018/8/6/587
v4: https://lkml.org/lkml/2018/7/24/79
v3: https://lkml.org/lkml/2018/7/6/255
v2: https://lkml.org/lkml/2018/7/3/401
v1: https://lkml.org/lkml/2018/5/11/245

Changes :

v6 --> v7:
   - Addressed the review comments from Srikar in Patch 1.
   - For building the SMT level sched-domain with
     small_core_sibling_mask, parse the "ibm,thread-groups" property
     of the CPU node only once, i.e when the CPU is made online for
     the first time.

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
show a marked improvement with this patchset over the 4.18.0 vanilla
kernel.

The result of 100 such runs for 4.18-rc7 kernel and the
4.18 + big-core-smt-patches are as follows

4.18.0 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0 - 1000000]        :      0      : #
[1000000 - 2000000]  :      11     : ###
[2000000 - 3000000]  :      9      : ##
[3000000 - 4000000]  :      9      : ##
[4000000 - 5000000]  :      0      : #
[5000000 - 6000000]  :      71     : ###############

4.18.0 + big-core-smt-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0 - 1000000]        :      0      : #
[1000000 - 2000000]  :      0      : #
[2000000 - 3000000]  :      16     : ####
[3000000 - 4000000]  :      0      : #
[4000000 - 5000000]  :      1      : #
[5000000 - 6000000]  :      83     : #################

2) Hackbench (perf bench sched pipe)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
500 iterations of the hackbench run both on 4.18.0 vanilla kernel
and v4.18.0 + big-core-smt-patches. More samples in the lower
numbered buckets is better. We can observe that for nearly 60% of the
samples are in the 4-5 seconds range when hackbench is run with this
patchset as opposed to < 20% of the time when the hackbench is
run on the vanilla kernel.

Similarly, nearly 80% of the samples are within the 4-6 seconds range
when hackbench is run with the patchset when compared with 50% of the
samples in the same range when hackbench is run on the vanilla kernel.

Though as a downside, we do see ~10% of the samples in the 7-9 seconds
range with the patchset as compared to 2% of the samples in the same
range without the patchset.

4.18.0 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
4 - 5 seconds : 74 samples
5 - 6 seconds : 169 samples
6 - 7 seconds : 248 samples
7 - 8 seconds : 6 samples
8 - 9 seconds : 3 samples

4.18.0 + big-core-smt-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
4 - 5 seconds : 289 samples
5 - 6 seconds : 99 samples
6 - 7 seconds : 58 samples
7 - 8 seconds : 28 samples
8 - 9 seconds : 26 samples


Gautham R. Shenoy (2):
  powerpc: Detect the presence of big-cores via "ibm,thread-groups"
  powerpc: Use cpu_smallcore_sibling_mask at SMT level on bigcores

 Documentation/ABI/testing/sysfs-devices-system-cpu |   8 ++
 arch/powerpc/include/asm/cputhreads.h              |  25 ++++
 arch/powerpc/kernel/setup-common.c                 | 151 +++++++++++++++++++++
 arch/powerpc/kernel/smp.c                          | 136 ++++++++++++++++++-
 arch/powerpc/kernel/sysfs.c                        |  38 ++++++
 5 files changed, 356 insertions(+), 2 deletions(-)

-- 
1.9.4
