Return-Path: <julia@diku.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A971AB7B77
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 00:30:04 +1000 (EST)
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3240CDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 00:30:04 +1000 (EST)
Date: Thu, 30 Jul 2009 16:29:54 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 5/5] sound/aoa: Add kmalloc NULL tests
In-Reply-To: <1248963420.16129.0.camel@johannes.local>
Message-ID: <Pine.LNX.4.64.0907301627260.8734@ask.diku.dk>
References: <Pine.LNX.4.64.0907301610550.8734@ask.diku.dk>
	<1248963420.16129.0.camel@johannes.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 30 Jul 2009, Johannes Berg wrote:

> On Thu, 2009-07-30 at 16:11 +0200, Julia Lawall wrote:
> > From: Julia Lawall <julia@diku.dk>
> > 
> > Check that the result of kzalloc is not NULL before a dereference.
> 
> >  		irq_client = kzalloc(sizeof(struct pmf_irq_client),
> >  				     GFP_KERNEL);
> > +		if (!irq_client) {
> > +			err = -ENOMEM;
> > +			printk(KERN_ERR "snd-aoa: gpio layer failed to"
> > +				" register %s irq (%d)\n", name, err);
> > +			goto out_unlock;
> > +		}
> 
> Looks good, thanks, but I'd really drop the printk if only to not have
> the string there, that doesn't really seem interesting.

The printk is based on similar error handling code a few lines later:

               if (err) {
                        printk(KERN_ERR "snd-aoa: gpio layer failed to"
                                        " register %s irq (%d)\n", name, 
err);
                        kfree(irq_client);
                        goto out_unlock;
                }

Should the printk be removed in this case as well?  Or is it ok to fail 
silently in one case and not in the other?

julia
