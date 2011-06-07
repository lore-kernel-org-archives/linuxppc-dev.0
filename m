Return-Path: <trinabh@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5C34B6FB4
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 02:29:21 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp07.in.ibm.com (8.14.4/8.13.1) with ESMTP id p57GTHPk002875
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2011 21:59:17 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p57GTHjB3039282
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2011 21:59:17 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p57GTH68026194
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2011 02:29:17 +1000
From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 0/7] cpuidle: (POWER) cpuidle driver for pSeries
To: linux-pm@lists.linux-foundation.org, linuxppc-dev@ozlabs.org
Date: Tue, 07 Jun 2011 21:59:15 +0530
Message-ID: <20110607162847.6848.44707.stgit@tringupt.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series ports the cpuidle framework for ppc64 platform and
implements a cpuidle back-end driver for ppc64 (pSeries) platform.
Currently idle states are managed by pseries_{dedicated,shared}_idle_sleep() 
routines in arch/powerpc/platforms/pseries/setup.c.  There are
generally two idle states (snooze and cede) that are exploited by
these routines based on simple heuristics.

Moving the idle states over to cpuidle framework can take advantage of
the advanced heuristics, tunables, and features provided by cpuidle
framework. Additional idle states like extended cede with hints would be
included and exploited using the cpuidle framework. The statistics and 
tracing infrastructure provided by the cpuidle framework also helps in 
enabling power management related tools and help tune the system and 
applications.

This series aims to maintain compatibility and functionality to
existing pSeries idle cpu management code.  There are no new functions
or idle states added as part of this series. The first three patch
in the series are taken from "idle cleanup - v3" posted by 
Len Brown (https://lkml.org/lkml/2011/4/2/8). These are required to
eliminate usage of pm_idle.

[1/7] cpuidle: create bootparam "cpuidle.off=1"
[2/7] cpuidle: replace xen access to x86 pm_idle and default_idle
[3/7] cpuidle: stop using pm_idle
[4/7] - Provides arch specific cpu_idle_wait() function required by cpuidle
  subsystem.
[5/7] - pseries_idle cpuidle driver
[6/7] - Enables cpuidle for pSeries and directly calls cpuidle_idle_call()
[7/7] - Handles powersave=off kernel boot parameter and disables registration
  of pseries_idle cpuidle driver.

This patch series has the following dependencies:

(1) Base kernel tree: 3.0.0-rc2
(2) Patch: cpuidle: global registration patch 
        https://lkml.org/lkml/2011/6/6/259

This series is tested on ppc64 pSeries POWER7 system with the snooze
and cede states.

Thanks,
-Trinabh
