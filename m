Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D41C51A1B42
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 18:04:23 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 187DE1400AB
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2014 18:04:22 +1000 (EST)
Message-ID: <1412323453.30859.31.camel@pasglop>
Subject: Re: powerpc/book3s: Fix flush_tlb cpu_spec hook to take a generic
 argument.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 03 Oct 2014 18:04:13 +1000
In-Reply-To: <20141003073622.3F0B8140180@ozlabs.org>
References: <20141003073622.3F0B8140180@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-03 at 17:36 +1000, Michael Ellerman wrote:
> It seems that the only detail we are abstracting here is that power7 has 128
> TLB sets and power8 has 512. Is that right?

Today ...

> It seems like a lot of code to deal with that one detail.
> 
> I guess the other thing it does is cur_cpu_spec->flush_tlb() is only
> implemented on power7 and power8, ie. not power6. But it seems that the two
> callers can only ever run on power7/power8 anway.
> 
> So couldn't we just do:
>  - add the number of tlb_sets to cpu_spec
>  - use that in flush_tlb()

Provided the form of tlbiel we use remains ... things are different from
embedded for example. I've asked Mahesh to add this hook with the idea
somewhat to migrate existing/older code to use it as well, and on older
chips or embedded the TLB flush is quite different.

Cheers,
Ben.
