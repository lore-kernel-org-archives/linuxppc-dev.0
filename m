Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 790F0DDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 20:12:53 +1000 (EST)
Date: Fri, 13 Jul 2007 12:12:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bob Nelson <rrnelson@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] Enable SPU switch notification to detect currently
	active SPU tasks.
Message-ID: <20070713101233.GA12426@lst.de>
References: <1184283940.16584.5.camel@bnelson60.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1184283940.16584.5.camel@bnelson60.rchland.ibm.com>
Cc: linuxppc <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linuxfoundation.org>,
	oprofile <oprofile-list@lists.sourceforge.net>,
	Philippe Elie <phil.el@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 12, 2007 at 06:45:40PM -0500, Bob Nelson wrote:
> We would like this patch included in -mm and in 2.6.23.

Do you plan to submit oprofile support aswell?  In that case it's fine
otherwise please send it together with the actual oprofile support.

> +static void notify_spus_active(void)
> +{
> +	int node;
> +	/* Wake up the active spu_contexts. When the awakened processes
> +	 * see their "notify_active" flag is set, they will call
> +	 * spu_switch_notify();
> +	 */

Small style issue, this should be:

	int node;

	/*
	 * Wake up the active spu_contexts.
	 *
	 * When the awakened processes see their "notify_active" flag is set,
	 * they will call spu_switch_notify().
	 */

> -static inline int spu_stopped(struct spu_context *ctx, u32 * stat)
> +static inline int spu_stopped(struct spu_context *ctx, u32 *stat)

useless (and wrong) reformatting, please remove.

> -static int spu_run_init(struct spu_context *ctx, u32 * npc)
> +static int spu_run_init(struct spu_context *ctx, u32 *npc)

Same here.

> -static int spu_run_fini(struct spu_context *ctx, u32 * npc,
> -			       u32 * status)
> +static int spu_run_fini(struct spu_context *ctx, u32 *npc,
> +			       u32 *status)

Same here.

> +		if (unlikely(test_bit(SPU_SCHED_NOTIFY_ACTIVE,
> +				      &ctx->sched_flags))) {
> +			clear_bit(SPU_SCHED_NOTIFY_ACTIVE, &ctx->sched_flags);

this should use test_and_clear_bit
