Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn0rQ6hRszDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 02:54:46 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2KFs3bm014660
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 11:54:40 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29af6eb0yj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 11:54:39 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 20 Mar 2017 11:54:38 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH 0/4] powernv:idle: Fixes for CPU-Hotplug on POWER DD1.0
Date: Mon, 20 Mar 2017 21:24:14 +0530
Message-Id: <cover.1490024477.git.ego@linux.vnet.ibm.com>
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

This is the second version of the patchset containing the fixes to
make CPU-Hotplug working on correctly on POWER9 DD1 systems.

The earlier version of this patchset can be found here:
https://lkml.org/lkml/2017/3/13/46

This patch addresses the feedback provided by Nicholas Piggin. The key
changes from the earlier version are:

- Move the piece of code in powernv/smp.c::pnv_smp_cpu_kill_self() which
  transitions the CPU to the deepest available platform idle state to a
  new function named pnv_cpu_offline() in powernv/idle.c. The rationale
  behind this code movement is that the data required to determine the
  deepest available platform state resides in powernv/idle.c.

- Adds a more descriptive warning describing the consequences of no
  suitable default/deepest stop states being available.

- Update the commit log for "powernv:Recover correct PACA on wakeup
  from a stop on P9 DD1" describing the problem that it is trying to
  solve.  Also ensure that on P9 DD1, NVGPRs are restored from the
  stack on the way out by setting the NAPSTATELOST in paca.

I have retained Nicholas Piggin's Reviewed-by tag for the second patch
in this series (was first patch in the previous series) even though
the file containing the code is different.

There are four patches in the series.

- The first patch moves the platform-idle code invoked when a CPU offlined from powernv/smp.c to powernv/idle.c

- The second adds a fallback mechanism for CPU-Hotplug when no
  platform idle state is available.

- The third patch ensures that the kernel doesn't use any stop state
  that is not exposed by the firmware.

- The fourth patch adds a recovery framework for correctly recovering
  paca pointer of the thread waking up from a stop.

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
 arch/powerpc/kernel/idle_book3s.S        | 49 +++++++++++++++++-
 arch/powerpc/platforms/powernv/idle.c    | 88 ++++++++++++++++++++++++++------
 arch/powerpc/platforms/powernv/powernv.h |  2 -
 arch/powerpc/platforms/powernv/smp.c     | 18 +------
 7 files changed, 129 insertions(+), 35 deletions(-)

-- 
1.9.4
