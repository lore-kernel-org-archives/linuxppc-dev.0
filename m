Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp12.wanadoo.fr (smtp12.wanadoo.fr [193.252.22.20])
	by ozlabs.org (Postfix) with ESMTP id CFEB967A6B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 18:29:46 +1100 (EST)
Date: Wed, 9 Mar 2005 08:17:22 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050309071722.GA25622@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy> <20050308064945.GC27722@pegasos>
	<1110266832.13607.267.camel@gaston>
	<20050308122048.GA22866@xyzzy> <20050308121501.GC4556@pegasos>
	<20050308124201.GA5545@pegasos> <20050308164310.GA9891@pegasos>
	<1110321086.13593.284.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1110321086.13593.284.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Dale Farnsworth <dale@farnsworth.org>, sl@bplan-gmbh.de,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Nicolas DET <det.nicolas@free.fr>, linuxppc-embedd@ozlabs.org
Subject: Re: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2005 at 09:31:26AM +1100, Benjamin Herrenschmidt wrote:
> 
> > Ok, i should have something working. adding here both sven2-dale.diff which is
> > a patch against linux-2.5-mv643xx-enet and sven2.diff which is a patch against
> > 2.6.11.
> > 
> > There is still a bit of cleanup needed in arch/ppc/platforms/mv643xx_eth_pegasos.c 
> > especially with regard the headers, and also the proper copyright/attibution
> > of it (since dale wrote it and i just pasted it and did the detection stuff
> > benh mentioned above.
> > 
> > I am unsure also about the : 
> > 
> > @@ -44,6 +44,9 @@
> >  #include <asm/pgtable.h>
> >  #include <asm/system.h>
> >  #include <asm/delay.h>
> > +#ifdef PPC_MULTIPLATEFORM
> > +#include <mv64x60.h>
> > +#endif
> >  #include "mv643xx_eth.h"
> > 
> >  /*
> > 
> > hunk. dale can you check it ? 
> 
> Looks broken...

Yep, removed it.

> > Comments are welcome, in particular benh, i guess my detection code will beak
> > horribly if there is another host node prior to the marvell one in the OF
> > tree, which is not the case currently on pegasos though.
> 
> Why are you looking at vid/did ? Isn't there some name string (model,
> compatible, whatever) you can use ? Or is your OF too bad to even give
> such info ?
> 
> You can also iterate after the find_devices() using np->next

Well, I have this : 

vendor-id             0x11AB (4523)
device-id             0x6460 (25696)
revision-id           0x3 (3)
class-code            0x60000 (393216)
subsystem-id          0x0 (0)
subsystem-vendor-id   0x0 (0)
.vendor-name          "Marvell"
.part-number          "MV6436x"
.description          "System Controller for PowerPC Processors"
.class                "Bridge Device"
.subclass             "Host/PCI"
devsel-speed          0x0 (0)
min-grant             0x0 (0)
max-latency           0x0 (0)
name                  "host"
reg                   0:0
assigned-addresses

In the /pci/host node, i also have :

model                 "Pegasos2"

In the root node, and in the new OF, we even have a /discovery2/port@1 or
something such, but it is unreleased yet.

The thing is not that there is no info, just to chose which info is best.

Christoph suggested to not do that though, but use the normal pci stuff and
match on the host pci id with pci_dev_present. This is what i was thinking of
doing too, and may be more logical, no ? 

Friendly,

Sven Luther
