Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PYKJ1d1XzDr4C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 04:10:28 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w69I8cjQ058578
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2018 14:10:25 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k48jgge36-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jul 2018 14:10:24 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 9 Jul 2018 12:10:23 -0600
Subject: Re: [next-20180709][bisected 9cf57731][ppc] build fail with ld: BFD
 version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-next
 <linux-next@vger.kernel.org>, stephen Rothwell <sfr@canb.auug.org.au>, mpe
 <mpe@ellerman.id.au>, sachinp <sachinp@linux.vnet.ibm.com>, Ingo Molnar
 <mingo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Mon, 09 Jul 2018 23:40:14 +0530
In-Reply-To: <20180709114716.GN2476@hirez.programming.kicks-ass.net>
References: <1531129883.6480.7.camel@abdul.in.ibm.com>
 <20180709114716.GN2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1531159814.6480.11.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-09 at 13:47 +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 03:21:23PM +0530, Abdul Haleem wrote:
> > Greeting's
> > 
> > Today's next fails to build on powerpc with below error
> > 
> > kernel/cpu.o:(.data.rel+0x18e0): undefined reference to
> > `lockup_detector_online_cpu'
> > ld: BFD version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
> > kernel/cpu.o:(.data.rel+0x18e8): undefined reference to
> > `lockup_detector_offline_cpu'
> > ld: BFD version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
> > Makefile:1005: recipe for target 'vmlinux' failed
> > make: *** [vmlinux] Error 1
> 
> Urgh, sorry about that. I think the below should cure that.
> 
> I got confused by all the varioud CONFIG options here abour and
> conflated CONFIG_LOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR it
> seems.
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 80664bbeca43..08f9247e9827 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -33,15 +33,10 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
>  #define sysctl_hardlockup_all_cpu_backtrace 0
>  #endif /* !CONFIG_SMP */
> 
> -extern int lockup_detector_online_cpu(unsigned int cpu);
> -extern int lockup_detector_offline_cpu(unsigned int cpu);
> -
>  #else /* CONFIG_LOCKUP_DETECTOR */
>  static inline void lockup_detector_init(void) { }
>  static inline void lockup_detector_soft_poweroff(void) { }
>  static inline void lockup_detector_cleanup(void) { }
> -#define lockup_detector_online_cpu	NULL
> -#define lockup_detector_offline_cpu	NULL
>  #endif /* !CONFIG_LOCKUP_DETECTOR */
> 
>  #ifdef CONFIG_SOFTLOCKUP_DETECTOR
> @@ -50,12 +45,18 @@ extern void touch_softlockup_watchdog(void);
>  extern void touch_softlockup_watchdog_sync(void);
>  extern void touch_all_softlockup_watchdogs(void);
>  extern unsigned int  softlockup_panic;
> -#else
> +
> +extern int lockup_detector_online_cpu(unsigned int cpu);
> +extern int lockup_detector_offline_cpu(unsigned int cpu);
> +#else /* CONFIG_SOFTLOCKUP_DETECTOR */
>  static inline void touch_softlockup_watchdog_sched(void) { }
>  static inline void touch_softlockup_watchdog(void) { }
>  static inline void touch_softlockup_watchdog_sync(void) { }
>  static inline void touch_all_softlockup_watchdogs(void) { }
> -#endif
> +
> +#define lockup_detector_online_cpu	NULL
> +#define lockup_detector_offline_cpu	NULL
> +#endif /* CONFIG_SOFTLOCKUP_DETECTOR */
> 
>  #ifdef CONFIG_DETECT_HUNG_TASK
>  void reset_hung_task_detector(void);
> 

Thanks Peter for the patch, build and boot is fine.

Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
