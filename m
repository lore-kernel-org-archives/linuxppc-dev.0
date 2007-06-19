Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F62FDDF1C
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 03:19:45 +1000 (EST)
Date: Tue, 19 Jun 2007 19:19:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
Message-ID: <20070619171938.GA21935@lst.de>
References: <20070615113919.142332000@pademelon.sonytel.be>
	<20070615120848.352093000@pademelon.sonytel.be>
	<20070619054324.GA18542@lst.de>
	<Pine.LNX.4.62.0706191450120.4069@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0706191450120.4069@pademelon.sonytel.be>
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 19, 2007 at 02:51:25PM +0200, Geert Uytterhoeven wrote:
> On Tue, 19 Jun 2007, Christoph Hellwig wrote:
> > On Fri, Jun 15, 2007 at 01:39:23PM +0200, Geert Uytterhoeven wrote:
> > > From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > > 
> > > Add a Disk Storage Driver for the PS3:
> > >   - Implemented as a block device driver with a dynamic major
> > >   - Disk names (and partitions) are of the format ps3d%c(%u)
> > >   - Uses software scatter-gather with a 64 KiB bounce buffer as the hypervisor
> > >     doesn't support scatter-gather
> > 
> > Looks good to me.  Only nitpicks are:
> > 
> >  - ps3disk_priv should probably be an inline function instead of a macro
> 
> I used a macro because you can do
> 
>     ps3disk_pri(dev) = ...;

I'm not exactly a fan of macros used as lvalues, but if you really
want this it can go in.
