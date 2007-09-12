Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id C2F28DDE27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 17:18:05 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: PCI target implementation on AMCC PPC CPUs
Date: Wed, 12 Sep 2007 09:17:29 +0200
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>
	<200709111113.46508.matthias.fuchs@esd-electronics.com>
	<46E6D131.2030904@ovro.caltech.edu>
In-Reply-To: <46E6D131.2030904@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709120917.29767.matthias.fuchs@esd-electronics.com>
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

I must admit, that the AMCC PowerPC's PCI interrupt capabilities could
be better:-) In both directions the host CPU has to do PCI
configuration cycles either to generate or acknowledge an interrupt.
The later is problematic for some OS coming from Redmond: you 
have to do pci configuration cycles from interrupt level - and
these OS do not 'like' that. 

In later designs and where possible we also switched to alternative
interrupt mechanisms (GPIO for target to host and gated flags in FPGA
registers for the other direction). Multiple interrupt sources 
are identified by messages that are written to the other sides
memory.

I think we should stop this discussion because its a little bit
off-topic on this list.

Matthias


On Tuesday 11 September 2007 19:32, David Hawkins wrote:
> Hi Matthias,
> 
> > we build a couple of PCI target designs using AMCC PowerPCs.
> > You are right that some things could be better. But ..
> > 
> > On Thursday 06 September 2007 22:26, David Hawkins wrote:
> >> There are several fundamental problems with the AMCC 440EP
> >> acting as a PCI target/slave;
> >>
> >> 2. Look in the data sheet and see if you can figure out
> >>     how the host processor can generate an interrupt to
> >>     the PowerPC core ... oops, you can't. That kind of
> >>     makes it difficult to work with doesn't it.
> >
> > You CAN! You can generate an interrupt to the PowerPC from the host
> > CPU bei writing to the PCI command register. You have to read the user manual
> > carefully. Perhaps it not that obvious.
> 
> Really!? Someone should tell AMCC tech support then.
> When I failed to find a method (other than hooking up
> an external GPIO), I contacted them and they came to
> the same conclusion (on the 440EP anyway).
> 
> I'll look in the latest user manual to be sure ...
> 
> PPC440EP_UM2000_v1_23.pdf
> 
> p394 has their 'cheesy' implementation of PCI INTA# control;
> toggle a single bit.
> 
> Then backing up a little, p388 has the PCI command register ...
> Nope, no comment there that a write causes an interrupt to
> the PowerPC core.
> 
> Ok, so going back to the UIC in Chapter 10, p224.
> 
> Ah-ha, PCI CMD write generates an interrupt 5!
> 
> So, I stand corrected; the host can generate an interrupt to
> the PowerPC core, and the method is 'cheesier' than the PCI
> INTA# control.
> 
> And my experience with AMCC's tech support is now a notch
> lower, as even they did not offer this as a solution :)
> 
> I sure am glad I changed to a Freescale processor ;)
> 
> Cheers,
> Dave
