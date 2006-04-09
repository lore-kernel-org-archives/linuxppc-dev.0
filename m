Return-Path: <daniel.ritz-ml@swissonline.ch>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCD87679E0
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 07:15:30 +1000 (EST)
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: "Edward Felberbaum" <efelberbaum@hotmail.com>
Subject: Re: Oops: machine check, sig: 7 [#1] - 16-bit Pccard - SOLVED!!!
Date: Sun, 9 Apr 2006 22:57:50 +0200
References: <BAY104-F3E7D812AD1E707C145856ABC90@phx.gbl>
In-Reply-To: <BAY104-F3E7D812AD1E707C145856ABC90@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604092257.52206.daniel.ritz-ml@swissonline.ch>
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 07 April 2006 08.25, Edward Felberbaum wrote:
> >From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
> >To: Edward Felberbaum <efelberbaum@hotmail.com>
> >CC: "linux-pcmcia" <linux-pcmcia@lists.infradead.org>
> >Subject: Re: Oops: machine check, sig: 7 [#1] - 16-bit Pccard - CardBus OK 
> >Edward Felberbaum
> >Date: Thu, 6 Apr 2006 20:11:50 +0200
> >
> > > >Can you try booting with the boot parameter
> > > >
> > > >reserve=0xfd000000-0xfdffffff
> > > >
> > > >?
> >
> >errm...that should have been:
> >	reserve=0xfd000000,0xffffff
> >ie. reserve=start,size
> >
> > >
> > > I added the above reserve to the boot parameters, it shows up on the 
> >Kernel
> > > command line in dmesg,  but dmesg still displays
> > >
> > > pcmcia: parent PCI bridge Memory window: 0xfd000000 - 0xfdffffff
> > >
> > > I would have expected the above line to not appear - use a different 
> >memory
> > > range due to the kernel command line "reserve".
> >
> >it will...:)
> >
> >rgds
> >-daniel
> 
> I followed your advice and inserted a 3Com 589 card and there was NO Oops!  
> WOW!
> 
> I built the 3c589 driver and the card works too.
> 
> Now I'm trying to get my Belkin F5D6020 v2 Wifi card to work.
> 
> Thanks very much for your help!
> 
> I see from the dmesg output from my original post that memory ranges 
> 0xfdd7f000 and 0xfddff000 are used by the Gatwick and Heathrow mac io 
> controllers.  That explains the conflict with PCMCIA over 0xfd000000.

interesting...the memory ranges are used by other devices yet the
request_resource() call in PCMCIA succeeds,,,and PCI resources shoudn't
be there in the first place then...

ok, it's in file arch/powerpc/platforms/powermac/feature.c...
i can't see any request_resource() calls in there...so CC'ing the PPC guys..
they can sure comment...

> 
> Question, can I minimize the range of memory that is reserved 0xffffff - or 
> is it a waste of time?
> 

yeah, you probably could, but it sounds like a waste of time...

> Eddie
> 

rgds
-daniel
