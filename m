Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C578DDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 15:53:09 +1000 (EST)
Date: Tue, 15 May 2007 07:52:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pcmcia: ppc64 needs 64-bit ioaddr_t
Message-ID: <20070515055256.GA18672@lst.de>
References: <20070512143105.GA12890@lixom.net> <20070513214608.GA26187@lst.de>
	<20070514225731.GA4191@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070514225731.GA4191@lixom.net>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, Christoph Hellwig <hch@lst.de>,
	Dominik Brodowski <linux@brodo.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 05:57:31PM -0500, Olof Johansson wrote:
> On Sun, May 13, 2007 at 11:46:08PM +0200, Christoph Hellwig wrote:
> > On Sat, May 12, 2007 at 09:31:05AM -0500, Olof Johansson wrote:
> > > ppc64 really needs ioaddr_t to be 64-bit, since I/O addresses really
> > > are MMIO addresses, and remapped to a high range.
> > > 
> > > While the type is exported to userspace, there hasn't been any platforms
> > > with PCMCIA on 64-bit powerpc until now, so changing it won't regress
> > > any existing users.
> > 
> > In fact the only use of the type should be in the obsolete ioctl-based user
> > interface.  So instead of changing the size of the type you should
> > 
> >  a) make sure you're not using cardmgr
> >  b) fix up those places that still use ioaddr_t where they shouldn't
> >     and switch the to kio_addr_t (why not just unsigned long like all
> >     other busses?) 
> 
> I just noticed that feature-removal-schedule.txt says November 2005 for
> the removal of the pcmcia ioctl's, but they're still there. I'm missing
> the history here, any reason they weren't removed yet?

See the discussions on lkml.  It seems like people haven't really
noticed the deprecation messages and are still using it.  Still not
a good reason to use them on a new port (at least new in terms of
pcmcia support)
