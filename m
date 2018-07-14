Return-Path: <srs0=wnvg=j6=infradead.org=rdunlap@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41SH0v0XhdzDqgr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 14:35:43 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41SH0t6VtSz8sxY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 14:35:42 +1000 (AEST)
Subject: Re: [PATCH 1/2] powerpc: Add ppc32_allmodconfig defconfig target
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com, malat@debian.org
References: <20180709142426.26999-1-mpe@ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a41ed163-3db6-f204-4262-d428ec0a8d7a@infradead.org>
Date: Fri, 13 Jul 2018 21:35:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180709142426.26999-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2018 07:24 AM, Michael Ellerman wrote:
> Because the allmodconfig logic just sets every symbol to M or Y, it
> has the effect of always generating a 64-bit config, because
> CONFIG_PPC64 becomes Y.
> 
> So to make it easier for folks to test 32-bit code, provide a phony
> defconfig target that generates a 32-bit allmodconfig.
> 
> The 32-bit port has several mutually exclusive CPU types, we choose
> the Book3S variants as that's what the help text in Kconfig says is
> most common.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Hi Michael,

ppc32_allmodconfig sets CONFIG_ISA=y (and other related symbols) and
CONFIG_PPC_CHRP=y.  But my builds are failing because they are missing
the functions isa_bus_to_virt() and isa_virt_to_bus().

Any ideas?

Thanks.

> ---
>  arch/powerpc/Makefile                 | 5 +++++
>  arch/powerpc/configs/book3s_32.config | 2 ++
>  2 files changed, 7 insertions(+)
>  create mode 100644 arch/powerpc/configs/book3s_32.config
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 2ea575cb3401..2556c2182789 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -354,6 +354,11 @@ mpc86xx_smp_defconfig:
>  	$(call merge_into_defconfig,mpc86xx_basic_defconfig,\
>  		86xx-smp 86xx-hw fsl-emb-nonhw)
>  
> +PHONY += ppc32_allmodconfig
> +ppc32_allmodconfig:
> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
> +		-f $(srctree)/Makefile allmodconfig
> +
>  define archhelp
>    @echo '* zImage          - Build default images selected by kernel config'
>    @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
> diff --git a/arch/powerpc/configs/book3s_32.config b/arch/powerpc/configs/book3s_32.config
> new file mode 100644
> index 000000000000..8721eb7b1294
> --- /dev/null
> +++ b/arch/powerpc/configs/book3s_32.config
> @@ -0,0 +1,2 @@
> +CONFIG_PPC64=n
> +CONFIG_PPC_BOOK3S_32=y
> 


-- 
~Randy
