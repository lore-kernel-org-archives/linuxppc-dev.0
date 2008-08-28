Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 89375DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 01:25:28 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: GPIO interrupt on AMCC 460EX
Date: Thu, 28 Aug 2008 17:20:13 +0200
References: <48B6B201.2070101@embedded-sol.com>
In-Reply-To: <48B6B201.2070101@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808281720.13138.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Felix,

On Thursday 28 August 2008, Felix Radensky wrote:
> I'm writing a Linux driver for CPLD access on custom
> 460EX based board. CPLD generates interrupt, which
> is connected to GPIO pin 45. According to 460EX user
> manual, this pin, if configured as alternate function 3,
> will generate external interrupt 12, which is mapped into
> irq 20 on UIC3.  My question is - how do I get irq number
> suitable for passing to request_irq().

arch/powerpc now used virtual interrupts. You need to include this hardware 
interrupt number into your device-tree (create a new node for your CPLD) and 
extract the virtual irq number from there by calling irq_of_parse_and_map().

Best regards,
Stefan
