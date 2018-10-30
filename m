Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85F2C0044C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 02:01:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0370C2082D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 02:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0370C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kZT24N78zDqf6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 13:01:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kZQq2cSQzDrSt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 12:59:30 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9U1xEhG002404;
 Mon, 29 Oct 2018 20:59:15 -0500
Message-ID: <ca934ae822ddae764736004972273ca8397184bd.camel@kernel.crashing.org>
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, Scott Wood <oss@buserror.net>,
 LEROY Christophe <christophe.leroy@c-s.fr>
Date: Tue, 30 Oct 2018 12:59:14 +1100
In-Reply-To: <7595e349-d925-9d03-c234-5070873e48d3@xenosoft.de>
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
 <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
 <20181029191321.Horde.fxo4MJUhTstCq8zaw1lK7Q3@messagerie.si.c-s.fr>
 <77061E9A-AFC9-437A-AB42-F47266FD9721@xenosoft.de>
 <074997be051a5684b5b8593c3c3ce2a2e06147fa.camel@buserror.net>
 <d13090a2-902e-e18c-c97f-79cddb277454@xenosoft.de>
 <7595e349-d925-9d03-c234-5070873e48d3@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-30 at 02:42 +0100, Christian Zigotzky wrote:
> OF patch for the latest Git kernel: http://www.xenosoft.de/of_v2.patch

This just seems to revert a whole bunch of stuff, not really the right
way to go. Why is of_get_next_cpu_node() not finding your CPUs ? There
must be something wrong with the device-tree...

> ----------------------------- of_v2.patch -----------------------------
> 
> diff -rupN a/drivers/of/base.c b/drivers/of/base.c
> --- a/drivers/of/base.c    2018-10-30 02:19:30.827089495 +0100
> +++ b/drivers/of/base.c    2018-10-30 02:18:51.666856715 +0100
> @@ -395,7 +395,7 @@ struct device_node *of_get_cpu_node(int
>   {
>       struct device_node *cpun;
> 
> -    for_each_of_cpu_node(cpun) {
> +    for_each_node_by_type(cpun, "cpu") {
>           if (arch_find_n_match_cpu_physical_id(cpun, cpu, thread))
>               return cpun;
>       }
> @@ -750,45 +750,6 @@ struct device_node *of_get_next_availabl
>   EXPORT_SYMBOL(of_get_next_available_child);
> 
>   /**
> - *    of_get_next_cpu_node - Iterate on cpu nodes
> - *    @prev:    previous child of the /cpus node, or NULL to get first
> - *
> - *    Returns a cpu node pointer with refcount incremented, use 
> of_node_put()
> - *    on it when done. Returns NULL when prev is the last child. Decrements
> - *    the refcount of prev.
> - */
> -struct device_node *of_get_next_cpu_node(struct device_node *prev)
> -{
> -    struct device_node *next = NULL;
> -    unsigned long flags;
> -    struct device_node *node;
> -
> -    if (!prev)
> -        node = of_find_node_by_path("/cpus");
> -
> -    raw_spin_lock_irqsave(&devtree_lock, flags);
> -    if (prev)
> -        next = prev->sibling;
> -    else if (node) {
> -        next = node->child;
> -        of_node_put(node);
> -    }
> -    for (; next; next = next->sibling) {
> -        if (!(of_node_name_eq(next, "cpu") ||
> -              (next->type && !of_node_cmp(next->type, "cpu"))))
> -            continue;
> -        if (!__of_device_is_available(next))
> -            continue;
> -        if (of_node_get(next))
> -            break;
> -    }
> -    of_node_put(prev);
> -    raw_spin_unlock_irqrestore(&devtree_lock, flags);
> -    return next;
> -}
> -EXPORT_SYMBOL(of_get_next_cpu_node);
> -
> -/**
>    * of_get_compatible_child - Find compatible child node
>    * @parent:    parent node
>    * @compatible:    compatible string
> diff -rupN a/include/linux/of.h b/include/linux/of.h
> --- a/include/linux/of.h    2018-10-30 02:19:32.047096634 +0100
> +++ b/include/linux/of.h    2018-10-30 02:18:51.666856715 +0100
> @@ -347,7 +347,6 @@ extern const void *of_get_property(const
>                   const char *name,
>                   int *lenp);
>   extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
> -extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
> 
>   #define for_each_property_of_node(dn, pp) \
>       for (pp = dn->properties; pp != NULL; pp = pp->next)
> @@ -757,11 +756,6 @@ static inline struct device_node *of_get
>       return NULL;
>   }
> 
> -static inline struct device_node *of_get_next_cpu_node(struct 
> device_node *prev)
> -{
> -    return NULL;
> -}
> -
>   static inline int of_n_addr_cells(struct device_node *np)
>   {
>       return 0;
> @@ -1239,10 +1233,6 @@ static inline int of_property_read_s32(c
>       for (child = of_get_next_available_child(parent, NULL); child != 
> NULL; \
>            child = of_get_next_available_child(parent, child))
> 
> -#define for_each_of_cpu_node(cpu) \
> -    for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
> -         cpu = of_get_next_cpu_node(cpu))
> -
>   #define for_each_node_with_property(dn, prop_name) \
>       for (dn = of_find_node_with_property(NULL, prop_name); dn; \
>            dn = of_find_node_with_property(dn, prop_name))

