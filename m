Date: Sun, 31 Mar 2002 21:04:48 -0700
From: Matt Porter <mporter@mvista.com>
To: Neil Wilson <nwilson@airspan.com>
Cc: mporter@mvista.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: forcing pci device start address ?
Message-ID: <20020401040448.GA18128@beef.az.mvista.com>
References: <000701c1d8ef$20c131c0$b949893e@m5axc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000701c1d8ef$20c131c0$b949893e@m5axc>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Mar 31, 2002 at 09:02:49PM +0100, Neil Wilson wrote:
> >On Sat, Mar 30, 2002 at 05:14:24PM -0000, Neil Wilson wrote:
> >
> > Hi,
> >
> > We have a new 7450/107 board that I have got to boot and run 2.4.17.  The
> > hardware designer has got some non-standard pci devices ie, a large fpga
> >  that lives in pci space but does not have a configuration register and
> also
> >  some standard pci devices like the AMD79C973 ethernet controller.
>
> >I don't understand.  It doesn't have "a configuration register".  Do
> >you mean that it does have any configuration space registers or that
> >it does not have BAR registers?  If it has BAR registers in config
> >space, do they respond to config cycles in the convential manner or
> >are they in a fixed position?  Please clarify so we can help you.
>
> Sorry for any lack of clarity, mainly it's due to me not understanding
> enough about pci to know what to ask for help on.
>
> Reading/decoding the hardware design spec section for the fpga says that it
> does not support pci plug & play and the pci interface in the fpga code does
> not have a configuration register set, it just details what IDSEL line is
> allocated and the fact that it is interfaced to the MPC107 pci bus both as a
> slave & master. There are no mention of BAR registers.
>
> Is it possible to set up a linuxppc pci interface to the fpga pci interface
> and other peripherals that do have configuration register sets (a tdm
> controller & an ethernet controller), to be at specific addresses in pci
> space, i.e. fpga at 0xc0000000, tdm at 0xd0000000 and ethernet at 0xe0000000
> rather than have the interfaces probed during initialisation and the ioaddr
> etc handed out to the relevant drivers ?  I know that we need to write a
> couple of drivers anyway but the ethernet is a pcnet32 controller.
>
> There, I have again probably unclarified what I am trying to find out !

Ok, I see the horrible mess they put you in.  Those !@$!# hardware
guys. :-/

Here's the basic layout:  you can use pci_auto like the other 7xx/74xx
embedded ports and constrain the I/O and Mem range so as to not conflict
with the PCI-wannabe devices your hardware guys spit out.  You are
writing custom drivers so you just depart from the Linux standard of
ioremaping or in*/out*ing resources and use your hardcoded addresses.

You could complicate things by manually adding the devices to the
PCI global list and creating resources but there is no value in that
for a custom design like this...you could boast about it to your
fellow engineers if you like though. :)

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
