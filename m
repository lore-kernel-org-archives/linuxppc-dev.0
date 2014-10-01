Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id D844C1A06EC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 06:26:58 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/3] powernv/cpuidle: Fastsleep workaround and fixes
Date: Wed, 01 Oct 2014 22:46:53 +0200
Message-ID: <2978842.I7Hdqv7lNe@vostro.rjw.lan>
In-Reply-To: <1412149560-2953-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1412149560-2953-1-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: "Srivatsa S. Bhat" <srivatsa@mit.edu>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, October 01, 2014 01:15:57 PM Shreyas B. Prabhu wrote:
> Fast sleep is an idle state, where the core and the L1 and L2
> caches are brought down to a threshold voltage. This also means that
> the communication between L2 and L3 caches have to be fenced. However
> the current P8 chips have a bug wherein this fencing between L2 and
> L3 caches get delayed by a cpu cycle. This can delay L3 response to
> the other cpus if they request for data during this time. Thus they
> would fetch the same data from the memory which could lead to data
> corruption if L3 cache is not flushed. 
> 
> This series overcomes above problem in kernel.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Srivatsa S. Bhat <srivatsa@mit.edu>
> Cc: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> 
> v2:
> Rebased on 3.17-rc7
> Split from 'powerpc/powernv: Support for fastsleep and winkle'
> 
> v1:
> https://lkml.org/lkml/2014/8/25/446
> 
> Preeti U Murthy (1):
>   powerpc/powernv/cpuidle: Add workaround to enable fastsleep
> 
> Shreyas B. Prabhu (1):
>   powerpc/kvm/book3s_hv: Enable CPUs to run guest after waking up from
>     fast-sleep
> 
> Srivatsa S. Bhat (1):
>   powerpc/powernv: Enable Offline CPUs to enter deep idle states
> 
>  arch/powerpc/include/asm/machdep.h             |   3 +
>  arch/powerpc/include/asm/opal.h                |   7 ++
>  arch/powerpc/include/asm/processor.h           |   4 +-
>  arch/powerpc/kernel/exceptions-64s.S           |  35 ++++----
>  arch/powerpc/kernel/idle.c                     |  19 ++++
>  arch/powerpc/kernel/idle_power7.S              |   2 +-
>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>  arch/powerpc/platforms/powernv/powernv.h       |   7 ++
>  arch/powerpc/platforms/powernv/setup.c         | 118 +++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/smp.c           |  11 ++-
>  drivers/cpuidle/cpuidle-powernv.c              |  13 ++-
>  11 files changed, 194 insertions(+), 26 deletions(-)

[2/3] seems to be missig from the series.

Also, since that mostly modifies arch/powerpc, I think it should go through
that tree.  I'm fine with the cpuidle-powernv changes in [1/3] and [3/3].

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
