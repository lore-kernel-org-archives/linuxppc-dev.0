Return-Path: <ddaney.cavm@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6710B7000
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2012 02:59:14 +1000 (EST)
Received: by dajt11 with SMTP id t11so3465696daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2012 09:59:12 -0700 (PDT)
Message-ID: <4FC8F4DB.2070906@gmail.com>
Date: Fri, 01 Jun 2012 09:59:07 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/27] smpboot: Define and use cpu_state per-cpu variable
 in generic code
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
 <20120601091038.31979.67878.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601091038.31979.67878.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Venkatesh Pallipadi <venki@google.com>,
 Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, mingo@kernel.org, linux-arch@vger.kernel.org,
 xen-devel@lists.xensource.com, Suresh Siddha <suresh.b.siddha@intel.com>,
 linux-sh@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 paulmck@linux.vnet.ibm.com, Fenghua Yu <fenghua.yu@intel.com>,
 Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 nikunj@linux.vnet.ibm.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 rusty@rustcorp.com.au, Chris Metcalf <cmetcalf@tilera.com>, rjw@sisk.pl,
 yong.zhang0@gmail.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 vatsa@linux.vnet.ibm.com, Ralf Baechle <ralf@linux-mips.org>,
 Paul Mundt <lethal@linux-sh.org>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2012 02:10 AM, Srivatsa S. Bhat wrote:
> The per-cpu variable cpu_state is used in x86 and also used in other
> architectures, to track the state of the cpu during bringup and hotplug.
> Pull it out into generic code.
>
> Cc: Tony Luck<tony.luck@intel.com>
> Cc: Fenghua Yu<fenghua.yu@intel.com>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Paul Mundt<lethal@linux-sh.org>
> Cc: Chris Metcalf<cmetcalf@tilera.com>
> Cc: Thomas Gleixner<tglx@linutronix.de>
> Cc: Ingo Molnar<mingo@redhat.com>
> Cc: "H. Peter Anvin"<hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Konrad Rzeszutek Wilk<konrad.wilk@oracle.com>
> Cc: Jeremy Fitzhardinge<jeremy@goop.org>
> Cc: Peter Zijlstra<a.p.zijlstra@chello.nl>
> Cc: Andrew Morton<akpm@linux-foundation.org>
> Cc: Mike Frysinger<vapier@gentoo.org>
> Cc: Yong Zhang<yong.zhang0@gmail.com>
> Cc: Venkatesh Pallipadi<venki@google.com>
> Cc: Suresh Siddha<suresh.b.siddha@intel.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: xen-devel@lists.xensource.com
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Srivatsa S. Bhat<srivatsa.bhat@linux.vnet.ibm.com>
> ---
>
>   arch/ia64/include/asm/cpu.h   |    2 --
>   arch/ia64/kernel/process.c    |    1 +
>   arch/ia64/kernel/smpboot.c    |    6 +-----
>   arch/mips/cavium-octeon/smp.c |    4 +---
>   arch/powerpc/kernel/smp.c     |    6 +-----
>   arch/sh/include/asm/smp.h     |    2 --
>   arch/sh/kernel/smp.c          |    4 +---
>   arch/tile/kernel/smpboot.c    |    4 +---
>   arch/x86/include/asm/cpu.h    |    2 --
>   arch/x86/kernel/smpboot.c     |    4 +---
>   arch/x86/xen/smp.c            |    1 +
>   include/linux/smpboot.h       |    1 +
>   kernel/smpboot.c              |    4 ++++
>   13 files changed, 13 insertions(+), 28 deletions(-)
>
[...]
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 97e7ce9..93cd4b0 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -13,6 +13,7 @@
>   #include<linux/kernel_stat.h>
>   #include<linux/sched.h>
>   #include<linux/module.h>
> +#include<linux/smpboot.h>
>
>   #include<asm/mmu_context.h>
>   #include<asm/time.h>
> @@ -252,9 +253,6 @@ static void octeon_cpus_done(void)
>
>   #ifdef CONFIG_HOTPLUG_CPU
>
> -/* State of each CPU. */
> -DEFINE_PER_CPU(int, cpu_state);
> -
>   extern void fixup_irqs(void);
>
>   static DEFINE_SPINLOCK(smp_reserve_lock);

The Octeon bit:

Acked-by: David Daney <david.daney@cavium.com>


FWIW, the rest looks good too.
