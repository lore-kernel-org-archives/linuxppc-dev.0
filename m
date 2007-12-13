Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F206DE0A7
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 07:38:45 +1100 (EST)
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071213130547.728d873d@weaponx>
References: <20071213073851.C321FDDFC9@ozlabs.org>
	<20071213130547.728d873d@weaponx>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 07:37:40 +1100
Message-Id: <1197578260.15741.152.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-12-13 at 13:05 -0600, Josh Boyer wrote:
> On Thu, 13 Dec 2007 18:38:46 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > This makes 4xx embedded platforms re-assign all PCI resources as we
> > pretty much never care about what the various firmwares have done on
> > these, it's generally not compatible with the way the kernel will map
> > the bridges.
> > 
> > We still need to also enable bus renumbering on some of them, but I
> > will do that from a separate patch after I've fixed 4xx PCIe to handle
> > all bus numbers.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> [snip]
> 
> > Index: linux-work/arch/powerpc/platforms/44x/sequoia.c
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/platforms/44x/sequoia.c	2007-12-10 16:51:42.000000000 +1100
> > +++ linux-work/arch/powerpc/platforms/44x/sequoia.c	2007-12-10 16:55:06.000000000 +1100
> > @@ -21,7 +21,8 @@
> >  #include <asm/udbg.h>
> >  #include <asm/time.h>
> >  #include <asm/uic.h>
> > -#include "44x.h"
> > +#include <asm/pci-bridge.h>
> > +
> 
> Oh, and you also broke the Sequoia build with this change because you
> removed the 44x.h include :).

Ok.

Ben.
