Date: Mon, 1 Apr 2002 13:35:35 -0700
From: Matt Porter <mporter@mvista.com>
To: Neil Wilson <nwilson@airspan.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: forcing pci device start address ?
Message-ID: <20020401203535.GD20767@beef.az.mvista.com>
References: <000701c1d9ba$c2f27aa0$b3ff883e@m5axc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000701c1d9ba$c2f27aa0$b3ff883e@m5axc>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Apr 01, 2002 at 09:21:08PM +0100, Neil Wilson wrote:
> >Ok, I see the horrible mess they put you in.  Those !@$!# hardware
> >guys. :-/
>
> >Here's the basic layout:  you can use pci_auto like the other 7xx/74xx
> >embedded ports and constrain the I/O and Mem range so as to not conflict
> >with the PCI-wannabe devices your hardware guys spit out.  You are
> >writing custom drivers so you just depart from the Linux standard of
> >ioremaping or in*/out*ing resources and use your hardcoded addresses.
>
> >You could complicate things by manually adding the devices to the
> >PCI global list and creating resources but there is no value in that
> >for a custom design like this...you could boast about it to your
> >fellow engineers if you like though. :)
>
>
> Thanks for your help, I will start looking at this when I get in tomorrow.
>
> Do you happen to know of a driver example in one of the kernel trees or
> elsewhere that implements this hardcoded address business that I can learn
> from ?

All you need to do is
ioremap(<hardcoded_base_address_in_physical_space>),<region_size>)
rather than ioremapping the PCI resource like a normal 2.3/2.4 PCI
device.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
