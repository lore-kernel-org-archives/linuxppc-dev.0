Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 860F22C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 19:05:39 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 25 Jul 2013 14:26:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8E8CB1258051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 14:34:31 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6P960d038273100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 14:36:02 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6P94wlu021595
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 19:05:02 +1000
Subject: [RFC PATCH 0/5] cpuidle/ppc: Timer offload framework to support
 deep idle states
To: benh@kernel.crashing.org, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, galak@kernel.crashing.org,
 fweisbec@gmail.com, paulmck@linux.vnet.ibm.com, michael@ellerman.id.au,
 arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org,
 rjw@sisk.pl, john.stultz@linaro.org, tglx@linutronix.de,
 chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com,
 geoff@infradead.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Thu, 25 Jul 2013 14:32:38 +0530
Message-ID: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
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

On PowerPC, when CPUs enter deep idle states, their local timers are
switched off. The responsibility of waking them up at their next timer event,
needs to be handed over to an external device. On PowerPC, we do not have an
external device equivalent to HPET, which is currently done on architectures
like x86. Instead we assign the local timer of one of the CPUs to do this job.

This patchset is an attempt to make use of the existing timer broadcast
framework in the kernel to meet the above requirement, except that the tick
broadcast device is the local timer of the boot CPU.

This patch series is ported ontop of 3.11-rc1 + the cpuidle driver backend
for powernv posted by Deepthi Dharwar recently. The current design and
implementation supports the ONESHOT tick mode. It does not yet support
the PERIODIC tick mode. This patch is tested with NOHZ_FULL off.

Patch[1/5], Patch[2/5]: optimize the broadcast mechanism on ppc.
Patch[3/5]: Introduces the core of the timer offload framework on powerpc.
Patch[4/5]: The cpu doing the broadcast should not go into tickless idle.
Patch[5/5]: Add a deep idle state to the cpuidle state table on powernv.

Patch[5/5] is the patch that ultimately makes use of the timer offload
framework that the patches Patch[1/5] to Patch[4/5] build.

---

Preeti U Murthy (3):
      cpuidle/ppc: Add timer offload framework to support deep idle states
      cpuidle/ppc: CPU goes tickless if there are no arch-specific constraints
      cpuidle/ppc: Add longnap state to the idle states on powernv

Srivatsa S. Bhat (2):
      powerpc: Free up the IPI message slot of ipi call function (PPC_MSG_CALL_FUNC)
      powerpc: Implement broadcast timer interrupt as an IPI message


 arch/powerpc/include/asm/smp.h                  |    3 +
 arch/powerpc/include/asm/time.h                 |    3 +
 arch/powerpc/kernel/smp.c                       |   23 ++++--
 arch/powerpc/kernel/time.c                      |   84 +++++++++++++++++++++++
 arch/powerpc/platforms/cell/interrupt.c         |    2 -
 arch/powerpc/platforms/powernv/Kconfig          |    1 
 arch/powerpc/platforms/powernv/processor_idle.c |   48 +++++++++++++
 arch/powerpc/platforms/ps3/smp.c                |    2 -
 kernel/time/tick-sched.c                        |    7 ++
 9 files changed, 161 insertions(+), 12 deletions(-)

-- 
Signature
