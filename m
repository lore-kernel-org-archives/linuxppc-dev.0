Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B09ADDD07
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Sep 2007 02:02:07 +1000 (EST)
Date: Sat, 8 Sep 2007 11:01:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/10] cpm2: Infrastructure code cleanup.
Message-ID: <20070908160154.GA31862@ld0162-tx32.am.freescale.net>
References: <20070905192841.GA32441@ld0162-tx32.am.freescale.net>
	<200709081648.54960.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200709081648.54960.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 08, 2007 at 04:48:53PM +0200, Arnd Bergmann wrote:
> On Wednesday 05 September 2007, Scott Wood wrote:
> > 
> >  void *cpm_dpram_addr(unsigned long offset)
> >  {
> > -       return (void *)(im_dprambase + offset);
> > +       return (void __force *)(im_dprambase + offset);
> >  }
> >  EXPORT_SYMBOL(cpm_dpram_addr);
> 
> This does not look like a legitimate use of __force. I think it's better
> to leave the warning in place for cases like this, so that someone else
> can clean up the remaining users of this.
> 
> In this particular case, it seems that the function should either
> be removed or changed to return an __iomem pointer so you get the
> warning in the mac-fcc driver using it.

Yeah, there's a fair amount of crud in the CPM API...

I wanted to avoid changing it until arch/ppc is gone (or at least until
CPM platforms are officially no longer supported in it) so I don't have
to worry about breaking it.  I'm OK with leaving the warning there as a
reminder.

-Scott
