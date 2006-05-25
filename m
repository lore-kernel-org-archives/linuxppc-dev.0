Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7CB4F67A41
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 00:06:35 +1000 (EST)
Date: Thu, 25 May 2006 07:05:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: PowerMac: force only suspend-to-disk to be valid
Message-Id: <20060525070558.2b7e24cd.akpm@osdl.org>
In-Reply-To: <1148551527.11759.10.camel@johannes.berg>
References: <1146562296.3858.9.camel@localhost>
	<1148551527.11759.10.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2006-05-02 at 11:31 +0200, Johannes Berg wrote:
> > This patch adds the .valid callback to pm_ops on PowerMac so that only the
> > suspend to disk state can be entered. Note that just returning 0 would
> > suffice since the upper layers don't pass PM_SUSPEND_DISK down, but I think
> > they ought to be passing it down since they do really need support (or
> > am I mistaken again?) so we handle it there regardless.
> 
> No one ever seemed to care about this patch,

I don't recall having seen it before.

> can we queue it up for
> 2.6.18? I suppose it's too late now for 2.6.17 even if it fixes the
> long-standing but that on ppc, /sys/power/state kills the machine.
> 
> [quoted patch for reference]
> 
> > --- wireless-dev.orig/arch/powerpc/platforms/powermac/setup.c	2006-05-02 10:57:32.101509438 +0200
> > +++ wireless-dev/arch/powerpc/platforms/powermac/setup.c	2006-05-02 10:58:44.491509438 +0200
> > @@ -463,11 +463,23 @@ static int pmac_pm_finish(suspend_state_
> >  	return 0;
> >  }
> >  
> > +static int pmac_pm_valid(suspend_state_t state)
> > +{
> > +	switch (state) {
> > +	case PM_SUSPEND_DISK:
> > +		return 1;
> > +	/* can't do any other states via generic mechanism yet */
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> >  static struct pm_ops pmac_pm_ops = {
> >  	.pm_disk_mode	= PM_DISK_SHUTDOWN,
> >  	.prepare	= pmac_pm_prepare,
> >  	.enter		= pmac_pm_enter,
> >  	.finish		= pmac_pm_finish,
> > +	.valid		= pmac_pm_valid,
> >  };
> >  
> >  #endif /* CONFIG_SOFTWARE_SUSPEND */
> 

It looks like a 2.6.17 patch to me.  If someone wants to send it over with
changelog, signed-off-by, etc I can take care of it.
