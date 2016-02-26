Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EB341A0B90
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 21:38:06 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A0EF1402A1
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 21:38:06 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 20:38:04 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4C27A2BB0057
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 21:38:00 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1QAbqWe65601654
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 21:38:00 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QAbRkM008610
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 21:37:27 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v10 0/2] cpufreq: powernv: Export throttle stat attributes and
 a bug fix
Date: Fri, 26 Feb 2016 16:06:50 +0530
Message-Id: <1456483012-29466-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch[1] solves a bug in the module{init/exit} path and Patch[2]
exports the throttle stats for the chip. This patchset is on top of
linux-pm/linux-next.

Changes from v9:
- Patch[1/2] is newly added to correctly handle error path in
  powernv_cpufreq_init() and unregistration path in
  powernv_cpufreq_exit() as suggested by Viresh.
- Patch[2/2] is rebased on top of Patch[1/2].

Shilpasri G Bhat (2):
  cpufreq: powernv: Fix bugs in powernv_cpufreq_{init/exit}
  cpufreq: powernv: Add sysfs attributes to show throttle stats

 Documentation/ABI/testing/sysfs-devices-system-cpu |  69 +++++++++
 drivers/cpufreq/powernv-cpufreq.c                  | 162 ++++++++++++++++++---
 2 files changed, 212 insertions(+), 19 deletions(-)

-- 
1.9.3
