Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FEEADDF47
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 09:09:17 +1000 (EST)
Date: Wed, 27 Jun 2007 16:09:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: mm snapshot broken-out-2007-06-27-03-28.tar.gz uploaded
Message-Id: <20070627160908.fe9052e4.akpm@linux-foundation.org>
In-Reply-To: <200706280057.07481.m.kozlowski@tuxland.pl>
References: <200706271030.l5RAUgKE015163@imap1.linux-foundation.org>
	<200706280057.07481.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Jun 2007 00:57:07 +0200
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	Build problems on iMac G3.
> 
> 1) allnoconfig results in this:
> 
>  CC      arch/powerpc/mm/tlb_32.o
> In file included from include/asm/tlb.h:60,
>                  from arch/powerpc/mm/tlb_32.c:30:
> include/asm-generic/tlb.h: In function 'tlb_flush_mmu':
> include/asm-generic/tlb.h:76: error: implicit declaration of function 'release_pages'
> include/asm-generic/tlb.h: In function 'tlb_remove_page':
> include/asm-generic/tlb.h:105: error: implicit declaration of function 'page_cache_release'
> make[1]: *** [arch/powerpc/mm/tlb_32.o] Blad 1
> make: *** [arch/powerpc/mm] Blad 2
> 
> 
> The patch below fixes that for me.
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
>  arch/powerpc/mm/tlb_32.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-2.6.22-rc6-bo-a/arch/powerpc/mm/tlb_32.c	2007-06-27 23:38:49.000000000 +0200
> +++ linux-2.6.22-rc6-bo-b/arch/powerpc/mm/tlb_32.c	2007-06-27 23:18:05.000000000 +0200
> @@ -26,6 +26,8 @@
>  #include <linux/mm.h>
>  #include <linux/init.h>
>  #include <linux/highmem.h>
> +#include <linux/pagemap.h>
> +
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>

OK.
  
> 
> 
> 2) These are conflicts introduced by kernel-sys_nic-should-include-linux-syscallsh.patch
> 
>   CC      kernel/sys_ni.o
> kernel/sys_ni.c:16: error: conflicting types for 'sys_nfsservctl'
> include/linux/syscalls.h:497: error: previous declaration of 'sys_nfsservctl' was here
> kernel/sys_ni.c:17: error: conflicting types for 'sys_quotactl'

erk, I suspect that's unfixable, or not worth fixing.
