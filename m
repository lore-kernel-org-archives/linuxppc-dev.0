Return-Path: <rmcguire@videopresence.com>
Received: from smtpout04-04.prod.mesa1.secureserver.net
	(smtpout04-04.prod.mesa1.secureserver.net [64.202.165.199])
	by ozlabs.org (Postfix) with SMTP id 48D63DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Feb 2007 11:51:35 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
References: <000c01c746db$6451e7e0$6405a8c0@absolut>
	<06A02CF1-7D0C-4D59-9628-A2EB0FF3CCF4@kernel.crashing.org>
	<001101c746e3$5b8dab00$6405a8c0@absolut>
	<A755B15B-9C78-40E1-998D-FE9E68E74805@kernel.crashing.org>
Subject: RE: MPC8360 : PCI resource allocate error
Date: Mon, 5 Feb 2007 16:51:19 -0800
Message-ID: <000001c74988$ea7d7960$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <A755B15B-9C78-40E1-998D-FE9E68E74805@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I think I might be getting someplace on this debugging of the PCI slots.

I solved the erratic SLOT 3 issue, it was a hardware problem. A net was
unconnected, I should shoot the designer. Anyway, this was fixed that so all
slots are 100% consistent.

I think general issue is probably a setup problem with the PCI bridge chip.
Though I do not know how U-boot and Linux set up the bridge.

But after reading through the Bridge documentation, I have learned that each
bus must have the memory map declared in it, for all three memory spaces.
I.e. the base and the upper limit for each mem, mmio, and IO space.

When I boot into Linux, with PCI cards plugged in, and I read these
registers it looks as if the base address is correct, but the upper limit is
actually set one byte below the base address. To me this effectively
prevents all access to the memory region, halting it at the bridge chip.
Would explain why the only region I can seem to read is the configuration
space. 

I guess the question is, does Linux only enable these ranges if a card is
actively using them. Or is BIOS supposed to have these enabled before the OS
gets access to the bridge?

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, February 02, 2007 8:07 AM
> To: rmcguire@videopresence.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC8360 : PCI resource allocate error
> 
> 
> On Feb 2, 2007, at 10:01 AM, Russell McGuire wrote:
> 
> > Here is the current .dts mapping, though I am beginning to suspect the
> > hardware or a possible U-boot bug on this.
> >
> > U-boot can't see the PCI USB card in SLOT 3, but it can see the all
> > of the
> > other various PCI cards I have <ATI video card, sound card, ATA card,
> > network card>
> 
> Are any cards detected in SLOT 3 with u-boot?  If not, I'd think HW
> as well.
> 
> > All the cards that are seen by U-boot have the IO resource problem.
> > Only
> > when in Slot 3.
> >
> > I probably need to direct this at the U-boot crowd, but what about
> > these
> > defines in U-boot? Would they have any bearing? I forgot to publish
> > these
> > when I originally had asked the question bout PCI IO space, but
> > they are the
> > only ALL zero's in the mapping.
> 
> They shouldn't on just seeing the device.  Since PCI config cycles
> are used and U-boot will scan all busses you should at least see the
> device.
> 
> - k
