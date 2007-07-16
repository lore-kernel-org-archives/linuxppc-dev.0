Return-Path: <James.Bottomley@SteelEye.com>
Received: from hancock.sc.steeleye.com (hancock.steeleye.com [71.30.118.248])
	by ozlabs.org (Postfix) with ESMTP id 16981DDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 08:03:37 +1000 (EST)
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1184622555.25235.91.camel@localhost.localdomain>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707131541150.18802@pademelon.sonytel.be>
	<1184335333.3402.20.camel@localhost.localdomain>
	<200707131619.54898.arnd@arndb.de>
	<Pine.LNX.4.62.0707131707290.18802@pademelon.sonytel.be>
	<1184340528.3402.32.camel@localhost.localdomain>
	<Pine.LNX.4.62.0707132212520.23000@chinchilla.sonytel.be>
	<Pine.LNX.4.62.0707161338230.1072@pademelon.sonytel.be>
	<20070716121649.GI5195@kernel.dk>
	<1184593643.3447.9.camel@localhost.localdomain>
	<1184622555.25235.91.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 16 Jul 2007 17:03:34 -0500
Message-Id: <1184623415.3447.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Alessandro Rubini <rubini@vision.unipv.it>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Jens Axboe <jens.axboe@oracle.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-17 at 07:49 +1000, Benjamin Herrenschmidt wrote:
> > No ... that was the point of flush_kernel_dcache_page().  The page in
> > question is page cache backed and contains user mappings.  However, the
> > block layer has already done a flush_dcache_page() in get_user_pages()
> > and the user shouldn't be touching memory under I/O (unless they want
> > self induced aliasing problems) so we're free to assume all the user
> > cachelines are purged, hence all we have to do is flush the kernel alias
> > to bring the page up to date and make the users see it correctly.
> 
> The block layer will have done that even in the swap-out path ? (Just
> asking... I'm not very familiar with the block layer)

Er ... not really, this is the I/O path for user initiated I/O.  The
page out path, by definition, can't have any extant user mappings.  For
page out, the relevant page is flushed before its mapping is detached,
and then it can be paged to the backing store (or for anonymous pages to
the swap device) when no mappings remain.

James
