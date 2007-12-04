Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 3EC37DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 10:26:18 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
Date: Wed, 5 Dec 2007 00:26:07 +0100
References: <11967907173600-git-send-email-timur@freescale.com>
	<200712042313.58252.arnd@arndb.de> <4755D73D.7040204@freescale.com>
In-Reply-To: <4755D73D.7040204@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712050026.07616.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 December 2007, Timur Tabi wrote:
> When I program the DMA controller, I give it a dma_addr_t. =A0And yet, th=
e DMA=20
> controller and the QE are both devices on the SoC. =A0So if the DMA contr=
oller=20
> takes a dma_addr_t, then shouldn't the QE also take one?
>=20

=46rom a code clarity perspective, the interesting point is that dma_addr_t=
 is
what comes back from the functions in dma-mapping.h. If you don't use them,
a physical address is phys_addr_t.

You can argue that the QS is really a DMA device, but in that case you
should convert the driver to use the DMA mapping interfaces correctly,
which I would consider overkill.

	Arnd <><
