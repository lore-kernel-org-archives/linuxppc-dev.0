Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxwPb0c3RzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 14:05:54 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3443cl4030497
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:05:39 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29m21m5ay1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 00:05:39 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 14:05:36 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3445Rwu54657134
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 14:05:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3444xCN031540
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 14:04:59 +1000
Date: Tue, 4 Apr 2017 09:34:41 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] cpuidle: powernv: Don't bounce between low and very
 low thread priority
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170403215414.16951-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170403215414.16951-1-anton@ozlabs.org>
Message-Id: <20170404040441.GB21029@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Anton Blanchard <anton@ozlabs.org> [2017-04-04 07:54:12]:

> From: Anton Blanchard <anton@samba.org>
> 
> The core of snooze_loop() continually bounces between low and very
> low thread priority. Changing thread priorities is an expensive
> operation that can negatively impact other threads on a core.
> 
> All CPUs that can run PowerNV support very low priority, so we can
> avoid the change completely.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

> ---
>  drivers/cpuidle/cpuidle-powernv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index cda8f62d555b..9d9f164894eb 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -57,7 +57,6 @@ static int snooze_loop(struct cpuidle_device *dev,
>  	snooze_exit_time = get_tb() + snooze_timeout;
>  	ppc64_runlatch_off();
>  	while (!need_resched()) {
> -		HMT_low();
>  		HMT_very_low();
>  		if (snooze_timeout_en && get_tb() > snooze_exit_time)
>  			break;


HMT_low() is legacy and can be removed for powernv platforms.

--Vaidy
