Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb9Sg2r6MzDscD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:48:03 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8G9hR3F059674
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 05:48:01 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25gca1xbwv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 05:48:01 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 16 Sep 2016 05:48:00 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powernv: Implement lite variant of stop with ESL=EC=0
Date: Fri, 16 Sep 2016 15:17:40 +0530
Message-Id: <cover.1474015799.git.ego@linux.vnet.ibm.com>
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

The Power ISA v3.0 allows us to execute the "stop" instruction with
ESL and EC of the PSSCR set to 0. This will ensure no loss of state,
and the wakeup from the stop will happen at an instruction following
the executed stop instruction.

This patchset adds support to run stop with ESL=EC=0 based on
a flag set for the corresponding stop state in the device tree.

The first patch renames the IDLE_STATE_ENTER_SEQ macro to
IDLE_STATE_ENTER_SEQ_NORET since the current users of this
macro expect the wakeup from stop to happen at the
System Reset vector. It reuses the name IDLE_STATE_ENTER_SEQ to a
variant where the wakeup from stop happens at the next instruction.

The second patch creates adds a new function (i.e, a lite variant)
that will execute a stop instruction with ESL=EC=0 and handle wakeup
at the subsequent instruction. A particular stop state is wired to
this new function if the device tree entry for that stop state has
OPAL_PM_WAKEUP_AT_NEXT_INST [1] flag set.

[1] : The corresponding patch in skiboot that defines
      OPAL_PM_WAKEUP_AT_NEXT_INST and enables it in the device tree
      can be found here:
      https://lists.ozlabs.org/pipermail/skiboot/2016-September/004805.html

Gautham R. Shenoy (2):
  powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
  powernv:idle:Implement lite variant of power_enter_stop

 arch/powerpc/include/asm/cpuidle.h    |  5 ++++-
 arch/powerpc/include/asm/opal-api.h   |  1 +
 arch/powerpc/include/asm/processor.h  |  3 ++-
 arch/powerpc/kernel/exceptions-64s.S  |  6 +++---
 arch/powerpc/kernel/idle_book3s.S     | 38 +++++++++++++++++++++++++++--------
 arch/powerpc/platforms/powernv/idle.c | 17 +++++++++++++---
 arch/powerpc/platforms/powernv/smp.c  |  2 +-
 drivers/cpuidle/cpuidle-powernv.c     | 24 ++++++++++++++++++++--
 8 files changed, 77 insertions(+), 19 deletions(-)

-- 
1.9.4
