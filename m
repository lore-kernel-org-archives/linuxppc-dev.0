Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNHVR6F3wzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 23:42:39 +1000 (AEST)
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <20170509181234.GA4397@dhcp22.suse.cz>
 <fae4a92c-e78c-32cb-606a-8e5087acb13f@oracle.com>
 <20170510072419.GC31466@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <3f5f1416-aa91-a2ff-cc89-b97fcaa3e4db@oracle.com>
Date: Wed, 10 May 2017 09:42:22 -0400
MIME-Version: 1.0
In-Reply-To: <20170510072419.GC31466@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> Well, I didn't object to this particular part. I was mostly concerned
> about
> http://lkml.kernel.org/r/1494003796-748672-4-git-send-email-pasha.tatashin@oracle.com
> and the "zero" argument for other functions. I guess we can do without
> that. I _think_ that we should simply _always_ initialize the page at the
> __init_single_page time rather than during the allocation. That would
> require dropping __GFP_ZERO for non-memblock allocations. Or do you
> think we could regress for single threaded initialization?
> 

Hi Michal,

Thats exactly right, I am worried that we will regress when there is no 
parallelized initialization of "struct pages" if we force 
unconditionally do memset() in __init_single_page(). The overhead of 
calling memset() on a smaller chunks (64-bytes) may cause the 
regression, this is why I opted only for parallelized case to zero this 
metadata. This way, we are guaranteed to see great improvements from 
this change without having regressions on platforms and builds that do 
not support parallelized initialization of "struct pages".

However, on some chips such as latest SPARCs it is beneficial to have 
memset() right inside __init_single_page() even for single threaded 
case, because it can act as a prefetch on chips with optimized block 
initialized store instructions.

Pasha
