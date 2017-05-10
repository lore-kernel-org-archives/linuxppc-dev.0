Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wNKfX6T2SzDqKR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 01:19:46 +1000 (AEST)
Date: Wed, 10 May 2017 11:19:43 -0400 (EDT)
Message-Id: <20170510.111943.1940354761418085760.davem@davemloft.net>
To: mhocko@kernel.org
Cc: pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 borntraeger@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170510145726.GM31466@dhcp22.suse.cz>
References: <20170510072419.GC31466@dhcp22.suse.cz>
 <3f5f1416-aa91-a2ff-cc89-b97fcaa3e4db@oracle.com>
 <20170510145726.GM31466@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 10 May 2017 16:57:26 +0200

> Have you measured that? I do not think it would be super hard to
> measure. I would be quite surprised if this added much if anything at
> all as the whole struct page should be in the cache line already. We do
> set reference count and other struct members. Almost nobody should be
> looking at our page at this time and stealing the cache line. On the
> other hand a large memcpy will basically wipe everything away from the
> cpu cache. Or am I missing something?

I guess it might be clearer if you understand what the block
initializing stores do on sparc64.  There are no memory accesses at
all.

The cpu just zeros out the cache line, that's it.

No L3 cache line is allocated.  So this "wipe everything" behavior
will not happen in the L3.
