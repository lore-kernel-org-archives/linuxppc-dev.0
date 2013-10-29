Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1EA4D2C0343
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:01:43 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 29 Oct 2013 21:01:41 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 957D43578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:01:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9TB1Ku1852352
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:01:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9TB1VO7026776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:01:32 +1100
Subject: [PATCH V7 0/7] POWER/cpuidle: Generic IBM-POWER cpuidle driver
 enabled for PSERIES and POWERNV platforms
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 29 Oct 2013 16:31:02 +0530
Message-ID: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, scottwood@freescale.com,
 linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series consolidates the backend cpuidle driver for pSeries
and powernv platforms with minimal code duplication.

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

Earlier in 3.3 kernel, pSeries idle state management was modified to 
exploit the cpuidle framework and the end goal of this patch is to have powernv
platform also to hook its idle states into cpuidle framework with minimal 
code duplication between both platforms.  

This series aims to maintain compatibility and functionality to existing pseries 
and powernv idle cpu management code. There are no new functions or idle 
states added as part of this series. This can be extended by adding more 
states to this existing framework.

With this patch series, the powernv cpuidle functionalities are on-par with 
pSeries idle management.  

V1 -> http://lkml.org/lkml/2013/7/23/143
V2 -> https://lkml.org/lkml/2013/7/30/872
V3 -> http://comments.gmane.org/gmane.linux.ports.ppc.embedded/63093 
V4 -> https://lkml.org/lkml/2013/8/22/25
V5 -> http://lkml.org/lkml/2013/8/22/184
V6 -> https://lkml.org/lkml/2013/8/27/432 

Changes in V7:
============
* Rebased to the latest kernel 3.12-rc7

* Default idle routine to be called on POWERNV
  is power7_idle() instead of HMT_low() routines.

Changes in V6:
=============
* Made changes in Patch3: Generic POWER cpuidle driver in V5 by
  breaking down to multiple patches, as there were multiple changes
  including moving the file location.

* Remove MAX_IDLE_STATE macro and kernel command line for
  IBM-POWER systems.

* Make backend driver a built-in, instead of a module.
  As building this as a module is currently not possible. 

* Generic backend driver minor cleanups.

* First two patches in V5 are not a part of the series, as
  they are generic cleanups, already pushed into the tree.

Changes in V5:
=============

* As per the discussions in the community, this patch series
  enables cpuidle backend driver only for IBM-POWER 
  platforms. File is re-named from drivers/cpuidle/cpuidle-powerpc.c
  to drivers/cpuidle/cpuildle-ibm-power.c
  New back-end cpuidle driver is called IBM-POWER-Idle.

* General cleanups on the accessors front that was introduced in 
  previous version.

Changes in V4:
=============

* This patch series includes generic backend driver cpuidle cleanups 
  including, replacing the driver and device initialisation
  routines with cpuidle_register function.

* Enable CPUIDLE framework only for POWER and POWERNV platforms.

Changes in V3:
=============

* This patch series does not include smt-snooze-delay fixes. 
  This will be taken up later on.

* Integrated POWERPC driver in drivers/cpuidle.  Enabled for all of 
  POWERPC platform.  Currently has PSERIES and POWERNV support.
  No compile time flags in .c file. This  will be one consolidated 
  binary that does a run time detection based on platform and take 
  decisions accordingly.

* Enabled CPUIDLE framwork for all of PPC64.

Changes in V2:
=============

* Merged the backend driver posted out for powernv in V1 with
  pSeries to create a single powerpc driver but this had compile
  time flags.

 Deepthi Dharwar (7):
      pseries/cpuidle: Move processor_idle.c to drivers/cpuidle.
      pseries/cpuidle: Use cpuidle_register() for initialisation.
      pseries/cpuidle: Make pseries_idle backend driver a  non-module.
      pseries/cpuidle: Remove MAX_IDLE_STATE macro.
      POWER/cpuidle: Generic POWER CPUIDLE driver supporting PSERIES.
      POWER/cpuidle: Enable powernv cpuidle support.
      powernv/cpuidle: Enable idle powernv cpu to call into the cpuidle framework.


 arch/powerpc/include/asm/processor.h            |    2 
 arch/powerpc/platforms/powernv/setup.c          |   13 +
 arch/powerpc/platforms/pseries/Kconfig          |    9 -
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/processor_idle.c |  364 -----------------------
 drivers/cpuidle/Kconfig                         |    5 
 drivers/cpuidle/Kconfig.powerpc                 |   10 +
 drivers/cpuidle/Makefile                        |    4 
 drivers/cpuidle/cpuidle-ibm-power.c             |  320 ++++++++++++++++++++
 9 files changed, 352 insertions(+), 376 deletions(-)
 delete mode 100644 arch/powerpc/platforms/pseries/processor_idle.c
 create mode 100644 drivers/cpuidle/Kconfig.powerpc
 create mode 100644 drivers/cpuidle/cpuidle-ibm-power.c


-- Deepthi
