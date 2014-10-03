Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 744091A0A5F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 17:36:22 +1000 (EST)
In-Reply-To: <20140923035330.6097.43515.stgit@mars>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/book3s: Fix flush_tlb cpu_spec hook to take a generic
 argument.
Message-Id: <20141003073622.3F0B8140180@ozlabs.org>
Date: Fri,  3 Oct 2014 17:36:22 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-23-09 at 03:53:54 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The flush_tlb hook in cpu_spec was introduced as a generic function hook
> to invalidate TLBs. But the current implementation of flush_tlb hook
> takes IS (invalidation selector) as an argument which is architecture
> dependent. Hence, It is not right to have a generic routine where caller
> has to pass non-generic argument.
> 
> This patch fixes this and makes flush_tlb hook as high level API.
> 
> The old code used to call flush_tlb hook with IS=0 (single page) resulting
> partial invalidation of TLBs which is not right. This fix now makes
> sure that whole TLB is invalidated to be able to successfully recover from
> TLB and ERAT errors.

Hi Mahesh,

It seems that the only detail we are abstracting here is that power7 has 128
TLB sets and power8 has 512. Is that right?

It seems like a lot of code to deal with that one detail.

I guess the other thing it does is cur_cpu_spec->flush_tlb() is only
implemented on power7 and power8, ie. not power6. But it seems that the two
callers can only ever run on power7/power8 anway.

So couldn't we just do:
 - add the number of tlb_sets to cpu_spec
 - use that in flush_tlb()

cheers
