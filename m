Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70BF9DDFB5
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:55:15 +1000 (EST)
Date: Tue, 29 May 2007 11:55:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
Message-ID: <20070529095508.GB29351@lst.de>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com>
	<20070525112414.GA32336@aepfle.de>
	<1180133119.19517.11.camel@localhost.localdomain>
	<Pine.LNX.4.62.0705261052110.2657@pademelon.sonytel.be>
	<1180217923.19517.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180217923.19517.42.camel@localhost.localdomain>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 27, 2007 at 08:18:43AM +1000, Benjamin Herrenschmidt wrote:
> > > > linux/highmem.h is not included to get the kmap_* prototypes.
> > > 
> > > Beside, I don't see the point of using kmap on ppc64...
> > 
> > So what should I use instead?
> 
> you don't need to map ... the linear mapping is there.... page_address()
> should just work. But then, kmap will resolve to just that anyway so I
> suppose it doesn't matter.

Generally I'd prefer to use kmap everywhere, to keep code future-proof.
Similar to how I advocate using spinlocks even in drivers for UP-only
architectures.
