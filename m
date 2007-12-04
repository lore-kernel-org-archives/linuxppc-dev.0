Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC1C3DE047
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 09:40:12 +1100 (EST)
Message-ID: <4755D73D.7040204@freescale.com>
Date: Tue, 04 Dec 2007 16:39:57 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
References: <11967907173600-git-send-email-timur@freescale.com>
	<200712042313.58252.arnd@arndb.de>
In-Reply-To: <200712042313.58252.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> I'm guessing that you don't really mean dma_addr_t here, but rather
> phys_addr_t, which is something different.

Now that I think about it, I don't know which is correct.  The value is plugged 
into the pointer register of a buffer descriptor, and the QE performs a DMA-like 
memory transfer from that address into its local memory.  I don't know if the QE 
is considered "external" enough that the address is a DMA address or a physical 
address.

When I program the DMA controller, I give it a dma_addr_t.  And yet, the DMA 
controller and the QE are both devices on the SoC.  So if the DMA controller 
takes a dma_addr_t, then shouldn't the QE also take one?

-- 
Timur Tabi
Linux kernel developer at Freescale
