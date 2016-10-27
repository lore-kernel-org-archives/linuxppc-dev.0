Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4Kvz5zHGzDvJC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 19:35:27 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9R8Xrr9035040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 04:35:25 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26bdyrgp1v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 04:35:25 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 27 Oct 2016 02:35:24 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, skiboot@lists.ozlabs.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] powernv:stop: Use psscr_val,mask provided by firmware
Date: Thu, 27 Oct 2016 14:05:04 +0530
Message-Id: <cover.1477556602.git.ego@linux.vnet.ibm.com>
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

This is the second iteration of the patchset to use the psscr_val and
psscr_mask provided by the firmware for each of the stop states.

The previous version can be found here: 
https://lkml.org/lkml/2016/9/29/45

The main changes in this version are:

1) Add a helper function in powernv-cpuidle.c to help initialize the
   powernv_states cpuidle table.

2) Handle the older firmware which populates only the Requested Level
   (RL) fields of the psscr and psscr_mask in the device tree. This
   patchset ensures that in the presence of the older firmware, the
   other fields of PSSCR are initalized to sane default values.


Synopsis
==========
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

The second patch adds a helper function in cpuidle-powernv.c for
initializing entries of the powernv_states[] table that is passed to
the cpu-idle core. This eliminates some of the code duplication in the
function that discovers and initializes the stop states.

The third patch in the series fixes issues a) and b) by ensuring that
the psscr-value and the psscr-mask provided by the firmware are what
will be used to set a particular stop state. It also adds support for
handling wake-up from stop states which were entered with ESL=EC=0.

The third patch also handles the older firmware which sets only the
Requested Level (RL) field in the psscr and psscr-mask exposed in the
device tree. In the presence of such older firmware, this patch will
set the default sane values for for remaining PSSCR fields (i.e PSLL,
MTL, ESL, EC, and TR).

The skiboot patch populates all the relevant fields in the PSSCR
values and the mask for all the stop states can be found here:
https://lists.ozlabs.org/pipermail/skiboot/2016-September/004869.html

The patches are based on top of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes

Gautham R. Shenoy (3):
  powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
  cpuidle:powernv: Add helper function to populate powernv idle states.
  powernv: Pass PSSCR value and mask to power9_idle_stop

 arch/powerpc/include/asm/cpuidle.h       |  42 +++++++++++-
 arch/powerpc/include/asm/processor.h     |   3 +-
 arch/powerpc/kernel/exceptions-64s.S     |   6 +-
 arch/powerpc/kernel/idle_book3s.S        |  41 +++++++-----
 arch/powerpc/platforms/powernv/idle.c    |  81 +++++++++++++++++++----
 arch/powerpc/platforms/powernv/powernv.h |   3 +-
 arch/powerpc/platforms/powernv/smp.c     |  14 ++--
 drivers/cpuidle/cpuidle-powernv.c        | 110 ++++++++++++++++++++-----------
 include/linux/cpuidle.h                  |   1 +
 9 files changed, 220 insertions(+), 81 deletions(-)

-- 
1.9.4
