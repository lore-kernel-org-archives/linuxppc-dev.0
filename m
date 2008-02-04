Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 72551DDEF0
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 01:11:57 +1100 (EST)
Received: from [192.168.12.21] (unknown [10.149.0.1])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 674E58810
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 19:12:04 +0400 (SAMT)
Message-ID: <47A71C60.1030406@ru.mvista.com>
Date: Mon, 04 Feb 2008 17:08:32 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PowerPC: add missing native dcr dcr_ind_lock spinlock
References: <20080201203634.GA21024@ru.mvista.com>
In-Reply-To: <20080201203634.GA21024@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops, sorry, please discard this one.
DEFINE_SPINLOCK should be used here.

Valentine Barshak wrote:
> The include/asm-powerpc/dcr-native.h declares extern spinlock_t dcr_ind_lock,
> but it's actually isn't defined. This patch adds a missing dcr_ind_lock.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  arch/powerpc/sysdev/dcr.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff -pruN linux-2.6.orig/arch/powerpc/sysdev/dcr.c linux-2.6/arch/powerpc/sysdev/dcr.c
> --- linux-2.6.orig/arch/powerpc/sysdev/dcr.c	2008-01-31 16:58:32.000000000 +0300
> +++ linux-2.6/arch/powerpc/sysdev/dcr.c	2008-02-01 23:17:35.000000000 +0300
> @@ -137,5 +137,6 @@ void dcr_unmap(dcr_host_t host, unsigned
>  	h.token = NULL;
>  }
>  EXPORT_SYMBOL_GPL(dcr_unmap);
> -
> -#endif /* !defined(CONFIG_PPC_DCR_NATIVE) */
> +#else	/* defined(CONFIG_PPC_DCR_NATIVE) */
> +spinlock_t dcr_ind_lock;
> +#endif	/* !defined(CONFIG_PPC_DCR_NATIVE) */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
