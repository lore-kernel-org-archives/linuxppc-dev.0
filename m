Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3337FDDEEA
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 12:51:26 +1100 (EST)
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <ada8wonnh3t.fsf@cisco.com>
References: <20090203164930.GA10101@mtls03>  <ada8wonnh3t.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 12:50:48 +1100
Message-Id: <1233712248.16867.131.camel@pasglop>
Mime-Version: 1.0
Cc: Eli Cohen <eli@mellanox.co.il>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-02-03 at 17:08 -0800, Roland Dreier wrote:
> Forwarding Eli's patch below, since PowerPC guys may have missed it.  I
> guess the question for Ben et al is whether there is any issue with
> exporting HPAGE_SHIFT for modules (can be EXPORT_SYMBOL_GPL if you feel
> it's an internal detail).  It would probably make sense to roll this
> change into the mlx4 change that Eli alludes to below and merge through
> my tree (with ppc maintainer acks of course), rather than splitting this
> patch out and introducing cross-tree dependencies (and also separating
> the rationale for the change from the change itself).
> 
> Thanks,
>   Roland
> 
> 
> Drivers may want to take advantage of the large pages used for memory obtained
> from hugetlbfs. One example is mlx4_ib which can use much less MTT entries (in
> the order of HPAGE_SIZE / PAGE_SIZE) when registering such memory, thus scale
> significantly better when registering larger memory regions. Other drivers
> could also benefit from this.

Except that we support multiple large page sizes nowadays ... I think
the size can be specified per mountpoint of hugetlbfs no ? Thus things
like mellanox would have to query the page size used for a given
mapping.

Do the generic hugetlbfs code provides such an API ? If not, we may need
to add one.

Cheers,
Ben.

> Signed-off-by: Eli Cohen <eli@mellanox.co.il>
> ---
>  arch/powerpc/mm/hash_utils_64.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 8d5b475..6cff8c7 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -104,6 +104,7 @@ int mmu_highuser_ssize = MMU_SEGSIZE_256M;
>  u16 mmu_slb_size = 64;
>  #ifdef CONFIG_HUGETLB_PAGE
>  unsigned int HPAGE_SHIFT;
> +EXPORT_SYMBOL(HPAGE_SHIFT);
>  #endif
>  #ifdef CONFIG_PPC_64K_PAGES
>  int mmu_ci_restrictions;
