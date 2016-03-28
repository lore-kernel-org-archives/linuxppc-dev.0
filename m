Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYbjJ2BwGzDqCj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 01:23:00 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 28 Mar 2016 08:22:23 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1F4121FF0026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 08:10:28 -0600 (MDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2SEMIUN24641676
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 14:22:18 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2SEMISo019964
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 10:22:18 -0400
Subject: Re: [PATCH 2/3] powerpc: make kernel/nvram_64.c explicitly non-modular
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
References: <1459116497-19991-1-git-send-email-paul.gortmaker@windriver.com>
 <1459116497-19991-3-git-send-email-paul.gortmaker@windriver.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Andrzej Hajda <a.hajda@samsung.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <56F93E18.7000809@linux.vnet.ibm.com>
Date: Mon, 28 Mar 2016 09:22:16 -0500
MIME-Version: 1.0
In-Reply-To: <1459116497-19991-3-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/27/2016 05:08 PM, Paul Gortmaker wrote:
> The Makefile/Kconfig currently controlling compilation of this code is:
> 
> obj-$(CONFIG_PPC64)             += setup_64.o sys_ppc32.o \
>                                    signal_64.o ptrace32.o \
>                                    paca.o nvram_64.o firmware.o
> 
> arch/powerpc/platforms/Kconfig.cputype:config PPC64
> arch/powerpc/platforms/Kconfig.cputype: bool "64-bit kernel"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> We don't replace module.h with init.h since the file already has that.
> 
> We delete the MODULE_LICENSE tag since that information is already
> contained at the top of the file in the comments.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

I think at some point in the past we thought this may be useful as a module
but I'm not sure it has ever been used that way.

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

>  arch/powerpc/kernel/nvram_64.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index 0cab9e8c3794..856f9a7944cd 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -15,8 +15,6 @@
>   *       parsing code.
>   */
> 
> -#include <linux/module.h>
> -
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/fs.h>
> @@ -1231,12 +1229,4 @@ static int __init nvram_init(void)
>    	
>    	return rc;
>  }
> -
> -static void __exit nvram_cleanup(void)
> -{
> -        misc_deregister( &nvram_dev );
> -}
> -
> -module_init(nvram_init);
> -module_exit(nvram_cleanup);
> -MODULE_LICENSE("GPL");
> +device_initcall(nvram_init);
> 
