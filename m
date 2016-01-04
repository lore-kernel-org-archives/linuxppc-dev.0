Return-Path: <yang.shi@linaro.org>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6EFB1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2016 09:19:26 +1100 (AEDT)
Received: by mail-pf0-x232.google.com with SMTP id 65so163594122pff.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jan 2016 14:19:26 -0800 (PST)
Subject: Re: [PATCH] ppc64: select HAVE_CONTEXT_TRACKING by default
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1449701034-5444-1-git-send-email-yang.shi@linaro.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linaro-kernel@lists.linaro.org
From: "Shi, Yang" <yang.shi@linaro.org>
Message-ID: <568AEFEA.4080400@linaro.org>
Date: Mon, 4 Jan 2016 14:19:22 -0800
MIME-Version: 1.0
In-Reply-To: <1449701034-5444-1-git-send-email-yang.shi@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks,

Any comment on this is appreciated.

Thanks,
Yang


On 12/9/2015 2:43 PM, Yang Shi wrote:
> The functionality of context tracking has been implemented by PPC64 and
> HAVE_CONTEXT_TRACKING was selected by pseries by default.
> Actually, it is applicale to all PPC64 platforms, so select it in PPC64
> generic Kconfig.
>
> NO_HZ_FULL depends on it, with this change NO_HZ_FULL could be enabled
> for all PPC64 machines.
>
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
> Following the instruction in Documentation/timers/NO_HZ.txt, I tested full nohz
> on my FSL T2080 target, the below trace log shows it works well.
>
>         user_loop-574   [001] d..1   137.044892: tick_stop: success=yes msg=
>         user_loop-574   [001] d.h1   138.044880: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=137796002092
>         user_loop-574   [001] d.h1   139.044880: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=138796002129
>         user_loop-574   [001] d.h1   140.044880: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=139796002219
>         user_loop-574   [001] d.h1   141.044880: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=140796002229
>         user_loop-574   [001] d.h1   142.044879: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=141796002159
>         user_loop-574   [001] d.h1   143.044879: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=142796002142
>         user_loop-574   [001] d.h1   144.044878: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=143796002046
>         user_loop-574   [001] d.h1   145.044878: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=144796002189
>         user_loop-574   [001] d.h1   146.044878: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=145796002199
>         user_loop-574   [001] d.h1   147.044880: hrtimer_expire_entry: hrtimer=c00000007fd22d10 function=.tick_sched_timer now=146796003836
>
> It shows the timer tick just comes in every second.
>
> It should be low risk to have problem on other PPC64 targets, although they are
> not tested.
>
>   arch/powerpc/platforms/Kconfig.cputype | 1 +
>   arch/powerpc/platforms/pseries/Kconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 142dff5..7b25dd1 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -3,6 +3,7 @@ config PPC64
>   	default n
>   	select HAVE_VIRT_CPU_ACCOUNTING
>   	select ZLIB_DEFLATE
> +	select HAVE_CONTEXT_TRACKING
>   	help
>   	  This option selects whether a 32-bit or a 64-bit kernel
>   	  will be built.
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index bec90fb..6853148 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -17,7 +17,6 @@ config PPC_PSERIES
>   	select PPC_UDBG_16550
>   	select PPC_NATIVE
>   	select PPC_DOORBELL
> -	select HAVE_CONTEXT_TRACKING
>   	select HOTPLUG_CPU if SMP
>   	select ARCH_RANDOM
>   	select PPC_DOORBELL
>
