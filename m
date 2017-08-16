Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTF732JXzDrJp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:47 +1000 (AEST)
In-Reply-To: <20170712150342.136ED6A666@pc13941vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/hugetlb: fix page rights verification in gup_hugepte()
Message-Id: <3xXTF72VThz9t4P@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-12 at 15:03:42 UTC, Christophe Leroy wrote:
> gup_hugepte() checks if pages are present and readable, and
> when  'write' is set, also checks if the pages are writable.
> 
> Initially this was done by checking if _PAGE_PRESENT and
> _PAGE_READ were set. In addition, _PAGE_WRITE was verified for write
> accesses.
> 
> The problem is that we have to handle the three following cases:
> 1/ The target defines __PAGE_READ and __PAGE_WRITE
> 2/ The target defines __PAGE_RW
> 3/ The target defines __PAGE_RO
> 
> In case 1/, this is obvious
> In case 2/, __PAGE_READ is defined as 0 and __PAGE_WRITE as __PAGE_RW
> so it works as well.
> But in case 3, __PAGE_RW is defined as 0, which means __PAGE_WRITE is 0
> and then the test returns true (page writable) in all cases.
> 
> A first correction was attempted in commit 6b8cb66a6a7cc ("powerpc: Fix
> usage of _PAGE_RO in hugepage"), but that fix is wrong:
> instead of checking that the page is writable when write is requested,
> it checks that the page is NOT writable when write is NOT requested.
> 
> This patch adds a new pte_read() helper to check whether a page is
> readable or not. This avoids handling all possible cases in
> gup_hugepte().
> 
> Then gup_hugepte() is modified to use pte_present(), pte_read()
> and pte_write() instead of the raw flags.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ca8afd4046255ac046f8229d5159c6

cheers
