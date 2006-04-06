Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (unknown [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 18B3967B14
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Apr 2006 02:44:45 +1000 (EST)
Subject: Re: [PATCH] ppc32: Support for Freescale PQ2FADS
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <1144339578.11172.19.camel@rhino.az.mvista.com>
References: <1144194855.32471.64.camel@rhino.az.mvista.com>
	<20060406180517.36ad1b7d@vitb.ru.mvista.com>
	<1144339578.11172.19.camel@rhino.az.mvista.com>
Content-Type: text/plain
Message-Id: <1144341883.11171.39.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 06 Apr 2006 09:44:44 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-06 at 09:06, Wade Farnsworth wrote:
> On Thu, 2006-04-06 at 07:05, Vitaly Bordug wrote:
> > 
> > Though I doubt if new boards are accepting to ppc/ currently, it's nice to have a patch 
> > available. BTW, I suggest to use phy abstraction and updated fs_enet (submitted here recently)
<snip>
> > > +CONFIG_USB_ARCH_HAS_HCD=y
> > > +CONFIG_USB_ARCH_HAS_OHCI=y
> > 
> > Not sure this is required as well.
> 
> I'll disable this as well.

Looking at drivers/usb/Kconfig, these are actually enabled by default if
CONFIG_PCI is enabled.  CONFIG_USB then depends on
CONFIG_USB_ARCH_HAS_HCD.

> 
> <snip>
> 
> > > +#ifdef CONFIG_PQ2FADS
> > > +#define F2_RXCLK	13
> > > +#define F2_TXCLK	14
> > > +#else
> > >  #define F2_RXCLK	15
> > >  #define F2_TXCLK	16
> > > +#endif
> > >  
> > Hmm, this should go into the board-specific header - here should exist just a "reasonable default" (pq2ads.h in this context). 
> > 
> > 
> > >  /* FCC3 Clock Source Configuration.  These can be redefined in the board specific file.
> > >     Can only choose from CLK13-16 */
> > > +#ifdef CONFIG_PQ2FADS
> > > +#define F3_RXCLK	15
> > > +#define F3_TXCLK	16
> > > +#else
> > >  #define F3_RXCLK	13
> > >  #define F3_TXCLK	14
> > > +#endif
> > >  
> > ditto.
> 
> Ok, I'll move these defines into pq2ads.h
> 

Also, moving the defines into pq2ads.h results in some nasty warning
messages.  I'll put some #ifndef's around the #define's in pq2ads_pd.h
to squelch them.

-Wade
