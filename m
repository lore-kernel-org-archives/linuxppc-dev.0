Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6B413DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 17:04:19 +1000 (EST)
Date: Fri, 3 Oct 2008 11:04:16 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: make Freescale QE support a selectable
	Kconfig option
Message-ID: <20081003070416.GA460@oksana.dev.rtsoft.ru>
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1222961277-6166-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 02, 2008 at 10:27:57AM -0500, Timur Tabi wrote:
> Modify the Kconfig so that Freescale QUICC Engine (QE) support is a selectable
> option, thereby allowing users to compile kernels without any QE support.
> 
> The drawback is that QE support is now disabled by default on platforms that
> have a QE, and so a defconfig is needed to enable QE and QE devices (like
> UCC GETH).  Fortunately, all the current relevant defconfigs do that already.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

[...]
>  config MPC836x_RDK
>  	bool "Freescale/Logic MPC836x RDK"
>  	select DEFAULT_UIMAGE
> -	select QUICC_ENGINE
>  	select QE_GPIO

IIRC selects do not honor any dependencies, i.e. you should delete
the QE_GPIO too.

>  	select FSL_GTM
>  	select FSL_LBC
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index 9578c45..6cf517f 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -239,7 +239,8 @@ config TAU_AVERAGE
>  	  If in doubt, say N here.
>  
>  config QUICC_ENGINE
> -	bool
> +	bool "Freescale QUICC Engine (QE) Support"
> +	depends on FSL_SOC
>  	select PPC_LIB_RHEAP
>  	select CRC32
>  	help
> -- 
> 1.5.5

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
