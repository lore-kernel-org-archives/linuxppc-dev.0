Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A93521A0598
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:17:21 +1100 (AEDT)
In-Reply-To: <1444359741-3037-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Differentiate between hugetlb and THP during page walk
Message-Id: <20151012111721.92EAE140D8F@ozlabs.org>
Date: Mon, 12 Oct 2015 22:17:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-09-10 at 03:02:21 UTC, "Aneesh Kumar K.V" wrote:
> We need to properly identify whether a hugepage is an explicit or
> a transparent hugepage in follow_huge_addr(). We used to depend
> on hugepage shift argument to do that. But in some case that can
> result in wrong results. For ex:
> 
> On finding a transparent hugepage we set hugepage shift to PMD_SHIFT.
> But we can end up clearing the thp pte, via pmdp_huge_get_and_clear.
> We do prevent reusing the pfn page via the usage of
> kick_all_cpus_sync(). But that happens after we updated the pte to 0.
> Hence in follow_huge_addr() we can find hugepage shift set, but transparent
> huge page check fail for a thp pte.
> 
> NOTE: We fixed a variant of this race against thp split in commit
> 691e95fd7396905a38d98919e9c150dbc3ea21a3
> ("powerpc/mm/thp: Make page table walk safe against thp split/collapse")
> 
> Without this patch, we may hit the BUG_ON(flags & FOLL_GET) in
> follow_page_mask occasionally.
> 
> In the long term, we may want to switch ppc64 64k page size config to
> enable CONFIG_ARCH_WANT_GENERAL_HUGETLB
> 
> Reported-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/891121e6c02c6242487aa4ea

cheers
