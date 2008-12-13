Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 71C44DDF40
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 07:17:11 +1100 (EST)
In-Reply-To: <1229022865-14993-1-git-send-email-ntl@pobox.com>
References: <c5d656532783550a8b21bb027497160a@bga.com>
	<1229022865-14993-1-git-send-email-ntl@pobox.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fc002fa9fb49e710793097c3d5b3010b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] check for GIQ indicator before calling set-indicator
Date: Sat, 13 Dec 2008 14:22:55 -0600
To: Nathan Lynch <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Dec 11, 2008, at 1:14 PM, Nathan Lynch wrote:

> Since "Factor out cpu joining/unjoining the GIQ"
> (b4963255ad5a426f04a0bb15c4315fa4bb40cde9) the WARN_ON in
> xics_set_cpu_giq() is being triggered during boot on JS20 because the
> GIQ indicator is not available on that platform.  While the warning is
> harmless and the system runs normally, it's nicer to check for the
> existence of the indicator before trying to manipulate it.
>
> Implement rtas_indicator_present(), which searches the
> /rtas/rtas-indicators property for the given indicator token, and use
> this function in xics_set_cpu_giq().
>
> Also use a WARN statement in xics_set_cpu_giq to get better
> information on failure.
>
> Signed-off-by: Nathan Lynch <ntl@pobox.com>

Acked-By: Milton Miller <miltonm@bga.com>

...
> diff --git a/arch/powerpc/platforms/pseries/xics.c 
> b/arch/powerpc/platforms/pseries/xics.c
> index e190477..37f5986 100644
> --- a/arch/powerpc/platforms/pseries/xics.c
> +++ b/arch/powerpc/platforms/pseries/xics.c
> @@ -728,9 +728,18 @@ static void xics_set_cpu_priority(unsigned char 
> cppr)
>  /* Have the calling processor join or leave the specified global 
> queue */
>  static void xics_set_cpu_giq(unsigned int gserver, unsigned int join)
>  {
> -	int status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
> -		(1UL << interrupt_server_size) - 1 - gserver, join);
> -	WARN_ON(status < 0);
> +	int index;
> +	int status;
> +
> +	if (!rtas_indicator_present(GLOBAL_INTERRUPT_QUEUE, NULL))
> +		return;
> +
> +	index = (1UL << interrupt_server_size) - 1 - gserver;
> +
> +	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE, index, 
> join);
> +
> +	WARN(status < 0, "set-indicator(%d, %d, %u) returned %d\n",
> +	     GLOBAL_INTERRUPT_QUEUE, index, join, status);
>  }
>
>  void xics_setup_cpu(void)
> -- 
> 1.5.5
>
