Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 724C52C01D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 21:58:29 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 14 Aug 2013 17:19:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4F2B81258054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 17:28:03 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7EBxcBp32571494
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 17:29:39 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7EBwBwl011698
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 17:28:13 +0530
Subject: [RFC V2 PATCH 0/6] cpuidle/ppc: Timer offload framework to support
 deep idle states
To: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, galak@kernel.crashing.org,
 deepthi@linux.vnet.ibm.com, benh@kernel.crashing.org,
 paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org,
 rostedt@goodmis.org, rjw@sisk.pl, john.stultz@linaro.org,
 tglx@linutronix.de, chenhui.zhao@freescale.com, michael@ellerman.id.au,
 r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 14 Aug 2013 17:25:47 +0530
Message-ID: <20130814115311.5193.32212.stgit@preeti.in.ibm.com>
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
for powernv posted by Deepthi Dharwar recently. NOHZ_FULL is disabled for all
testing purposes.
  The current design and implementation supports the ONESHOT tick mode.
It does not yet support the PERIODIC tick mode.

The discussion around V1 of this patchset can be found here:
https://lkml.org/lkml/2013/7/25/740.

Changes since V1:
1. Dynamically pick a broadcast CPU, instead of having a dedicated one.
2. Remove the constraint of having to disable tickless idle on the broadcast CPU.

Thanks to Ben H, Frederic Weisbecker, Li Yang and Vaidyanathan Srinivasan for
all their comments and suggestions on the V1 of this patchset.

Patch[1/6], Patch[2/6]: optimize the broadcast mechanism on ppc.
Patch[3/6]: Introduces the core of the timer offload framework on powerpc.
Patch[4/6]: Add a deep idle state to the cpuidle state table on powernv
Patch[5/6]: Dynamically pick a broadcast CPU
Patch[6/6]: Remove the constraint of having to disable tickless idle on the
broadcast cpu, by queueing a hrtimer exclusively to do broadcast handling.

---

Preeti U Murthy (4):
      cpuidle/ppc: Add timer offload framework to support deep idle states
      cpuidle/ppc: Add longnap state to the idle states on powernv
      cpuidle/ppc: Enable dynamic movement of the broadcast functionality across CPUs
      cpuidle/ppc : Queue a hrtimer on bc_cpu, explicitly to do broadcast handling

Srivatsa S. Bhat (2):
      powerpc: Free up the IPI message slot of ipi call function (PPC_MSG_CALL_FUNC)
      powerpc: Implement broadcast timer interrupt as an IPI message


 arch/powerpc/include/asm/smp.h                  |    3 -
 arch/powerpc/include/asm/time.h                 |    9 ++
 arch/powerpc/kernel/smp.c                       |   23 +++--
 arch/powerpc/kernel/time.c                      |  114 +++++++++++++++++++++++
 arch/powerpc/platforms/cell/interrupt.c         |    2 
 arch/powerpc/platforms/powernv/Kconfig          |    1 
 arch/powerpc/platforms/powernv/processor_idle.c |  104 +++++++++++++++++++++
 arch/powerpc/platforms/ps3/smp.c                |    2 
 8 files changed, 246 insertions(+), 12 deletions(-)
