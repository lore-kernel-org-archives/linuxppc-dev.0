Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A2C6D2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 22:21:24 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 14 Feb 2014 21:21:20 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C9E5A3578054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 22:21:15 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1EB1inE59048004
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 22:01:45 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1EBLDvV018314
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 22:21:14 +1100
Message-ID: <52FDFB4C.7010607@linux.vnet.ibm.com>
Date: Fri, 14 Feb 2014 16:47:32 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
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

You will have to include the below patch with yours. You
could squash the two I guess, I have added the changelog
just for clarity. And you also might want to change the subject to
cpuidle/powernv. It gives a better picture.

Thanks

Regards
Preeti U Murthy


cpuidle/powernv: Add ppc64_runlatch_off/on() to idle routines

Following moving of cpuidle_idle_call() to the generic idle loop, we need to
add the runlatch functions to the idle routines on powernv which was earlier
taken care of by the arch specific idle routine.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 78fd174..f48607c 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -14,6 +14,7 @@
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
+#include <asm/runlatch.h>
 
 struct cpuidle_driver powernv_idle_driver = {
 	.name             = "powernv_idle",
@@ -30,12 +31,14 @@ static int snooze_loop(struct cpuidle_device *dev,
 	local_irq_enable();
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
+	ppc64_runlatch_off();
 	while (!need_resched()) {
 		HMT_low();
 		HMT_very_low();
 	}
 
 	HMT_medium();
+	ppc64_runlatch_on();
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 	smp_mb();
 	return index;
@@ -45,7 +48,9 @@ static int nap_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
+	ppc64_runlatch_off();
 	power7_idle();
+	ppc64_runlatch_on();
 	return index;
 }

 
On 02/06/2014 07:46 PM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/powerpc/platforms/powernv/setup.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 21166f65c9..a932feb290 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -26,7 +26,6 @@
>  #include <linux/of_fdt.h>
>  #include <linux/interrupt.h>
>  #include <linux/bug.h>
> -#include <linux/cpuidle.h>
> 
>  #include <asm/machdep.h>
>  #include <asm/firmware.h>
> @@ -217,16 +216,6 @@ static int __init pnv_probe(void)
>  	return 1;
>  }
> 
> -void powernv_idle(void)
> -{
> -	/* Hook to cpuidle framework if available, else
> -	 * call on default platform idle code
> -	 */
> -	if (cpuidle_idle_call()) {
> -		power7_idle();
> -	}
> -}
> -
>  define_machine(powernv) {
>  	.name			= "PowerNV",
>  	.probe			= pnv_probe,
> @@ -236,7 +225,7 @@ define_machine(powernv) {
>  	.show_cpuinfo		= pnv_show_cpuinfo,
>  	.progress		= pnv_progress,
>  	.machine_shutdown	= pnv_shutdown,
> -	.power_save             = powernv_idle,
> +	.power_save             = power7_idle,
>  	.calibrate_decr		= generic_calibrate_decr,
>  #ifdef CONFIG_KEXEC
>  	.kexec_cpu_down		= pnv_kexec_cpu_down,
> 
