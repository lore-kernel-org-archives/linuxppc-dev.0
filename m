Return-Path: <mgreer@mvista.com>
Date: Mon, 19 Dec 2005 18:01:36 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Phil Nitschke <Phil.Nitschke@avalon.com.au>
Message-ID: <20051220010136.GA31165@mag.az.mvista.com>
References: <kw3bkovcup.fsf@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <kw3bkovcup.fsf@lamorak.int.avalon.com.au>
Cc: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: linux DMA capabilities in MV64460
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Phil,

[Note: I'm cc'ing linuxppc-embedded for others to reference and to
add their thoughts.]
---

On Tue, Dec 20, 2005 at 10:49:58AM +1030, Phil Nitschke wrote:
> Hi Mark,
> 
> I'm developing a device driver to run in the 2.6.10 kernel.  I want to

That's a pretty old kernel.  Do you have the option of using a more
recent one like 2.6.14?

> get large amounts of data from a custom peripheral on the PCI bus.  The
> software is running on an Artesyn PmPPC7448, which includes a Discovery
> III bridge.

Can you share exact platform you're using?

> The custom device is a digitizer, which runs at over 200 million samples
> per second, so we're looking to use a fair amount of PCI bandwidth to
> get the data into main memory.  Burst reads/writes seem like the only
> way.
> 
> I have seen that you wrote some code for the mainstream kernel that sets
> up the mv64460.  One source told me:
> 
>   > In order to do PCI bursts, you'll need to use a DMA engine.  The
>   > MV64460 does contain a DMA engine, but you'd need to write a driver
>   > to access it.

That is not correct (assuming the quote is not out of context).
The bridge supports bursting on the PCI bus as long as the bridge is
configured correctly and the PCI device is making an appropriate request.
Note, however, that there are many errata for the Marvell parts including
some with cache coherency.  If your system is running with coherency on,
you may have to limit your bursts to 32 bytes (i.e., the size of one
cache line).

You can see how the bursting is set up on the bridge by looking at the
platform file for your board (e.g., <file:arch/ppc/platforms/katana.c> in
the latest linux kernel)--search for 'BURST'.

> Is there a summary of what is possible and/or not possible with the 4
> IDMA channels on the mv64460?

The only real documentation is the bridge's user manual from Marvell.
Unfortunately, you must sign an NDA to get access to it so I can't share
mine with you.  You will need access to that info to get very far so I
recommend you contact the people in your company that can make that
happen, ASAP.

> For example, if the device that I'm trying to get data from supported a
> DMA engine capable of initiating bursts on the PCI bus (it currently
> can't do this), does the current kernel code support that?

That's a hardware feature so its not really an issue of kernel support
other than ensuring that the firmware and/or kernel configures the bridge
correctly.  IOW, it can be supported by software but its an issue of
whether your hardware supports it (and it actually works).

> Or if I wanted to suck the data into main memory using the mv64460 IDMA
> controller (assuming the device couldn't initiate its own burst writes),
> is there a standard kernel interface to allow me to do this?

Yes.  You would make a "dma ctlr driver" for the dma ctlr(s).
I don't know what the best example would be but hopefully someone else
has a suggestion.

> Sorry if the questions are silly or inappropriately directed.

Not at all.  Those were good questions.

> At the
> moment I'm still trying to understand some really basic things, like
> what determines the difference between burst reads and ordinary reads,
> and what is the difference between SDMA and IDMA, etc ;-)

You may want to pick up "PCI System Architecture" from Mindshare, Inc.
There are ones for PCI-X and PCI-Express too, I think.  Well worth the money.

> Many thanks for any help/suggestions/information you can offer.
> 
> --
> Phil

I hope this helps,

Mark
