Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRrkQ0NMWzDqc2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 18:50:21 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G8mkgk027094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:11 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afwhj21vf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:11 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 16 May 2017 04:50:08 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 0/6] Enable support for deep-stop states on POWER9
Date: Tue, 16 May 2017 14:19:42 +0530
Message-Id: <cover.1494585671.git.ego@linux.vnet.ibm.com>
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

This patch series contains some of the fixes required for enabling
support for deep stop states such as STOP4 and STOP11 via CPU-Hotplug.

These fixes mainly ensure that some of the hypervisor resources which
are lost during the deep stop state are correctly restored on a
wakeup.

There are 6 patches in the series.

Patch 1 correctly initializes the core_idle_state_ptr based on the
threads_per_core. core_idle_state_ptr is used to determine if a thread
is the last thread entering a deep stop state or a first thread waking
up from deep stop state in order to save/restore per-core resources.

Patch 2 decouples restoring timebase from restoring hypervisor
resources, as there are stop states which lose hypervisor state but
not the timebase.

Patch 3 saves the LPCR value before executing deep stop and restores
it back to the saved value on the wakeup from stop.

Patch 4 programs the restoration of some of one-time initialized SPRs
via the stop-api.

Patch 5 provides a workaround for a hardware issue on POWER9 DD1 chips
where the PLS value cannot be relied upon on a wakeup from deep stop.

Patch 6 fixes the cpuidle-powernv initialization code to allow deep
states that don't lose timebase.

These patches are based on the Linux upstream and have been tested
with the corresponding skiboot patches in
https://lists.ozlabs.org/pipermail/skiboot/2017-May/007183.html to get
STOP4 working via CPU-Hotplug.

Akshay Adiga (1):
  powernv:idle: Restore SPRs for deep idle states via stop API.

Gautham R. Shenoy (5):
  powernv:idle: Correctly initialize core_idle_state_ptr
  powernv:idle: Decouple Timebase restore & Per-core SPRs restore
  powernv:idle: Restore LPCR on wakeup from deep-stop
  powernv:idle: Use Requested Level for restoring state on P9 DD1
  cpuidle-powernv: Allow Deep stop states that don't stop time

 arch/powerpc/include/asm/paca.h       |   2 +
 arch/powerpc/kernel/asm-offsets.c     |   1 +
 arch/powerpc/kernel/idle_book3s.S     |  33 +++++++---
 arch/powerpc/platforms/powernv/idle.c | 112 +++++++++++++++++++++-------------
 drivers/cpuidle/cpuidle-powernv.c     |  16 +++--
 5 files changed, 110 insertions(+), 54 deletions(-)

-- 
1.8.3.1
