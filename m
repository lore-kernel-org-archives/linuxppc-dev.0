Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by ozlabs.org (Postfix) with SMTP id AB02A679FC
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 06:51:52 +1000 (EST)
Received: from midway.site ([71.245.102.105]) by xenotime.net for
	<linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 13:51:50 -0700
Date: Mon, 15 May 2006 13:54:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [PATCH 14/16] ehca: queue page table handling
Message-Id: <20060515135419.f77a1d8b.rdunlap@xenotime.net>
In-Reply-To: <4468BDAD.3020701@de.ibm.com>
References: <4468BDAD.3020701@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
	MEDER@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 15 May 2006 19:43:09 +0200 Heiko J Schick wrote:

> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 
> 
>   drivers/infiniband/hw/ehca/ipz_pt_fn.c |  177 ++++++++++++++++++++++
>   drivers/infiniband/hw/ehca/ipz_pt_fn.h |  254 +++++++++++++++++++++++++++++++++
>   2 files changed, 431 insertions(+)
> 
> 
> 
> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ipz_pt_fn.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ipz_pt_fn.h	2006-05-12 12:25:43.000000000 +0200
> @@ -0,0 +1,254 @@

> +/*  return current Queue Page , increment Queue Page iterator from
> + *   page to page in struct ipz_queue, last increment will return 0! and
> + *   NOT wrap
> + *   returns address (kv) of Queue Page
> + *   warning don't use in parallel with ipz_QE_get_inc()
> + */

When not using kernel-doc format... the preferred multi-line
comment format is:

/*
 * foo foo foo ........
 * bar bar bar .......
 * blahz ..........
 */

repeat below.

> +void *ipz_qpageit_get_inc(struct ipz_queue *queue);
> +
> +/*  return current Queue Entry, increment Queue Entry iterator by one
> + *   step in struct ipz_queue, will wrap in ringbuffer
> + *   @returns address (kv) of Queue Entry BEFORE increment
> + *   warning don't use in parallel with ipz_qpageit_get_inc()
> + *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
> + */
> +static inline void *ipz_qeit_get_inc(struct ipz_queue *queue)
> +{
> +	void *ret = NULL;
> +
> +	ret = ipz_qeit_get(queue);
> +	queue->current_q_offset += queue->qe_size;
> +	if (queue->current_q_offset >= queue->queue_length) {
> +		queue->current_q_offset = 0;
> +		/* toggle the valid flag */
> +		queue->toggle_state = (~queue->toggle_state) & 1;
> +	}
> +
> +	EDEB(7, "queue=%p ret=%p new current_q_addr=%lx qe_size=%x",
> +	     queue, ret, queue->current_q_offset, queue->qe_size);
> +
> +	return ret;
> +}
> +
> +/*  return current Queue Entry, increment Queue Entry iterator by one
> + *   step in struct ipz_queue, will wrap in ringbuffer
> + *   returns address (kv) of Queue Entry BEFORE increment
> + *   returns 0 and does not increment, if wrong valid state
> + *   warning don't use in parallel with ipz_qpageit_get_inc()
> + *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
> + */
> +static inline void *ipz_qeit_get_inc_valid(struct ipz_queue *queue)
> +{
> +	struct ehca_cqe *cqe = ipz_qeit_get(queue);
> +	u32 cqe_flags = cqe->cqe_flags;
> +
> +	if ((cqe_flags >> 7) != (queue->toggle_state & 1))
> +		return NULL;
> +
> +	ipz_qeit_get_inc(queue);
> +	return cqe;
> +}
> +

> +/* destructor for a ipz_queue_t
> + *  -# free queue
> + *  see ipz_queue_ctor()
> + *  returns true if ok, false if queue was NULL-ptr of free failed
> + */
> +int ipz_queue_dtor(struct ipz_queue *queue);
> +
> +/* constructor for a ipz_qpt_t,
> + * placement new for struct ipz_queue, new for all dependent datastructors
> + *
> + *  all QP Tables are the same,
> + *  flow:
> + *  -# allocate+pin queue
> + *  -# initialise ptcb
> + *  -# allocate+pin PTs
> + *  -# link PTs to a ring, according to HCA Arch, set bit62 id needed
> + *  -# the ring must have room for exactly nr_of_PTEs
> + *  see ipz_qpt_ctor()
> + */
> +void ipz_qpt_ctor(struct ipz_qpt *qpt,
> +		  const u32 nr_of_QEs,
> +		  const u32 pagesize,
> +		  const u32 qe_size,
> +		  const u8 lowbyte, const u8 toggle,
> +		  u32 * act_nr_of_QEs, u32 * act_nr_of_pages);
> +
> +/*  return current Queue Entry, increment Queue Entry iterator by one
> + *   step in struct ipz_queue, will wrap in ringbuffer
> + *   returns address (kv) of Queue Entry BEFORE increment
> + *   warning don't use in parallel with ipz_qpageit_get_inc()
> + *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
> + *
> + *   fix EQ page problems
> + */
> +void *ipz_qeit_eq_get_inc(struct ipz_queue *queue);
> +
> +/*  return current Event Queue Entry, increment Queue Entry iterator
> + *   by one step in struct ipz_queue if valid, will wrap in ringbuffer
> + *   returns address (kv) of Queue Entry BEFORE increment
> + *   returns 0 and does not increment, if wrong valid state
> + *   warning don't use in parallel with ipz_queue_QPageit_get_inc()
> + *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
> + */
> +static inline void *ipz_eqit_eq_get_inc_valid(struct ipz_queue *queue)
> +{
> +	void *ret = ipz_qeit_get(queue);
> +	u32 qe = *(u8 *) ret;
> +	EDEB(7, "ipz_QEit_EQ_get_inc_valid qe=%x", qe);
> +	if ((qe >> 7) == (queue->toggle_state & 1))
> +		ipz_qeit_eq_get_inc(queue); /* this is a good one */
> +	else
> +		ret = NULL;
> +	return ret;
> +}


---
~Randy
