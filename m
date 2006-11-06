Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B9C6767C7D
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 07:00:28 +1100 (EST)
Date: Mon, 6 Nov 2006 21:00:25 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFC (take 2)] linkstation / kurobox support under
	arch/powerpc
In-Reply-To: <4EC85F22-99A9-4B0F-987C-25B715235320@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0611062048080.6091@poirot.grange>
References: <Pine.LNX.4.60.0611011844570.3736@poirot.grange>
	<Pine.LNX.4.60.0611051526510.4214@poirot.grange>
	<4EC85F22-99A9-4B0F-987C-25B715235320@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 6 Nov 2006, Kumar Gala wrote:

> > +config  KUROBOX
> > +	bool "Kurobox"
> > +
> > +config  KUROBOXHG
> > +	bool "Kurobox HG"
> > +
> 
> These two config options don't appear to be used anywhere

Yep, right, left-overs. Forgot I switched to fdt properties.

> > +void __init linkstation_pcibios_fixup(void)
> > +{
> > +	struct pci_dev *dev = NULL;
> > +
> > +	for_each_pci_dev(dev)
> > +		pci_read_irq_line(dev);
> > +}
> > +
> 
> You don't need this fixup going forward.

You mean this patch: 
http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027287.html? Yes, I 
knew about it, just that my local tree didn't have it yet:-)

> > +#include <linux/serial_reg.h>
> > +#include <linux/serial_8250.h>
> > +#include <asm/io.h>
> > +#include <asm/mpc10x.h>
> > +#include <asm/ppc_sys.h>
> > +#include <asm/prom.h>
> > +#include <asm/termbits.h>
> > +
> 
> Can this code not be reworked to use the standard 8250 driver?

I would gladly do, but I don't know how. There's no standard API to serial 
drivers from the kernel. There's linedisc, serio, but I don't think any of 
them directly fits my needs? I think, there was a patch recently on LKML 
exactly for this, but I didn't look at it too closely, haven't seen many 
replies either.

> > diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
> > index f1c7575..25cd8de 100644
> > --- a/drivers/net/r8169.c
> > +++ b/drivers/net/r8169.c
> > @@ -1396,41 +1396,6 @@ static void rtl8169_netpoll(struct net_d
> >  }
> >  #endif
> 
> Pull this into a separate patch since it effects a driver.  Also, any reason
> this code is being removed?

I explained in version 1 of the patch, sorry, didn't repeat: This is a 
recent patch to this driver, which I proved to break my system, so it has 
been now reverted as of 19-rc4. Just included it here for completeness in 
case anybody wants to boot this kernel:-) Of course, it doesn't actually 
belong here.

Thanks for ther review! I'll remove the superfluous config options, will 
be glad to see any ideas as to how to interface to the serial driver.

Thanks
Guennadi
---
Guennadi Liakhovetski
