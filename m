Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8A7FDE086
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 11:59:56 +1100 (EST)
Date: Wed, 5 Dec 2007 03:59:35 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
Message-ID: <20071205035935.75088890@kernel.crashing.org>
In-Reply-To: <200712050056.40543.arnd@arndb.de>
References: <11967907173600-git-send-email-timur@freescale.com>
	<200712050026.07616.arnd@arndb.de> <4755E701.3040908@freescale.com>
	<200712050056.40543.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Dec 2007 00:56:39 +0100
Arnd Bergmann wrote:

> On Wednesday 05 December 2007, Timur Tabi wrote:
> > Arnd Bergmann wrote:
> >=20
> > > You can argue that the QS is really a DMA device, but in that
> > > case you should convert the driver to use the DMA mapping
> > > interfaces correctly, which I would consider overkill.
> >=20
> > I'm confused. =C2=A0I'm already calling dma_alloc_coherent() and getting
> > a dma_addr_t back. =C2=A0Why do I need to use mapping functions to
> > convert between virtual and physical/bus addresses?
>=20
> No, I'm sorry but I'm the one who was confused. The problem I saw was
> that you return something offset from "bd_phys" as a dma_addr_t. This
> would be a lot easier if you had called it bd_bus or bd_dma instead
> of bd_phys, but your code looks absolutely correct upon closer
> inspection.
>=20
Adding my 2 cents, we already have very similar thing in cpm_uart driver...

> 	Arnd <><
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


--=20
Sincerely, Vitaly
