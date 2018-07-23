Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z2Nt4FW3zDqmj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 23:27:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Allen <jallen@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com
Cc: John Allen <jallen@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc/pseries: Avoid blocking rtas polling
 handling multiple PRRN events
In-Reply-To: <20180717194048.3057-2-jallen@linux.ibm.com>
References: <20180717194048.3057-1-jallen@linux.ibm.com>
 <20180717194048.3057-2-jallen@linux.ibm.com>
Date: Mon, 23 Jul 2018 23:27:56 +1000
Message-ID: <87muuihyjn.fsf@concordia.ellerman.id.au>
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

Hi John,

I'm a bit puzzled by this one.

John Allen <jallen@linux.ibm.com> writes:
> When a PRRN event is being handled and another PRRN event comes in, the
> second event will block rtas polling waiting on the first to complete,
> preventing any further rtas events from being handled. This can be
> especially problematic in case that PRRN events are continuously being
> queued in which case rtas polling gets indefinitely blocked completely.
>
> This patch introduces a mutex that prevents any subsequent PRRN events from
> running while there is a prrn event being handled, allowing rtas polling to
> continue normally.
>
> Signed-off-by: John Allen <jallen@linux.ibm.com>
> ---
> v2:
>   -Unlock prrn_lock when PRRN operations are complete, not after handler is
>    scheduled.
>   -Remove call to flush_work, the previous broken method of serializing
>    PRRN events.
> ---
>  arch/powerpc/kernel/rtasd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index 44d66c33d59d..845fc5aec178 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -284,15 +286,17 @@ static void prrn_work_fn(struct work_struct *work)
>  	 */
>  	pseries_devicetree_update(-prrn_update_scope);
>  	numa_update_cpu_topology(false);
> +	mutex_unlock(&prrn_lock);
>  }
>  
>  static DECLARE_WORK(prrn_work, prrn_work_fn);
>  
>  static void prrn_schedule_update(u32 scope)
>  {
> -	flush_work(&prrn_work);

This seems like it's actually the core of the change. Previously we were
basically blocking on the flush before continuing.

> -	prrn_update_scope = scope;

I don't really understand the scope. With the old code we always ran the
work function once for call, now we potentially throw away the scope
value (if the try lock fails).

> -	schedule_work(&prrn_work);
> +	if (mutex_trylock(&prrn_lock)) {
> +		prrn_update_scope = scope;
> +		schedule_work(&prrn_work);
> +	}

Ignoring the scope, the addition of the mutex should not actually make
any difference. If you see the doco for schedule_work() it says:

 * This puts a job in the kernel-global workqueue if it was not already
 * queued and leaves it in the same position on the kernel-global
 * workqueue otherwise.


So the mutex basically implements that existing behaviour. But maybe the
scope is the issue? Like I said I don't really understand the scope
value.


So I guess I'm wondering if we just need to drop the flush_work() and
the rest is not required?

cheers
