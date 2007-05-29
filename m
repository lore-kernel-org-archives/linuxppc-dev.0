Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68151DDECA
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 20:51:29 +1000 (EST)
Date: Tue, 29 May 2007 12:51:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
Message-ID: <20070529105119.GD29351@lst.de>
References: <20070525083607.784351000@sonycom.com>
	<200705251850.30342.arnd@arndb.de>
	<Pine.LNX.4.62.0705252135010.2657@pademelon.sonytel.be>
	<200705252304.30396.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705252304.30396.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 25, 2007 at 11:04:29PM +0200, Arnd Bergmann wrote:
> On Friday 25 May 2007, Geert Uytterhoeven wrote:
> > 
> > > What is the problem? Is there infrastructure missing in the
> > > CD-ROM layer?
> > 
> > As the CD/DVD/BD part just accepts SCSI/ATAPI commands (except for plain
> > read/write), I was suggested to keep it as a SCSI driver.
> 
> Ok, so I guess the tradeoff here is that by writing it as a SCSI
> driver, you don't need to implement any of the cdrom_device_ops
> yourself but instead need to fake a few of the SCSI commands
> in ps3rom_request(). Fair enough.

ps3rom is just a normal scsi low level driver.  Currently the only
attached devices or MMC devices so the sr driver attaches to it,
but if you want to hack the ps3 hardware you should be able to
attach a tape or disk aswell, and linux would work (lv1 and gameos
might of course not like this)
