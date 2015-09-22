Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 3A0501A026E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 04:12:30 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 22/25] powerpc32: move xxxxx_dcache_range() functions
 inline
Date: Tue, 22 Sep 2015 18:12:27 +0000
Message-ID: <1442945547.29498.50.camel@transmode.se>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <c1c88096cb3f6ee71048dbab44ffb9ac260b07a3.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <c1c88096cb3f6ee71048dbab44ffb9ac260b07a3.1442939410.git.christophe.leroy@c-s.fr>
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

On Tue, 2015-09-22 at 18:51 +0200, Christophe Leroy wrote:
> flush/clean/invalidate _dcache_range() functions are all very
> similar and are quite short. They are mainly used in __dma_sync()
> perf_event locate them in the top 3 consumming functions during
> heavy ethernet activity
>=20
> They are good candidate for inlining, as __dma_sync() does
> almost nothing but calling them
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> New in v2
>=20
>  arch/powerpc/include/asm/cacheflush.h | 55 +++++++++++++++++++++++++++--
>  arch/powerpc/kernel/misc_32.S         | 65 -----------------------------=
------
>  arch/powerpc/kernel/ppc_ksyms.c       |  2 ++
>  3 files changed, 54 insertions(+), 68 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include=
/asm/cacheflush.h
> index 6229e6b..6169604 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -47,12 +47,61 @@ static inline void __flush_dcache_icache_phys(unsigne=
d long physaddr)
>  }
>  #endif
> =20
> -extern void flush_dcache_range(unsigned long start, unsigned long stop);
>  #ifdef CONFIG_PPC32
> -extern void clean_dcache_range(unsigned long start, unsigned long stop);
> -extern void invalidate_dcache_range(unsigned long start, unsigned long s=
top);
> +/*
> + * Write any modified data cache blocks out to memory and invalidate the=
m.
> + * Does not invalidate the corresponding instruction cache blocks.
> + */
> +static inline void flush_dcache_range(unsigned long start, unsigned long=
 stop)
> +{
> +	void *addr =3D (void *)(start & ~(L1_CACHE_BYTES - 1));
> +	unsigned int size =3D stop - (unsigned long)addr + (L1_CACHE_BYTES - 1)=
;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < size >> L1_CACHE_SHIFT; i++, addr +=3D L1_CACHE_BYTES=
)
> +		dcbf(addr);
> +	if (i)
> +		mb();	/* sync */
> +}

This feels optimized for the uncommon case when there is no invalidation.
I THINK it would be better to bail early and use do { .. } while(--i); inst=
ead.

 Jocke=
