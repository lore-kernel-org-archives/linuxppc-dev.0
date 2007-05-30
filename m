Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80CB1DDFEF
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 20:13:58 +1000 (EST)
Date: Wed, 30 May 2007 12:13:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
Message-ID: <20070530101348.GD24586@lst.de>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com>
	<20070529104948.GC29351@lst.de>
	<Pine.LNX.4.62.0705291308280.7698@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0705291308280.7698@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 01:11:41PM +0200, Geert Uytterhoeven wrote:
> > This looks very inefficient.  Just set sg_tablesize of your driver
> > to 1 to avoid getting mutiple segments.
> 
> The disadvantage of setting sg_tablesize = 1 is that the driver will get small
> requests (PAGE_SIZE) most of the time, which is very bad for performance.

If you set .clustering = 1 in your host template you will frequently
get larger requests.

For any sane hypervisor or hardware the copy should be worth
than that.  Then again a sane hardware or hypervisor would support
SG requests..
