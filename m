Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACB68DDFDD
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 10:44:22 +1100 (EST)
Message-ID: <4755E65B.3050208@freescale.com>
Date: Tue, 04 Dec 2007 17:44:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
References: <11967907173600-git-send-email-timur@freescale.com>
	<200712050026.07616.arnd@arndb.de> <4755E3A6.80704@freescale.com>
	<200712050039.39153.arnd@arndb.de>
In-Reply-To: <200712050039.39153.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 05 December 2007, Scott Wood wrote:
>>> You can argue that the QS is really a DMA device, but in that
>>> case you should convert the driver to use the DMA mapping
>>> interfaces correctly, which I would consider overkill.
>> Why is it overkill?
>> 
> 
> Well, if the QE can never be used with an IOMMU anyway,

I'm unconvinced that that will always be the case.

> The DMA mapping API is meant for the cases where physical and dma 
> addresses can be different in the first place.

It's also used for noncoherent DMA; while it's unlikely Freescale will 
come out with a QE 8xx chip any time soon, there could be hardware bugs 
or performance considerations that make it desireable to treat it as 
non-coherent.

-Scott
