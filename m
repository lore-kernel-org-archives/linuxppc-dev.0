Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F28CD1A0F75
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 18:05:03 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B4E31402B1
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 18:05:03 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 13:35:01 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 529993940070
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:56 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6G84gJU24772782
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6G84fWK030527
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:41 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: joel@jms.id.au, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 0/6] powernv: cpufreq: Report frequency throttle by OCC
Date: Thu, 16 Jul 2015 13:34:17 +0530
Message-Id: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset intends to add frequency throttle reporting mechanism
to powernv-cpufreq driver when OCC throttles the frequency. OCC is an
On-Chip-Controller which takes care of the power and thermal safety of
the chip. The CPU frequency can be throttled during an OCC reset or
when OCC tries to limit the max allowed frequency. The patchset will
report such conditions so as to keep the user informed about reason
for the drop in performance of workloads when frequency is throttled.

Changes from v4:
- Taken care of Joel Stanley's comment, modification in patch[3].
  This replaces memcpy() with be64_to_cpu() and no change in 
  functionality of the patch

Changes from v3:
- Rebased on top of 4.2-rc1
- Minor changes in patch 2,3,4,6 this does not change the
  functionality of the code
- 594fcb9ec9e powerpc/powernv: Expose OPAL APIs required by PRD
  interface , this patch fixes the build error due to which this
  series was initially dropped
  ERROR: ".opal_message_notifier_register"
  drivers/cpufreq/powernv-cpufreq.ko] undefined!

Changes from v2:
- Split into multiple patches
- Semantic fixes

Shilpasri G Bhat (6):
  cpufreq: powernv: Handle throttling due to Pmax capping at chip level
  powerpc/powernv: Add definition of OPAL_MSG_OCC message type
  cpufreq: powernv: Register for OCC related opal_message notification
  cpufreq: powernv: Call throttle_check() on receiving OCC_THROTTLE
  cpufreq: powernv: Report Psafe only if PMSR.psafe_mode_active bit is
    set
  cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling

 arch/powerpc/include/asm/opal-api.h |  12 +++
 drivers/cpufreq/powernv-cpufreq.c   | 198 +++++++++++++++++++++++++++++++++---
 2 files changed, 195 insertions(+), 15 deletions(-)

-- 
1.9.3
