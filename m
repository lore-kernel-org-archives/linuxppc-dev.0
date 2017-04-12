Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w32FZ00hmzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:46:41 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CBebbO074687
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:46:39 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29scjej3rh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:46:39 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 05:46:38 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powernv:stop: Some fixes for handling deep stop
Date: Wed, 12 Apr 2017 17:16:19 +0530
Message-Id: <cover.1491996797.git.ego@linux.vnet.ibm.com>
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

This patchset contains three fixes required to get a deep stop state
that can lose the Hypervisor state to work correctly.

The first patch in the series uses the correct value for the
IDLE_THREAD_BITS on POWER8 which has 8 threads per core and on POWER9
which has 4 threads per core.

The second patch decouples restoring Timebase from restoring per-core
spr state as the current code assumes that if the timebase is not lost
then neither is per-core state. This was true on POWER8, but no longer
true on POWER9.

The third patch in the series sets the UPRT bit in LPCR on wakeup from
a deep stop if we are running in radix mode, without which the kernel
crashes once we switch to virtual mode.

These patches are on top of the patches for fixing CPU-Hotplug on
POWER9 DD1.0 (https://lkml.org/lkml/2017/3/22/472) and Nicholas
Piggin's idle fixes and changes for POWER8 and POWER9
(https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-March/155608.html)

Gautham R. Shenoy (3):
  powernv:idle: Use correct IDLE_THREAD_BITS in POWER8 vs POWER9
  powernv:idle: Decouple TB restore & Per-core SPRs restore
  powernv:idle: Set LPCR_UPRT on wakeup from deep-stop

 arch/powerpc/include/asm/cpuidle.h    |  3 ++-
 arch/powerpc/kernel/idle_book3s.S     | 29 +++++++++++++++++++++++------
 arch/powerpc/platforms/powernv/idle.c |  5 ++++-
 3 files changed, 29 insertions(+), 8 deletions(-)

-- 
1.9.4
