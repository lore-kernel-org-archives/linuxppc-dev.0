Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhS1T1fzczDqZ9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 17:01:49 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2D5x1Iv053743
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 02:01:46 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 294emes8jv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 02:01:46 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 13 Mar 2017 02:01:45 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powernv:idle: Fixes for CPU-Hotplug on POWER DD1.0
Date: Mon, 13 Mar 2017 11:31:25 +0530
Message-Id: <cover.1489383815.git.ego@linux.vnet.ibm.com>
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

This patchset contains fixes to make CPU-Hotplug working on correctly
on POWER9 DD1 systems.

There are three patches in the series.

- The first patch adds a fallback mechanism for CPU-Hotplug when no
  platform idle state is available.

- The second patch ensures that the kernel doesn't use any stop state
  that is not exposed by the firmware.

- The third patch adds a recovery framework for correctly recovering
  paca pointer of the thread waking up from a stop.

These patches are based on powerpc/linux.git "fixes" with the top
commit a7d2475af7aed ("powerpc: Sort the selects under CONFIG_PPC").

The patches have been tested with stop1 (ESL=EC=1) as the
deepest-state entered into during CPU-Hotplug.

Gautham R. Shenoy (3):
  powernv:smp: Add busy-wait loop as fall back for CPU-Hotplug
  powernv:idle: Don't override default/deepest directly in kernel
  powernv:Recover correct PACA on wakeup from a stop on P9 DD1

 arch/powerpc/include/asm/paca.h          |  5 ++++
 arch/powerpc/kernel/asm-offsets.c        |  1 +
 arch/powerpc/kernel/idle_book3s.S        | 43 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/idle.c    | 49 ++++++++++++++++++++++++++------
 arch/powerpc/platforms/powernv/powernv.h |  1 +
 arch/powerpc/platforms/powernv/smp.c     | 18 ++++++++++--
 6 files changed, 105 insertions(+), 12 deletions(-)

-- 
1.9.4
