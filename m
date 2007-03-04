Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4ED78DDF8F
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 16:17:49 +1100 (EST)
Date: Sun, 4 Mar 2007 06:17:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070304051738.GA30747@lst.de>
References: <1172872183.5310.145.camel@goblue>
	<20070302222748.GA1206@lixom.net>
	<1172910451.8184.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1172910451.8184.51.camel@localhost.localdomain>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 03, 2007 at 09:27:31AM +0100, Benjamin Herrenschmidt wrote:
> - Drivers are broken -today- and I doubt they can all be audited and
> fixed (and fixes bacported to distros) quickly

Which drivers?  All requests coming from the block layer make sure
you never span the 4GB boundary, and IIRC that same is true for
networking.  Similarly dma_alloc_coherent and pci_alloc_consinstant
only allocate from the lower 4G unless told otherwise.  A driver writer
would have to be extra-ordinarily stuid to get this wrong.  (And yes,
some driver writers are..)
