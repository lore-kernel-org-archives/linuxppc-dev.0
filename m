Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9DE4DDF9E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 06:06:02 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBDJ5tei024230
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 14:05:55 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBDJ5oK3827586
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 14:05:51 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBDJ5nJO020490
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 12:05:50 -0700
Date: Thu, 13 Dec 2007 13:05:47 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
Message-ID: <20071213130547.728d873d@weaponx>
In-Reply-To: <20071213073851.C321FDDFC9@ozlabs.org>
References: <20071213073851.C321FDDFC9@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 13 Dec 2007 18:38:46 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This makes 4xx embedded platforms re-assign all PCI resources as we
> pretty much never care about what the various firmwares have done on
> these, it's generally not compatible with the way the kernel will map
> the bridges.
> 
> We still need to also enable bus renumbering on some of them, but I
> will do that from a separate patch after I've fixed 4xx PCIe to handle
> all bus numbers.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

[snip]

> Index: linux-work/arch/powerpc/platforms/44x/sequoia.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/platforms/44x/sequoia.c	2007-12-10 16:51:42.000000000 +1100
> +++ linux-work/arch/powerpc/platforms/44x/sequoia.c	2007-12-10 16:55:06.000000000 +1100
> @@ -21,7 +21,8 @@
>  #include <asm/udbg.h>
>  #include <asm/time.h>
>  #include <asm/uic.h>
> -#include "44x.h"
> +#include <asm/pci-bridge.h>
> +

Oh, and you also broke the Sequoia build with this change because you
removed the 44x.h include :).

josh
