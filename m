Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82452B7ECD
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Feb 2010 17:10:14 +1100 (EST)
Subject: Re: [PATCH 2/9] proc_devtree: fix THIS_MODULE without module.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100213160236.4767.48310.stgit@angua>
References: <20100213154838.4767.83881.stgit@angua>
	<20100213160236.4767.48310.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Feb 2010 17:09:54 +1100
Message-ID: <1266127794.16346.59.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-02-13 at 09:02 -0700, Grant Likely wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> Commit e22f628395432b967f2f505858c64450f7835365 introduced a build
> breakage for ARM devtree work: the THIS_MODULE macro was added, but we
> don't have module.h
> 
> This change adds the necessary #include to get THIS_MODULE defined.
> While we could just replace it with NULL (PROC_FS is a bool, not a
> tristate), using THIS_MODULE will prevent unexpected breakage if we
> ever do compile this as a module.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
>  fs/proc/proc_devtree.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
> index 0ec4511..f8650dc 100644
> --- a/fs/proc/proc_devtree.c
> +++ b/fs/proc/proc_devtree.c
> @@ -11,6 +11,7 @@
>  #include <linux/stat.h>
>  #include <linux/string.h>
>  #include <linux/of.h>
> +#include <linux/module.h>
>  #include <asm/prom.h>
>  #include <asm/uaccess.h>
>  #include "internal.h"
