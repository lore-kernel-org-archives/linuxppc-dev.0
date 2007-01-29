Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.4.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4272DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Jan 2007 19:07:31 +1100 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l0T87L9G026408
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 Jan 2007 09:07:22 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45BDAB22.30908@246tNt.com>
Date: Mon, 29 Jan 2007 09:06:58 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Eric Nuckols <jrocnuck@hotmail.com>
Subject: Re: mem=XXXM  ioremap DMA
References: <BAY117-F357AAA4A4F722329BBA628C8A10@phx.gbl>
In-Reply-To: <BAY117-F357AAA4A4F722329BBA628C8A10@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1
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

Eric Nuckols wrote:
> in my driver, I'm calling
> my_virt_address =   ioremap( 0x1F800000, 0x800000  );
> my_bus_address = virt_to_bus( my_virt_address );
>
You can't use virt_to_bus on address returned by ioremap AFAIK.

I think you could do
my_bus_address = virt_to_bus(phys_to_virt(0x1f800000));

Altough it slightly misuse the functions ... but that should work.


        Sylvain
