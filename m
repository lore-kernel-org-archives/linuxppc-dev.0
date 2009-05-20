Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 892BBDDFD1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 08:41:09 +1000 (EST)
Date: Wed, 20 May 2009 15:41:04 -0700 (PDT)
Message-Id: <20090520.154104.48737237.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: Musings on PCI busses
From: David Miller <davem@davemloft.net>
In-Reply-To: <1242856782.16901.203.camel@pasglop>
References: <20090520.122453.169463011.davem@davemloft.net>
	<fa686aa40905201306j4ef96cafl8ac02736dbdf7e5@mail.gmail.com>
	<1242856782.16901.203.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com, John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 May 2009 07:59:42 +1000

> On ppc64, we have code that can "create" the pci_bus & pci_dev hierarchy
> from the OF tree (avoiding the config space probing entirely). This is
> very efficient and has some advantages such as avoiding touching the
> BARs for sizing (which mean avoiding to temporarily disable access to
> devices behind them, which can be useful when it's your serial port or
> system controller there) etc...
> 
> It also have the advantage of avoiding a double PCI probe pass when the
> FW already did it and since most FW do ...
> 
> I'm tempted to extract that code and stick it in a
> drivers/pci/probe_of.c or something like that for more generic usage. We
> also have a per-bus hook that allows to switch to "real" config space
> probing at any point of the hierarchy (for example, you can setup things
> so that only on-board devices are in OF and probed that away and
> anything on your slot gets probed by linux using config space, that sort
> of thing).

This is exactly what sparc64 does as well, I took the powerpc code. :)

It also avoids a bunch of bugs that get unearthed as a result of
scanning the entire hierarchy with PCI config access "pokes".  Some
PCI controllers hang when certain PCI config space addresses are
accessed, meanwhile some hypervisor versions don't generate the bus
timeout exception properly on PCI config accesses to nonexisting
devices, the list is endless.

And all of that went away when I imported the ppc64 code to do
this using the OF device tree.

So if you put this in a common place, let's consolidate the differences
accumulated in the sparc64 code so I can use it too :-)
