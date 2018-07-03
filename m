Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Kdsv1L6JzF1LK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 19:21:38 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w639JabP020833
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2018 05:21:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k04abdkef-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 05:21:35 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 3 Jul 2018 10:21:33 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com,
 mpe@ellerman.id.au, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] powernv/cpuidle Device-tree parsing cleanup
Date: Tue,  3 Jul 2018 14:50:54 +0530
Message-Id: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Device-tree parsed multiple time in powernv cpuidle and powernv
hotplug code. 

First to identify supported flags. Second time, to identify deepest_state
and first deep state. Third time, during cpuidle init to find the available
idle states. Any change in device-tree format will lead to make changes in
these 3 places. Errors in device-tree can be handled in a better manner.

This series adds code to parse device tree once and save in global structure.

Changes from v2 :
 - Fix build error (moved a hunk from patch 1 to patch 2)
Changes from v1 :
 - fold first 2 patches into 1
 - rename pm_ctrl_reg_* as psscr_*
 - added comment stating removal of pmicr parsing code
 - removed parsing code for pmicr
 - add member valid in pnv_idle_states_t to indicate if the psscr-mask/val
are valid combination,
 - Change function description of pnv_parse_cpuidle_dt
 - Added error handling code.


Akshay Adiga (2):
  powernv/cpuidle: Parse dt idle properties into global structure
  powernv/cpuidle: Use parsed device tree values for cpuidle_init

 arch/powerpc/include/asm/cpuidle.h    |  13 ++
 arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
 drivers/cpuidle/cpuidle-powernv.c     | 154 ++++--------------
 3 files changed, 177 insertions(+), 206 deletions(-)

-- 
2.18.0.rc2.85.g1fb9df7
