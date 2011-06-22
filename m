Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE003.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2BA7EB6FCA
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 03:53:00 +1000 (EST)
Date: Wed, 22 Jun 2011 12:52:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/3] driver core: Add ability for arch code to setup
	pdev_archdata
Message-ID: <20110622125252.66eceb46@schlenkerla.am.freescale.net>
In-Reply-To: <1308755396-17988-1-git-send-email-galak@kernel.crashing.org>
References: <1308744176-24491-1-git-send-email-galak@kernel.crashing.org>
	<1308755396-17988-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 22 Jun 2011 10:09:56 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c291af..c25e0c0 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -20,6 +20,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> +#include <asm/platform_device.h>
>  
>  #include "base.h"
>  
> @@ -173,6 +174,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
>  		pa->pdev.id = id;
>  		device_initialize(&pa->pdev.dev);
>  		pa->pdev.dev.release = platform_device_release;
> +		arch_setup_pdev_archdata(&pa->pdev);
>  	}
>  
>  	return pa ? &pa->pdev : NULL;

Need to call this from platform_device_register() as well, for devices
which are not dynamically allocated.

> +/*
> + * an architecture can override to define arch_setup_pdev_archdata
> + */
> +#ifndef arch_setup_pdev_archdata
> +static inline void arch_setup_pdev_archdata(struct platform_device *pdev) { }
> +#endif

That's not a particularly useful comment.  More useful would be a statement
of when this hook is called, examples of what it's meant to be used for,
etc.

-Scott
