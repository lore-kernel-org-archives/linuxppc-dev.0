Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7295ADDE2C
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 07:46:22 +1000 (EST)
Date: Sun, 13 May 2007 23:46:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pcmcia: ppc64 needs 64-bit ioaddr_t
Message-ID: <20070513214608.GA26187@lst.de>
References: <20070512143105.GA12890@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070512143105.GA12890@lixom.net>
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 12, 2007 at 09:31:05AM -0500, Olof Johansson wrote:
> ppc64 really needs ioaddr_t to be 64-bit, since I/O addresses really
> are MMIO addresses, and remapped to a high range.
> 
> While the type is exported to userspace, there hasn't been any platforms
> with PCMCIA on 64-bit powerpc until now, so changing it won't regress
> any existing users.

In fact the only use of the type should be in the obsolete ioctl-based user
interface.  So instead of changing the size of the type you should

 a) make sure you're not using cardmgr
 b) fix up those places that still use ioaddr_t where they shouldn't
    and switch the to kio_addr_t (why not just unsigned long like all
    other busses?) 
