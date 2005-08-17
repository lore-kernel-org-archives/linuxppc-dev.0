Return-Path: <miklos@szeredi.hu>
Received: from dorka.pomaz.szeredi.hu (adsl-266.mirage.euroweb.hu
	[193.226.239.10]) by ozlabs.org (Postfix) with ESMTP id 4CEAF67FBA
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 19:16:43 +1000 (EST)
To: hch@infradead.org
In-reply-to: <20050817090920.GA12716@infradead.org> (message from Christoph
	Hellwig on Wed, 17 Aug 2005 10:09:20 +0100)
References: <20050816.203312.77701192.davem@davemloft.net>
	<032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
	<20050817083048.GA11892@infradead.org>
	<E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu>
	<20050817090920.GA12716@infradead.org>
Message-Id: <E1E5K1L-0004bH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Aug 2005 11:15:39 +0200
Cc: akpm@osdl.org, zach@vmware.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, galak@freescale.com, davem@davemloft.net
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > There are perfectly valid uses of kernel headers from userspace.  For
> > example if a program uses the netlink interface, it should include
> > <linux/netlink.h>.  It's the interface definition after all.
> > 
> > Glibc headers also include <linux/*> and <asm/*> in quite few places.
> 
> But these files in /usr/include/ aren't provided by the kernel anymore.

They are provided by _one_ kernel, not necessarily the running kernel.

That doesn't make them any less a kernel header.

So if some userspace program depends on header <linux/x.h> to get the
interface definition for feature x, and you remove <linux/x.h> from
the current kernel, it _will_ break the userspace program some time
later, when glibc picks up the new kernel.

Having said that that, <asm/segment.h> may or may not be validly
exported to userspace.

Miklos
