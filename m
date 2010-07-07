Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35171B6F05
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jul 2010 07:45:41 +1000 (EST)
Date: Wed, 7 Jul 2010 14:45:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH 1/2] edac: mpc85xx: Fix MPC85xx dependency
Message-Id: <20100707144502.22b91374.akpm@linux-foundation.org>
In-Reply-To: <20100702124111.GA23320@oksana.dev.rtsoft.ru>
References: <20100702124111.GA23320@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, linuxppc-dev@ozlabs.org,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2 Jul 2010 16:41:11 +0400
Anton Vorontsov <avorontsov@mvista.com> wrote:

> Since commit 5753c082f66eca5be81f6bda85c1718c5eea6ada ("powerpc/85xx:
> Kconfig cleanup"), there is no MPC85xx Kconfig symbol anymore, so the
> driver became non-selectable.

hm.  5753c082f66eca5be81f6bda85c1718c5eea6ada got merged into mainline
six months ago.  How come nobody noticed?

> This patch fixes the issue by switching to PPC_85xx symbol.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
>  drivers/edac/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index aedef79..0d2f9db 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -209,7 +209,7 @@ config EDAC_I5100
>  
>  config EDAC_MPC85XX
>  	tristate "Freescale MPC83xx / MPC85xx"
> -	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || MPC85xx)
> +	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || PPC_85xx)
>  	help
>  	  Support for error detection and correction on the Freescale
>  	  MPC8349, MPC8560, MPC8540, MPC8548

I suppose we shold scoot this into 2.6.35 and mark it for -stable
backporting.  All very odd.
