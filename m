Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x6354c4mzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 00:18:41 +1000 (AEST)
In-Reply-To: <8097a1d32403ea47d076803e9070869badfe24bc.1534856426.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: powerpc/nohash: fix pte_access_permitted()
Message-Id: <41x63533G3z9s5b@ozlabs.org>
Date: Fri, 24 Aug 2018 00:18:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-21 at 13:03:23 UTC, Christophe Leroy wrote:
> Commit 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper
> for other platforms") replaced generic pte_access_permitted() by an
> arch specific one.
> 
> The generic one is defined as
> (pte_present(pte) && (!(write) || pte_write(pte)))
> 
> The arch specific one is open coded checking that _PAGE_USER and
> _PAGE_WRITE (_PAGE_RW) flags are set, but lacking to check that
> _PAGE_RO and _PAGE_PRIVILEGED are unset, leading to a useless test
> on targets like the 8xx which defines _PAGE_RW and _PAGE_USER as 0.
> 
> Commit 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted
> for hugetlb access check") replaced some tests performed with
> pte helpers by a call to pte_access_permitted(), leading to the same
> issue.
> 
> This patch rewrites powerpc/nohash pte_access_permitted()
> using pte helpers.
> 
> Fixes: 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper for other platforms")
> Fixes: 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted for hugetlb access check")
> Cc: stable@vger.kernel.org # v4.15+
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/810e9f86f36f59f1d6f6710220c49a

cheers
