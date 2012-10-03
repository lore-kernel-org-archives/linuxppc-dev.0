Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 896AC2C0324
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 08:36:27 +1000 (EST)
Date: Wed, 3 Oct 2012 15:36:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH 5/5] rapidio: add destination ID allocation mechanism
Message-Id: <20121003153625.39fd5af7.akpm@linux-foundation.org>
In-Reply-To: <1349291923-22860-6-git-send-email-alexandre.bounine@idt.com>
References: <1349291923-22860-1-git-send-email-alexandre.bounine@idt.com>
 <1349291923-22860-6-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  3 Oct 2012 15:18:43 -0400
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Replace the single global destination ID counter with per-net allocation
> mechanism to allow independent destID management for each available RapidIO
> network. Using bitmap based mechanism instead of counters allows
> destination ID release and reuse in systems that support hot-swap.
> 
>
> ...
>
> +static u16 rio_destid_alloc(struct rio_net *net)
> +{
> +	int destid;
> +	struct rio_id_table *idtab = &net->destid_table;
> +
> +	spin_lock(&idtab->lock);
> +	destid = find_next_zero_bit(idtab->table, idtab->max, idtab->next);
> +	if (destid >= idtab->max)
> +		destid = find_first_zero_bit(idtab->table, idtab->max);
> +
> +	if (destid < idtab->max) {
> +		idtab->next = destid + 1;
> +		if (idtab->next >= idtab->max)
> +			idtab->next = 0;
> +		set_bit(destid, idtab->table);
> +		destid += idtab->start;
> +	} else
> +		destid = RIO_INVALID_DESTID;
> +
> +	spin_unlock(&idtab->lock);
> +	return (u16)destid;
> +}

This is round-robin rather than the simpler first-fit, and this reader
doesn't know why.  Suggest the addition of a code comment explaining
this decision.

> +/*
> + * rio_destid_reserve - Reserve the specivied destID
> + * net: RIO network
> + * destid: destID to reserve
> + *
> + * Tries to reserve the specified destID.
> + * Returns 0 if successfull.
> + */
> +static int rio_destid_reserve(struct rio_net *net, u16 destid)
> +{
> +	int oldbit;
> +	struct rio_id_table *idtab = &net->destid_table;
> +
> +	destid -= idtab->start;
> +	spin_lock(&idtab->lock);
> +	oldbit = test_and_set_bit(destid, idtab->table);
> +	spin_unlock(&idtab->lock);
> +	return oldbit;
> +}
> +
> +/*
> + * rio_destid_free - free a previously allocated destID
> + * net: RIO network
> + * destid: destID to free
> + *
> + * Makes the specified destID available for use.
> + */
> +static void rio_destid_free(struct rio_net *net, u16 destid)
> +{
> +	struct rio_id_table *idtab = &net->destid_table;
> +
> +	destid -= idtab->start;
> +	spin_lock(&idtab->lock);
> +	clear_bit(destid, idtab->table);
> +	spin_unlock(&idtab->lock);
> +}
> +
> +/*
> + * rio_destid_first - return first destID in use
> + * net: RIO network
> + */
> +static u16 rio_destid_first(struct rio_net *net)
> +{
> +	int destid;
> +	struct rio_id_table *idtab = &net->destid_table;
> +
> +	spin_lock(&idtab->lock);
> +	destid = find_first_bit(idtab->table, idtab->max);
> +	if (destid >= idtab->max)
> +		destid = RIO_INVALID_DESTID;
> +	else
> +		destid += idtab->start;
> +	spin_unlock(&idtab->lock);
> +	return (u16)destid;
> +}
> +
> +/*
> + * rio_destid_next - return next destID in use
> + * net: RIO network
> + * from: destination ID from which search shall continue
> + */

All these code comments look like kerneldoc, but they aren't.  kerneldoc
uses /** and identifiers have a leading `@'.  And that's OK - one
doesn't *have* to use kerneldoc.  But a lot of
drivers/rapidio/rio-scan.c is already using kerneldoc so the
inconsistency is odd.

>
> ...
>
> -static struct rio_net __devinit *rio_alloc_net(struct rio_mport *port)
> +static struct rio_net __devinit *rio_alloc_net(struct rio_mport *port,
> +					       int do_enum, u16 start)
>  {
>  	struct rio_net *net;
>  
>  	net = kzalloc(sizeof(struct rio_net), GFP_KERNEL);
> +	if (net && do_enum) {
> +		net->destid_table.table = kzalloc(
> +			BITS_TO_LONGS(RIO_MAX_ROUTE_ENTRIES(port->sys_size)) *
> +			sizeof(long),
> +			GFP_KERNEL);

kcalloc() would be idiomatic here.

> +		if (net->destid_table.table == NULL) {
> +			pr_err("RIO: failed to allocate destID table\n");
> +			kfree(net);
> +			net = NULL;
> +		} else {
> +			net->destid_table.start = start;
> +			net->destid_table.next = 0;
> +			net->destid_table.max =
> +					RIO_MAX_ROUTE_ENTRIES(port->sys_size);
> +			spin_lock_init(&net->destid_table.lock);
> +		}
> +	}
> +
>
> ...
>
