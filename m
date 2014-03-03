Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D32B2C00E8
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 19:34:08 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 3 Mar 2014 14:04:06 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E8C291258056
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 14:06:12 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s238XxCs10485986
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:04:00 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s238Xxp3016640
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:04:01 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 0/4] powernv:cpufreq: Export nominal and current frequency via
 sysfs
Date: Mon,  3 Mar 2014 14:03:41 +0530
Message-Id: <1393835625-25102-1-git-send-email-ego@linux.vnet.ibm.com>
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

On IBM POWERNV platforms[1], presently we do not report the current
operating frequency of the processor through the sysfs interface
"cpuinfo_cur_freq" since the cpu frequency driver[1] has not
implemented the ->get(unsigned int cpu) method. Fix this by
implementing the ->get(unsigned int cpu) method which will report the
frequency corresponding to the pstate_id on PMSR on "cpu".

Also, export the nominal frequency of the processor through the sysfs
interface "cpuinfo_nominal_freq" by defining it as a driver attribute.

The patch series depends on the cpu-frequency driver patch-series[1].

[1] http://comments.gmane.org/gmane.linux.ports.ppc.embedded/67905

Thanks and Regards
gautham.

Summary:
==========================
Gautham R. Shenoy (4):
  powernv:cpufreq: Create pstate_id_to_freq() helper
  powernv:cpufreq: Export nominal frequency via sysfs.
  powernv:cpufreq: Create a powernv_cpu_to_core_mask() helper.
  powernv:cpufreq: Implement the driver->get() method

 drivers/cpufreq/powernv-cpufreq.c | 115 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 5 deletions(-)

-- 
1.8.3.1
