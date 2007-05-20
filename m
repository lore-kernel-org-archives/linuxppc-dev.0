Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hirscho.in-berlin.de (fallback-mx.in-berlin.de [192.109.42.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EB3CDDE40
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 02:46:53 +1000 (EST)
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by fallback-mx.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id
	l4KFrOK7019753
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 17:53:24 +0200
Message-ID: <46506EE0.9000405@s5r6.in-berlin.de>
Date: Sun, 20 May 2007 17:53:04 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 2.6.22-rc2 built on ppc
References: <20070520112904.GM3253@aragorn.home.lxtec.de>
In-Reply-To: <20070520112904.GM3253@aragorn.home.lxtec.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	ben.collins@ubuntu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Adding linuxppc-dev)

Elimar Riesebieter wrote:
> Hi,
> 
> FYI, building the kernel modules with
> gcc (GCC) 4.1.3 20070514 (prerelease) (Debian 4.1.2-7)
> on my powerbook (PPC) gives:
> 
> ...
> drivers/firewire/fw-ohci.c: In function 'ar_context_tasklet':
> drivers/firewire/fw-ohci.c:357: warning: unused variable 'ohci'
> drivers/firewire/fw-ohci.c: In function 'context_release':
> drivers/firewire/fw-ohci.c:502: warning: unused variable 'card'
> drivers/firewire/fw-sbp2.c: In function 'complete_command_orb':
> drivers/firewire/fw-sbp2.c:838: warning: unused variable 'device'
> drivers/ieee1394/sbp2.c: In function 'sbp2util_remove_command_orb_pool':
> drivers/ieee1394/sbp2.c:497: warning: unused variable 'host'
> drivers/ieee1394/sbp2.c: In function 'sbp2util_mark_command_completed':
> drivers/ieee1394/sbp2.c:588: warning: unused variable 'host'
> ...


The allegedly unused variables are used in calls to dma_unmap_single(),
but only for these calls.  On PPC32, you get

	/* We do nothing. */
	#define dma_unmap_single(dev, addr, size, dir)  ((void)0)

in dma-mapping.h.  This is also the case for Linux 2.6.20.
But in Linux 2.6.19 and older, it was

	/* We do nothing. */
	#define dma_unmap_single(dev, addr, size, dir)	do { } while (0)

(Furthermore, the sbp2 driver used the pci_dma_ API in Linux 2.6.19 and
older, and fw-ohci wasn't in mainline before 2.6.22-rc1.)

I don't know what's to blame for the warnings --- new gcc versions or
the change from do { } while (0) to ((void)0)?  Either way, the compiler
should comprehend that the arguments stuffed into the dma_unmap_single
macro are _not_ unused by accident; it should stay quiet and optimize
the unused variables away if run with -Osomething.

Does somebody know more?

I'd like to avoid cluttering the drivers with __attribute((used)).


> If more info is needed, please contact me via PM, as I am not
> subscribed.

We usually keep posters Cc'ed in list replies, at least on development
lists where bug reports are welcomed.
-- 
Stefan Richter
-=====-=-=== -=-= =-=--
http://arcgraph.de/sr/
