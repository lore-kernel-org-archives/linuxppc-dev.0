Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F8221A0274
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 09:08:18 +1100 (AEDT)
Message-ID: <1428012483.20500.284.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 03 Apr 2015 09:08:03 +1100
In-Reply-To: <20150402215453.GB15680@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150402215453.GB15680@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-02 at 17:54 -0400, Sowmini Varadhan wrote:
> the other question that comes to my mind is: the whole lazy_flush
> optimization probably works best when there is exactly one pool,
> and no large pools. In most other cases, we'd end up doing a lazy_flush
> when we wrap within our pool itself, losing the benefit of that 
> optimization. 

Not a big deal. The point of the optimization is to avoid flushing on
every map/unmap. As long as the pool wrapping is an order of magnitude
rarer than actual map/unmap operations, it's a win.

> Given that the lazy_flush is mostly there to avoid regressions for 
> the older sun4u architectures (which have other hardware bottlenecks 
> anyway), and this code is rapidly getting messy, does it make sense
> to constrain the lazy_flush check to only apply for the 1-pool, 
> no-large-pool case?

I was planning to use it to improve things on older G5s as well and I
definitely want pools on these. Leave it in, we just need to get it
right.

I think it's not that messy, if you refactor the way I suggested, it
basically boils down to conditionally flushing in two places, at
the point where the pool lock is dropped, if the hint for that pool
was moved backward.

Do the test once in the else case of the n == -1 for all the "normal"
cases (which includes the hint > limit, multi-pass wrap and *handle
below hint, they are all covered) and in the pool hop'ing case.

Cheers,
Ben.
