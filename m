Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 3AB7367B16
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 17:29:52 +1000 (EST)
Date: Wed, 28 Jun 2006 02:29:28 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Make lparcfg.c work when both iseries and pseries are
	selected
Message-ID: <20060628072928.GX16029@localdomain>
References: <20060628115728.17f1a04d.sfr@canb.auug.org.au>
	<20060628040539.GW16029@localdomain>
	<20060628161903.7767131f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060628161903.7767131f.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Nathan,
> 
> On Tue, 27 Jun 2006 23:05:40 -0500 Nathan Lynch <ntl@pobox.com> wrote:
> >
> > Stephen Rothwell wrote:
> > >  static ssize_t lparcfg_write(struct file *file, const char __user * buf,
> > >  			     size_t count, loff_t * off)
> > >  {
> > > +	ssize_t retval = -ENOMEM;
> > > +#ifdef CONFIG_PPC_PSERIES
> 	.
> 	.
> 	.
> > > +#endif				/* CONFIG_PPC_PSERIES */
> > >  	return retval;
> > >  }
> > 
> > Erm... this is kind of gross, and will return -ENOMEM on iSeries when
> > it should really return -ENOSYS (I think).
> 
> lparcfg_write will never be called on iSeries.  The function just needs to
> exist to satisfy a conditional reference further down.

Okay.  Well, my earlier comment regarding readability still stands,
and I think is bolstered somewhat by this explanation ;)
