Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13577B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 04:15:52 +1000 (EST)
Date: Tue, 5 Apr 2011 13:15:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [RFC 2/5]arch:powerpc:sysdev:Makefile Remove unused config in
	the Makefile.
Message-ID: <20110405131504.1d182da4@schlenkerla.am.freescale.net>
In-Reply-To: <1302022702-24541-2-git-send-email-justinmattock@gmail.com>
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
	<1302022702-24541-2-git-send-email-justinmattock@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, trivial@kernel.org,
	linux-kernel@vger.kernel.org, Harninder Rai <harninder.rai@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Apr 2011 09:58:19 -0700
"Justin P. Mattock" <justinmattock@gmail.com> wrote:

> The patch below removes an unused config variable found by using a kernel
> cleanup script.
> Note: I did try to cross compile these but hit erros while doing so..
> (gcc is not setup to cross compile) and am unsure if anymore needs to be done.
> Please have a look if/when anybody has free time.
> 
> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@lists.ozlabs.org
> 
> ---
>  arch/powerpc/sysdev/Makefile |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index 1e0c933..243b6ad 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -18,7 +18,6 @@ obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
>  obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
>  obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
>  obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
> -obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
>  obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
>  obj-$(CONFIG_FSL_RIO)		+= fsl_rio.o
>  obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o

Those files do exist, and aren't pulled in by any other means I can see.
It was introduced by commit 6db92cc9d07db9f713da8554b4bcdfc8e54ad386, whose
changelog says:
	Drivers can do the following in Kconfig to use these APIs "select
FSL_85XX_CACHE_SRAM if MPC85xx"

Now, the absence of such a kconfig option[1] is a problem, but I don't think
outright removal (labelled "trivial cleanup") is appropriate, unless nobody
fixes it after the problem is pointed out.  And if it is removed, the files
should go with it.

-Scott

[1] and of any drivers that select it, though this was added fairly
recently -- perhaps such a driver change is on its way?
