Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5FB7C67A5F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 16:19:25 +1000 (EST)
Date: Wed, 28 Jun 2006 16:19:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] Make lparcfg.c work when both iseries and pseries are
	selected
Message-Id: <20060628161903.7767131f.sfr@canb.auug.org.au>
In-Reply-To: <20060628040539.GW16029@localdomain>
References: <20060628115728.17f1a04d.sfr@canb.auug.org.au>
	<20060628040539.GW16029@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nathan,

On Tue, 27 Jun 2006 23:05:40 -0500 Nathan Lynch <ntl@pobox.com> wrote:
>
> Stephen Rothwell wrote:
> >  static ssize_t lparcfg_write(struct file *file, const char __user * buf,
> >  			     size_t count, loff_t * off)
> >  {
> > +	ssize_t retval = -ENOMEM;
> > +#ifdef CONFIG_PPC_PSERIES
	.
	.
	.
> > +#endif				/* CONFIG_PPC_PSERIES */
> >  	return retval;
> >  }
> 
> Erm... this is kind of gross, and will return -ENOMEM on iSeries when
> it should really return -ENOSYS (I think).

lparcfg_write will never be called on iSeries.  The function just needs to
exist to satisfy a conditional reference further down.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
