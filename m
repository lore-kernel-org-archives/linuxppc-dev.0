Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDS5N6D2VzDqtl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 20:42:32 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6LAd4WB085174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 06:42:30 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bub7tjvb9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 06:42:30 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Jul 2017 06:42:29 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v3 PATCH 0/2] powerpc: powernv: Enable stop4 via cpuidle
Date: Fri, 21 Jul 2017 16:11:36 +0530
Message-Id: <cover.1500631040.git.ego@linux.vnet.ibm.com>
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

This is the third iteration of the patchset to enable exploitation of
stop4 idle state on POWER9 via cpuidle.

The earlier version can be found here :
[v2]: https://lkml.org/lkml/2017/7/19/152
[v1]: https://lkml.org/lkml/2017/7/18/691

The changes across the versions are as follows:
v2-->v3:
- Use a structure instead of an array for the stop sprs save area.
- Name the offsets into the paca->stop_sprs as STOP_XXX instead of PACA_XXX.
- Add comments in the assembly code explaining why saving/restoring
  is not needed on POWER8.
- Program the LPCR during platform idle entry/exit on both POWER8 and POWER9
  as suggested by Nicholas Piggin.

v1 --> v2:
- Move the LPCR manipulations for CPU-Hotplug into
arch/powerpc/platforms/powernv/idle.c as per Nicholas Piggin's
suggestion.

====================== Description ===========================
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

 arch/powerpc/include/asm/cpuidle.h    | 11 ++++++
 arch/powerpc/include/asm/paca.h       |  7 ++++
 arch/powerpc/kernel/asm-offsets.c     |  8 +++++
 arch/powerpc/kernel/idle_book3s.S     | 65 +++++++++++++++++++++++++++++++++--
 arch/powerpc/platforms/powernv/idle.c | 34 +++++++++++++++++-
 arch/powerpc/platforms/powernv/smp.c  | 10 ------
 6 files changed, 122 insertions(+), 13 deletions(-)

-- 
1.9.4
