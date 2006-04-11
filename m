Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2990267A76
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2006 11:35:01 +1000 (EST)
Subject: Re: Oops: machine check, sig: 7 [#1] - 16-bit Pccard - SOLVED!!!
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
In-Reply-To: <200604092257.52206.daniel.ritz-ml@swissonline.ch>
References: <BAY104-F3E7D812AD1E707C145856ABC90@phx.gbl>
	<200604092257.52206.daniel.ritz-ml@swissonline.ch>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 11:30:14 +1000
Message-Id: <1144719014.19353.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Edward Felberbaum <efelberbaum@hotmail.com>,
	linux-pcmcia@lists.infradead.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I see from the dmesg output from my original post that memory ranges 
> > 0xfdd7f000 and 0xfddff000 are used by the Gatwick and Heathrow mac io 
> > controllers.  That explains the conflict with PCMCIA over 0xfd000000.
> 
> interesting...the memory ranges are used by other devices yet the
> request_resource() call in PCMCIA succeeds,,,and PCI resources shoudn't
> be there in the first place then...
> 
> ok, it's in file arch/powerpc/platforms/powermac/feature.c...
> i can't see any request_resource() calls in there...so CC'ing the PPC guys..
> they can sure comment...

Most of the macio stuff is in drivers/macintosh/macio_asic.c ... the
whole macio itself is a PCI device and thus should already "occupy" it's
possibly address range...

> > 
> > Question, can I minimize the range of memory that is reserved 0xffffff - or 
> > is it a waste of time?
> > 
> 
> yeah, you probably could, but it sounds like a waste of time...
> 
> > Eddie
> > 
> 
> rgds
> -daniel
