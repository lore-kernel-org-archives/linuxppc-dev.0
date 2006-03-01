Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BAE2867A06
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 09:30:39 +1100 (EST)
Date: Wed, 1 Mar 2006 23:30:34 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Message-ID: <20060301223034.GA5965@suse.de>
References: <jehd7527wq.fsf@sykes.suse.de>
	<1139783738.5247.54.camel@localhost.localdomain>
	<20060226173908.GA4871@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060226173908.GA4871@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Feb 26, Olaf Hering wrote:

>  On Mon, Feb 13, Benjamin Herrenschmidt wrote:
> 
> > On Sat, 2006-02-11 at 17:10 +0100, Andreas Schwab wrote:
> > > When booting with line out or headphone plugged, you won't hear anything.
> > > The problem is that after reset all channels are muted, but the actual
> > > value of the gpio port doesn't exactly match the active_val settings as
> > > expected by check_audio_gpio.  For example, the line_mute port is set to
> > > 7, but check_audio_gpio would expect 0xd or 0xf, thus its return value
> > > indicates that it is not active, even though it is.  AFAICS only looking
> > > at the low bit is enough to determine whether the port is active.
> > > 
> > > Signed-off-by: Andreas Schwab <schwab@suse.de>
> > > 
> > > Index: linux-2.6.16-rc2/sound/ppc/tumbler.c
> > > ===================================================================
> > > --- linux-2.6.16-rc2.orig/sound/ppc/tumbler.c	2006-02-03 19:43:50.000000000 +0100
> > > +++ linux-2.6.16-rc2/sound/ppc/tumbler.c	2006-02-11 03:46:30.000000000 +0100
> > > @@ -207,7 +207,7 @@ static int check_audio_gpio(struct pmac_
> > >  
> > >  	ret = do_gpio_read(gp);
> > >  
> > > -	return (ret & 0xd) == (gp->active_val & 0xd);
> > > +	return (ret & 0x1) == (gp->active_val & 0x1);
> > >  }
> > >  
> > >  static int read_audio_gpio(struct pmac_gpio *gp)
> 
> This (sort of) breaks PowerMac3,4 (69 (PowerMac G4 Silver)). I have to
> force it on up to now, but with this patch the internal speaker will not
> work with or without my patch to force it on.

But the patch fixes also my PowerBook4,1, I dont have to toggle the headphone
once to get the built-in speakers enabled.
Looks like 2.6.16 stuff, but its been broken for so long now...
