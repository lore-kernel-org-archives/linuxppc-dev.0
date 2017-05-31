Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdGhZ5c6XzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 02:51:23 +1000 (AEST)
Date: Wed, 31 May 2017 12:51:18 -0400 (EDT)
Message-Id: <20170531.125118.94140984076231176.davem@davemloft.net>
To: mhocko@kernel.org
Cc: pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 borntraeger@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170531163131.GY27783@dhcp22.suse.cz>
References: <20170529115358.GJ19725@dhcp22.suse.cz>
 <ae992f21-3edf-1ae7-41db-641052e411c7@oracle.com>
 <20170531163131.GY27783@dhcp22.suse.cz>
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
Date: Wed, 31 May 2017 18:31:31 +0200

> On Tue 30-05-17 13:16:50, Pasha Tatashin wrote:
>> >Could you be more specific? E.g. how are other stores done in
>> >__init_single_page safe then? I am sorry to be dense here but how does
>> >the full 64B store differ from other stores done in the same function.
>> 
>> Hi Michal,
>> 
>> It is safe to do regular 8-byte and smaller stores (stx, st, sth, stb)
>> without membar, but they are slower compared to STBI which require a membar
>> before memory can be accessed.
> 
> OK, so why cannot we make zero_struct_page 8x 8B stores, other arches
> would do memset. You said it would be slower but would that be
> measurable? I am sorry to be so persistent here but I would be really
> happier if this didn't depend on the deferred initialization. If this is
> absolutely a no-go then I can live with that of course.

It is measurable.  That's the impetus for this work in the first place.

When the do the memory barrier, the whole store buffer flushes because
the memory barrier is done with a dependency on the next load or store
operation, one of which the caller is going to do immediately.
