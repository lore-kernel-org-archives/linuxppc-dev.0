Return-Path: <clg@kaod.org>
Received: from 5.mo1.mail-out.ovh.net (5.mo1.mail-out.ovh.net [178.33.45.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401l886DWBzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 08:23:35 +1100 (AEDT)
Received: from player159.ha.ovh.net (unknown [10.109.120.188])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 69FD8E0107
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:47:10 +0100 (CET)
Subject: Re: [RFC] powerpc/xive: Remove irq from queue when it is shutdown
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Cc: andrew.donnellan@au1.ibm.com, vaibhav@linux.vnet.ibm.com
References: <20180314165808.26628-1-fbarrat@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ba73a10a-320c-914e-5d7e-1ff212fdd6c5@kaod.org>
Date: Wed, 14 Mar 2018 18:47:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180314165808.26628-1-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2018 05:58 PM, Frederic Barrat wrote:
> If a driver has called free_irq() but an irq is waiting in a queue, an
> error is logged when a cpu processes it:
> 
>     irq 232, desc: 0000000044e5941a, depth: 1, count: 9823, unhandled: 0
>     ->handle_irq():  0000000023f2e352,
>     handle_bad_irq+0x0/0x2e0
>     ->irq_data.chip(): 000000007fd7bf50,
>     no_irq_chip+0x0/0x110
>     ->action():           (null)
>     IRQ_NOREQUEST set
>     unexpected IRQ trap at vector e8
> 
> In most cases, it's due to a driver bug or a misbehaving device, but
> it can be observed with opencapi with no involvment of a device. AFU
> interrupts are triggered by writing a special page of a process, but
> it's possible for a thread of that process to write to that page as
> well. If that process exits abruptly, the driver will free the AFU
> interrupts resources, but there's no possible quiescing of the
> process, so we may have interrupts in the queue.
> 
> This patch adds a scan of the queue when an interrupt is shutdown to
> replace any pending irq with XIVE_BAD_IRQ, since those are ignored.
> Also move when XIVE_BAD_IRQs are ignored closer to reading the queue,
> so that we can reset the CPPR if it's the last interrupt in the queue.

We could also loop on the ESB 'P' bit to wait for the irqs to be handled,
using :

	xive_esb_read(irq, XIVE_ESB_GET)

which has no side effect. It looks simpler to me. Is that possible ? 


> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>  arch/powerpc/sysdev/xive/common.c | 69 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index 3459015092fa..91047bc7c731 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -148,8 +148,16 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, bool just_peek)
>  		prio = ffs(xc->pending_prio) - 1;
>  		DBG_VERBOSE("scan_irq: trying prio %d\n", prio);
>  
> -		/* Try to fetch */
> -		irq = xive_read_eq(&xc->queue[prio], just_peek);
> +		/*
> +		 * Try to fetch.
> +		 * When not peeking, drop any BAD_IRQ on the floor
> +		 * now. If we let it reach get_irq() and it's the last
> +		 * one, then we'd need to rescan again to reset the
> +		 * CPPR
> +		 */
> +		do {
> +			irq = xive_read_eq(&xc->queue[prio], just_peek);
> +		} while (irq == XIVE_BAD_IRQ && !just_peek);
>  
>  		/* Found something ? That's it */
>  		if (irq)
> @@ -282,8 +290,6 @@ static unsigned int xive_get_irq(void)
>  	    irq, xc->pending_prio);
>  
>  	/* Return pending interrupt if any */
> -	if (irq == XIVE_BAD_IRQ)
> -		return 0;
>  	return irq;
>  }
>  
> @@ -592,6 +598,58 @@ static unsigned int xive_irq_startup(struct irq_data *d)
>  	return 0;
>  }
>  
> +static void xive_remove_from_queue(unsigned int hw_irq, int cpu)
> +{
> +	struct xive_cpu *xc;
> +	struct xive_q *q;
> +	u32 irq = 0, cur, idx, toggle, prev;
> +	u8 prio;
> +	int count;
> +
> +	xc = per_cpu(xive_cpu, cpu);
> +
> +	/*
> +	 * Only one queue is really in use, but let's try stay generic, and
> +	 * check all of them
> +	 */

nevertheless, we could use some helper routines to manipulate 
the xive queues. This is beginning to be cryptic. 

> +	for (prio = 0; prio < XIVE_MAX_QUEUES; prio++) {
> +		q = &xc->queue[prio];
> +		if (!q->qpage)
> +			continue;
> +
> +		/*
> +		 * We can't read a reliable index and toggle without
> +		 * locking, as another cpu can process an interrupt
> +		 * and read the queue at any given time. So use the
> +		 * toggle from the previous index, which should be ok
> +		 * as long as the queue doesn't overflow.
> +		 */
> +		idx = q->idx;
> +		prev = (idx - 1) & q->msk;
> +		cur = be32_to_cpup(q->qpage + prev);
> +		toggle = (cur >> 31) ^ 1;
> +		count = 0;
> +		do {
> +			count++;
> +			cur = be32_to_cpup(q->qpage + idx);
> +			if ((cur >> 31) == toggle)
> +				irq = 0;
> +			else
> +				irq = cur & 0x7fffffff;
> +
> +			if (irq == hw_irq) {
> +				cur &= 1 << 31;
> +				cur |= XIVE_BAD_IRQ;
> +				*(q->qpage + idx) = cpu_to_be32(cur);

Are we sure that the XIVE controller is not updating the queue at 
the same time ? 

Thanks,

C.


> +			}
> +
> +			idx = (idx + 1) & q->msk;
> +			if (idx == 0)
> +				toggle ^= 1;
> +		} while (irq && (count < q->msk));
> +	}
> +}
> +
>  static void xive_irq_shutdown(struct irq_data *d)
>  {
>  	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> @@ -624,6 +682,9 @@ static void xive_irq_shutdown(struct irq_data *d)
>  				get_hard_smp_processor_id(xd->target),
>  				0xff, XIVE_BAD_IRQ);
>  
> +	/* configure_irq() syncs the queue */
> +	xive_remove_from_queue(hw_irq, xd->target);
> +
>  	xive_dec_target_count(xd->target);
>  	xd->target = XIVE_INVALID_TARGET;
>  }
> 
