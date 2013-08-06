Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 480CD2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 09:09:07 +1000 (EST)
Message-ID: <1375830520.5600.23.camel@snotra.buserror.net>
Subject: Re: [PATCH V2 5/6] cpuidle/powerpc: Backend-powerpc idle driver for
 powernv and pseries.
From: Scott Wood <scottwood@freescale.com>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 6 Aug 2013 18:08:40 -0500
In-Reply-To: <20130731025934.19448.16658.stgit@deepthi>
References: <20130731025840.19448.24468.stgit@deepthi>
 <20130731025934.19448.16658.stgit@deepthi>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, dongsheng.wang@freescale.com,
 srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-31 at 08:29 +0530, Deepthi Dharwar wrote:
>  /*
> - * pseries_idle_probe()
> + * powerpc_idle_probe()
>   * Choose state table for shared versus dedicated partition
>   */
> -static int pseries_idle_probe(void)
> +static int powerpc_idle_probe(void)
>  {
>  
> +#ifndef PPC_POWERNV
>  	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
>  		return -ENODEV;
> +#endif

A bunch of ifdefs is not a good start for a file you're claiming is now
generic for all powerpc.

Certainly you shouldn't be calling pseries stuff based only on the
absence of powernv.

And do you not support building one kernel that supports both pseries
and powernv?

>  	if (cpuidle_disable != IDLE_NO_OVERRIDE)
>  		return -ENODEV;
>  
>  	if (max_idle_state == 0) {
> -		printk(KERN_DEBUG "pseries processor idle disabled.\n");
> +		printk(KERN_DEBUG "powerpc processor idle disabled.\n");
>  		return -EPERM;
>  	}
>  
> +#ifdef PPC_POWERNV
> +	cpuidle_state_table = powernv_states;
> +#else
>  	if (get_lppaca()->shared_proc)

Here's another example.  get_lppaca() will only build on book3s -- and
yet we get requests for e500 code to use this file.

-Scott
