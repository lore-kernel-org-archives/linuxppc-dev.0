Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D271BDDFD1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 20:12:22 +1000 (EST)
Date: Wed, 30 May 2007 12:12:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] remove geometry support from ps3 storage driver
Message-ID: <20070530101205.GC24586@lst.de>
References: <20070521125311.GA27626@aepfle.de> <20070521143938.GA20321@lst.de>
	<Pine.LNX.4.62.0705291114340.7698@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0705291114340.7698@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 11:15:14AM +0200, Geert Uytterhoeven wrote:
> On Mon, 21 May 2007, Christoph Hellwig wrote:
> > On Mon, May 21, 2007 at 02:53:11PM +0200, Olaf Hering wrote:
> > > The old ps3_storage driver did not support DOS geometry, so there is no
> > > point to start adding code for it.
> > 
> > That's not quite true.  sd applies some heuristics  and has a default
> > geometry if there is no ->bios_param method.  Then again this whole
> > gemetry thing really only makes sense on x86.
> 
> Would it make sense to have a default implementation in block/ioctl.c?

Maybe.  Someone would have to look all over block drivers if there is
something common enough to be considered default.  Also some drivers
that never ran on x86 never supported it so they'd need a new method
that always returns an error.  I'm not sure whether it'll be worth it
in the end.
