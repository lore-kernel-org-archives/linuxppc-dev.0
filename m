Return-Path: <ego@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B7D462C00AB
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:31:37 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 21:31:35 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 526B32CE8047
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:31:31 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2BBBUSA7733724
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:11:30 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2BBVUDQ019828
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:31:30 +1100
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 0/2] powernv: Show the correct clock value in /proc/cpuinfo
Date: Tue, 11 Mar 2014 17:01:17 +0530
Message-Id: <1394537479-17231-1-git-send-email-ego@linux.vnet.ibm.com>
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

Currently, the code in setup-common.c for powerpc assumes that all
clock rates are same in a smp system. This value is cached in the
variable named ppc_proc_freq and is the value that is reported in
/proc/cpuinfo.

However on the PowerNV platform, the clock rate is same only across
the threads of the same core. Hence the value that is reported in
/proc/cpuinfo is incorrect on PowerNV platforms.

This patch-series fixes this problem by having /proc/cpuinfo report
the value returned by cpufreq_quick_get(cpu) whenever the cpufreq
backend driver is available and fallback to the old way of reporting
the clock rate in its absence.

These patches depend on the patches to enable dynamic cpufrequency
scaling on PowerNV that can be found here:
http://linuxppc.10917.n7.nabble.com/PATCH-v2-0-6-powernv-cpufreq-Dynamic-cpu-frequency-scaling-td80641.html

Gautham R. Shenoy (2):
  powerpc: powernv: Framework to show the correct clock in /proc/cpuinfo
  powerpc: powernv: Implement ppc_md.get_proc_freq()

 arch/powerpc/include/asm/machdep.h     |  2 ++
 arch/powerpc/kernel/setup-common.c     | 16 ++++++++++++----
 arch/powerpc/platforms/powernv/setup.c | 21 +++++++++++++++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

-- 
1.8.3.1
