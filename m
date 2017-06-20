Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsJgR6yk9zDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 17:02:11 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K6xaE8096744
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 03:02:09 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b6hbhy9ds-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 03:02:09 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 17:02:06 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K724BT53739652
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 17:02:04 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K71tTj026438
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 17:01:55 +1000
Date: Tue, 20 Jun 2017 12:32:00 +0530
From: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Santosh Sivaraj <santosh@fossix.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/time: Fix tracing in time.c
References: <20170620062045.1347-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170620062045.1347-1-santosh@fossix.org>
Message-Id: <20170620070200.d53qywt6fce6b6e5@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/20 11:50AM, Santosh Sivaraj wrote:
> Since trace_clock is in a different file and already marked with notrace,
> enable tracing in time.c by removing it from the disabled list in Makefile.
> Also annotate clocksource read functions and sched_clock with notrace.
> 
> Testing: Timer and ftrace selftests run with different trace clocks.
> 
> CC: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

Thanks for doing this! Apart from the minor nit below:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/Makefile | 2 --
>  arch/powerpc/kernel/time.c   | 6 +++---
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index e132902..0845eeb 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -25,8 +25,6 @@ CFLAGS_REMOVE_cputable.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_prom_init.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_btext.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_prom.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
> -# timers used by tracing
> -CFLAGS_REMOVE_time.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
>  endif
> 
>  obj-y				:= cputable.o ptrace.o syscalls.o \
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 2b33cfa..6d10c5f 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -675,7 +675,7 @@ EXPORT_SYMBOL_GPL(tb_to_ns);
>   * the high 64 bits of a * b, i.e. (a * b) >> 64, where a and b
>   * are 64-bit unsigned numbers.
>   */
> -unsigned long long sched_clock(void)
> +unsigned long long notrace sched_clock(void)

For the sake of consistency, it's probably better to add the notrace 
annotation before the return values, though I see that the prototype in 
include/sched.h has used this order.

- Naveen

>  {
>  	if (__USE_RTC())
>  		return get_rtc();
> @@ -823,12 +823,12 @@ void read_persistent_clock(struct timespec *ts)
>  }
> 
>  /* clocksource code */
> -static u64 rtc_read(struct clocksource *cs)
> +static notrace u64 rtc_read(struct clocksource *cs)
>  {
>  	return (u64)get_rtc();
>  }
> 
> -static u64 timebase_read(struct clocksource *cs)
> +static notrace u64 timebase_read(struct clocksource *cs)
>  {
>  	return (u64)get_tb();
>  }
> -- 
> 2.9.4
> 
