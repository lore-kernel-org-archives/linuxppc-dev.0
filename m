Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 084C72C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 18:12:00 +1100 (EST)
Message-ID: <1352963506.23412.63.camel@pasglop>
Subject: Re: linux-next: build failure after merge of the final tree
 (powercp tree related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 15 Nov 2012 18:11:46 +1100
In-Reply-To: <20121115180607.4a545ad6b6b6c8e3481a11e9@canb.auug.org.au>
References: <20121115180607.4a545ad6b6b6c8e3481a11e9@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-11-15 at 18:06 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> lib/pSeries-reconfig-notifier-error-inject.c:4:34: fatal error: asm/pSeries_reconfig.h: No such file or directory
> 
> Caused by commit f459d63e1689 ("powerpc+of: Remove the pSeries_reconfig.h
> file") and even if the file existed, things were removed by commit
> 1cf3d8b3d24c ("powerpc+of: Add of node/property notification chain for
> adds and removes") that would cause
> lib/pSeries-reconfig-notifier-error-inject.c to fail to build.  I have
> marked it as broken for now using this patch:

My bad, didn't notice, I don't have error injection enabled in my test
configs. I think that stuff went in after the original patches were
written I think.

Not a big deal, nobody actually enables that error inject test stuff
just yet, I'll put a fix patch into my "dt" and my "next" branch asap.

Cheers,
Ben.
 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 15 Nov 2012 18:02:13 +1100
> Subject: [PATCH] lib: disable PSERIES_RECONFIG_NOTIFIER_ERROR_INJECT
> 
> It has been fundamentally broken by other changes.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  lib/Kconfig.debug |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 41faf0b..ad84944 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1195,6 +1195,7 @@ config MEMORY_NOTIFIER_ERROR_INJECT
>  config PSERIES_RECONFIG_NOTIFIER_ERROR_INJECT
>  	tristate "pSeries reconfig notifier error injection module"
>  	depends on PPC_PSERIES && NOTIFIER_ERROR_INJECTION
> +	depends on BROKEN
>  	help
>  	  This option provides the ability to inject artifical errors to
>  	  pSeries reconfig notifier chain callbacks.  It is controlled
> -- 
> 1.7.10.280.gaa39
> 
