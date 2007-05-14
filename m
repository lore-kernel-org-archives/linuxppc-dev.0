Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2B5D4DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 08:54:30 +1000 (EST)
Date: Mon, 14 May 2007 17:57:31 -0500
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] pcmcia: ppc64 needs 64-bit ioaddr_t
Message-ID: <20070514225731.GA4191@lixom.net>
References: <20070512143105.GA12890@lixom.net> <20070513214608.GA26187@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070513214608.GA26187@lst.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 13, 2007 at 11:46:08PM +0200, Christoph Hellwig wrote:
> On Sat, May 12, 2007 at 09:31:05AM -0500, Olof Johansson wrote:
> > ppc64 really needs ioaddr_t to be 64-bit, since I/O addresses really
> > are MMIO addresses, and remapped to a high range.
> > 
> > While the type is exported to userspace, there hasn't been any platforms
> > with PCMCIA on 64-bit powerpc until now, so changing it won't regress
> > any existing users.
> 
> In fact the only use of the type should be in the obsolete ioctl-based user
> interface.  So instead of changing the size of the type you should
> 
>  a) make sure you're not using cardmgr
>  b) fix up those places that still use ioaddr_t where they shouldn't
>     and switch the to kio_addr_t (why not just unsigned long like all
>     other busses?) 

I just noticed that feature-removal-schedule.txt says November 2005 for
the removal of the pcmcia ioctl's, but they're still there. I'm missing
the history here, any reason they weren't removed yet?


-Olof
