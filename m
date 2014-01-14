Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E61F22C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:55:27 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 20:55:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D044C2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:55:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0EAaUY25767436
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:36:30 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0EAtM0H022700
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:55:23 +1100
Subject: [PATCH v1 0/6] pseries/cpuidle: pseries cpuidle backend driver
 clean-ups.
To: linux-pm@vger.kernel.org, benh@kernel.crashing.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 16:25:39 +0530
Message-ID: <20140114105525.3064.52013.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch series includes a bunch of clean-ups for the
pseries cpuidle backend driver. This includes,
moving the driver from arch/powerpc/platforms/pseries to
driver/cpuidle, refactoring of the code, making it a non-module,
removing smt-snooze-delay update and dead code around it.

After a number of attempts to consolidate the backend cpuidle driver 
for pSeries and powernv platforms, it seems best to have separate 
idle drivers for both the platforms as any kind of  code duplication 
seizes to exist beyond snooze loop and a hot plug notifier.  
Also going further, with addition of device tree parsing to setup
idle states and related changes just for powernv platform, it is
best to keep these drivers separate without adding complexity 
and thus improving readabilty for both the platform drivers.  

The clean-up undertaken here was posted earlier as part of
generic powerpc cpuidle driver clean-up.

V1 -> http://lkml.org/lkml/2013/7/23/143
V2 -> https://lkml.org/lkml/2013/7/30/872
V3 -> http://comments.gmane.org/gmane.linux.ports.ppc.embedded/63093
V4 -> https://lkml.org/lkml/2013/8/22/25
V5 -> http://lkml.org/lkml/2013/8/22/184
V6 -> https://lkml.org/lkml/2013/8/27/432
V7 -> https://lkml.org/lkml/2013/10/29/216
V8 -> https://lkml.org/lkml/2013/11/11/29

 Deepthi Dharwar (5):
      pseries/cpuidle: Move processor_idle.c to drivers/cpuidle.
      pseries/cpuidle: Use cpuidle_register() for initialisation.
      pseries/cpuidle: Make cpuidle-pseries backend driver a non-module.
      pseries/cpuidle: Remove MAX_IDLE_STATE macro.
      pseries/cpuidle: smt-snooze-delay cleanup.

Preeti U Murthy (1):
      pseries/cpuidle: Remove redundant call to ppc64_runlatch_off() in cpu idle routines


 arch/powerpc/include/asm/processor.h            |    7 
 arch/powerpc/kernel/sysfs.c                     |    2 
 arch/powerpc/platforms/pseries/Kconfig          |    9 -
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/processor_idle.c |  364 -----------------------
 drivers/cpuidle/Kconfig                         |    5 
 drivers/cpuidle/Kconfig.powerpc                 |   11 +
 drivers/cpuidle/Makefile                        |    4 
 drivers/cpuidle/cpuidle-pseries.c               |  267 +++++++++++++++++
 9 files changed, 287 insertions(+), 383 deletions(-)
 delete mode 100644 arch/powerpc/platforms/pseries/processor_idle.c
 create mode 100644 drivers/cpuidle/Kconfig.powerpc
 create mode 100644 drivers/cpuidle/cpuidle-pseries.c


-- Deepthi
