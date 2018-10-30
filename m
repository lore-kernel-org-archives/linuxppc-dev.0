Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49A1C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 14:19:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8732080A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 14:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8732080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kts05SbXzF1Pl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 01:19:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ktq00tXFzDrGp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 01:18:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42ktpz4z82z9s8r;
 Wed, 31 Oct 2018 01:18:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/21] of: Add cpu node iterator for_each_of_cpu_node()
In-Reply-To: <20180905193738.19325-2-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-2-robh@kernel.org>
Date: Wed, 31 Oct 2018 01:18:00 +1100
Message-ID: <874ld3jz6v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Frank Rowand <frowand.list@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

Sorry I missed this when you posted it.

Rob Herring <robh@kernel.org> writes:
> Iterating thru cpu nodes is a common pattern. Create a common iterator
> which can find child nodes either by node name or device_type == cpu.
> Using the former will allow for eventually dropping device_type
> properties which are deprecated for FDT.

Device trees we see on powerpc generally don't (never?) use "cpu" as the
node name for CPU nodes. And many of those device trees come from
firmware, so we can't update them.

So dropping support for device_type is a non-starter from our POV.

cheers

> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/base.c  | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h | 11 +++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index a055cd1ef96d..4807db0a35b3 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -741,6 +741,45 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
>  }
>  EXPORT_SYMBOL(of_get_next_available_child);
>
> +/**
> + *	of_get_next_cpu_node - Iterate on cpu nodes
> + *	@prev:	previous child of the /cpus node, or NULL to get first
> + *
> + *	Returns a cpu node pointer with refcount incremented, use of_node_put()
> + *	on it when done. Returns NULL when prev is the last child. Decrements
> + *	the refcount of prev.
> + */
> +struct device_node *of_get_next_cpu_node(struct device_node *prev)
> +{
> +	struct device_node *next = NULL;
> +	unsigned long flags;
> +	struct device_node *node;
> +
> +	if (!prev)
> +		node = of_find_node_by_path("/cpus");
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +	if (prev)
> +		next = prev->sibling;
> +	else if (node) {
> +		next = node->child;
> +		of_node_put(node);
> +	}
> +	for (; next; next = next->sibling) {
> +		if (!(of_node_name_eq(next, "cpu") ||
> +		      (next->type && !of_node_cmp(next->type, "cpu"))))
> +			continue;
> +		if (!__of_device_is_available(next))
> +			continue;
> +		if (of_node_get(next))
> +			break;
> +	}
> +	of_node_put(prev);
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +	return next;
> +}
> +EXPORT_SYMBOL(of_get_next_cpu_node);
> +
>  /**
>   * of_get_compatible_child - Find compatible child node
>   * @parent:	parent node
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 99b0ebf49632..1aca0dbd35df 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -353,6 +353,8 @@ extern const void *of_get_property(const struct device_node *node,
>  				const char *name,
>  				int *lenp);
>  extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
> +extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
> +
>  #define for_each_property_of_node(dn, pp) \
>  	for (pp = dn->properties; pp != NULL; pp = pp->next)
>
> @@ -754,6 +756,11 @@ static inline struct device_node *of_get_cpu_node(int cpu,
>  	return NULL;
>  }
>
> +static inline struct device_node *of_get_next_cpu_node(struct device_node *prev)
> +{
> +	return NULL;
> +}
> +
>  static inline int of_n_addr_cells(struct device_node *np)
>  {
>  	return 0;
> @@ -1217,6 +1224,10 @@ static inline int of_property_read_s32(const struct device_node *np,
>  	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
>  	     child = of_get_next_available_child(parent, child))
>
> +#define for_each_of_cpu_node(cpu) \
> +	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
> +	     cpu = of_get_next_cpu_node(cpu))
> +
>  #define for_each_node_with_property(dn, prop_name) \
>  	for (dn = of_find_node_with_property(NULL, prop_name); dn; \
>  	     dn = of_find_node_with_property(dn, prop_name))
> --
> 2.17.1
