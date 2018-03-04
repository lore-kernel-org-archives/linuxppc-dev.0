Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvKgr0SCTzF0Wy
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 21:55:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in
 pfn_valid
In-Reply-To: <20180225172236.29650-6-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-6-malat@debian.org>
Date: Sun, 04 Mar 2018 21:55:17 +1100
Message-ID: <87lgf8gley.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> writes:

> Rewrite comparison since all values compared are of type `unsigned long`.
>
> Fix a warning (treated as error in W=3D1):
>
>   CC      arch/powerpc/kernel/irq.o
> In file included from ./include/linux/bug.h:5:0,
>                  from ./include/linux/cpumask.h:13,
>                  from ./include/linux/smp.h:13,
>                  from ./include/linux/kernel_stat.h:5,
>                  from arch/powerpc/kernel/irq.c:35:
> ./include/linux/dma-mapping.h: In function =E2=80=98dma_map_resource=E2=
=80=99:
> ./arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned e=
xpression >=3D 0 is always true [-Werror=3Dtype-limits]
>  #define pfn_valid(pfn)  ((pfn) >=3D ARCH_PFN_OFFSET && (pfn) < max_mapnr)
>                                 ^
> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/powerpc/include/asm/page.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/p=
age.h
> index 8da5d4c1cab2..19dea64e7ed2 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -126,7 +126,8 @@ extern long long virt_phys_offset;
>=20=20
>  #ifdef CONFIG_FLATMEM
>  #define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
> -#define pfn_valid(pfn)		((pfn) >=3D ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> +#define pfn_valid(pfn) \
> +		(((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))

I'm not a big fan of this one, because the original code is *far* more
obvious as to what it's doing.

I'm not sure if we can make this one a static inline, or whether that
would help, but it would be worth investigating.

cheers
