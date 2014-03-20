Return-Path: <ego@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A58922C009A
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2014 23:11:09 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 20 Mar 2014 22:11:08 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 813AD3578048
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2014 23:11:05 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KBoiYe9503108
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2014 22:50:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KCB4oK003985
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2014 23:11:04 +1100
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/5] powernv: Enable Dynamic Frequency 
Date: Thu, 20 Mar 2014 17:40:55 +0530
Message-Id: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
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

This is the v3 of the consolidated patchset consisting
patches for enabling cpufreq on IBM POWERNV platforms
along with some enhancements. I have incorporated the review 
for v2 (which can be found at [1]).

- This patchset contains code for the platform driver to support CPU
  frequency scaling on IBM POWERNV platforms.

- In addition to the standard control and status files exposed by the
  cpufreq core, the patchset exposes the nominal frequency through the
  file named "cpuinfo_nominal_freq".


The changes from from v2:
  - Updated the changelog for "powernv: cpufreq driver for powernv platform"
    to record the fact that policy->cpus must be populated with a sibling mask
    that includes even the offlined siblings.

  - Dropped the patch named 
    "powernv:cpufreq: Create a powernv_cpu_to_core_mask() helper"
     since the driver->get() method can use cpu_sibling_mask().
  
  -  Updated "powernv:cpufreq: Implement the driver->get() method" to 
     use cpu_sibling_mask() in powernv_cpufreq_get()

The patchset is based against commit 4907cdca7210c5895311bddcf05a4c85b67d8566
of the mainline tree.

[1]: https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-March/115861.html


Gautham R. Shenoy (3):
  powernv:cpufreq: Create pstate_id_to_freq() helper
  powernv:cpufreq: Export nominal frequency via sysfs.
  powernv:cpufreq: Implement the driver->get() method

Srivatsa S. Bhat (1):
  powernv,cpufreq:Add per-core locking to serialize frequency
    transitions

Vaidyanathan Srinivasan (1):
  powernv: cpufreq driver for powernv platform

 arch/powerpc/include/asm/reg.h         |   4 +
 arch/powerpc/platforms/powernv/Kconfig |   1 +
 drivers/cpufreq/Kconfig                |   1 +
 drivers/cpufreq/Kconfig.powerpc        |  13 ++
 drivers/cpufreq/Makefile               |   1 +
 drivers/cpufreq/powernv-cpufreq.c      | 375 +++++++++++++++++++++++++++++++++
 6 files changed, 395 insertions(+)
 create mode 100644 drivers/cpufreq/powernv-cpufreq.c

-- 
1.8.3.1
