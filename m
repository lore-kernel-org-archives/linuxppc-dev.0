Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7bcz6tYzzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 08:04:19 +1000 (AEST)
In-Reply-To: <20170411075457.28020-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: v4.9+@ozlabs.ru, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Greg Kurz <groug@kaod.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, #@ozlabs.ru
Subject: Re: [kernel,
 v2] powerpc/iommu: Do not call PageTransHuge() on tail pages
Message-Id: <3w7bcz5ZT4z9s7k@ozlabs.org>
Date: Thu, 20 Apr 2017 08:04:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-11 at 07:54:57 UTC, Alexey Kardashevskiy wrote:
> The CMA pages migration code does not support compound pages at
> the moment so it performs few tests before proceeding to actual page
> migration.
> 
> One of the tests - PageTransHuge() - has VM_BUG_ON_PAGE(PageTail()) as
> it is designed to be called on head pages only. Since we also test for
> PageCompound(), and it contains PageTail() and PageHead(), we can
> simplify the check by leaving just PageCompound() and therefore avoid
> possible VM_BUG_ON_PAGE.
> 
> Fixes: 2e5bbb5461f1 ("KVM: PPC: Book3S HV: Migrate pinned pages out of CMA")
> Cc: stable@vger.kernel.org # v4.9+
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e889e96e98e8da97bd39e46b725361

cheers
