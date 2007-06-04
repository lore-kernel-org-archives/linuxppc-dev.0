Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D12BDDE18
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 06:28:02 +1000 (EST)
In-Reply-To: <20070603083339.GB2157@iram.es>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <02DC2E36-86B1-4458-BB0C-13CF79AC1D11@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Mon, 4 Jun 2007 15:27:59 -0500
To: Gabriel Paubert <paubert@iram.es>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 3, 2007, at 03:33, Gabriel Paubert wrote:

> On Sun, Jun 03, 2007 at 09:41:33AM +0200, Segher Boessenkool wrote:
>>>> Oh what the hell, I'm too curious...  "pnpPNP,0" it is.
>>>>
>>>>> I believe that "8259" should appear somewhere because of the
>>>>> "8259-interrupt-acknowledge" property (defined in CHRP bindings)
>>>>> which you can have on the parent bridge to speed up interrupt
>>>>> vector acquisition.
>>>>
>>>> You're not CHRP so you have nothing to do with the CHRP
>>>> bindings...
>>>
>>> Still, you are close to CHRP
>>
>> Not at all, the rest of the device interrupt subsystem
>> is very different, too.
>
> Given how well you agree, I understand how other people
> might get a bit confused ;-)
>
> This said, I'm looking at device trees right now, and I can understand
> that interrupt-parent of the 8259 is &mpic in mpc8641_hpcn.dts, but
> I don't understand at all why it is &pci1 on the mpc85??cds.dts.
>
> But the definition of the ISA bridge in these files is very strange to
> start with: I've never seen an ISA bridge with only an interrupt  
> controller
> on it, no interrupts are connected to it and its reg property is
> almost certainly wrong. Maybe it is an example of things that should
> not be done.


I take full responsibility for that.  The CDS is a strange beast, so  
I did some strange things in the DTS.

The i8259 is on a subsidiary bus, and so it's one bus #1.  I chose  
not to create a proper node around it.  Not for any good reason.  The  
reason its interrupt parent is pci1 is because the i8259 emits its  
irq though PCI.  This is because the 8555 (and other CDS chips) are  
actually on a PCI card which is connected through PCI 1, while the  
i8259 is behind a bridge on the motherboard into which the CDS  
Carrier Card is plugged.

I always find my grammar stretched to the breaking point when  
describing the PCI topology of the CDS!

The 8641's topology is much simpler, and the i8259 sends its  
interrupts over an external interrupt pin which goes through the mpic/ 
openpic.


Andy
