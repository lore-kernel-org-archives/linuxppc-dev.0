Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3BFC41A09FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 11:42:09 +1100 (AEDT)
Date: Thu, 02 Apr 2015 20:42:01 -0400 (EDT)
Message-Id: <20150402.204201.1019535262608342723.davem@davemloft.net>
To: sowmini.varadhan@oracle.com
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150402215453.GB15680@oracle.com>
References: <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150402215453.GB15680@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 2 Apr 2015 17:54:53 -0400

> the other question that comes to my mind is: the whole lazy_flush
> optimization probably works best when there is exactly one pool,
> and no large pools. In most other cases, we'd end up doing a lazy_flush
> when we wrap within our pool itself, losing the benefit of that 
> optimization. 
> 
> Given that the lazy_flush is mostly there to avoid regressions for 
> the older sun4u architectures (which have other hardware bottlenecks 
> anyway), and this code is rapidly getting messy, does it make sense
> to constrain the lazy_flush check to only apply for the 1-pool, 
> no-large-pool case?

I think it's better to have the multiple pools with more often global
flushing.
