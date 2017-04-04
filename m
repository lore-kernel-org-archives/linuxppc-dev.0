Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxwVt1JWFzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 14:10:30 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3448tQG036388
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:10:19 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29m258w2j9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 00:10:19 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 09:40:16 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v344AEI39961694
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 09:40:14 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v344ADeZ013866
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 09:40:14 +0530
Date: Tue, 4 Apr 2017 09:40:11 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] cpuidle: powernv: Avoid a branch in the core
 snooze_loop() loop
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170403215414.16951-1-anton@ozlabs.org>
 <20170403215414.16951-3-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170403215414.16951-3-anton@ozlabs.org>
Message-Id: <20170404041011.GD21029@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Anton Blanchard <anton@ozlabs.org> [2017-04-04 07:54:14]:

> From: Anton Blanchard <anton@samba.org>
> 
> When in the snooze_loop() we want to take up the least amount of
> resources. On my version of gcc (6.3), we end up with an extra
> branch because it predicts snooze_timeout_en to be false, whereas it
> is almost always true.

By default snooze_timeout_en is true.  It will become false only when
we do not want to exit the snooze loop and that will be when snooze is
the only idle state available in the platform, which is a rare case.

> Use likely() to avoid the branch and be a little nicer to the
> other non idle threads on the core.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

> ---
>  drivers/cpuidle/cpuidle-powernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 8c991c254b95..251a60bfa8ee 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -58,7 +58,7 @@ static int snooze_loop(struct cpuidle_device *dev,
>  	ppc64_runlatch_off();
>  	HMT_very_low();
>  	while (!need_resched()) {
> -		if (snooze_timeout_en && get_tb() > snooze_exit_time)
> +		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time)
>  			break;
>  	}
> 
> -- 
> 2.11.0
> 
