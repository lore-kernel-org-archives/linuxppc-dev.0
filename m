Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 191FE67A5F
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 00:10:46 +1000 (EST)
Date: Thu, 25 May 2006 07:10:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: johannes@sipsolutions.net, linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org
Subject: Re: PowerMac: force only suspend-to-disk to be valid
Message-Id: <20060525071013.21379ba8.akpm@osdl.org>
In-Reply-To: <20060525070558.2b7e24cd.akpm@osdl.org>
References: <1146562296.3858.9.camel@localhost>
	<1148551527.11759.10.camel@johannes.berg>
	<20060525070558.2b7e24cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton <akpm@osdl.org> wrote:
>
> > > +static int pmac_pm_valid(suspend_state_t state)
>  > > +{
>  > > +	switch (state) {
>  > > +	case PM_SUSPEND_DISK:
>  > > +		return 1;
>  > > +	/* can't do any other states via generic mechanism yet */
>  > > +	default:
>  > > +		return 0;
>  > > +	}
>  > > +}
>  > > +
>  > >  static struct pm_ops pmac_pm_ops = {
>  > >  	.pm_disk_mode	= PM_DISK_SHUTDOWN,
>  > >  	.prepare	= pmac_pm_prepare,
>  > >  	.enter		= pmac_pm_enter,
>  > >  	.finish		= pmac_pm_finish,
>  > > +	.valid		= pmac_pm_valid,
>  > >  };
>  > >  
>  > >  #endif /* CONFIG_SOFTWARE_SUSPEND */
>  > 
> 
>  It looks like a 2.6.17 patch to me.  If someone wants to send it over with
>  changelog, signed-off-by, etc I can take care of it.
> 

Please also explain whether this fix is needed in 2.6.16.x.
