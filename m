Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A5D1DDE39
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 00:31:14 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9CEV8dY006753
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:31:08 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9CEV60q020815
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 09:31:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA
	Controller
Date: Fri, 12 Oct 2007 22:31:06 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B582F@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071012145522.29dd7413@the-village.bc.nu>
References: <1192196849-24758-1-git-send-email-leoli@freescale.com>
	<20071012145522.29dd7413@the-village.bc.nu>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com,
	Kalra Ashish-B00888 <ashish.kalra@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]=20
> Sent: Friday, October 12, 2007 9:55 PM
> To: Li Yang-r58472
> Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org;=20
> linuxppc-dev@ozlabs.org; Kalra Ashish-B00888; Li Yang-r58472
> Subject: Re: [PATCH v2] drivers/ata: add support to Freescale=20
> 3.0Gbps SATA Controller
>=20
> > +	cd =3D pp->cmdentry + tag;
> > +
> > +	memcpy(fis, &cd->sfis, 6 * 4);	/* should we use=20
> memcpy_from_io() */
>=20
> If cd->sfis points at memory over the PCI bus (eg mmio or=20
> memory on the controller card) then you need to use=20
> ioread/_io type functions. If
> cd->sfis points into host memory where the FIS is delivered=20
> by DMA from
> the card you will be fine if it was allocated with an=20
> _coherent allocator

Thanks for the clarification.  So the code here is ok, that we use
command descriptor from dma_alloc_coherent().  :)

- Leo
