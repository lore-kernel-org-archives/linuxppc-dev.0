Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E82A42C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jan 2014 16:41:13 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 2 Jan 2014 15:40:59 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E84B42CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jan 2014 16:40:55 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s025MHKn44892386
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jan 2014 16:22:17 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s025etBv001384
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jan 2014 16:40:55 +1100
Message-ID: <52C4FBF3.1060605@linux.vnet.ibm.com>
Date: Thu, 02 Jan 2014 11:11:07 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 2/9] POWERPC: pseries: cpuidle: remove superfluous
 dev->state_count initialization
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
 <1387565251-7051-3-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1387565251-7051-3-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 kyungmin.park@samsung.com, linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/21/2013 12:17 AM, Bartlomiej Zolnierkiewicz wrote:
> pseries cpuidle driver sets dev->state_count to drv->state_count so
> the default dev->state_count initialization in cpuidle_enable_device()
> (called from cpuidle_register_device()) can be used instead.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

> Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/processor_idle.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
> index a166e38..8aa8c40 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -271,7 +271,6 @@ static void pseries_idle_devices_uninit(void)
>  static int pseries_idle_devices_init(void)
>  {
>  	int i;
> -	struct cpuidle_driver *drv = &pseries_idle_driver;
>  	struct cpuidle_device *dev;
> 
>  	pseries_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> @@ -280,7 +279,6 @@ static int pseries_idle_devices_init(void)
> 
>  	for_each_possible_cpu(i) {
>  		dev = per_cpu_ptr(pseries_cpuidle_devices, i);
> -		dev->state_count = drv->state_count;
>  		dev->cpu = i;
>  		if (cpuidle_register_device(dev)) {
>  			printk(KERN_DEBUG \
> 
