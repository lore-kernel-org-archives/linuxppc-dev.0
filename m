Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59D4E1A012C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 21:50:06 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 10 Nov 2014 03:50:04 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EAFC419D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 03:38:42 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAA8jWor65077292
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 09:45:32 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAAAmueH021543
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 03:48:57 -0700
Message-ID: <54609804.9070006@linux.vnet.ibm.com>
Date: Mon, 10 Nov 2014 16:18:36 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: mpe@ellerman.id.au, mikey@neuling.org, joel.stanley@au1.ibm.com,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH] cpuidle/powernv: Fix return value of idle index in
 fastsleep
References: <20141027132618.9085.97044.stgit@preeti.in.ibm.com>
In-Reply-To: <20141027132618.9085.97044.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: rjw@rjwysocki.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben, Mikey,

Can you please take a look at this patch?  I feel the commit dcb1869 was
just a plug-in solution. Shouldn't we take a look at this again?

Ideally we should not need this check. With the cpuidle redesign on
PowerNV going in, we can enable fastsleep at bootup itself and without
checks on any debug parameters such as powersave_nap .We will then only
need to check for powersave_nap == 0 and return only if that is the
case. This check is still required since the user can disable all deep
idle states by setting powersave_nap to 0.

Regards
Preeti U Murthy

On 10/27/2014 06:56 PM, Preeti U Murthy wrote:
> Commit dcb18694 : Fix ipi on Palmeto added a workaround to disable
> going into fastsleep on Palmeto boards which was reported to fail
> to boot when fastsleep was enabled. However it missed returning
> an idle index. Fix this.
> 
> There is probably no harm in returning the index of fastsleep
> although the cpu did not enter this state. The governor will notice
> the difference in the residency time in the idle state and the
> target residency of the idle state and prevent cpus from entering
> fastsleep from that point on. Hence the usage and time statistics
> logged for fastsleep will not be out of sync with reality except
> for the first entry.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> Do we still need this workaround? Or can we get rid of the check
> on powersave_nap altogether?
> ---
> 
>  drivers/cpuidle/cpuidle-powernv.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index fa79392..c18da24 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -70,7 +70,7 @@ static int fastsleep_loop(struct cpuidle_device *dev,
>  	unsigned long new_lpcr;
>  
>  	if (powersave_nap < 2)
> -		return;
> +		return index;
>  	if (unlikely(system_state < SYSTEM_RUNNING))
>  		return index;
>  
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
