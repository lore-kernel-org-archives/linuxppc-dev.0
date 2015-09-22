Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id B1C5E1A01DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 03:57:56 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 20/25] powerpc32: Remove clear_pages() and define
 clear_page() inline
Date: Tue, 22 Sep 2015 17:57:49 +0000
Message-ID: <1442944669.29498.46.camel@transmode.se>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <9dcad7b2c05a397a97cc1cab211b6cf0f09a9900.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <9dcad7b2c05a397a97cc1cab211b6cf0f09a9900.1442939410.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe

Really nice patchset!

On Tue, 2015-09-22 at 18:51 +0200, Christophe Leroy wrote:
> clear_pages() is never used, and PPC32 is the only architecture
> (still) having this function. Neither PPC64 nor any other
> architecture has it.
>=20
> This patch removes clear_page() and move clear_page() function
> inline (same as PPC64) as it only is a few isns
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> No change in v2
>=20
>  arch/powerpc/include/asm/page_32.h | 17 ++++++++++++++---
>  arch/powerpc/kernel/misc_32.S      | 16 ----------------
>  arch/powerpc/kernel/ppc_ksyms_32.c |  1 -
>  3 files changed, 14 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/as=
m/page_32.h
> index 68d73b2..6a8e179 100644
> --- a/arch/powerpc/include/asm/page_32.h
> +++ b/arch/powerpc/include/asm/page_32.h
> @@ -1,6 +1,8 @@
>  #ifndef _ASM_POWERPC_PAGE_32_H
>  #define _ASM_POWERPC_PAGE_32_H
> =20
> +#include <asm/cache.h>
> +
>  #if defined(CONFIG_PHYSICAL_ALIGN) && (CONFIG_PHYSICAL_START !=3D 0)
>  #if (CONFIG_PHYSICAL_START % CONFIG_PHYSICAL_ALIGN) !=3D 0
>  #error "CONFIG_PHYSICAL_START must be a multiple of CONFIG_PHYSICAL_ALIG=
N"
> @@ -36,9 +38,18 @@ typedef unsigned long long pte_basic_t;
>  typedef unsigned long pte_basic_t;
>  #endif
> =20
> -struct page;
> -extern void clear_pages(void *page, int order);
> -static inline void clear_page(void *page) { clear_pages(page, 0); }
> +/*
> + * Clear page using the dcbz instruction, which doesn't cause any
> + * memory traffic (except to write out any cache lines which get
> + * displaced).  This only works on cacheable memory.
> + */
> +static inline void clear_page(void *addr)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < PAGE_SIZE / L1_CACHE_BYTES; i++, addr +=3D L1_CACHE_B=
YTES)
> +		dcbz(addr);
> +}

Does gcc manage to transform this into efficient asm?
Otherwise you could help gcc by using do { .. } while(--i); instead.
