Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wP58J2GmfzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 06:59:44 +1000 (AEST)
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: Pasha Tatashin <pasha.tatashin@oracle.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <20170509181234.GA4397@dhcp22.suse.cz>
 <fae4a92c-e78c-32cb-606a-8e5087acb13f@oracle.com>
 <20170510072419.GC31466@dhcp22.suse.cz>
 <3f5f1416-aa91-a2ff-cc89-b97fcaa3e4db@oracle.com>
 <20170510145726.GM31466@dhcp22.suse.cz>
 <ab667486-54a0-a36e-6797-b5f7b83c10f7@oracle.com>
 <9088ad7e-8b3b-8eba-2fdf-7b0e36e4582e@oracle.com>
Message-ID: <65b8a658-76d1-0617-ece8-ff7a3c1c4046@oracle.com>
Date: Thu, 11 May 2017 16:59:33 -0400
MIME-Version: 1.0
In-Reply-To: <9088ad7e-8b3b-8eba-2fdf-7b0e36e4582e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should either keep memset() only for deferred struct pages as what I 
have in my patches.

Another option is to add a new function struct_page_clear() which would 
default to memset() and to something else on platforms that decide to 
optimize it.

On SPARC it would call STBIs, and we would do one membar call after all 
"struct pages" are initialized.

I think what I sent out already is cleaner and better solution, because 
I am not sure what kind of performance we would see on other chips.

On 05/11/2017 04:47 PM, Pasha Tatashin wrote:
>>>
>>> Have you measured that? I do not think it would be super hard to
>>> measure. I would be quite surprised if this added much if anything at
>>> all as the whole struct page should be in the cache line already. We do
>>> set reference count and other struct members. Almost nobody should be
>>> looking at our page at this time and stealing the cache line. On the
>>> other hand a large memcpy will basically wipe everything away from the
>>> cpu cache. Or am I missing something?
>>>
> 
> Here is data for single thread (deferred struct page init is disabled):
> 
> Intel CPU E7-8895 v3 @ 2.60GHz  1T memory
> -----------------------------------------
> time to memset "struct pages in memblock: 11.28s
> time to init "struct pag"es:               4.90s
> 
> Moving memset into __init_single_page()
> time to init and memset "struct page"es:   8.39s
> 
> SPARC M6 @ 3600 MHz  1T memory
> -----------------------------------------
> time to memset "struct pages in memblock:  1.60s
> time to init "struct pag"es:               3.37s
> 
> Moving memset into __init_single_page()
> time to init and memset "struct page"es:  12.99s
> 
> 
> So, moving memset() into __init_single_page() benefits Intel. I am 
> actually surprised why memset() is so slow on intel when it is called 
> from memblock. But, hurts SPARC, I guess these membars at the end of 
> memset() kills the performance.
> 
> Also, when looking at these values, remeber that Intel has twice as many 
> "struct page" for the same amount of memory.
> 
> Pasha
> -- 
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
