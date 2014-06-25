Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B7581A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 17:31:08 +1000 (EST)
Date: Wed, 25 Jun 2014 09:14:16 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] sched: Fix compiler warnings
Message-ID: <20140625071416.GM14781@pengutronix.de>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
Cc: Russell King <linux@arm.linux.org.uk>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 06:05:29PM -0700, Guenter Roeck wrote:
> Commit 143e1e28cb (sched: Rework sched_domain topology definition)
> introduced a number of functions with a return value of 'const int'.
> gcc doesn't know what to do with that and, if the kernel is compiled
> with W=1, complains with the following warnings whenever sched.h
> is included.
> 
> include/linux/sched.h:875:25: warning:
> 	type qualifiers ignored on function return type
> include/linux/sched.h:882:25: warning:
> 	type qualifiers ignored on function return type
> include/linux/sched.h:889:25: warning:
> 	type qualifiers ignored on function return type
> include/linux/sched.h:1002:21: warning:
> 	type qualifiers ignored on function return type
> 
> Commits fb2aa855 (sched, ARM: Create a dedicated scheduler topology table)
> and 607b45e9a (sched, powerpc: Create a dedicated topology table) introduce
> the same warning in the arm and powerpc code.
> 
> Drop 'const' from the function declarations to fix the problem.
> 
> The fix for all three patches has to be applied together to avoid
> compilation failures for the affected architectures.
> 
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Fix problem in all affected architectures with a single patch
>     to avoid compilation errors.
> 
>  arch/arm/kernel/topology.c | 2 +-
>  arch/powerpc/kernel/smp.c  | 2 +-
>  include/linux/sched.h      | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 9d85318..e35d880 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -275,7 +275,7 @@ void store_cpu_topology(unsigned int cpuid)
>  		cpu_topology[cpuid].socket_id, mpidr);
>  }
>  
> -static inline const int cpu_corepower_flags(void)
> +static inline int cpu_corepower_flags(void)
>  {
>  	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
>  }
Maybe the author's intention was:

	static inline int cpu_corepower_flags(void) __attribute__((const));

?
This specifies that the function has no side effects and the return value
only depends on the (here non-existing) function arguments.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
