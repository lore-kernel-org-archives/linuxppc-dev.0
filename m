Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 85B0C1A0279
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:44:57 +1100 (AEDT)
Date: Mon, 23 Mar 2015 21:44:53 -0400 (EDT)
Message-Id: <20150323.214453.255192641139042325.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
In-Reply-To: <1427149265.4770.238.camel@kernel.crashing.org>
References: <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
 <1427149265.4770.238.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, aik@ozlabs.ru, sowmini.varadhan@oracle.com,
 anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Mar 2015 09:21:05 +1100

> Dave, what's your feeling there ? Does anybody around still have
> some HW that we can test with ?

I don't see what the actual problem is.

Even if you use multiple pools, which we should for scalability on
sun4u too, just do the flush when allocation in _any_ pool wraps
around.

That's still better than not doing the optimization at all.

That is always going to be correct, and you can use a separate
spinlock to make sure only one thread of control does the full
IOMMU flush at a time.
