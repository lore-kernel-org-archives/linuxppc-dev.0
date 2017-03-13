Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhwvv3c2PzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 11:43:39 +1100 (AEDT)
Message-ID: <1489447868.2174.16.camel@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/2] reworking cause_ipi and adding global doorbell
 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Mar 2017 10:31:08 +1100
In-Reply-To: <20170312171327.21088-1-npiggin@gmail.com>
References: <20170312171327.21088-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-13 at 03:13 +1000, Nicholas Piggin wrote:
> Hi,
> 
> Just after the previous two fixes, I would like to propose changing
> the way we do doorbell vs interrupt controller IPIs, and add support
> for global doorbells supported by POWER9 in HV mode.
> 
> After this, the platform code knows about doorbells and interrupt
> controller IPIs, rather than they know about each other.

A few things come to mind:

 - We don't want to use doorbells under KVM. They are going to turn
into traps and be emulated, slower than using H_IPI, at least on P9.
Even for core only doorbells. I'm not sure how to convey that to the
guest.

 - On PP9 DD1 we need a CI load instead of msgsync (a DARN instruction
would do too if it works)

 - Can we get rid of the atomic ops for manipulating the IPI mux ? What
about a cache line per message and just set/clear ? If we clear in the
doorbell handler before we call the respective targets, we shouldn't
"lose" messages no ? As long as the actual handlers "loop" as necessary
of course.

Cheers,
Ben.

> Thanks,
> Nick
> 
> Nicholas Piggin (2):
>   powerpc/64s: change the doorbell IPI calling convention
>   powerpc/64s: use global doorbell on POWER9 in HV mode
> 
>  arch/powerpc/include/asm/dbell.h       | 38 ++++++++++++++++++++++
> -----
>  arch/powerpc/include/asm/smp.h         |  4 +--
>  arch/powerpc/include/asm/xics.h        |  2 +-
>  arch/powerpc/kernel/dbell.c            | 47 ++++++++++++++++++++++
> ------------
>  arch/powerpc/kernel/smp.c              | 27 ++++++++++---------
>  arch/powerpc/platforms/85xx/smp.c      |  9 +------
>  arch/powerpc/platforms/powermac/smp.c  |  2 +-
>  arch/powerpc/platforms/powernv/smp.c   | 32 +++++++++++++++++------
>  arch/powerpc/platforms/pseries/smp.c   | 28 ++++++++------------
>  arch/powerpc/sysdev/xics/icp-hv.c      |  2 +-
>  arch/powerpc/sysdev/xics/icp-native.c  | 12 +--------
>  arch/powerpc/sysdev/xics/icp-opal.c    |  2 +-
>  arch/powerpc/sysdev/xics/xics-common.c |  3 ---
>  13 files changed, 118 insertions(+), 90 deletions(-)
> 
