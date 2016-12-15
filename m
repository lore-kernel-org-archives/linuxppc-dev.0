Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfcT62hNTzDw6J
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 02:15:38 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tfcT54pdqz9sCN
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2016 02:15:37 +1100 (AEDT)
Message-ID: <1481814929.17253.106.camel@kernel.crashing.org>
Subject: Re: [powerpc/nmi: RFC 2/2] Keep interrupts enabled even on soft
 disable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>
Date: Thu, 15 Dec 2016 09:15:29 -0600
In-Reply-To: <b1455ef8-7583-bafb-fce9-0c2829d87c0b@gmail.com>
References: <20161212095003.1885-1-bsingharora@gmail.com>
 <20161212095003.1885-3-bsingharora@gmail.com>
 <20161212233111.1712ba79@roar.ozlabs.ibm.com>
 <1481607371.11971.1.camel@gmail.com>
 <1481642851.17253.72.camel@kernel.crashing.org>
 <b1455ef8-7583-bafb-fce9-0c2829d87c0b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-12-14 at 11:41 +1100, Balbir Singh wrote:
> I was planning to skipping other IRQ chips for now and support just
> XICS/XIVE with BOOK3S and PPC64. But we can discuss this.

Well you still need to make sure you don't do your lazy stuff on
them and actually mask EE.

> > That's why I mentioned opt-in. Maybe make it conditional on a
> > global
> > boolean that gets enabled by the PIC itself, or make it an enum
> > 
> > enum lazy_irq_masking_mode {
> >        lazy_irq_mask_ee,       /* Use CPU EE bit (default) */
> >        lazy_irq_mask_fetch,    /* Fetch the interrupt and stash it
> > away */
> >        lazy_irq_mask_prio      /* Change processor priority */
> > };
> > 
> > For the latter we'd need a ppc_md. hook to do the priority change
> > which xive (and potentially others like MPIC) could use.
> 
> We have set_cpu_priority for XICS, which sets the base_priority
> only for the CPPR at the moment. It can be extended

Well, that's what I said earlier. XICS can do that in *theory* but it's
broken in HW. There's a race condition or two, if you whack the CPPR in
a way that causes a pending interrupt to be rejected, there's a timing
window where the ICP can wedge itself or the interrupt be lost, I don't
remember.

The only safe way on XICS is to fetch the interrupt (which implicitly
raises the CPPR) and lower it using EOI.

Cheers,
Ben.
