Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 83F28DDFDB
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 10:56:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
Date: Wed, 5 Dec 2007 00:56:39 +0100
References: <11967907173600-git-send-email-timur@freescale.com>
	<200712050026.07616.arnd@arndb.de> <4755E701.3040908@freescale.com>
In-Reply-To: <4755E701.3040908@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712050056.40543.arnd@arndb.de>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 December 2007, Timur Tabi wrote:
> Arnd Bergmann wrote:
>=20
> > You can argue that the QS is really a DMA device, but in that case you
> > should convert the driver to use the DMA mapping interfaces correctly,
> > which I would consider overkill.
>=20
> I'm confused. =A0I'm already calling dma_alloc_coherent() and getting a d=
ma_addr_t=20
> back. =A0Why do I need to use mapping functions to convert between virtua=
l and=20
> physical/bus addresses?

No, I'm sorry but I'm the one who was confused. The problem I saw was that
you return something offset from "bd_phys" as a dma_addr_t. This would be
a lot easier if you had called it bd_bus or bd_dma instead of bd_phys, but
your code looks absolutely correct upon closer inspection.

	Arnd <><
