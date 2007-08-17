Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A9BDDDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Aug 2007 02:28:12 +1000 (EST)
Message-ID: <46C5CC94.9090902@freescale.com>
Date: Fri, 17 Aug 2007 11:28:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: robert lazarski <robertlazarski@gmail.com>
Subject: Re: external IRQ's
References: <f87675ee0708160751u14f96dbcs3ad35a147b70a3f3@mail.gmail.com>	<46C47A1D.5030303@freescale.com>	<f87675ee0708161434i9f38b0dg123a767822cf7402@mail.gmail.com>	<46C4C4E6.9070406@freescale.com>
	<f87675ee0708170703t632db650o95fd7ec16f587c37@mail.gmail.com>
In-Reply-To: <f87675ee0708170703t632db650o95fd7ec16f587c37@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

robert lazarski wrote:
> On 8/16/07, Scott Wood <scottwood@freescale.com> wrote:
> 
>>robert lazarski wrote:
>>
>>>Why <1d 2 1e 2 22 2> ? I can't seem to parse these numbers
>>
>>They alternate between IRQ numbers and level/sense information, and the
>>IRQ numbers are the internal IRQ number plus 16.
> 
> 
> Thanks, The "internal IRQ number plus 16" part is the info I was
> lacking. However by 'internal IRQ' do you mean DMA? I just asked the
> hardware engineer and that's what he thought you may have meant.

No, I mean interrupts that come from on-chip devices, rather than 
external interrupt pins.

> So in '1d'  the first cell is the irq and the second cell is the sense
> level, how is the '1' calculated from 'internal IRQ number plus 16' .
> Thanks for you patience, I'm just not getting that part yet.

What do you mean, the '1'?

 From table 10-3 of the 8548 manual, the eTSEC1 transmit interrupt is 
internal interrupt 13, or 0xd.  Adding 16 gives 0x1d.

It's (apparently) level-triggered active-high, so the sense is 2, 
according to the table in booting-without-of.txt.

>>If, like the CDS board, you have level-triggered active-low phy
>>interrupts, then <0 1>, <1 1>, <2 1>, and <3 1>.  If not, then choose an
>>appropriate value for the second cell based on booting-without-of.txt.
>>
> 
> 
> Kool, think I got this part. Do the 0-3 irq's in the mdio node
> influence in any way the ethernet nodes irq's - the <1d 2 1e 2 22 2>
> in this example ?

No.

-Scott
