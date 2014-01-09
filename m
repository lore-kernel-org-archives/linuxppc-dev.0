Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 618952C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 19:12:49 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Thu, 9 Jan 2014 18:12:48 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EE35C3578023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 19:12:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s098CQ9t10486220
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jan 2014 19:12:29 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s098Cc4F013923
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jan 2014 19:12:39 +1100
Message-ID: <52CE58CC.8040604@linux.vnet.ibm.com>
Date: Thu, 09 Jan 2014 13:37:40 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] pseries/cpuidle: Remove redundant call to
 ppc64_runlatch_off() in cpu idle routines
References: <20140109050519.11532.6044.stgit@preeti.in.ibm.com>
In-Reply-To: <20140109050519.11532.6044.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, deepthi@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2014 10:35 AM, Preeti U Murthy wrote:
> Commit fbd7740fdfdf9475f switched pseries cpu idle handling from complete idle
> loops to ppc_md.powersave functions. Earlier to this switch,
> ppc64_runlatch_off() had to be called in each of the idle routines. But after
> the switch this call is handled in arch_cpu_idle(),just before the call
> to ppc_md.powersave, where platform specific idle routines are called.
> 
> As a consequence, the call to ppc64_runlatch_off() got duplicated in the
> arch_cpu_idle() routine as well as in the some of the idle routines in
> pseries and commit fbd7740fdfdf9475f missed to get rid of these redundant
> calls. These calls were carried over subsequent enhancements to the pseries
> cpuidle routines. This patch takes care of eliminating this redundancy.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> 
>  arch/powerpc/platforms/pseries/processor_idle.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
> index a166e38..09e4f56 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -17,7 +17,6 @@
>  #include <asm/reg.h>
>  #include <asm/machdep.h>
>  #include <asm/firmware.h>
> -#include <asm/runlatch.h>
>  #include <asm/plpar_wrappers.h>
> 
>  struct cpuidle_driver pseries_idle_driver = {
> @@ -63,7 +62,6 @@ static int snooze_loop(struct cpuidle_device *dev,
>  	set_thread_flag(TIF_POLLING_NRFLAG);
> 
>  	while ((!need_resched()) && cpu_online(cpu)) {
> -		ppc64_runlatch_off();
>  		HMT_low();
>  		HMT_very_low();
>  	}
> @@ -103,7 +101,6 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
>  	idle_loop_prolog(&in_purr);
>  	get_lppaca()->donate_dedicated_cpu = 1;
> 
> -	ppc64_runlatch_off();
>  	HMT_medium();
>  	check_and_cede_processor();
> 
> 
