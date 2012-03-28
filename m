Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E78E7B6F6E
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2012 10:22:52 +1100 (EST)
Message-ID: <1332976968.3010.0.camel@pasglop>
Subject: Re: [patch 1/2] powerpc/eeh: remove eeh_event_handler()->daemonize()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
Date: Thu, 29 Mar 2012 10:22:48 +1100
In-Reply-To: <20120328222057.B749EA0363@akpm.mtv.corp.google.com>
References: <20120328222057.B749EA0363@akpm.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tj@kernel.org, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
 matt.fleming@intel.com, oleg@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-03-28 at 15:20 -0700, akpm@linux-foundation.org wrote:
> From: Oleg Nesterov <oleg@redhat.com>
> Subject: powerpc/eeh: remove eeh_event_handler()->daemonize()
> 
> daemonize() is only needed when a user-space task does kernel_thread().
> 
> eeh_event_handler() thread is created by the worker kthread, and thus it
> doesn't need the soon-to-be-deprecated daemonize().

For some reason I thought you were sending that directly to Linus, but
looking at your CC list that's obviously not the case :-) I'll send
them myself.

Cheers,
Ben.

> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Linas Vepstas <linasvepstas@gmail.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Matt Fleming <matt.fleming@intel.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/platforms/pseries/eeh_event.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN arch/powerpc/platforms/pseries/eeh_event.c~powerpc-eeh-remove-eeh_event_handler-daemonize arch/powerpc/platforms/pseries/eeh_event.c
> --- a/arch/powerpc/platforms/pseries/eeh_event.c~powerpc-eeh-remove-eeh_event_handler-daemonize
> +++ a/arch/powerpc/platforms/pseries/eeh_event.c
> @@ -59,7 +59,7 @@ static int eeh_event_handler(void * dumm
>  	struct eeh_event *event;
>  	struct eeh_dev *edev;
>  
> -	daemonize("eehd");
> +	set_task_comm(current, "eehd");
>  	set_current_state(TASK_INTERRUPTIBLE);
>  
>  	spin_lock_irqsave(&eeh_eventlist_lock, flags);
> _
