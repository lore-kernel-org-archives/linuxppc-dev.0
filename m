Return-Path: <nicolas.pitre@linaro.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by ozlabs.org (Postfix) with ESMTP id 2BF652C0089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 17:24:16 +1100 (EST)
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N0100CJWQFBKVJ0@VL-VM-MR006.ip.videotron.ca> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jan 2014 01:09:11 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/9] setting the table for integration of cpuidle with the
 scheduler
Date: Mon, 27 Jan 2014 01:08:15 -0500
Message-id: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
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
core code.  No functional change should have occurred yet.

The ARM, PPC, SH and X86 architectures are concerned.  Small cleanups
to ARM and ARM64 are also included. I don't know yet the best path for
those patches to get into mainline, but it is probably best if they
stay together. So ACKs from architecture maintainers would be greatly
appreciated.


 arch/arm/kernel/process.c                       | 21 +++---------
 arch/arm/kernel/setup.c                         |  7 ++++
 arch/arm64/kernel/process.c                     |  5 ---
 arch/arm64/kernel/setup.c                       |  7 ++++
 arch/powerpc/platforms/pseries/processor_idle.c |  5 +++
 arch/powerpc/platforms/pseries/setup.c          | 34 ++++++++-----------
 arch/sh/kernel/idle.c                           |  4 +--
 arch/x86/kernel/process.c                       |  5 +--
 include/linux/cpu.h                             |  1 -
 kernel/Makefile                                 |  1 -
 kernel/cpu/Makefile                             |  1 -
 kernel/sched/Makefile                           |  2 +-
 kernel/{cpu => sched}/idle.c                    |  6 ++--
 13 files changed, 44 insertions(+), 55 deletions(-)


Nicolas
