Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n3RR12BbzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 21:53:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Allen <jallen@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, desnesn@linux.vnet.ibm.com,
 John Allen <jallen@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] powerpc/pseries: Avoid blocking rtas polling
 handling multiple PRRN events
In-Reply-To: <20180808152926.28842-2-jallen@linux.ibm.com>
References: <20180808152926.28842-1-jallen@linux.ibm.com>
 <20180808152926.28842-2-jallen@linux.ibm.com>
Date: Fri, 10 Aug 2018 21:53:22 +1000
Message-ID: <87600i8mkt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

John Allen <jallen@linux.ibm.com> writes:
> When a PRRN event is being handled and another PRRN event comes in, the
> second event will block rtas polling waiting on the first to complete,
> preventing any further rtas events from being handled. This can be
> especially problematic in case that PRRN events are continuously being
> queued in which case rtas polling gets indefinitely blocked completely.
>
> This patch removes the blocking call to flush_work and allows the
> default workqueue behavior to handle duplicate events.
>
> Signed-off-by: John Allen <jallen@linux.ibm.com>
> ---
> v3:
>   -Scrap the mutex as it only replicates existing workqueue behavior.
> v2:
>   -Unlock prrn_lock when PRRN operations are complete, not after handler is
>    scheduled.
>   -Remove call to flush_work, the previous broken method of serializing
>    PRRN events.
> ---
>  arch/powerpc/kernel/rtasd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index 44d66c33d59d..2017934e5985 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -290,7 +290,6 @@ static DECLARE_WORK(prrn_work, prrn_work_fn);
>  
>  static void prrn_schedule_update(u32 scope)
>  {
> -	flush_work(&prrn_work);
>  	prrn_update_scope = scope;
>  	schedule_work(&prrn_work);
>  }

I think we can still lose a "scope" value here.

ie.

prrn_schedule_update(1)
  prrn_update_scope = 1;
  schedule_work(&prrn_work);    // scheduled but doesn't run yet

...

prrn_schedule_update(2)
  prrn_update_scope = 2;
  schedule_work(&prrn_work);   // it's still scheduled

// finally

prrn_work_fn(..)
  pseries_devicetree_update(-prrn_update_scope); // aka 2


So we lost the "1" value.

We could fix that by allocating a work struct that holds the scope value.

But I'd really like to try just calling the prrn_work_fn() directly,
we're already running as a scheduled work function, I don't see any
benefit in scheduling more work.

cheers
