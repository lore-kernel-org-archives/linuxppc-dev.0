Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdd704LmGzDt1T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 11:41:32 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tdd6z5w1qz9t37
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2016 11:41:31 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id p66so405097pga.2
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2016 16:41:31 -0800 (PST)
Subject: Re: [powerpc/nmi: RFC 2/2] Keep interrupts enabled even on soft
 disable
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20161212095003.1885-1-bsingharora@gmail.com>
 <20161212095003.1885-3-bsingharora@gmail.com>
 <20161212233111.1712ba79@roar.ozlabs.ibm.com>
 <1481607371.11971.1.camel@gmail.com>
 <1481642851.17253.72.camel@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <b1455ef8-7583-bafb-fce9-0c2829d87c0b@gmail.com>
Date: Wed, 14 Dec 2016 11:41:15 +1100
MIME-Version: 1.0
In-Reply-To: <1481642851.17253.72.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 14/12/16 02:27, Benjamin Herrenschmidt wrote:
> On Tue, 2016-12-13 at 16:36 +1100, Balbir Singh wrote:
>> Yep, although the code works for PPC_XICS only which is good for now.
>> When we do XIVE, we can add more bits
> 
> We may want to do XIVE differently, dunno. On XIVE we can just poke the
> processor priority with a single MMIO store, so we don't actually need
> to "fetch" the interrupt and we can continue doing separate priorities.
> 

It would be good to have it be uniform, where the CPPR can be set to
the level of the current IRQ being processed (as seen from the controller)
but not yet finished via EOI. I've not looked at the CPPR/Context/Queue/Ring
details of the XIVE. But I'll let you provide the expertise on IRQ
handling

> Note that raising the priority would work on XICS in *theory* as well
> but HW bugs get in the way if we do that.
> 

Yep, I am not using the MFRR. Right now, I notice the CPPR is set to the
priority of the acked interrupt when we do a read of XIRR. Which works
well when we have just one priority at the moment.

> We also need to make sure you either adjust MPIC and all other PICs
> potentially used on ppc64 to do this "only one priority" thing or you
> disable that new mechanism on all those PICs.
> 

I was planning to skipping other IRQ chips for now and support just
XICS/XIVE with BOOK3S and PPC64. But we can discuss this.

> That's why I mentioned opt-in. Maybe make it conditional on a global
> boolean that gets enabled by the PIC itself, or make it an enum
> 
> enum lazy_irq_masking_mode {
> 	lazy_irq_mask_ee,	/* Use CPU EE bit (default) */
> 	lazy_irq_mask_fetch,	/* Fetch the interrupt and stash it away */
> 	lazy_irq_mask_prio	/* Change processor priority */
> };
> 
> For the latter we'd need a ppc_md. hook to do the priority change
> which xive (and potentially others like MPIC) could use.

We have set_cpu_priority for XICS, which sets the base_priority
only for the CPPR at the moment. It can be extended

Thanks for the comments,
Balbir
