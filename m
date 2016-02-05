Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C5701A0026
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 03:04:06 +1100 (AEDT)
Date: Fri, 5 Feb 2016 16:03:53 +0000
From: Luis Henriques <luis.henriques@canonical.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] PPC32: Fix build failure caused by missing dirty pte
 handlers
Message-ID: <20160205160353.GA27574@ares>
References: <1453731778-18464-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1453731778-18464-1-git-send-email-bobby.prani@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 25, 2016 at 09:22:58AM -0500, Pranith Kumar wrote:
> In 4.5-rc1, I am getting a build failure as follows:
> 
> mm/memory.c: In function ‘do_swap_page’:
> mm/memory.c:2573:9: error: implicit declaration of function ‘pte_mksoft_dirty’
> [-Werror=implicit-function-declaration]
>    pte = pte_mksoft_dirty(pte);
> 
> The soft dirty pte handlers are declared only for PPC64 on PPC_BOOK3S in
> arch/powerpc/include/asm/book3s/64/hash.h and missing in the 32-bit arch.
> 
> Avoid this error by not setting HAVE_ARCH_SOFT_DIRTY for 32-bit system.
>

I am seeing this build failure too and I can confirm that this patch fixes
it.  I would just add a

Fixes: 7207f43665b8 ("powerpc/mm: Add page soft dirty tracking")

to this patch.  Feel free to add my 'Tested-by:'.

Cheers,
--
Luís


> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/powerpc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e4824fd..21cb5c5 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -557,7 +557,7 @@ choice
>  
>  config PPC_4K_PAGES
>  	bool "4k page size"
> -	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
> +	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S && PPC64
>  
>  config PPC_16K_PAGES
>  	bool "16k page size"
> @@ -566,7 +566,7 @@ config PPC_16K_PAGES
>  config PPC_64K_PAGES
>  	bool "64k page size"
>  	depends on !PPC_FSL_BOOK3E && (44x || PPC_STD_MMU_64 || PPC_BOOK3E_64)
> -	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
> +	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S && PPC64
>  
>  config PPC_256K_PAGES
>  	bool "256k page size"
> -- 
> 2.7.0
> 
