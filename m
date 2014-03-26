Return-Path: <ego@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5620314008C
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 03:56:09 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 27 Mar 2014 02:56:08 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2E32C2BB0045
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 03:56:04 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2QGZXxw10485912
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 03:35:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2QGu10p027247
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 03:56:01 +1100
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, benh@kernel.crashing.org
Subject: [PATCH v4] powernv: Dynamic Frequency Scaling Enablement
Date: Wed, 26 Mar 2014 22:25:46 +0530
Message-Id: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, srivatsa.bhat@linux.vnet.ibm.com
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

This is the v4 of the patchset to enable Dynamic Frequency Scaling
on IBM PowerNV Platforms. I have incorporated the review comments
from the previous version (can be found at [1]). 

In this version, 

  * Multiple patches from the previous version have been into a single
    patch, since the higher numbered patches implemented some helper
    functions and the driver methods which should have been a part of
    the first patch to begin with.

  * Use the generic helpers provided by the cpufreq core available in
    the latest linux-next tree.

  * Fix the code to avoid casting integer pointers to void.

The patch is based on top of the commit:06ed26d1de59ce7cbbe68378b7e470be169750e5
of the linux-next tree.


[1]: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg76675.html

Vaidyanathan Srinivasan (1):
  powernv, cpufreq: cpufreq driver for powernv platform

 arch/powerpc/configs/pseries_defconfig    |   1 +
 arch/powerpc/configs/pseries_le_defconfig |   1 +
 arch/powerpc/include/asm/reg.h            |   4 +
 arch/powerpc/platforms/powernv/Kconfig    |   6 +
 drivers/cpufreq/Kconfig.powerpc           |   8 +
 drivers/cpufreq/Makefile                  |   1 +
 drivers/cpufreq/powernv-cpufreq.c         | 372 ++++++++++++++++++++++++++++++
 7 files changed, 393 insertions(+)
 create mode 100644 drivers/cpufreq/powernv-cpufreq.c

-- 
1.8.3.1
