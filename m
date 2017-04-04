Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxwQN6MDkzDqLf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 14:06:36 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3443dkl125212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:06:31 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ktf6f3na-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 00:06:30 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 09:36:27 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3446Pie21102694
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 09:36:25 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3446OVp022131
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 09:36:25 +0530
Date: Tue, 4 Apr 2017 09:36:22 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] cpuidle: powernv: Don't continually set thread
 priority in snooze_loop()
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170403215414.16951-1-anton@ozlabs.org>
 <20170403215414.16951-2-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170403215414.16951-2-anton@ozlabs.org>
Message-Id: <20170404040622.GC21029@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Anton Blanchard <anton@ozlabs.org> [2017-04-04 07:54:13]:

> From: Anton Blanchard <anton@samba.org>
> 
> The powerpc64 kernel exception handlers have preserved thread priorities
> for a long time now, so there is no need to continually set it.
> 
> Just set it once on entry and once exit.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

> ---
>  drivers/cpuidle/cpuidle-powernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 9d9f164894eb..8c991c254b95 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -56,8 +56,8 @@ static int snooze_loop(struct cpuidle_device *dev,
> 
>  	snooze_exit_time = get_tb() + snooze_timeout;
>  	ppc64_runlatch_off();
> +	HMT_very_low();
>  	while (!need_resched()) {
> -		HMT_very_low();
>  		if (snooze_timeout_en && get_tb() > snooze_exit_time)
>  			break;
>  	}
> -- 
> 2.11.0
> 
