Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18161.50630.769910.207866@cargo.ozlabs.ibm.com>
Date: Thu, 20 Sep 2007 10:58:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH v2] [POWERPC] Fix build errors when BLOCK=n
In-Reply-To: <1190227172-593-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1190227172-593-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	kumar.gala@Freescale.com, bzolnier@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Emil Medve writes:

> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -12,12 +12,15 @@
>  #include <linux/irq.h>
>  #include <linux/pci.h>
>  #include <linux/delay.h>
> +#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
>  #include <linux/ide.h>
> +#endif

Why are we still including linux/ide.h at all here?

>  #include <linux/bitops.h>
>  
>  #include <asm/page.h>
>  #include <asm/semaphore.h>
>  #include <asm/processor.h>
> +#include <asm/cacheflush.h>

What's the point of adding this?

Paul.
