Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id CED201A0145
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 14:12:29 +1100 (AEDT)
Date: Tue, 31 Mar 2015 23:12:24 -0400 (EDT)
Message-Id: <20150331.231224.402909066860518278.davem@davemloft.net>
To: sowmini.varadhan@oracle.com
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
In-Reply-To: <551B4502.1020603@oracle.com>
References: <20150331180642.GA13314@oracle.com>
 <1427850091.20500.150.camel@kernel.crashing.org>
 <551B4502.1020603@oracle.com>
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
Date: Tue, 31 Mar 2015 21:08:18 -0400

> I'm starting to wonder if  some approximation of dma premapped
> buffers may be needed. Doing a map/unmap on each packet is expensive.

It's much more amortized with smart buffering strategies, which are
common on current generation networking cards.

There you only eat one map/unmap per "PAGE_SIZE / rx_pkt_size".

Maybe the infiniband stuff is doing things very suboptimally, and
actually with that subsystem and drivers absolutely nothing would
surprise me.
