Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 445AD67BF5
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 22:20:03 +1100 (EST)
Subject: Re: [PATCH] linkstation / kurobox support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200612021156.37067.arnd@arndb.de>
References: <Pine.LNX.4.60.0612012241430.13326@poirot.grange>
	<200612021156.37067.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 22:19:51 +1100
Message-Id: <1165058392.22108.34.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-12-02 at 11:56 +0100, Arnd Bergmann wrote:
> > +
> > +       /* Interpret the "ranges" property */
> > +       /* This also maps the I/O region and sets isa_io/mem_base */
> > +       pci_process_bridge_OF_ranges(hose, dev, 1);
> > +
> > +       return 0;
> > +}
> 
> Can't you use the new PCI probing from arch/powerpc/kernel/of_platform
> for this?

I wouldnt recomment it for 32 bits just yet ...

> > +#ifdef CONFIG_BLK_DEV_INITRD
> > +       if (initrd_start)
> > +               ROOT_DEV = Root_RAM0;
> > +       else
> > +#endif
> > +#ifdef CONFIG_ROOT_NFS
> > +               ROOT_DEV = Root_NFS;
> > +#else
> > +               ROOT_DEV = Root_HDA1;
> > +#endif
> > +
> 
> This looks wrong. Didn't the same code come up recently in a review for
> another platform? What was the conclusion?

It's a copy paste that we inhertit from the big bang...  Should probably
go...

Note that PowerMac does have a proper root autodetect feature though
it's not fascionable to have such a thing nowadays and the only reason
it's still in is because it mostly stays under the radar :-)

So basically... yeah, the #ifdef sucks, but I don't mind that much...

Ben
