Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpCdn4snfzDq8x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 02:04:45 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MF3Cx8116526
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 11:04:34 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vqaejv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 11:04:34 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 09:04:33 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v3 PATCH 0/4] powernv:idle: Fixes for CPU-Hotplug on POWER DD1.0
Date: Wed, 22 Mar 2017 20:34:13 +0530
Message-Id: <cover.1490194710.git.ego@linux.vnet.ibm.com>
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

This is the third version of the patchset containing the fixes to
make CPU-Hotplug working on correctly on POWER9 DD1 systems.

The earlier versions can be found here:
[v2] : https://lkml.org/lkml/2017/3/20/555
[v1] : https://lkml.org/lkml/2017/3/13/46

The only change in this patch series from v2 are the following
optimizations suggested by Nicholas Piggin.

- Dynamically allocate the thread_sibling_pacas array to contain
  "threads_per_core" number of slots instead of declaring the array
  size upfront.

- Use SPRN_TIR instead of (SPRN_PIR & 0x3) to determine the thread's
  index within a core.

Patch 4 in the series requires Nicholas Piggin's ack. Rest of the
patches are unchanged from the previous version.

These patches are based on v4.11-rc3.

The patches have been tested with stop1 (ESL=EC=1) as the
deepest-state entered into during CPU-Hotplug.

Gautham R. Shenoy (4):
  powernv: Move CPU-Offline idle state invocation from smp.c to idle.c
  powernv:smp: Add busy-wait loop as fall back for CPU-Hotplug
  powernv:idle: Don't override default/deepest directly in kernel
  powernv: Recover correct PACA on wakeup from a stop on P9 DD1

 arch/powerpc/include/asm/cpuidle.h       |  1 +
 arch/powerpc/include/asm/paca.h          |  5 ++
 arch/powerpc/kernel/asm-offsets.c        |  1 +
 arch/powerpc/kernel/idle_book3s.S        | 48 +++++++++++++++-
 arch/powerpc/platforms/powernv/idle.c    | 96 ++++++++++++++++++++++++++------
 arch/powerpc/platforms/powernv/powernv.h |  2 -
 arch/powerpc/platforms/powernv/smp.c     | 18 +-----
 7 files changed, 136 insertions(+), 35 deletions(-)

-- 
1.9.4
