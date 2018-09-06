Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425gJh3S9BzF3Rc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 22:45:08 +1000 (AEST)
Date: Thu, 6 Sep 2018 14:45:04 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 mpe@ellerman.id.au, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V2 2/4] mm: Add get_user_pages_cma_migrate
Message-ID: <20180906124504.GW14951@dhcp22.suse.cz>
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906054342.25094-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906054342.25094-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 06-09-18 11:13:40, Aneesh Kumar K.V wrote:
> This helper does a get_user_pages_fast and if it find pages in the CMA area
> it will try to migrate them before taking page reference. This makes sure that
> we don't keep non-movable pages (due to page reference count) in the CMA area.
> Not able to move pages out of CMA area result in CMA allocation failures.

Again, there is no user so it is hard to guess the intention completely.
There is no documentation to describe the expected context and
assumptions about locking etc.

As noted in the previous email. You should better describe why you are
bypassing hugetlb pools. I assume that the reason is to guarantee a
forward progress because those might be sitting in the CMA pools
already, right?
-- 
Michal Hocko
SUSE Labs
