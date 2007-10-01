Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6344DDEE3
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 07:38:04 +1000 (EST)
Message-ID: <470168B4.7090005@freescale.com>
Date: Mon, 01 Oct 2007 16:37:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: Problem with OF interrupt parsing code
References: <20071001210025.314240@gmx.net> <470165F6.7030505@freescale.com>
In-Reply-To: <470165F6.7030505@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
>> The problem occurs now, if there is no device node defined for another
>> PCI device. In this case, of_irq_map_pci() checks for an interrupt pin,
>> searches again for the host bridge node and calls of_irq_map_raw() with
>> the device node of the host bridge. The function finds the
>> #interrupt-cells, #address-cells, interrupt-controller properties, but
>> fails to find the interrupt-map property (because it's missing in the
>> device tree). Therefore the function then tries to find a new parent,
>> which leads to an endless loop (it always selects the PCI2ISA southbridge
>> in the device tree).
> 
> That seems likely... there should probably be some loop detection.

Actually, it doesn't -- it should stop when it sees the 
interrupt-controller property in the i8259 node, at which point it'll be 
trying to use the raw PCI IRQ pin number as an i8259 IRQ.  This is 
Unlikely To Work(tm).

-Scott
