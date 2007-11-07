Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7152DDE1A
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 10:39:00 +1100 (EST)
Date: Thu, 8 Nov 2007 02:39:05 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1021205055.20071108023905@emcraft.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re[2]: [PATCH] [PPC 44x] L2-cache synchronization for ppc44x
In-Reply-To: <1194477573.6523.58.camel@pasglop>
References: <608329302.20071108021252@emcraft.com>
	<1194477573.6523.58.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Reply-To: Yuri Tikhonov <yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hi Ben,


On 08.11.2007, 2:19:33 you wrote:
> On Thu, 2007-11-08 at 02:12 +0300, Yuri Tikhonov wrote:
>> This is the updated patch for support synchronization of L2-Cache with
>> the external memory on the ppc44x-based platforms.
>> 
>>  Differencies against the previous patch-set:
>> - remove L2_CACHE config option;
>> - introduce the ppc machdep to invalidate L2 cache lines;
>> - some code clean-up.

> Can you tell me more about how this cache operates ? I don't quite
> understand why you would invalidate it on bidirectional DMAs rather than
> flush it to memory (unless you get your terminology wrong) and why you
> wouldn't flush it on transfers to the device.. Unless it is a
> write-through cache ?

 Yes, the ppc44x Level2 cache has the write-through design, so no need to do any kind of l2_flush.

 As far as the DMA_BIDIRECTIONAL case is concerned flush_dcache_range() flushes the data over the following path: L1->L2->RAM, but invalidates L1 only, and  L2 remains invalid. Since in the BIDIRECTIONAL case DMA may update the data in RAM - we have to invalidate L2-cache manually, so that CPU may read new data transmitted by DMA right from RAM rather than old ones stuck in L2 due to flush_dcache().


Regards,
 Yuri 

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
