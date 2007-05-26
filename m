Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C703DDEEE
	for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2007 08:18:54 +1000 (EST)
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0705261052110.2657@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com>
	<20070525112414.GA32336@aepfle.de>
	<1180133119.19517.11.camel@localhost.localdomain>
	<Pine.LNX.4.62.0705261052110.2657@pademelon.sonytel.be>
Content-Type: text/plain
Date: Sun, 27 May 2007 08:18:43 +1000
Message-Id: <1180217923.19517.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-26 at 10:52 +0200, Geert Uytterhoeven wrote:
> On Sat, 26 May 2007, Benjamin Herrenschmidt wrote:
> > On Fri, 2007-05-25 at 13:24 +0200, Olaf Hering wrote:
> > > On Fri, May 25, Geert.Uytterhoeven@sonycom.com wrote:
> > > 
> > > > +++ b/drivers/scsi/ps3rom.c
> > > 
> > > > +			kaddr = kmap_atomic(sgpnt->page, KM_USER0);
> > > 
> > > linux/highmem.h is not included to get the kmap_* prototypes.
> > 
> > Beside, I don't see the point of using kmap on ppc64...
> 
> So what should I use instead?

you don't need to map ... the linear mapping is there.... page_address()
should just work. But then, kmap will resolve to just that anyway so I
suppose it doesn't matter.

Ben.
