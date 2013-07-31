Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64EAC2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 13:00:00 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 12:49:13 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A51EF3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 12:59:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V2xNFT8192324
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 12:59:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6V2xWEN004865
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 12:59:32 +1000
Subject: [PATCH V2 0/6] cpuidle/powerpc: POWERPC cpuidle driver for POWER
 and POWERNV platforms
To: benh@kernel.crashing.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, michael@ellerman.id.au,
 srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 31 Jul 2013 08:28:44 +0530
Message-ID: <20130731025840.19448.24468.stgit@deepthi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rjw@sisk.pl, dongsheng.wang@freescale.com, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Following patch series consolidates backend cpuidle driver
for pseries and powernv platforms. 

Current existing backend driver for pseries has been moved to
arch/powerpc/sysdev and has been extended to accommodate 
powernv idle power mgmt states. 
As seen in V1 of this patch series, too much code duplication persists
having separate back-end driver for individual platforms.

Moving the idle states over to cpuidle framework can take advantage 
of advanced heuristics, tunables and features provided by cpuidle 
framework. Additional idle states can be exploited using the cpuidle 
framework. The statistics and tracing infrastructure provided by 
the cpuidle framework also helps in enabling power management 
related tools and help tune the system and applications.

This series aims to maintain compatibility and functionality to
existing pseries and powernv idle cpu management code.  
There are no new functions or idle states added as part of this series. 
This can be extended by adding more states to this existing framework.

With this patch series the powernv cpuidle functionalities
are on-par with pSeries idle management. Other POWERPC
platforms can use this to exploit CPUIDLE framework.

This patch mainly focus on an integrated CPUIDLE backend
driver for POWERPC. Minor cpuidle clean-ups will be
taken up going further.

One need to enable POWERPC_IDLE config option to exploit these
backend drivers.

V1 -> http://lkml.org/lkml/2013/7/23/143

 Deepthi Dharwar (6):
      cpuidle/pseries: Fix kernel command line parameter smt-snooze-delay
      cpuidle/pseries: Remove dependency of pseries.h file
      pseries: Move plpar_wrapper.h to powerpc common include/asm location.
      cpuidle/pseries: Move the pseries_idle backend driver to sysdev.
      cpuidle/powerpc: Backend-powerpc idle driver for powernv and pseries.
      cpuidle/powernv: Enable idle powernv cpu to call into the cpuidle framework.


  arch/powerpc/include/asm/plpar_wrappers.h       |  324 ++++++++++++++++++
 arch/powerpc/include/asm/processor.h            |    2 
 arch/powerpc/platforms/powernv/setup.c          |   12 +
 arch/powerpc/platforms/pseries/Kconfig          |    9 
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/cmm.c            |    3 
 arch/powerpc/platforms/pseries/dtl.c            |    3 
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |    3 
 arch/powerpc/platforms/pseries/hvconsole.c      |    2 
 arch/powerpc/platforms/pseries/iommu.c          |    3 
 arch/powerpc/platforms/pseries/kexec.c          |    2 
 arch/powerpc/platforms/pseries/lpar.c           |    2 
 arch/powerpc/platforms/pseries/plpar_wrappers.h |  324 ------------------
 arch/powerpc/platforms/pseries/processor_idle.c |  362 --------------------
 arch/powerpc/platforms/pseries/pseries.h        |    3 
 arch/powerpc/platforms/pseries/setup.c          |    2 
 arch/powerpc/platforms/pseries/smp.c            |    2 
 arch/powerpc/sysdev/Kconfig                     |    9 
 arch/powerpc/sysdev/Makefile                    |    1 
 arch/powerpc/sysdev/processor_idle.c            |  424 +++++++++++++++++++++++
 20 files changed, 780 insertions(+), 713 deletions(-)
 create mode 100644 arch/powerpc/include/asm/plpar_wrappers.h
 delete mode 100644 arch/powerpc/platforms/pseries/plpar_wrappers.h
 delete mode 100644 arch/powerpc/platforms/pseries/processor_idle.c
 create mode 100644 arch/powerpc/sysdev/processor_idle.c


-- Deepthi
