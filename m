Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 23B9EDDF17
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 18:00:39 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: AMCC PPC460EX Canyonlands Hardwired interrupt
Date: Tue, 26 Aug 2008 10:00:27 +0200
References: <1219380814-17229-1-git-send-email-fkan@amcc.com>
	<200808222144.15235.sr@denx.de>
	<02f101c9074f$26d2cd90$0109220a@deltatau.local>
In-Reply-To: <02f101c9074f$26d2cd90$0109220a@deltatau.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808261000.27333.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 26 August 2008, Henry Bausley wrote:
> How do I go about using one of the gpio pins for my own interrupt with the
> Canyonlands board.  Previously I used a yosemite (ppc) board and modified
> the yosemite.c file so that IRQ0 and IRQ1 were edge sensitive and and stole
> the ETH0/1 phy hardware interrupts for my own purposes and everything
> worked.
>
> I am trying to do the same with the Canyonlands (powerpc) board.but cannot
> seem to enable the interrupt.

arch/powerpc now uses virtual interrupts instead of the physical interrupts 
used in arch/ppc. So you can't just use the physical interrupt number in your 
request_irq() anymore. You need an of-platform driver to generate the virtual 
interrupt from the physical interrupt in the device-tree 
(irq_of_parse_and_map()). And you need to add this new node with the 
interrupt property to your device-tree of course.

Best regards,
Stefan
