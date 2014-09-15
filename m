Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37B641A0027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:59:15 +1000 (EST)
Message-ID: <1410764352.32643.2.camel@concordia>
Subject: Re: [PATCH] cpuidle/powernv: Enter fastsleep on checking if deep
 idle states are allowed
From: Michael Ellerman <mpe@ellerman.id.au>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 16:59:12 +1000
In-Reply-To: <20140912110131.7311.86417.stgit@preeti.in.ibm.com>
References: <20140912110131.7311.86417.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-09-12 at 16:31 +0530, Preeti U Murthy wrote:
> Today the procfs interface /proc/sys/kernel/powersave-nap is used to control
> entry into deep idle states beyond snooze. Check for the value of this
> parameter before entering fastsleep. We already do this check for nap in
> power7_idle().
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> 
>  drivers/cpuidle/cpuidle-powernv.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index a64be57..b8ba52e 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -69,6 +69,12 @@ static int fastsleep_loop(struct cpuidle_device *dev,
>  	unsigned long old_lpcr = mfspr(SPRN_LPCR);
>  	unsigned long new_lpcr;
>  
> +	/*
> +	 * Verify if snooze is the only valid cpuidle state
> +	 */
> +	if (!(powersave_nap > 0))
> +		return index;
> +
>  	if (unlikely(system_state < SYSTEM_RUNNING))
>  		return index;

Doesn't the above mean we are just going to keep trying to go into fastsleep
again and again? Or does the idle code work out that it didn't work based on
the fact that we didn't sleep for the right period?

We were talking about getting rid of powersave_nap altogether, but I think we
decided we couldn't, I forget.

cheers
