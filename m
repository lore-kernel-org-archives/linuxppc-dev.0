Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63A9CDDE4A
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 16:53:11 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBC5r94p025652
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 00:53:09 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBC5r9n6165618
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 22:53:09 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBC5r8Fg021763
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 22:53:08 -0700
Date: Tue, 11 Dec 2007 21:53:07 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] iSeries: fix unregistering HV event handlers.
Message-ID: <20071212055307.GB8921@linux.vnet.ibm.com>
References: <20071212150056.9a21c8a4.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071212150056.9a21c8a4.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 03:00:56PM +1100, Stephen Rothwell wrote:
> Commit fbd568a3e61a7decb8a754ad952aaa5b5c82e9e5 ("Change
> synchronize_kernel to _rcu and _sched") changed the deprecated
> synchronize_kernel() in HvLpEvent_unregisterHandler() to
> synchronize_rcu().  It turns out that it should have been
> synchronize_sched().

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/platforms/iseries/lpevents.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/iseries/lpevents.c b/arch/powerpc/platforms/iseries/lpevents.c
> index 34bdbbe..02c1422 100644
> --- a/arch/powerpc/platforms/iseries/lpevents.c
> +++ b/arch/powerpc/platforms/iseries/lpevents.c
> @@ -226,7 +226,7 @@ int HvLpEvent_unregisterHandler(HvLpEvent_Type eventType)
>  			 * other CPUs, and that the deleted handler isn't
>  			 * still running on another CPU when we return.
>  			 */
> -			synchronize_rcu();
> +			synchronize_sched();
>  			return 0;
>  		}
>  	}
> -- 
> 1.5.3.7
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
