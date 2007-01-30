Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0686DDF44
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 20:11:12 +1100 (EST)
Subject: Re: [PATCH 5/9] ps3: Preallocate bootmem memory for ps3fb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0701300934270.4728@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<1170124157.19887.116.camel@concordia.ozlabs.ibm.com>
	<Pine.LNX.4.62.0701300914580.4728@pademelon.sonytel.be>
	<200701300927.52087.arnd@arndb.de>
	<Pine.LNX.4.62.0701300934270.4728@pademelon.sonytel.be>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 20:08:36 +1100
Message-Id: <1170148116.26655.328.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: James Simmons <jsimmons@infradead.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-30 at 09:36 +0100, Geert Uytterhoeven wrote:
> On Tue, 30 Jan 2007, Arnd Bergmann wrote:
> > On Tuesday 30 January 2007 09:16, Geert Uytterhoeven wrote:
> > > We have a similar problem with the storage driver, which needs a block of 256
> > > KiB of contiguous memory.
> > 
> > I guess at least that one should be solveable. If the 256kb is only
> > internal flash access, it is should not be part of the storage driver
> > but of whatever else is used to drive this.
> 
> If we convert the FLASH part to a character device driver, the 256 KiB will be
> internal to the character device driver.
> 
> > Assuming the module gets loaded shortly after boot, you can still allocate
> > 256kb practically always, using get_free_pages().
> 
> I'm afraid that assumption is usually false, as you only need to access the
> FLASH when you want to change boot flags or update the boot loader.

At the same time, flash doesn't have to be fast... can't we use a
smaller bounce buffer (a page) and divide the transfer ?

Ben.
