Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC1CT4Tr9zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 07:27:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>
Subject: Re: [PATCH 9/9] powerpc: A new cache geometry aux vectors
In-Reply-To: <20170108233150.15353-9-benh@kernel.crashing.org>
References: <20170108233150.15353-1-benh@kernel.crashing.org>
 <20170108233150.15353-9-benh@kernel.crashing.org>
Date: Tue, 31 Jan 2017 07:27:13 +1100
Message-ID: <87bmuowaxq.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/el=
f.h
> index 730c27e..a128836 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -156,6 +163,14 @@ do {									\
>  	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
>  	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
>  	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->mm->context.vdso_base);	\
> +	NEW_AUX_ENT(AT_L1I_CACHESIZE, ppc64_caches.l1i.size);		\
> +	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY, get_cache_shape(l1i));	\
> +	NEW_AUX_ENT(AT_L1D_CACHESIZE, ppc64_caches.l1i.size);		\
> +	NEW_AUX_ENT(AT_L1D_CACHEGEOMETRY, get_cache_shape(l1i));	\
> +	NEW_AUX_ENT(AT_L2_CACHESIZE, ppc64_caches.l2.size);		\
> +	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY, get_cache_shape(l2));		\
> +	NEW_AUX_ENT(AT_L3_CACHESIZE, ppc64_caches.l3.size);		\
> +	NEW_AUX_ENT(AT_L3_CACHEGEOMETRY, get_cache_shape(l3));		\
>  } while (0)
=20=20
This breaks the 32-bit build:


  ../fs/binfmt_elf.c: In function =E2=80=98create_elf_tables=E2=80=99:
  ../arch/powerpc/include/asm/elf.h:166:32: error: =E2=80=98ppc64_caches=E2=
=80=99 undeclared (first use in this function)
    NEW_AUX_ENT(AT_L1I_CACHESIZE, ppc64_caches.l1i.size);  \
                                  ^
  ../fs/binfmt_elf.c:222:26: note: in definition of macro =E2=80=98NEW_AUX_=
ENT=E2=80=99
     elf_info[ei_index++] =3D val; \
                            ^~~
  ../fs/binfmt_elf.c:232:2: note: in expansion of macro =E2=80=98ARCH_DLINF=
O=E2=80=99
    ARCH_DLINFO;
    ^~~~~~~~~~~
  ../arch/powerpc/include/asm/elf.h:166:32: note: each undeclared identifie=
r is reported only once for each function it appears in
    NEW_AUX_ENT(AT_L1I_CACHESIZE, ppc64_caches.l1i.size);  \
                                  ^
  ../fs/binfmt_elf.c:222:26: note: in definition of macro =E2=80=98NEW_AUX_=
ENT=E2=80=99
     elf_info[ei_index++] =3D val; \
                            ^~~
  ../fs/binfmt_elf.c:232:2: note: in expansion of macro =E2=80=98ARCH_DLINF=
O=E2=80=99
    ARCH_DLINFO;
    ^~~~~~~~~~~
  make[2]: *** [fs/binfmt_elf.o] Error 1
  make[2]: *** Waiting for unfinished jobs....
  make[1]: *** [fs] Error 2
  make: *** [sub-make] Error 2


Will need some more macro foo.

cheers
