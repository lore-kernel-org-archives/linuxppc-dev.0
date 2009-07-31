Return-Path: <julia@diku.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 560EDB7C0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 16:31:46 +1000 (EST)
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 785E9DDDB2
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:31:45 +1000 (EST)
Date: Fri, 31 Jul 2009 08:31:30 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5/5] sound/aoa: Add kmalloc NULL tests
In-Reply-To: <s5hws5pid6u.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.64.0907310831160.13462@ask.diku.dk>
References: <Pine.LNX.4.64.0907301610550.8734@ask.diku.dk>
	<1248963420.16129.0.camel@johannes.local>
	<Pine.LNX.4.64.0907301627260.8734@ask.diku.dk>
	<s5hws5pid6u.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 31 Jul 2009, Takashi Iwai wrote:

> At Thu, 30 Jul 2009 16:29:54 +0200 (CEST),
> Julia Lawall wrote:
> > 
> > On Thu, 30 Jul 2009, Johannes Berg wrote:
> > 
> > > On Thu, 2009-07-30 at 16:11 +0200, Julia Lawall wrote:
> > > > From: Julia Lawall <julia@diku.dk>
> > > > 
> > > > Check that the result of kzalloc is not NULL before a dereference.
> > > 
> > > >  		irq_client = kzalloc(sizeof(struct pmf_irq_client),
> > > >  				     GFP_KERNEL);
> > > > +		if (!irq_client) {
> > > > +			err = -ENOMEM;
> > > > +			printk(KERN_ERR "snd-aoa: gpio layer failed to"
> > > > +				" register %s irq (%d)\n", name, err);
> > > > +			goto out_unlock;
> > > > +		}
> > > 
> > > Looks good, thanks, but I'd really drop the printk if only to not have
> > > the string there, that doesn't really seem interesting.
> > 
> > The printk is based on similar error handling code a few lines later:
> 
> But another problem is that the same error message is reused although
> the error condition is totally different.  The kzalloc NULL isn't
> about the registration error.  So, it's rather confusing.
> 
> However, for this particular error path, I agree with Johannes; we can
> skip the error message since the error code ENOMEM is obvious.

OK, I will send a new patch.

julia
