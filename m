Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7DE8E140088
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2014 07:11:46 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Sat, 29 Mar 2014 01:41:43 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9B1631258044
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2014 01:44:06 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2SKBMfE4129056
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2014 01:41:22 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2SKBd2C009644
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2014 01:41:39 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v5 0/3] powernv,cpufreq: Dynamic Frequency Scaling support
Date: Sat, 29 Mar 2014 01:41:21 +0530
Message-Id: <1396037484-23907-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org,
 cpufreq@vger.kernel.org, linuxppc-dev@ozlabs.org,
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

This is v5 of the patchset to enable dynamic frequency scaling on IBM
PowerNV platforms. This patchset does address all the review comments
obtained for v4 (which can be found at [1]).

Changes from v4:

    * Created a separate patch to select the CPUFreq related Config
      options for PowerNV

    * Dropped the per-core locking hunks in
      drivers/cpufreq/powernv-cpufreq.c since the CPUFreq core takes
      care of the for us after the following commit which is present in
      linux-next:

	commit 12478cf0c55e5969f740bb38a24b1a0104ae18d8	  
      	Author: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
        Date:   Mon Mar 24 13:35:44 2014 +0530

       	cpufreq: Make sure frequency transitions are serialized

    * [PATCH v5 3/3] gets rid of the powernv_pstate_ids[] array that
      was being used to record the pstate ids. After the following
      patch it is safe to use cpufreq_frequency_table.driver_data
      since it is opaque to the cpufreq core: 

      	From: Viresh Kumar <viresh.kumar@linaro.org>
	Date: 2014-03-28 13:53:47
	url: http://marc.info/?l=linux-pm&m=139601416804702&w=2
	    
	cpufreq: create another field .flags in cpufreq_frequency_table

The patchset is based on the commit
201544be8c37dffbf069bb5fc9edb5674f8c1754 of the linux-next tree.

While all the patches in the patchset apply cleanly on linux-next,
[PATCH v5 3/3] requires the Viresh's patch that was mentioned
above. Otherwise, the frequency corresponding to pstate id -3 will be
omited while reporting the "scaling_available_frequencies" in sysfs.

[1]: http://marc.info/?l=linux-pm&m=139585297620612&w=2

Gautham R. Shenoy (2):
  powernv, cpufreq: Select CPUFreq related Kconfig options for powernv
  powernv,cpufreq: Use cpufreq_frequency_table.driver_data to store
    pstate ids

Vaidyanathan Srinivasan (1):
  powernv, cpufreq: cpufreq driver for powernv platform

 arch/powerpc/configs/pseries_defconfig    |   1 +
 arch/powerpc/configs/pseries_le_defconfig |   1 +
 arch/powerpc/include/asm/reg.h            |   4 +
 arch/powerpc/platforms/powernv/Kconfig    |   6 +
 drivers/cpufreq/Kconfig.powerpc           |   8 +
 drivers/cpufreq/Makefile                  |   1 +
 drivers/cpufreq/powernv-cpufreq.c         | 341 ++++++++++++++++++++++++++++++
 7 files changed, 362 insertions(+)
 create mode 100644 drivers/cpufreq/powernv-cpufreq.c

-- 
1.8.3.1
