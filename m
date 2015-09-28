Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0114.outbound.protection.outlook.com [207.46.100.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 873DB1A013E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 09:41:31 +1000 (AEST)
Date: Mon, 28 Sep 2015 18:41:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 06/25] powerpc32: iounmap() cannot vunmap() area
 mapped by TLBCAMs either
Message-ID: <20150928234116.GC6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <2b94a5b931daa6aa2f32ddad88175d932da4d573.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <2b94a5b931daa6aa2f32ddad88175d932da4d573.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:50:40PM +0200, Christophe Leroy wrote:
> iounmap() cannot vunmap() area mapped by TLBCAMs either
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> No change in v2
> 
>  arch/powerpc/mm/pgtable_32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 7692d1b..03a073a 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -278,7 +278,9 @@ void iounmap(volatile void __iomem *addr)
>  	 * If mapped by BATs then there is nothing to do.
>  	 * Calling vfree() generates a benign warning.
>  	 */
> -	if (v_mapped_by_bats((unsigned long)addr)) return;
> +	if (v_mapped_by_bats((unsigned long)addr) ||
> +	    v_mapped_by_tlbcam((unsigned long)addr))
> +		return;

This is pretty pointless given that the next patch replaces both with
v_mapped_by_other().

-Scott
