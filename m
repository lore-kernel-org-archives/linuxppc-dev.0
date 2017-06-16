Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq7ww3fQfzDq98
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 04:21:20 +1000 (AEST)
Date: Fri, 16 Jun 2017 11:21:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>, Babu Moger <babu.moger@oracle.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/5] watchdog: introduce arch_touch_nmi_watchdog()
Message-Id: <20170616112117.a33b1096985a786777bc8b54@linux-foundation.org>
In-Reply-To: <20170616065715.18390-3-npiggin@gmail.com>
References: <20170616065715.18390-1-npiggin@gmail.com>
 <20170616065715.18390-3-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Jun 2017 16:57:12 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> For architectures that define HAVE_NMI_WATCHDOG, instead of having
> them provide the complete touch_nmi_watchdog() function, just have
> them provide arch_touch_nmi_watchdog().
> 
> This gives the generic code more flexibility in implementing this
> function, and arch implementations don't miss out on touching the
> softlockup watchdog or other generic details.
> 
> ...
>
> --- a/arch/blackfin/include/asm/nmi.h
> +++ b/arch/blackfin/include/asm/nmi.h
> @@ -9,4 +9,6 @@
>  
>  #include <linux/nmi.h>
>  
> +extern void arch_touch_nmi_watchdog(void);

Do we actually need to add this to the arch header files...

>
> ...
>
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -6,6 +6,9 @@
>  
>  #include <linux/sched.h>
>  #include <asm/irq.h>
> +#if defined(CONFIG_HAVE_NMI_WATCHDOG)
> +#include <asm/nmi.h>
> +#endif
>  
>  #ifdef CONFIG_LOCKUP_DETECTOR
>  extern void touch_softlockup_watchdog_sched(void);
> @@ -58,6 +61,18 @@ static inline void reset_hung_task_detector(void)
>  #define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
>  #define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
>  
> +#if defined(CONFIG_HARDLOCKUP_DETECTOR)
> +extern void hardlockup_detector_disable(void);
> +#else
> +static inline void hardlockup_detector_disable(void) {}
> +#endif
> +
> +#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
> +extern void arch_touch_nmi_watchdog(void);
> +#else
> +static inline void arch_touch_nmi_watchdog(void) {}
> +#endif
> +

given that we have a global declaration here?
