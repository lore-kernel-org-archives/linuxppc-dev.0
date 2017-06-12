Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmKZJ6l2wzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 14:25:28 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5C4Nvle108467
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 00:25:25 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b19pe2pc4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 00:25:25 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 12 Jun 2017 14:25:22 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5C4PKQA62324934
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 14:25:20 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5C4PK8D029848
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 14:25:20 +1000
Subject: Re: [PATCH 00/14 v2] idle performance improvements
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, "Shreyas B . Prabhu"
 <shreyas@linux.vnet.ibm.com>
Date: Mon, 12 Jun 2017 14:25:24 +1000
In-Reply-To: <20170611093102.2025-1-npiggin@gmail.com>
References: <20170611093102.2025-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1497241524.2897.1.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-06-11 at 19:30 +1000, Nicholas Piggin wrote:
> I rebased this on the powerpc next tree.
> 
> A couple of things are changed since last post:
> 
> - Patch 1 now properly accounts for the fact the powernv idle
>   wakeups do not re-enable interrupts until the cpuidle driver
>   enables them. This was not quite right in the previous patch
>   (and prep_irq_for_idle() is not quite right for that case so
>   a new primitive has to be introduced).

What do you mean ? We shouldn't be going to sleep with the CPU thinking
it's interrupts are off, otherwise we end up effectively "taking an
interrupt while off" which is not right and it will cause accounting to
think we are off for too long.

Is this a generic cpuidle problem or a powerpc issue ?

I'd rather we don't have to of those "prep_for_idle...". If necessary
sync the other one.

> - Patch to replace interrupts from system reset wakeup changed
>   rather than replaying directly, it just marks the IRQ in the
>   lazy pending bit and it will get replayed at the right time
>   when irqs are re-enabled.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (14):
>   powerpc/64s: idle move soft interrupt mask logic into C code
>   powerpc/64s: idle hotplug lazy-irq simplification
>   powerpc/64s: idle provide a default idle for POWER9
>   powerpc/64s: idle process interrupts from system reset wakeup
>   powerpc/64s: msgclr when handling doorbell exceptions
>   powerpc/64s: interrupt replay balance the return branch predictor
>   powerpc/64s: idle branch to handler with virtual mode offset
>   powerpc/64s: idle avoid SRR usage in idle sleep/wake paths
>   powerpc/64s: idle hmi wakeup is unlikely
>   powerpc/64s: cpuidle set polling before enabling irqs
>   powerpc/64s: cpuidle read mostly for common globals
>   powerpc/64s: cpuidle no memory barrier after break from idle
>   powerpc/64: runlatch CTRL[RUN] set optimisation
>   powerpc/64s: idle runlatch switch is done with MSR[EE]=0
> 
>  arch/powerpc/include/asm/dbell.h         |  13 +++
>  arch/powerpc/include/asm/exception-64s.h |  17 +++-
>  arch/powerpc/include/asm/hw_irq.h        |   5 ++
>  arch/powerpc/include/asm/machdep.h       |   1 +
>  arch/powerpc/include/asm/ppc-opcode.h    |   3 +
>  arch/powerpc/include/asm/processor.h     |  10 +--
>  arch/powerpc/kernel/asm-offsets.c        |   1 +
>  arch/powerpc/kernel/exceptions-64s.S     |  33 ++++++--
>  arch/powerpc/kernel/idle_book3s.S        | 135 +++++++++----------------------
>  arch/powerpc/kernel/irq.c                |  58 ++++++++++++-
>  arch/powerpc/kernel/process.c            |  12 +--
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   8 +-
>  arch/powerpc/platforms/powernv/idle.c    |  90 +++++++++++++++++++--
>  arch/powerpc/platforms/powernv/smp.c     |  31 ++++---
>  arch/powerpc/platforms/powernv/subcore.c |   3 +-
>  drivers/cpuidle/cpuidle-powernv.c        |  37 +++++----
>  drivers/cpuidle/cpuidle-pseries.c        |  22 +++--
>  17 files changed, 309 insertions(+), 170 deletions(-)
> 
