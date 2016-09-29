Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl5G04N9DzDrYg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 17:06:16 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8T74Hp3098926
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 03:06:13 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25rrts4ujq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 03:06:13 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 01:06:13 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powernv:stop: Use psscr_val,mask provided by firmware
Date: Thu, 29 Sep 2016 12:35:57 +0530
Message-Id: <cover.1475130107.git.ego@linux.vnet.ibm.com>
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

In the current implementation, the code for ISA v3.0 stop
implementation has a couple of shortcomings.

a) The code hand-codes the values for ESL,EC,TR,MTL bits of PSSCR and
   uses only the RL field from the firmware. While this is not
   incorrect, since the hand-coded values are legitimate, it is not a
   very flexible design since the firmware has the capability to
   communicate these values via the "ibm,cpu-idle-state-psscr" and
   "ibm,cpu-idle-state-psscr-mask" properties. In case where the
   firmware provides values for these fields that is different from
   the hand-coded values, the current code will not work as intended.

b) Due to issue a), the current code assumes that ESL=EC=1 for all the
   stop states and hence the wakeup from the stop instruction will
   happen at 0x100, the system-reset vector. However, the ISA v3.0
   allows the ESL=EC=0 behaviour where the corresponding stop-state
   loses no state and wakes up from the subsequent instruction. The
   current code doesn't handle this case.
   
This patch series addresses these issues.

The first patch in the series renames the existing
IDLE_STATE_ENTER_SEQ macro to IDLE_STATE_ENTER_SEQ_NORET. It reuses
the name IDLE_STATE_ENTER_SEQ for entering into stop-states which wake
up at the subsequent instruction.

The second patch in the series fixes issues a) and b) by ensuring that
the psscr-value and the psscr-mask provided by the firmware are what
will be used to set a particular stop state. It also adds support for
handling wake-up from stop states which were entered with ESL=EC=0.

These patches depend on the following skiboot patch that exports
the PSSCR values and the mask for all the stop states:
https://lists.ozlabs.org/pipermail/skiboot/2016-September/004869.html

Gautham R. Shenoy (2):
  powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
  powernv: Pass PSSCR value and mask to power9_idle_stop

 arch/powerpc/include/asm/cpuidle.h       |  5 ++-
 arch/powerpc/include/asm/processor.h     |  3 +-
 arch/powerpc/kernel/exceptions-64s.S     |  6 +--
 arch/powerpc/kernel/idle_book3s.S        | 41 ++++++++++-------
 arch/powerpc/platforms/powernv/idle.c    | 76 +++++++++++++++++++++++++++-----
 arch/powerpc/platforms/powernv/powernv.h |  3 +-
 arch/powerpc/platforms/powernv/smp.c     |  7 +--
 drivers/cpuidle/cpuidle-powernv.c        | 30 ++++++++++---
 8 files changed, 127 insertions(+), 44 deletions(-)

-- 
1.9.4
