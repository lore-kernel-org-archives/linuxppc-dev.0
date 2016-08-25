Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKgzS6S5fzDrK4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 20:54:28 +1000 (AEST)
Message-ID: <1472122446.2246.93.camel@kernel.crashing.org>
Subject: Re: PowerPC agpmode issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike <michael.heltne@gmail.com>, "Herminio Hernandez Jr."
 <herminio.hernandezjr@gmail.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, "open list:LINUX FOR POWERPC..."
 <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 25 Aug 2016 20:54:06 +1000
In-Reply-To: <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-08-25 at 05:09 +0200, Mike wrote:
> Any improvement on your ends? Seems -1 is now the quirk. But does
> your trackpads work? Did an update after getting a new and the latest
> released powerbook up. Also found an interesting interface which can
> replace our ide drives, intended for ipod classics, but it can fit in
> the bay and has msata interface.

There are bigger issues with Apple AGP implementation, but yes that's
one of them. Another one is that because it's not cache coherent, AGP
pages shouldn't also be mapped cachable in Linux via the linear
mapping, as the prefetcher could cause cache aliases of them which
would be very bad. Sadly, Linux uses BATs on ppc32 to map the linear
mapping and so we can't unmap selected pages.

So sadly, while slow, I'm afraid PCI mode is the way to go for those
old things.

To revive those old Mac laptops, one of the more interesting to do
would be to port all my old power management code from radeonfb to
radeon KMS so sleep can work again ;-)

> On 5 Feb 2016 15:32, "Herminio Hernandez Jr."
> <herminio.hernandezjr@gmail.com> wrote:
> > I have been experiencing the same thing with my iBook and
> > PowerBook. 
> > 
> > Sent from my iPhone
> > 
> > On Feb 4, 2016, at 8:47 PM, Mike <michael.heltne@gmail.com> wrote:
> > 
> > > Hi. 
> > > Managed to get the Radeon R300 running on mesa 11.1.1 with an old
> > > 2013 patch from Michel Dànzer, next problem is of course enabling
> > > agpmode, running with pci-mode with radeon.agpmode=-1 works, but
> > > is of course slow, and seems to load the cpu a lot.
> > > 
> > > Upon initial investigation i could not initially believe agp
> > > could be this this broken for this long, until i found this.
> > >  "committed with Ben Skeggs on Feb 26, 2013"
> > > https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba
> > > 84d69ba445abc0efcfe3890a
> > > http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouv
> > > eau_agp.c?v=4.2
> > > #ifdef __powerpc__
> > > 		/* Disable AGP by default on all PowerPC machines for
> > > 		 * now -- At least some UniNorth-2 AGP bridges are
> > > 		 * known to be broken: DMA from the host to the card
> > > 		 * works just fine, but writeback from the card to the
> > > 		 * host goes straight to memory untranslated bypassing
> > > 		 * the GATT somehow, making them quite painful to deal
> > > 		 * with...
> > > 		 */
> > > 		if (nouveau_agpmode == -1)
> > > 			return false;
> > > #endif
> > >  
> > >  and now later this: 
> > > https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nou
> > > veau/nvkm/subdev/pci/agp.c
> > > #ifdef __powerpc__
> > > 	/* Disable AGP by default on all PowerPC machines for now -- At
> > > 	 * least some UniNorth-2 AGP bridges are known to be broken:
> > > 	 * DMA from the host to the card works just fine, but writeback
> > > 	 * from the card to the host goes straight to memory
> > > 	 * untranslated bypassing that GATT somehow, making them quite
> > > 	 * painful to deal with...
> > > 	 */
> > > 	mode = 0;
> > > #endif
> > > 
> > > All seems to point to serious issues had around the time of
> > > change to ums to kms and a serious regression hitting the linux
> > > kernel? No?
> > > 
> > > Cheers
> > > -Mike
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@lists.ozlabs.org
> > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
