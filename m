Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0FFD8DDFD2
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 13:24:40 +1000 (EST)
In-Reply-To: <20070823131032.04d929e7.sfr@canb.auug.org.au>
References: <20070823130913.2e9db6eb.sfr@canb.auug.org.au>
	<20070823131032.04d929e7.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DDBA4998-5BCC-413A-9759-3815693A68E6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] Size swapper_pg_dir correctly
Date: Wed, 22 Aug 2007 22:26:35 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 10:10 PM, Stephen Rothwell wrote:

> David Gibson pointed out that swapper_pg_dir actually need to be
> PGD_TABLE_SIZE bytes long not PAGE_SIZE.  This actually saves 64k in
> the bss for a ppc64_defconfig kernel built with CONFIG_PPC_64K_PAGES.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/asm-offsets.c |    4 ++++
>  arch/powerpc/kernel/head_64.S     |    2 +-
>  include/asm-powerpc/pgtable-4k.h  |    2 ++
>  include/asm-powerpc/pgtable-64k.h |    2 ++
>  4 files changed, 9 insertions(+), 1 deletions(-)
>
> --  
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
>
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/ 
> kernel/asm-offsets.c
> index a408053..0ae5d57 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -320,5 +320,9 @@ int main(void)
>  	DEFINE(VMALLOC_START_ESID, GET_ESID(VMALLOC_START));
>  	DEFINE(VMALLOC_START_VSID, KERNEL_VSID(VMALLOC_START));
>  #endif
> +
> +#ifdef CONFIG_PPC64
> +	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
> +#endif

Why limit this to ppc64?  The cleanup should be reasonable for all ppc.

- k
