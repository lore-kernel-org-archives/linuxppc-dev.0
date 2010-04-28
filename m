Return-Path: <xiaoxianghua@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 92C1AB7D2D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Apr 2010 05:15:53 +1000 (EST)
Received: by gwj17 with SMTP id 17so3891961gwj.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Apr 2010 12:15:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1272439375.24542.94.camel@pasglop>
References: <1272439375.24542.94.camel@pasglop>
Date: Wed, 28 Apr 2010 14:15:50 -0500
Message-ID: <y2te6bf505b1004281215n9dcc6190j9915aa27ae91f75d@mail.gmail.com>
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
From: Xianghua Xiao <xiaoxianghua@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 28, 2010 at 2:22 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> So we tried to speed things up a bit using flush_hash_pages() directly
> but that falls over on 603 of course meaning we fail to flush the TLB
> properly and we may even end up having it corrupt memory randomly by
> accessing a hash table that doesn't exist.
>
> This removes the "optimization" by always going through flush_tlb_page()
> for now at least.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Somebody with a 603 or e300 core based FSL SoC to try this out for me ?
>
> It's obviously completely untested :-)
>
> Cheers,
> Ben.
>
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index b9243e7..95774b4 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -385,11 +385,7 @@ static int __change_page_attr(struct page *page, pgp=
rot_t prot)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_pte_at(&init_mm, address, kpte, mk_pte(p=
age, prot), 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wmb();
> -#ifdef CONFIG_PPC_STD_MMU
> - =C2=A0 =C2=A0 =C2=A0 flush_hash_pages(0, address, pmd_val(*kpmd), 1);
> -#else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_tlb_page(NULL, address);
> -#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pte_unmap(kpte);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
This change works me on a 834x(e300) platform, tested with lmbench and
a production-ready application with 2.6.33.3.

Xianghua
