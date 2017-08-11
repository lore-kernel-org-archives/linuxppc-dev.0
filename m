Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTVFV1VCtzDr2M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:04:45 +1000 (AEST)
Subject: Re: [v6 08/15] mm: zero struct pages during initialization
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-9-git-send-email-pasha.tatashin@oracle.com>
 <20170811125047.GJ30811@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <f81f5eaa-109e-666e-7020-84c090721a56@oracle.com>
Date: Fri, 11 Aug 2017 12:03:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170811125047.GJ30811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I believe this deserves much more detailed explanation why this is safe.
> What actually prevents any pfn walker from seeing an uninitialized
> struct page? Please make your assumptions explicit in the commit log so
> that we can check them independently.

There is nothing prevents pfn walkers from walk over any struct pages 
deferred and non-deferred. However, during boot before deferred pages 
are initialized we have just a few places that do that, and all of those 
cases are fixed in this patchset.

> Also this is done with some purpose which is the perfmance, right? You
> have mentioned that in the cover letter but if somebody is going to read
> through git logs this wouldn't be obvious from the specific commit.
> So add that information here as well. Especially numbers will be
> interesting.

I will add more performance data to this patch comment.
