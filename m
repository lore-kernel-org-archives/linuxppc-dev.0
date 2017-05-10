Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wNKhB54WtzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 01:21:11 +1000 (AEST)
Date: Wed, 10 May 2017 11:20:59 -0400 (EDT)
Message-Id: <20170510.112059.169845404310247896.davem@davemloft.net>
To: pasha.tatashin@oracle.com
Cc: mhocko@kernel.org, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 borntraeger@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: David Miller <davem@davemloft.net>
In-Reply-To: <ab667486-54a0-a36e-6797-b5f7b83c10f7@oracle.com>
References: <3f5f1416-aa91-a2ff-cc89-b97fcaa3e4db@oracle.com>
 <20170510145726.GM31466@dhcp22.suse.cz>
 <ab667486-54a0-a36e-6797-b5f7b83c10f7@oracle.com>
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

From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 10 May 2017 11:01:40 -0400

> Perhaps you are right, and I will measure on x86. But, I suspect hit
> can become unacceptable on some platfoms: there is an overhead of
> calling a function, even if it is leaf-optimized, and there is an
> overhead in memset() to check for alignments of size and address,
> types of setting (zeroing vs. non-zeroing), etc., that adds up
> quickly.

Another source of overhead on the sparc64 side is that we much
do memory barriers around the block initializiing stores.  So
batching calls to memset() amortize that as well.
