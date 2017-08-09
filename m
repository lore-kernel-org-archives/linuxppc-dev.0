Return-Path: <clg@kaod.org>
Received: from 6.mo177.mail-out.ovh.net (6.mo177.mail-out.ovh.net
 [46.105.51.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS4db40sRzDqyV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 18:47:14 +1000 (AEST)
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 752FF7444C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:30:48 +0200 (CEST)
Subject: Re: [PATCH 10/10] powerpc/xive: fix the size of the cpumask used in
 xive_find_target_in_mask()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
References: <1502182969-3180-1-git-send-email-clg@kaod.org>
 <874lthnrse.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <969dcea9-c348-90cd-2541-8b058e3613cd@kaod.org>
Date: Wed, 9 Aug 2017 09:30:42 +0200
MIME-Version: 1.0
In-Reply-To: <874lthnrse.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2017 09:06 AM, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
>> When called from xive_irq_startup(), the size of the cpumask can be
>> larger than nr_cpu_ids. Most of time, its value is NR_CPUS (2048).
> 
> Ugh, you're right.
> 
>   #define nr_cpumask_bits	((unsigned int)NR_CPUS)
>   ...
>   /**
>    * cpumask_weight - Count of bits in *srcp
>    * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
>    */
>   static inline unsigned int cpumask_weight(const struct cpumask *srcp)
>   {
>   	return bitmap_weight(cpumask_bits(srcp), nr_cpumask_bits);
>   }
> 
> 
> I don't know what the comment on srcp is trying to say. It's not true
> that it only counts nr_cpu_ids worth of bits.
> 
> So it does seem if we're passed a mask with > nr_cpu_ids bits set then
> cpumask_weight() will return > nr_cpu_ids, which is .. unhelpful.
> 
> 
> BUT, I don't see other code handling cpumask_weight() returning >
> nr_cpu_ids - at least I can't find any with some grepping.
> 
> 
> So what is going wrong here that we're being passed a mask with more
> than nr_cpu_ids bits set?
> 
> I think the affinity mask is copied to the desc in desc_smp_init(), and
> the call chain will be:
> 
>   irq_create_mapping()
>     -> irq_domain_alloc_descs()
>        -> __irq_alloc_descs()
>           -> alloc_descs()
>              -> alloc_desc()
>                 -> desc_set_defaults()
>                    -> desc_smp_init()
> 
> irq_create_mapping() is doing:
> 
>   virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node), NULL);
> 
> Where the affinity mask is the NULL at the end.
> 
> So presumably we're hitting the irq_default_affinity case here:
> 
>   static void desc_smp_init(struct irq_desc *desc, int node,
>   			  const struct cpumask *affinity)
>   {
>   	if (!affinity)
>   		affinity = irq_default_affinity;
>   	cpumask_copy(desc->irq_common_data.affinity, affinity);
> 
> 
> Which comes from:
> 
>   static void __init init_irq_default_affinity(void)
>   {
>   #ifdef CONFIG_CPUMASK_OFFSTACK
>   	if (!irq_default_affinity)
>   		zalloc_cpumask_var(&irq_default_affinity, GFP_NOWAIT);
>   #endif
>   	if (cpumask_empty(irq_default_affinity))
>   		cpumask_setall(irq_default_affinity);
>   }
> 
> And cpumask_setall() will indeed set NR_CPUs bits.
> 
> 
> So that all seems sane, except that it does mean cpumask_weight() can
> return > nr_cpu_ids which is awkward.
> 
> I guess this patch is a good fix, I'll expand the change log a bit.

Yes. Thanks for the digging. I didn't do as much.

Cheers,

C.
