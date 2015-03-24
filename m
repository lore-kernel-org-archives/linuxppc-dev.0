Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 737FB1A033E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 19:55:36 +1100 (AEDT)
Message-ID: <1427187317.4770.322.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc/mm/thp: Make page table walk safe against
 thp split/collapse
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 24 Mar 2015 19:55:17 +1100
In-Reply-To: <87vbhrlz4i.fsf@linux.vnet.ibm.com>
References: <1427122851-22495-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1427153762.4770.266.camel@kernel.crashing.org>
 <87vbhrlz4i.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: anton@au1.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-24 at 11:23 +0530, Aneesh Kumar K.V wrote:

> >>  	/* assume we don't have huge pages in vmalloc space... */
> >>  	addr = (pte_pfn(*p) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
> >> +	local_irq_restore(flags);
> >>  	return __va(addr);
> >>  }
> >
> > This is called in real mode, I don't like the debug stuff that can
> > happen inside local_irq_* in that context. Can you either pounce that
> > to the higher level callers (and so not do it in real mode at all) or
> > use a lower level variant ? (I prefer going for the callers).
> >
> 
> Which debug stuff ? the dump_stack print in
> find_linux_pte_or_hugepte ?.

No, local_save/irq_restore

>  One of the reason I endup using pr_info and
> not WARN_ON is that the later didn't work in real mode. Or are you
> suggesting that we don't need to track for irqs_disabled for real-mode ?
> I was not sure whether we avoid taking an IPI when we are in real mode. 

We take no interrupts in real mode (we run with EE off). Just pounce the
local_irq_save/restore to the upper level callers in the handful of virt
mode cases where we call into these functions.

Cheers,
Ben.
