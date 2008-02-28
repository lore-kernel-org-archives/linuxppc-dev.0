Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AEE22DDEFB
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 04:24:45 +1100 (EST)
Date: Thu, 28 Feb 2008 11:24:34 -0600
From: Scott Wood <scottwood@freescale.com>
To: biswa.nayak@wipro.com
Subject: Re: Wrong IRQ assigned on MPC8349EMDS board
Message-ID: <20080228172434.GA25737@ld0162-tx32.am.freescale.net>
References: <4F36B0A4CDAD6F46A61B2B32C33DC69C05C579C0@BLR-EC-MBX03.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F36B0A4CDAD6F46A61B2B32C33DC69C05C579C0@BLR-EC-MBX03.wipro.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 28, 2008 at 09:38:36PM +0530, biswa.nayak@wipro.com wrote:
> I found that the IRQ lines assigned to different peripherals are
> completely wrong.
> My serial ports are connected to pin 9 and 10, but in this kernel the
> IRQs assigned are 16 and 17. 

These are virtual IRQ numbers, which have nothing to do with the IPIC IRQ
numbers.

> On a little investigation I found that the base address assigned to the
> IPIC chip is '0xFDDFB700'

That's a virtual address returned from ioremap(), not the physical
address of the IPIC.

> Does this wrong assignment is due to the wrong base address of the IPIC
> chip?
> With IRQs 16 and 17, how the serial console is working fine?
> 
> When I tried hard coding the IPIC base value to '0xfe000700' then the
> system refuses to boot up.

That might be a hint that things aren't as wrong as you think. :-)

> I kept the IPIC base as 0xfddfb700 and hard coded the irq lines for
> serial ports as 9 and 10
> and in that case the 'request_irq' call fails with the error number as
> '-38',
> which translates to '-ENOSYS'. 

Likewise.

-Scott
