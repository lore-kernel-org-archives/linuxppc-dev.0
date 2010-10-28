Return-Path: <pacman@kosh.dhis.org>
Received: from kosh.dhis.org (c-67-162-90-113.hsd1.in.comcast.net
	[67.162.90.113]) by ozlabs.org (Postfix) with SMTP id CB6A4B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 08:07:55 +1100 (EST)
Message-ID: <20101028210753.22240.qmail@kosh.dhis.org>
From: pacman@kosh.dhis.org
Subject: Re: Pegasos OHCI bug (was Re: PROBLEM: memory corrupting bug,
To: segher@kernel.crashing.org (Segher Boessenkool)
Date: Thu, 28 Oct 2010 16:07:53 -0500 (GMT+5)
In-Reply-To: <52441.84.105.60.153.1288295412.squirrel@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool writes:
> 
> > So is it wrong to leave the host controller enabled when the OS is booted?
> 
> Yes.  Or, rather, there should be some way for the client to turn off
> all dma and interrupt activity; if the client closes the ihandles in
> "/chosen", and perhaps calls "quiesce", that should be enough.

Sounds good to me, I only wish someone had written down what "quiesce" means.

> >
> > Almost all of my devices are under that PCI node. What will I prove by
> > disabling them?
> 
> You should put it after "load", and before "go".
> 
> It should give you a working system; it's a sledgehammer workaround.

I can do it a little more gracefully than that. This works to deactivate the
problem devices manually:

  1 lbflip 80000000 8 + rl!
  1 lbflip 80001000 8 + rl!

where 80000000 and 80001000 have been obtained from
/pci@80000000/usb@5/assigned-addresses and
/pci@80000000/usb@5,1/assigned-addresses; 8 is the offset of the
HcCommandStatus register; and the 1 bit is HostControllerReset (HCR).

Now I'm just trying to find the more correct way of doing it, without
hardcoded addresses. That'll be something like this:

  search the device tree for OHCI nodes
  for each OHCI node
    get assigned-addresses
    map-in
    set HCR
    wait for acknowledgement
    map-out

which can be done any time before the quiesce call, since that marks the
point where the kernel assumes that there are no devices writing to memory.
Sound good?

-- 
Alan Curry
