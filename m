Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [80.160.20.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 51453DDEFA
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:17:37 +1000 (EST)
Date: Mon, 16 Jul 2007 14:16:50 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
Message-ID: <20070716121649.GI5195@kernel.dk>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707131541150.18802@pademelon.sonytel.be>
	<1184335333.3402.20.camel@localhost.localdomain>
	<200707131619.54898.arnd@arndb.de>
	<Pine.LNX.4.62.0707131707290.18802@pademelon.sonytel.be>
	<1184340528.3402.32.camel@localhost.localdomain>
	<Pine.LNX.4.62.0707132212520.23000@chinchilla.sonytel.be>
	<Pine.LNX.4.62.0707161338230.1072@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0707161338230.1072@pademelon.sonytel.be>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Alessandro Rubini <rubini@vision.unipv.it>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 16 2007, Geert Uytterhoeven wrote:
> On Fri, 13 Jul 2007, Geert Uytterhoeven wrote:
> > Ah, that explains it. flush_dcache_page() is used in some drivers.
> > I'll update my patches. Thanks for the comments!
> 
> Does this look OK?
>   - Replaced KM_USER0 by KM_IRQ0 (all routines are either called from an
>     interrupt handler, from .request_fn (ps3disk), or from .queuecommand
>     (ps3rom))

That looks good.

>   - Add a call to flush_kernel_dcache_page() in routines that write to buffers

Hmm, I would have thought a flush_dcache_page() would be more
appropriate, the backing could be page cache pages.

-- 
Jens Axboe
