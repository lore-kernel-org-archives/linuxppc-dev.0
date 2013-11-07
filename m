Return-Path: <will.deacon@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id A36612C008E
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Nov 2013 22:18:09 +1100 (EST)
Date: Thu, 7 Nov 2013 11:17:41 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
Message-ID: <20131107111741.GD13139@mudshark.cambridge.arm.com>
References: <20131103224242.GF3947@linux.vnet.ibm.com>
 <CA+55aFyD_kCkAHQwHCUBrumO-pH6LaZikTNvyWDW_tWsHdqk6Q@mail.gmail.com>
 <20131104105059.GL3947@linux.vnet.ibm.com>
 <20131104112254.GK28601@twins.programming.kicks-ass.net>
 <20131104162732.GN3947@linux.vnet.ibm.com>
 <20131104191127.GW16117@laptop.programming.kicks-ass.net>
 <20131104205344.GW3947@linux.vnet.ibm.com>
 <20131106123946.GJ10651@twins.programming.kicks-ass.net>
 <CAMuHMdXZjQJvT7R4ODbDNBgAVwPUBPjB6UoR66_sNuFx7opUDw@mail.gmail.com>
 <20131106135736.GK10651@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131106135736.GK10651@twins.programming.kicks-ass.net>
Cc: Michael Neuling <mikey@neuling.org>, Tony Luck <tony.luck@intel.com>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>, Russell King <linux@arm.linux.org.uk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

Couple of minor fixes on the arm64 side...

On Wed, Nov 06, 2013 at 01:57:36PM +0000, Peter Zijlstra wrote:
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -35,11 +35,59 @@
>  #define smp_mb()       barrier()
>  #define smp_rmb()      barrier()
>  #define smp_wmb()      barrier()
> +
> +#define smp_store_release(p, v)                                                \
> +do {                                                                   \
> +       compiletime_assert_atomic_type(*p);                             \
> +       smp_mb();                                                       \
> +       ACCESS_ONCE(*p) = (v);                                          \
> +} while (0)
> +
> +#define smp_load_acquire(p)                                            \
> +({                                                                     \
> +       typeof(*p) ___p1 = ACCESS_ONCE(*p);                             \
> +       compiletime_assert_atomic_type(*p);                             \
> +       smp_mb();                                                       \
> +       ___p1;                                                          \
> +})
> +
>  #else
> +
>  #define smp_mb()       asm volatile("dmb ish" : : : "memory")
>  #define smp_rmb()      asm volatile("dmb ishld" : : : "memory")
>  #define smp_wmb()      asm volatile("dmb ishst" : : : "memory")
> -#endif

Why are you getting rid of this #endif?

> +#define smp_store_release(p, v)                                                \
> +do {                                                                   \
> +       compiletime_assert_atomic_type(*p);                             \
> +       switch (sizeof(*p)) {                                           \
> +       case 4:                                                         \
> +               asm volatile ("stlr %w1, [%0]"                          \
> +                               : "=Q" (*p) : "r" (v) : "memory");      \
> +               break;                                                  \
> +       case 8:                                                         \
> +               asm volatile ("stlr %1, [%0]"                           \
> +                               : "=Q" (*p) : "r" (v) : "memory");      \
> +               break;                                                  \
> +       }                                                               \
> +} while (0)
> +
> +#define smp_load_acquire(p)                                            \
> +({                                                                     \
> +       typeof(*p) ___p1;                                               \
> +       compiletime_assert_atomic_type(*p);                             \
> +       switch (sizeof(*p)) {                                           \
> +       case 4:                                                         \
> +               asm volatile ("ldar %w0, [%1]"                          \
> +                       : "=r" (___p1) : "Q" (*p) : "memory");          \
> +               break;                                                  \
> +       case 8:                                                         \
> +               asm volatile ("ldar %0, [%1]"                           \
> +                       : "=r" (___p1) : "Q" (*p) : "memory");          \
> +               break;                                                  \
> +       }                                                               \
> +       ___p1;                                                          \
> +})

You don't need the square brackets when using the "Q" constraint (otherwise
it will expand to something like [[x0]], which gas won't accept).

With those changes, for the general idea and arm/arm64 parts:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
