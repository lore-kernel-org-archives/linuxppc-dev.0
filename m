Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v73W81RZpzDqRD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 20:57:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH] cxl: drop unused header asm/pnv-pci.h
In-Reply-To: <148482301037.30441.14177888563610790803.stgit@bahia>
References: <148482301037.30441.14177888563610790803.stgit@bahia>
Date: Tue, 24 Jan 2017 20:57:06 +1100
Message-ID: <87k29kaih9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kurz <groug@kaod.org> writes:

> The kernel API does not use anything from this header file.

That's actually hard to prove in general, because pnv-pci.h includes
linux/pci.h, linux/pci_hotplug.h, linux/irq.h, misc/cxl-base.h and
asm/opal-api.h. At least four of which aren't included directly by
api.c.

But I'll take you word for it :)

cheers

> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 1b35e33d2434..bcc030eacab7 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -11,7 +11,6 @@
>  #include <linux/slab.h>
>  #include <linux/file.h>
>  #include <misc/cxl.h>
> -#include <asm/pnv-pci.h>
>  #include <linux/msi.h>
>  #include <linux/module.h>
>  #include <linux/mount.h>
