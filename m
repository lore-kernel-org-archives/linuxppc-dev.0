Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0222DE1CF
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 19:42:55 +1100 (EST)
Date: Sun, 28 Jan 2007 09:42:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/16] ps3: system bus minor mmio fix
Message-ID: <20070128084239.GA6311@lst.de>
References: <45BAC20A.8040107@am.sony.com>
	<1169928417.24996.205.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169928417.24996.205.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 28, 2007 at 07:06:57AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2007-01-26 at 19:07 -0800, Geoff Levand wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Fix two minor bugs in the PS3 system bus mmio region code.  First, on error or
> > when freeing a region, retain the bus_addr and len fields to allow subsequent
> > calls to create the region.  Second, correct the region address argument to the
> > lv1_unmap_device_mmio_region() call.
> 
> Note that I personally think that drivers/ps3 is a very wrong place for
> the ps3 system bus. It should stay in arch/powerpc/platform/ps3

Yes, absolutely.  We should not spreads things all over the tree do
make understanding the code even more difficult than all the lv1
braindamage already makes it.
