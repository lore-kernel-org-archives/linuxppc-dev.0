Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20614B6F1E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 20:02:12 +1100 (EST)
Subject: Re: linux-next: rr tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20091112190308.443d97a3.sfr@canb.auug.org.au>
References: <20091112190308.443d97a3.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Nov 2009 20:02:00 +1100
Message-ID: <1258016520.2140.329.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>,
	Paul Mackerras <paulus@samba.org>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-12 at 19:03 +1100, Stephen Rothwell wrote:
> Hi Rusty,
> 
> Today's linux-next build (powerpc ppc44x_defconfig) failed like this:
> 
> .tmp_exports-asm.o: In function `__ksymtab_pci_alloc_consistent':
> (__ksymtab_sorted+0x2a30): undefined reference to `pci_alloc_consistent'
> .tmp_exports-asm.o: In function `__ksymtab_pci_free_consistent':
> (__ksymtab_sorted+0x2b70): undefined reference to `pci_free_consistent'
> 
> Caused by the powerpc architecture EXPORTing static inlines (for 32 bit
> builds) interacting with changes in the rr tree.
> 
> I have applied this patch for today:

Thanks. Our EXPORTs are bogus (probably leftovers) it seems. I'll dbl
check tomorrow but that looks like a patch I should pickup in powerpc
-next anyways.

Cheers,
Ben.

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 12 Nov 2009 18:54:13 +1100
> Subject: [PATCH] powerpc: do not export pci_alloc/free_consistent
> 
> Since they are static inline functions.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/ppc_ksyms.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
> index 07115d6..4254514 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -96,8 +96,6 @@ EXPORT_SYMBOL(copy_4K_page);
>  EXPORT_SYMBOL(isa_io_base);
>  EXPORT_SYMBOL(isa_mem_base);
>  EXPORT_SYMBOL(pci_dram_offset);
> -EXPORT_SYMBOL(pci_alloc_consistent);
> -EXPORT_SYMBOL(pci_free_consistent);
>  #endif /* CONFIG_PCI */
>  
>  EXPORT_SYMBOL(start_thread);
> -- 
> 1.6.5.2
> 
