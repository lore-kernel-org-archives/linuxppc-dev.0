Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E2CC867BBE
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 23:32:21 +1100 (EST)
Date: Sat, 2 Dec 2006 13:32:23 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] linkstation / kurobox support
In-Reply-To: <1165058392.22108.34.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0612021325090.4841@poirot.grange>
References: <Pine.LNX.4.60.0612012241430.13326@poirot.grange>
	<200612021156.37067.arnd@arndb.de>
	<1165058392.22108.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2 Dec 2006, Benjamin Herrenschmidt wrote:

> On Sat, 2006-12-02 at 11:56 +0100, Arnd Bergmann wrote:
> 
> > > +#ifdef CONFIG_BLK_DEV_INITRD
> > > +       if (initrd_start)
> > > +               ROOT_DEV = Root_RAM0;
> > > +       else
> > > +#endif
> > > +#ifdef CONFIG_ROOT_NFS
> > > +               ROOT_DEV = Root_NFS;
> > > +#else
> > > +               ROOT_DEV = Root_HDA1;
> > > +#endif
> > > +
> > 
> > This looks wrong. Didn't the same code come up recently in a review for
> > another platform? What was the conclusion?
> 
> It's a copy paste that we inhertit from the big bang...  Should probably
> go...
> 
> Note that PowerMac does have a proper root autodetect feature though
> it's not fascionable to have such a thing nowadays and the only reason
> it's still in is because it mostly stays under the radar :-)
> 
> So basically... yeah, the #ifdef sucks, but I don't mind that much...

Thanks for the reviews. I don't like this place either. Never needed 
anything like that on ARM, don't think many other platforms have it 
either, but looking through other powerpc platforms I saw a few similar 
code fragments, so, kept it for now. In fact, it is there just to try to 
boot in case no "root=..." command line option is passed at all, right? I 
wouldn't mind just a panic then. Besides, this is supposed to be booted 
from u-boot, so, specifying a command line is not a problem. So, yes, will 
remove that. Is this an acceptable solution? But - could we, please, just 
get it into some tree in this form for now (if there are no other major 
objections), and I promise I'll send an incremental patch soon. I just 
don't want to bomb the list with this "minor" patch - it's already the 5th 
version...

Thanks
Guennadi
---
Guennadi Liakhovetski
