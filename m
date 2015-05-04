Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 223CF1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 19:00:23 +1000 (AEST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C796D140157
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:22 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 4 May 2015 19:00:22 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 96DB93578055
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:19 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4490AVw47186074
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 19:00:19 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t448xjTk023403
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 18:59:46 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] powernv: cpufreq: Report frequency throttle by OCC
Date: Mon,  4 May 2015 14:24:06 +0530
Message-Id: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
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

Changes from v2:
- Split into multiple patches
- Semantic fixes

Shilpasri G Bhat (6):
  cpufreq: poowernv: Handle throttling due to Pmax capping at chip level
  powerpc/powernv: Add definition of OPAL_MSG_OCC message type
  cpufreq: powernv: Register for OCC related opal_message notification
  cpufreq: powernv: Call throttle_check() on receiving OCC_THROTTLE
  cpufreq: powernv: Report Psafe only if PMSR.psafe_mode_active bit is
    set
  cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling

 arch/powerpc/include/asm/opal-api.h |   8 ++
 drivers/cpufreq/powernv-cpufreq.c   | 199 +++++++++++++++++++++++++++++++++---
 2 files changed, 192 insertions(+), 15 deletions(-)

-- 
1.9.3
