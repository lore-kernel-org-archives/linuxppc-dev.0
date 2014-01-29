Return-Path: <nicolas.pitre@linaro.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by ozlabs.org (Postfix) with ESMTP id 3BBEA2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 04:45:22 +1100 (EST)
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N0600IR6BZJOTG0@VL-VM-MR006.ip.videotron.ca> for
 linuxppc-dev@lists.ozlabs.org; Wed, 29 Jan 2014 12:45:19 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Russell King <linux@arm.linux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 0/6] setting the table for integration of cpuidle with the
 scheduler
Date: Wed, 29 Jan 2014 12:45:07 -0500
Message-id: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As everyone should know by now, we want to integrate the cpuidle
governor with the scheduler for a more efficient idling of CPUs.
In order to help the transition, this small patch series moves the
existing interaction with cpuidle from architecture code to generic
core code.  The ARM, PPC, SH and X86 architectures are concerned.
No functional change should have occurred yet.

@peterz: Are you willing to pick up those patches?

Change from v1:

- dropped removal of arch_cpu_idle_prepare()


 arch/arm/kernel/process.c                       | 16 +++------
 arch/powerpc/platforms/pseries/processor_idle.c |  5 +++
 arch/powerpc/platforms/pseries/setup.c          | 34 ++++++++-----------
 arch/sh/kernel/idle.c                           |  4 +--
 arch/x86/kernel/process.c                       |  5 +--
 kernel/Makefile                                 |  1 -
 kernel/cpu/Makefile                             |  1 -
 kernel/sched/Makefile                           |  2 +-
 kernel/{cpu => sched}/idle.c                    |  4 ++-
 9 files changed, 30 insertions(+), 42 deletions(-)


Nicolas
