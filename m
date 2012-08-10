Return-Path: <zch@tx30smr01.freescale.net>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2285A2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 19:39:51 +1000 (EST)
Received: from mail48-am1 (localhost [127.0.0.1])	by mail48-am1-R.bigfish.com
 (Postfix) with ESMTP id 1C7523400A2	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 10 Aug 2012 09:39:45 +0000 (UTC)
Received: from AM1EHSMHS005.bigfish.com (unknown [10.3.201.225])	by
 mail48-am1.bigfish.com (Postfix) with ESMTP id EA6A7140044	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 09:39:41 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q7A9dcbc007784	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 02:39:39 -0700
Date: Fri, 10 Aug 2012 17:41:41 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/4] cpu: export cpu hotplug disable/enable functions as
 global functions
Message-ID: <20120810094141.GA17891@localhost.localdomain>
References: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
 <1344329006-10645-3-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1344329006-10645-3-git-send-email-chenhui.zhao@freescale.com>
Sender: <zch@tx30smr01.freescale.net>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2012 at 04:43:25PM +0800, Zhao Chenhui wrote:
> The cpufreq driver of mpc85xx will disable/enable cpu hotplug temporarily.
> Therefore, the related functions should be exported.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
>  include/linux/cpu.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index ce7a074..df8f73d 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -146,6 +146,8 @@ void notify_cpu_starting(unsigned int cpu);
>  extern void cpu_maps_update_begin(void);
>  extern void cpu_maps_update_done(void);
>  
> +extern void cpu_hotplug_disable_before_freeze(void);
> +extern void cpu_hotplug_enable_after_thaw(void);
>  #else	/* CONFIG_SMP */
>  
>  #define cpu_notifier(fn, pri)	do { (void)(fn); } while (0)
> @@ -167,6 +169,8 @@ static inline void cpu_maps_update_done(void)
>  {
>  }
>  
> +static inline void cpu_hotplug_disable_before_freeze(void)	{}
> +static inline void cpu_hotplug_enable_after_thaw(void)	{}
>  #endif /* CONFIG_SMP */
>  extern struct bus_type cpu_subsys;
>  
> -- 
> 1.6.4.1
> 

Hi kumar,

I will not use these API in the 4/4 patch. please ignore this patch.

-Chenhui
