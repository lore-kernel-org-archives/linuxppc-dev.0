Return-Path: <root@ucw.cz>
Received: from spitz.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 93F71DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 21:13:48 +1000 (EST)
Date: Thu, 5 Apr 2007 21:41:44 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070405214143.GC5513@ucw.cz>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<20070404022544.59b022a6@the-village.bc.nu>
	<17939.10130.687893.167511@cargo.ozlabs.ibm.com>
	<1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
	<1175666635.2932.17.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1175666635.2932.17.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> > > Why? What's so special about the name 'ttyS'?
> > 
> > It's the name that users of Linux expect built-in serial ports to have.
> 
> Not really. The norm under Linux is for non-8250 ports to use
> properly-registered device numbers and names. There's not many which are
> still broken in this respect -- it's basically pmac_zilog and some Sun
> UARTs, isn't it?
> 
> And even if it _were_ true, it wouldn't be a particularly good reason
> for changing the way we handle serial ports under Linux.
> 
> > > > The built-in ports can generally be enumerated early on boot in a
> > > > stable order, and they should be assigned the low ttySn numbers,
> > > > regardless of what chip is used to implement them. 
> > > 
> > > I don't see why that 'should' be the case. Certainly it _isn't_ the case
> > > on most supported platforms -- we have separate device numbers, and
> > > names, for most types of ports. There's only one or two drivers which
> > > abuse ttySn for anything other than 8250 ports.
> >
> > It 'should' be the case because that is what is easiest for users and
> > makes most sense from a user's point of view.
> 
> I really don't buy that argument. People cope perfectly well
> with /dev/ttySA0 on StrongARM, with /dev/ttySC0 on SH, etc. If it isn't

Actually I thought that it was a typo when I seen ttySA0 on
openmoko... 

(Which is mostly offtopic here, because the fix for zilog is obviously
needed).

Did not linus say something like 'all devices of one type should use
similar name), in some sata debate?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
