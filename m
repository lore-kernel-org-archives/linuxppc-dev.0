Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C2F7C2C00AD
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 22:11:23 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 10 Mar 2014 16:41:13 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id DA336E0045
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:44:55 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2ABBEor65404990
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:14 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2ABB92P002356
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:10 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/6] powernv:cpufreq: Dynamic cpu-frequency scaling
Date: Mon, 10 Mar 2014 16:40:55 +0530
Message-Id: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: srivatsa.bhat@linux.vnet.ibm.com,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
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

This is the v2 of the consolidated patchset consisting
patches for enabling cpufreq on IBM POWERNV platforms
along with some enhancements. 

The v1 of these patches have been previously 
submitted on linuxppc-dev [1][2].

- This patchset contains code for the platform driver to support CPU
  frequency scaling on IBM POWERNV platforms.

- In addition to the standard control and status files exposed by the
  cpufreq core, the patchset exposes the nominal frequency through the
  file named "cpuinfo_nominal_freq".

The patchset is based against commit c3bebc71c4bcdafa24b506adf0c1de3c1f77e2e0
of the mainline tree.

[1]: https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-February/115244.html
[2]: https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-March/115703.html

Gautham R. Shenoy (3):
  powernv:cpufreq: Create pstate_id_to_freq() helper
  powernv:cpufreq: Export nominal frequency via sysfs.
  powernv:cpufreq: Implement the driver->get() method

Srivatsa S. Bhat (2):
  powernv:cpufreq: Create a powernv_cpu_to_core_mask() helper.
  powernv,cpufreq:Add per-core locking to serialize frequency
    transitions

Vaidyanathan Srinivasan (1):
  powernv: cpufreq driver for powernv platform

 arch/powerpc/include/asm/reg.h         |   4 +
 arch/powerpc/platforms/powernv/Kconfig |   1 +
 drivers/cpufreq/Kconfig                |   1 +
 drivers/cpufreq/Kconfig.powerpc        |  13 ++
 drivers/cpufreq/Makefile               |   1 +
 drivers/cpufreq/powernv-cpufreq.c      | 397 +++++++++++++++++++++++++++++++++
 6 files changed, 417 insertions(+)
 create mode 100644 drivers/cpufreq/powernv-cpufreq.c

-- 
1.8.3.1
