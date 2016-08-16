Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCv0y2htRzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 10:50:42 +1000 (AEST)
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
 [150.101.137.143])
 by ozlabs.org (Postfix) with ESMTP id 3sCv0y1DrBz9t1K
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2016 10:50:42 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: bsingharora@gmail.com
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, stewart@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/powernv: Initialise nest mmu
Date: Tue, 16 Aug 2016 10:37:58 +1000
Message-ID: <1989530.M5axb7bib9@new-mexico>
In-Reply-To: <20160815072240.GA21080@balbir.ozlabs.ibm.com>
References: <1471243919-18362-1-git-send-email-alistair@popple.id.au>
 <20160815072240.GA21080@balbir.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir,

<snip>
 
> > +	/* Update partition table control register on all Nest MMUs */
> > +	opal_nmmu_set_ptcr(-1UL, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
> > +
> 
> Just wondering if
> 
> 1. Instead of using -1 for all cpus, we should do
> 	for_each_online_cpu() {
> 		opal_numm_set_ptcr(...)
> 	}

Good question, but I don't think it makes sense to do that. The NMMU is
per-chip/socket rather than per-cpu so it shouldn't be tied to
onlining/offlining of individual CPUs.

> 2. In cpu hotplug path do the same when onlining and set to NULL on
> offlining?

Again, the nmmu isn't tied to a specific CPU but rather a chip/socket. So in
theory at least it's possible that all CPUs in a chip could be offline but
other units on the chip could still be using the nmmu so we wouldn't want to
disable the nmmu at that point.

> I think we should definitely try and become hotplug aware from the OS
> view point and drive it from the OS
> 
> What do you think?
>
> Balbir Singh.
