Return-Path: <josh@joshtriplett.org>
Received: from slow1-d.mail.gandi.net (slow1-d.mail.gandi.net [217.70.178.86])
 by lists.ozlabs.org (Postfix) with ESMTP id 3w6QkL61G1zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 10:19:54 +1000 (AEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 by slow1-d.mail.gandi.net (Postfix) with ESMTP id CE6D847A9F3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 02:19:52 +0200 (CEST)
Date: Mon, 17 Apr 2017 17:19:27 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org,
 mathieu.desnoyers@efficios.com, tglx@linutronix.de,
 peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com,
 edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
 bobby.prani@gmail.com, Will Deacon <will.deacon@arm.com>,
 Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 tip/core/rcu 02/39] rcu: Make arch select
 smp_mb__after_unlock_lock() strength
Message-ID: <20170418001927.vsuf7m34hypytnqr@x>
References: <20170417234452.GB19013@linux.vnet.ibm.com>
 <1492472726-3841-2-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492472726-3841-2-git-send-email-paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 17, 2017 at 04:44:49PM -0700, Paul E. McKenney wrote:
> The definition of smp_mb__after_unlock_lock() is currently smp_mb()
> for CONFIG_PPC and a no-op otherwise.  It would be better to instead
> provide an architecture-selectable Kconfig option, and select the
> strength of smp_mb__after_unlock_lock() based on that option.  This
> commit therefore creates ARCH_WEAK_RELEASE_ACQUIRE, has PPC select it,
> and bases the definition of smp_mb__after_unlock_lock() on this new
> ARCH_WEAK_RELEASE_ACQUIRE Kconfig option.
> 
> Reported-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: <linuxppc-dev@lists.ozlabs.org>

Seems sensible.

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  arch/Kconfig             | 3 +++
>  arch/powerpc/Kconfig     | 1 +
>  include/linux/rcupdate.h | 6 +++---
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index cd211a14a88f..adefaf344239 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -320,6 +320,9 @@ config HAVE_CMPXCHG_LOCAL
>  config HAVE_CMPXCHG_DOUBLE
>  	bool
>  
> +config ARCH_WEAK_RELEASE_ACQUIRE
> +	bool
> +
>  config ARCH_WANT_IPC_PARSE_VERSION
>  	bool
>  
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 97a8bc8a095c..7a5c9b764cd2 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -99,6 +99,7 @@ config PPC
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
>  	select ARCH_WANT_IPC_PARSE_VERSION
> +	select ARCH_WEAK_RELEASE_ACQUIRE
>  	select BINFMT_ELF
>  	select BUILDTIME_EXTABLE_SORT
>  	select CLONE_BACKWARDS
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index de88b33c0974..e6146d0074f8 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1127,11 +1127,11 @@ do { \
>   * if the UNLOCK and LOCK are executed by the same CPU or if the
>   * UNLOCK and LOCK operate on the same lock variable.
>   */
> -#ifdef CONFIG_PPC
> +#ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE
>  #define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
> -#else /* #ifdef CONFIG_PPC */
> +#else /* #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
>  #define smp_mb__after_unlock_lock()	do { } while (0)
> -#endif /* #else #ifdef CONFIG_PPC */
> +#endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
>  
>  
>  #endif /* __LINUX_RCUPDATE_H */
> -- 
> 2.5.2
> 
