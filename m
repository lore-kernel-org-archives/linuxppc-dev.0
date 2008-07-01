Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB74BDDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Jul 2008 13:38:31 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m613cOAE023992 for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jun 2008 20:38:24 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m613cMPV026067
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jun 2008 22:38:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Subject: RE: [PATCH] DMA Engine: fix error path(s) in fsl-dma driver
Date: Tue, 1 Jul 2008 11:38:23 +0800
Message-ID: <989B956029373F45A0B8AF029708189002563E31@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080630181856.GA6980@www.tglx.de>
References: <20080630181856.GA6980@www.tglx.de>
From: "Li Yang" <LeoLi@freescale.com>
To: "Sebastian Siewior" <bigeasy@linutronix.de>
Cc: Zhang Wei <zw@zh-kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Sebastian Siewior [mailto:bigeasy@linutronix.de]=20
> Sent: Tuesday, July 01, 2008 2:19 AM
> To: Li Yang
> Cc: Zhang Wei; linuxppc-embedded@ozlabs.org;=20
> linux-kernel@vger.kernel.org
> Subject: [PATCH] DMA Engine: fix error path(s) in fsl-dma driver
>=20
> of_fsl_dma_probe:
>  - kfree(NULL) doesn't hurt but dereferencing the pointer in=20
> iounmap does
>  - also, the irq can be freed
>=20
> of_fsl_dma_chan_probe:
> - iounmap(NULL) resolved in vunmap() what which in turn is=20
> able to handle NULL
>   pointer but dereferencing still doesn't work
> - don't clean up not yet allocated ressources, like list_del=20
> before list_add
>=20
> fsl_dma_self_test:
> - call fsl_dma_free_chan_resources() if the first dma trans=20
> didn't complete

Thanks Sebastian,

But similar patch has already been waiting in sub-system maintainer's =
tree which can be found at=20

http://git.kernel.org/?p=3Dlinux/kernel/git/djbw/async_tx.git;a=3Dcommit;=
h=3D29ec9bdef73d68134e7070ee91ccda0718d46150

- Leo
