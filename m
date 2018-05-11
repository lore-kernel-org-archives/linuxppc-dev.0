Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j6yM4FmRzF2Fq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 21:17:44 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4BB9uth010734
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 07:17:41 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hw8c7crm1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 07:17:41 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 11 May 2018 07:17:41 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powerpc: Scheduler optimization for POWER9 bigcores
Date: Fri, 11 May 2018 16:47:22 +0530
Message-Id: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
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

The Linux scheduler has a feature called "ASYM_SMT" which will bias
the load-balancing of the tasks on the smaller numbered threads in the
core. On an big-core whose threads are interleavings of the threads of
the small cores, enabling ASYM_SMT automatically results in spreading
the tasks uniformly across the associated pair of SMT4 cores.

In this patchset, we detect if the cores are big-cores with interleaved threads.
If so, we enable ASYM_SMT feature at the SMT-sched domain.

Experimental results for ebizzy with 2 threads, bound to a single big-core
show a marked improvement with this patchset over the 4.17-rc3 vanilla
kernel.

The results of 100 such runs, for 4.17-rc3 vanilla kernel and
4.17-rc3 + this_patchset are as follows.

4.17-rc3 vanilla:
================================================
  ebizzy records/s   :# samples: Histogram 
=================================================
[1000000 - 2000000]  :      14    : ###
[2000000 - 3000000]  :      13    : ###
[3000000 - 4000000]  :      15    : ####
[4000000 - 5000000]  :       2    : #
[5000000 - 6000000]  :      56    : ############
=================================================
 
4.17-rc3 vanilla + this_patchset
=================================================
  ebizzy records/s   :# samples: Histogram 
=================================================
[1000000 - 2000000]  :       0    : #
[2000000 - 3000000]  :      14    : ###
[3000000 - 4000000]  :       0    : #
[4000000 - 5000000]  :       1    : #
[5000000 - 6000000]  :      85    : ##################
=================================================

This patchset contains two patchset.

The first patch detects the presence of big-cores with interleaved
threads.

The second patch adds the ASYM_SMT bit to the flags the SMT-sched
domain when interleaved big-cores are detected.

Gautham R. Shenoy (2):
  powerpc: Detect the presence of big-core with interleaved threads
  powerpc: Enable ASYM_SMT on interleaved big-core systems

 arch/powerpc/include/asm/cputhreads.h |  8 +++--
 arch/powerpc/kernel/setup-common.c    | 63 +++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/smp.c             |  2 +-
 3 files changed, 67 insertions(+), 6 deletions(-)

-- 
1.9.4
