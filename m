Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8ACF72C0181
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 14:28:31 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 14:18:11 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4B2DA3578050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 14:28:27 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7J4CWiu24903900
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 14:12:32 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7J4SQ5r030691
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 14:28:26 +1000
Subject: [RFC PATCH V3 0/5] powerpc/cpuidle: Generic POWERPC cpuidle driver
 enabled for POWER and POWERNV platforms
To: benh@kernel.crashing.org, daniel.lezcano@linaro.org,
 kernel@vger.kernel.org, scottwood@freescale.com,
 linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 09:57:49 +0530
Message-ID: <20130819042736.8609.17890.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: preeti@linux.vnet.ibm.com, dongsheng.wang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series consolidates the backend cpuidle driver for pseries
and powernv platforms and also enables the new drivers/cpuidle/cpuidle-powerpc.c 
to include other powerpc drivers with minimal code duplication.

Current existing backend driver for pseries has been moved to drivers/cpuidle 
and has been extended to accommodate powernv idle power mgmt states. 
As seen in V1 of this patch series, having a separate powernv backend driver 
results in too much code duplication, which is less elegant and can pose 
maintenance problems going further.

Using the cpuidle framework to exploit platform low power idle states
management can take advantage of advanced heuristics, tunables and features 
provided by framework. The statistics and tracing infrastructure provided 
by the cpuidle framework also helps in enabling power management 
related tools and help tune the system and applications.

Earlier in 3.3 kernel, pseries idle state management was modified to 
exploit the cpuidle framework and the end goal of this patch is to have powernv
platform also to hook its idle states into cpuidle framework with minimal 
code duplication between both platforms. This result is a generic powerpc 
backend driver currently enabled for pseries and powernv platforms and which
can be extended to accommodate other powerpc archs in the future.

This series aims to maintain compatibility and functionality to existing pseries 
and powernv idle cpu management code. There are no new functions or idle 
states added as part of this series. This can be extended by adding more 
states to this existing framework.

With this patch series, the powernv cpuidle functionalities are on-par with 
pSeries idle management. Other POWERPC platforms can use this patch series 
to exploit the CPUIDLE framework.

This patch mainly focus on an integrated CPUIDLE backend driver for POWERPC. 
Minor cpuidle clean-ups including a generic hotplug cpuidle notifier, 
using cpuidle_register calls will be taken up going further.

V1 -> http://lkml.org/lkml/2013/7/23/143
V2 -> https://lkml.org/lkml/2013/7/30/872

Changes from V2:
===============

* This patch series does not include smt-snooze-delay fixes. 
  This will be taken up later on.

* Integrated POWERPC driver in drivers/cpuidle.
  Enabled for all of POWERPC platform. 
  Currently has PSERIES and POWERNV support.
  No compile time flags in .c file. This  will be 
  one consolidated binary that does a run time 
  detection based on platform and take decisions 
  accordingly.

 Deepthi Dharwar (5):
      pseries/cpuidle: Remove dependency of pseries.h file
      pseries: Move plpar_wrapper.h to powerpc common include/asm location.
      powerpc/cpuidle: Generic powerpc backend cpuidle driver.
      powerpc/cpuidle: Enable powernv cpuidle support.
      powernv/cpuidle: Enable idle powernv cpu to call into the cpuidle framework.


 arch/powerpc/include/asm/paca.h                 |   23 +
 arch/powerpc/include/asm/plpar_wrappers.h       |  325 +++++++++++++++++++
 arch/powerpc/include/asm/processor.h            |    2 
 arch/powerpc/platforms/powernv/setup.c          |   14 +
 arch/powerpc/platforms/pseries/Kconfig          |    9 -
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/cmm.c            |    3 
 arch/powerpc/platforms/pseries/dtl.c            |    3 
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |    3 
 arch/powerpc/platforms/pseries/hvconsole.c      |    2 
 arch/powerpc/platforms/pseries/iommu.c          |    3 
 arch/powerpc/platforms/pseries/kexec.c          |    2 
 arch/powerpc/platforms/pseries/lpar.c           |    2 
 arch/powerpc/platforms/pseries/plpar_wrappers.h |  324 -------------------
 arch/powerpc/platforms/pseries/processor_idle.c |  362 ---------------------
 arch/powerpc/platforms/pseries/pseries.h        |    3 
 arch/powerpc/platforms/pseries/setup.c          |    2 
 arch/powerpc/platforms/pseries/smp.c            |    2 
 drivers/cpuidle/Kconfig                         |    7 
 drivers/cpuidle/Makefile                        |    2 
 drivers/cpuidle/cpuidle-powerpc.c               |  391 +++++++++++++++++++++++
 21 files changed, 772 insertions(+), 713 deletions(-)
 create mode 100644 arch/powerpc/include/asm/plpar_wrappers.h
 delete mode 100644 arch/powerpc/platforms/pseries/plpar_wrappers.h
 delete mode 100644 arch/powerpc/platforms/pseries/processor_idle.c
 create mode 100644 drivers/cpuidle/cpuidle-powerpc.c


-- Deepthi
