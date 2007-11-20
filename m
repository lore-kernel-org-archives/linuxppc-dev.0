Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3505DDDDFE
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 15:16:22 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAK4GJsj008372
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 23:16:19 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAK4GJj7120002
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 21:16:19 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAK4GJRP026128
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 21:16:19 -0700
Message-ID: <47425F8F.3060208@linux.vnet.ibm.com>
Date: Tue, 20 Nov 2007 09:46:15 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] fix scaled time accounting possible divide by zero
References: <9965.1195529141@neuling.org>
In-Reply-To: <9965.1195529141@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> This fixes a problem noticed by Balbir Singh
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Paulus: can we send this up for 2.6.24?
> 
>  arch/powerpc/kernel/time.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/time.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/time.c
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/time.c
> @@ -244,8 +244,9 @@ void account_system_vtime(struct task_st
>  		/* deltascaled includes both user and system time.
>  		 * Hence scale it based on the purr ratio to estimate
>  		 * the system time */
> -		deltascaled = deltascaled * get_paca()->system_time /
> -		(get_paca()->system_time + get_paca()->user_time);
> +		if (get_paca()->user_time)
> +			deltascaled = deltascaled * get_paca()->system_time /
> +			(get_paca()->system_time + get_paca()->user_time);

Hi, Michael,

I'd be doubly careful with scaled multiplication approach, we tried this
for CFS (please see task_utime() and task_stime() and the fixes that
went around it). We ran into problems were due to multiplication
rounding errors, we would see stime and utime go back after a period
of time.

Please see http://kerneltrap.org/mailarchive/linux-kernel/2007/10/16/344377

Our problems were made severe by the fact that sum_exec_runtime and
stime/utime accounting occured differently. stime/utime were sampled
at jiffy boundaries and hence could we incorrect. I think we need
to use rounding to ensure that ac_scaled*time never goes back
due to rounding errors.

>  		delta += get_paca()->system_time;
>  		get_paca()->system_time = 0;
>  	}


-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
