Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4248EDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:39:10 +1000 (EST)
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0707161515460.1072@pademelon.sonytel.be>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707131541150.18802@pademelon.sonytel.be>
	<1184335333.3402.20.camel@localhost.localdomain>
	<200707131619.54898.arnd@arndb.de>
	<Pine.LNX.4.62.0707131707290.18802@pademelon.sonytel.be>
	<1184340528.3402.32.camel@localhost.localdomain>
	<Pine.LNX.4.62.0707132212520.23000@chinchilla.sonytel.be>
	<Pine.LNX.4.62.0707161338230.1072@pademelon.sonytel.be>
	<20070716121649.GI5195@kernel.dk>
	<Pine.LNX.4.62.0707161459010.1072@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707161515460.1072@pademelon.sonytel.be>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 07:38:48 +1000
Message-Id: <1184621929.25235.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Alessandro Rubini <rubini@vision.unipv.it>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Upon closer look, while flush_kernel_dcache_page() is a no-op on ppc64,
> flush_dcache_page() isn't. So I'd prefer to not call it if not really needed.
> 
> And according to James, flush_kernel_dcache_page() should be sufficient...
> 
> So I'm getting puzzled again...

flush_dcache_page() handles icache vs. dcache coherency by clearing the
PG_arch_1 bit in the struct page that indicates that the page is cache
clean.

You -must- call it if you're going to use any form of CPU access to
write to the page (basically dirtying the data cache) and that page can
be ever mapped into user space and executed from.

I don't know what flush_kernel_dcache_page() does and if it needs a
similar treatement, it's a new interface, so maybe Jens and or James can
tell me more about it..

Cheers,
Ben.
