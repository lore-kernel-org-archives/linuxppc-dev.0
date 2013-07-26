Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0A972C0108
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 15:17:48 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 26 Jul 2013 10:42:12 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7CD71394005B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 10:47:03 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6Q5I7m540239184
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 10:48:07 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6Q5H5wj003144
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 15:17:08 +1000
Subject: [Resend RFC PATCH 0/5] cpuidle/ppc: Timer offload framework to
 support deep idle states
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
Date: Fri, 26 Jul 2013 10:43:54 +0530
Message-ID: <20130726050915.17167.16298.stgit@preeti>
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
like x86. Instead we assign the local timer of one of the CPUs to do this
job.

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

This patch series is being resent to clarify certain ambiguity in the patch
descriptions from the previous post. Discussion around this:
https://lkml.org/lkml/2013/7/25/754

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
 arch/powerpc/kernel/time.c                      |   86 +++++++++++++++++++++++
 arch/powerpc/platforms/cell/interrupt.c         |    2 -
 arch/powerpc/platforms/powernv/Kconfig          |    1 
 arch/powerpc/platforms/powernv/processor_idle.c |   48 +++++++++++++
 arch/powerpc/platforms/ps3/smp.c                |    2 -
 kernel/time/tick-sched.c                        |    7 ++
 9 files changed, 163 insertions(+), 12 deletions(-)
