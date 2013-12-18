Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 901372C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 14:35:29 +1100 (EST)
Message-ID: <1387337708.3140.31.camel@snotra.buserror.net>
Subject: Re: [v3][PATCH 3/8] book3e/kexec/kdump: enable kexec for kernel
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 17 Dec 2013 21:35:08 -0600
In-Reply-To: <1373357007-30785-4-git-send-email-tiejun.chen@windriver.com>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-4-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-09 at 16:03 +0800, Tiejun Chen wrote:
> We need to active KEXEC for book3e and bypass or convert non-book3e stuff
> in kexec coverage.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/Kconfig                   |    2 +-
>  arch/powerpc/kernel/machine_kexec_64.c |  148 ++++++++++++++++++--------------
>  arch/powerpc/kernel/misc_64.S          |    6 ++
>  3 files changed, 89 insertions(+), 67 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 5374776..d945435 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -357,7 +357,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>  
>  config KEXEC
>  	bool "kexec system call"
> -	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP))
> +	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP)) || PPC_BOOK3E

Please remove the outher parentheses, and especially don't put
PPC_BOOK3E on the outside of them when there's no reason to group the
other items together.

> @@ -367,6 +301,87 @@ void default_machine_kexec(struct kimage *image)
>  	/* NOTREACHED */
>  }
>  
> +#ifdef CONFIG_PPC_BOOK3E
> +int default_machine_kexec_prepare(struct kimage *image)
> +{
> +	int i;
> +	/*
> +	 * Since we use the kernel fault handlers and paging code to
> +	 * handle the virtual mode, we must make sure no destination
> +	 * overlaps kernel static data or bss.
> +	 */
> +	for (i = 0; i < image->nr_segments; i++)
> +		if (image->segment[i].mem < __pa(_end))
> +			return -ETXTBSY;
> +	return 0;

Factor out this common code rather than duplicate it.

-Scott
