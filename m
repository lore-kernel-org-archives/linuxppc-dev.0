Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [80.160.20.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C5FE9DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 02:35:48 +1000 (EST)
Date: Fri, 13 Jul 2007 18:35:28 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
Message-ID: <20070713163528.GU5328@kernel.dk>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707131541150.18802@pademelon.sonytel.be>
	<1184335333.3402.20.camel@localhost.localdomain>
	<200707131619.54898.arnd@arndb.de>
	<Pine.LNX.4.62.0707131707290.18802@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0707131707290.18802@pademelon.sonytel.be>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 13 2007, Geert Uytterhoeven wrote:
> > It's probably a good idea to have the flush_kernel_dcache_page() in there
> > anyway, if only to serve as an example for people that copy it into
> > architecture-independent drivers, same as what we do for the
> > k{,un}map_atomic() that is also not required on ppc64.
> 
> Now my next question: why should I add it, if currently no single driver in
> mainline calls flush_kernel_dcache_page()? 
> 
> `git grep' finds it in the following files only:
>     Documentation/cachetlb.txt
>     arch/parisc/kernel/cache.c
>     arch/parisc/kernel/pacache.S
>     include/asm-parisc/cacheflush.h
>     include/linux/highmem.h

Not many drivers fiddle around with stuff like this, it's usually hidden
behind the dma api or in helpers.

-- 
Jens Axboe
