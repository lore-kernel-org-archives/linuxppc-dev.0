Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC90n5XNmzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 18:19:05 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6J89KL9025323
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 04:19:03 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bsu0sjeuk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 04:19:03 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 19 Jul 2017 04:19:02 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH 0/2] powerpc: powernv: Enable stop4 via cpuidle
Date: Wed, 19 Jul 2017 13:48:48 +0530
Message-Id: <cover.1500452107.git.ego@linux.vnet.ibm.com>
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

This is the second iteration of the patchset to enable exploitation of
stop4 idle state on POWER9 via cpuidle.

The earlier version can be found here :
https://lkml.org/lkml/2017/7/18/691

The change from the first version is to the second patch titled "
powernv/powerpc: Clear PECE1 in LPCR via stop-api only on Hotplug"
where all the LPCR manipulations for CPU-Hotplug are moved into
arch/powerpc/platforms/powernv/idle.c as per Nicholas Piggin's
suggestion.

====== Description  ===========================
The stop4 idle state on POWER9 is a deep idle state which loses
hypervisor resources, but whose latency is low enough that it can be
exposed via cpuidle.

Until now, the deep idle states which lose hypervisor resources (eg:
winkle) were only exposed via CPU-Hotplug.  Hence currently on wakeup
from such states, barring a few SPRs which need to be restored to
their older value, rest of the SPRS are reinitialized to their values
corresponding to that at boot time. When stop4 is used in the context
of cpuidle, we want these additional SPRs to be restored to their
older value, to ensure that the context on the CPU coming back from
idle is same as it was before going idle.

Additionally, the CPU which is in stop4 while idling can be woken up
by the decrementer interrupts. So we need to ensure that the LPCR is
programmed with PECE1 bit cleared via the stop-api only for the
CPU-Hotplug case and not for cpuidle.

The two patches in the series address this problem.

Gautham R. Shenoy (2):
  powernv/powerpc:Save/Restore additional SPRs for stop4 cpuidle
  powernv/powerpc: Clear PECE1 in LPCR via stop-api only on Hotplug

 arch/powerpc/include/asm/paca.h       |  7 ++++++
 arch/powerpc/kernel/asm-offsets.c     | 12 +++++++++
 arch/powerpc/kernel/idle_book3s.S     | 46 +++++++++++++++++++++++++++++++++--
 arch/powerpc/platforms/powernv/idle.c | 45 +++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/smp.c  | 10 --------
 5 files changed, 107 insertions(+), 13 deletions(-)

-- 
1.9.4
