Return-Path: <B40534@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 946D92C018F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 13:25:02 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Kevin Hao <haokexin@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: [PATCH] powerpc: add the missing required isync for the
 coherent icache flush
Date: Mon, 19 Aug 2013 03:24:50 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F1543925901020606@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1376567767-20620-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1376567767-20620-1-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+b40534=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Kevin Hao
> Sent: Thursday, August 15, 2013 7:56 PM
> To: Benjamin Herrenschmidt
> Cc: linuxppc
> Subject: [PATCH] powerpc: add the missing required isync for the coherent
> icache flush
>=20
> Even we don't need to flush the dcache and invalidate the icache
> on the CPU which has coherent icache. But we do need an isync to
> discard the prefetched instructions in this case.
>=20
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/kernel/misc_32.S | 2 ++
>  arch/powerpc/kernel/misc_64.S | 1 +
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/misc_32.S
> b/arch/powerpc/kernel/misc_32.S
> index 777d999..0b84c8d 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -433,6 +433,7 @@ _GLOBAL(invalidate_dcache_range)
>   */
>  _GLOBAL(__flush_dcache_icache)
>  BEGIN_FTR_SECTION
> +	isync
There is not touch the icache, why need we to do this?

>  	blr
>  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>  	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address
> */
> @@ -474,6 +475,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_44x)
>   */
>  _GLOBAL(__flush_dcache_icache_phys)
>  BEGIN_FTR_SECTION
> +	isync
>  	blr					/* for 601, do nothing */
>  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>  	mfmsr	r10
> diff --git a/arch/powerpc/kernel/misc_64.S
> b/arch/powerpc/kernel/misc_64.S
> index 992a78e..d74fefb 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -69,6 +69,7 @@ PPC64_CACHES:
>=20
>  _KPROBE(flush_icache_range)
>  BEGIN_FTR_SECTION
> +	isync
>  	blr
>  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>  /*
> --
> 1.8.3.1
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
