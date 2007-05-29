Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84941DE033
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 20:51:39 +1000 (EST)
Date: Tue, 29 May 2007 12:51:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 7/7] ps3: FLASH ROM Storage Driver
Message-ID: <20070529105135.GE29351@lst.de>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.815300000@sonycom.com>
	<20070529095355.GA29351@lst.de>
	<Pine.LNX.4.62.0705291157260.7698@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0705291157260.7698@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 11:57:52AM +0200, Geert Uytterhoeven wrote:
> On Tue, 29 May 2007, Christoph Hellwig wrote:
> > On Fri, May 25, 2007 at 10:36:14AM +0200, Geert.Uytterhoeven@sonycom.com wrote:
> > > Add a FLASH ROM Storage Driver for the PS3:
> > >   - Implemented as a misc character device driver
> > >   - Uses a fixed 256 KiB buffer allocated from boot memory as the hypervisor
> > >     requires the writing of aligned 256 KiB blocks
> > 
> > Looks good, but please either make the driver aware of multiple devices
> > even if they can't happen currently, or alternatively error out in
> > ->probe if of some reason it's called for a second device.
> 
> ps3flash_probe() does return -EBUSY when called for a second device.

You're right, I missed that bit.
