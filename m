Return-Path: <dzickus@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq3FY1z4hzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 00:50:25 +1000 (AEST)
Date: Fri, 16 Jun 2017 10:50:22 -0400
From: Don Zickus <dzickus@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Babu Moger <babu.moger@oracle.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 0/5] Improve watchdog config for arch watchdogs
Message-ID: <20170616145022.6vl452dpwgpw5q4f@redhat.com>
References: <20170616065715.18390-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170616065715.18390-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(adding Andrew)

On Fri, Jun 16, 2017 at 04:57:10PM +1000, Nicholas Piggin wrote:
> This is the latest series to make the hardlockup watchdog more
> easily replaceable by arch code. The last patch provides some
> justification for why we want to do this (existing sparc watchdog
> is another that could benefit).
> 
> Since last time, we tidied up the Kconfig approach so it was not
> so jumbled -- Thanks Don and Babu for help and suggestions there.

Thanks Nick!  I think this version is good enough for now.

> 
> Since last posting the powerpc patch, I re-added the soft-NMI
> watchdog, but have it using the emergency stack so we can always
> avoid the process stacks when perf interrupts are soft-masked.
> 
> I'm not sure of the best strategy to merge this. The powerpc
> watchdog is too much to carry anywhere but powerpc tree now, and
> watchdog patches seem to go via Andrew...

Andrew, suggestions here?


Reviewed-by: Don Zickus <dzickus@redhat.com>
Acked-by: Don Zickus <dzickus@redhat.com>


> 
> Thanks,
> Nick
> 
> Nicholas Piggin (5):
>   watchdog: remove unused declaration
>   watchdog: introduce arch_touch_nmi_watchdog()
>   watchdog: split up config options
>   watchdog: provide watchdog_reconfigure() for arch watchdogs
>   powerpc/64s: implement arch-specific hardlockup watchdog
> 
>  arch/Kconfig                               |  23 ++
>  arch/blackfin/include/asm/nmi.h            |   2 +
>  arch/blackfin/kernel/nmi.c                 |   2 +-
>  arch/mn10300/include/asm/nmi.h             |   2 +
>  arch/mn10300/kernel/mn10300-watchdog-low.S |   8 +-
>  arch/mn10300/kernel/mn10300-watchdog.c     |   2 +-
>  arch/powerpc/Kconfig                       |   6 +-
>  arch/powerpc/include/asm/nmi.h             |  11 +
>  arch/powerpc/include/asm/smp.h             |   2 +
>  arch/powerpc/kernel/Makefile               |   1 +
>  arch/powerpc/kernel/exceptions-64s.S       |  30 ++-
>  arch/powerpc/kernel/kvm.c                  |   7 +
>  arch/powerpc/kernel/setup_64.c             |  19 --
>  arch/powerpc/kernel/smp.c                  |  20 +-
>  arch/powerpc/kernel/watchdog.c             | 388 +++++++++++++++++++++++++++++
>  arch/sparc/include/asm/nmi.h               |   1 +
>  arch/sparc/kernel/nmi.c                    |   6 +-
>  arch/x86/Kconfig                           |   1 +
>  arch/x86/kernel/apic/hw_nmi.c              |   2 +-
>  include/linux/nmi.h                        |  57 +++--
>  kernel/Makefile                            |   2 +-
>  kernel/sysctl.c                            |  31 ++-
>  kernel/watchdog.c                          | 268 +++++++++++++-------
>  kernel/watchdog_hld.c                      |  37 +--
>  lib/Kconfig.debug                          |  45 ++--
>  25 files changed, 763 insertions(+), 210 deletions(-)
>  create mode 100644 arch/powerpc/kernel/watchdog.c
> 
> -- 
> 2.11.0
> 
