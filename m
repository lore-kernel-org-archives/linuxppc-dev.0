Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 911E62C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 22:02:11 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 16:32:08 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5DB5D3940060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 16:32:07 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0EB24EK54263902
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 16:32:04 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0EB24NL002820
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 16:32:06 +0530
Subject: [PATCH v1] powernv/cpuidle: Back-end cpuidle driver for powernv
 platform for idle state management.
To: linux-pm@vger.kernel.org, benh@kernel.crashing.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 16:32:24 +0530
Message-ID: <20140114110157.4091.80684.stgit@deepthi.in.ibm.com>
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

Following patch ports the cpuidle framework for powernv
platform and also implements a cpuidle back-end powernv 
idle driver calling on to power7_nap and snooze idle states.

Moving the idle states over to cpuidle framework can take advantage 
of advanced heuristics, tunables and features provided by cpuidle 
framework. Additional idle states can be exploited using the cpuidle 
framework. The statistics and tracing infrastructure provided by 
the cpuidle framework also helps in enabling power management 
related tools and help tune the system and applications.

This series aims to maintain compatibility and functionality to
existing powernv idle cpu management code.  There are no new functions
or idle states added as part of this series. This can be extended by 
adding more states to this existing framework.

For POWERNV platform to hook into CPUIDLE framework, one
needs to enable CONFIG_POWERNV_IDLE. 

This patch series applies on pseries cpuidle backend driver
fixes patchset posted earlier.
pseries/cpuidle: pseries cpuidle backend driver clean-ups.

 Deepthi Dharwar (1):
      powernv/cpuidle: Back-end cpuidle driver for powernv platform.


 arch/powerpc/platforms/powernv/setup.c |   13 ++
 drivers/cpuidle/Kconfig.powerpc        |    9 ++
 drivers/cpuidle/Makefile               |    1 
 drivers/cpuidle/cpuidle-powernv.c      |  169 ++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpuidle/cpuidle-powernv.c


-- Deepthi
