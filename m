Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0132.outbound.protection.outlook.com [157.56.111.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AD4E1A0014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 09:47:14 +1000 (AEST)
Date: Mon, 28 Sep 2015 18:47:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 07/25] powerpc32: refactor x_mapped_by_bats() and
 x_mapped_by_tlbcam() together
Message-ID: <20150928234702.GD6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <a5b89d1db195031679775bfe7c32f903e9403bb3.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <a5b89d1db195031679775bfe7c32f903e9403bb3.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:50:42PM +0200, Christophe Leroy wrote:
> x_mapped_by_bats() and x_mapped_by_tlbcam() serve the same kind of
> purpose, so lets group them into a single function.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> No change in v2
> 
>  arch/powerpc/mm/pgtable_32.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 03a073a..3fd9083 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -67,6 +67,28 @@ extern unsigned long p_mapped_by_tlbcam(phys_addr_t pa);
>  #define p_mapped_by_tlbcam(x)	(0UL)
>  #endif /* HAVE_TLBCAM */
>  
> +static inline unsigned long p_mapped_by_other(phys_addr_t pa)
> +{
> +	unsigned long v;
> +
> +	v = p_mapped_by_bats(pa);
> +	if (v /*&& p_mapped_by_bats(p+size-1)*/)
> +		return v;
> +
> +	return p_mapped_by_tlbcam(pa);
> +}

Did you forget to remove that comment?

-Scott
