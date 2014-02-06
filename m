Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 951372C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 03:03:37 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 7 Feb 2014 02:03:35 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DBD792CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 03:03:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s16FiBth38797530
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 02:44:11 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s16G3VnE018895
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 03:03:32 +1100
Message-ID: <52F3B17E.4040209@linux.vnet.ibm.com>
Date: Thu, 06 Feb 2014 21:29:58 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 2/2] ARM64: powernv: remove redundant cpuidle_idle_call()
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicolas,

powernv in the subject of the patch?

Regards
Preeti U Murthy
On 02/06/2014 07:46 PM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm64/kernel/process.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1c0a9be2ff..9cce0098f4 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -33,7 +33,6 @@
>  #include <linux/kallsyms.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
> -#include <linux/cpuidle.h>
>  #include <linux/elfcore.h>
>  #include <linux/pm.h>
>  #include <linux/tick.h>
> @@ -94,10 +93,8 @@ void arch_cpu_idle(void)
>  	 * This should do all the clock switching and wait for interrupt
>  	 * tricks
>  	 */
> -	if (cpuidle_idle_call()) {
> -		cpu_do_idle();
> -		local_irq_enable();
> -	}
> +	cpu_do_idle();
> +	local_irq_enable();
>  }
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> 
