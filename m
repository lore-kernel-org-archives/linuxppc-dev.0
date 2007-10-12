Return-Path: <ashish.kalra@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31947DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 00:37:01 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9CEauRJ012980
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:36:56 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9CEareH022007
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 09:36:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA
	Controller
Date: Fri, 12 Oct 2007 20:06:52 +0530
Message-ID: <2A6F278C5B66C4459AF4013E77A40CD3FCB95E@zin33exm20.fsl.freescale.net>
In-Reply-To: <20071012145522.29dd7413@the-village.bc.nu>
From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
	"Li Yang-r58472" <LeoLi@freescale.com>
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

This should be fine, as cd->sfis is allocated in host memory using a
_coherent allocator and the SATA-2 controller is
DMA'ing the D2H FIS into it.

Ashish =20

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]=20
Sent: Friday, October 12, 2007 7:25 PM
To: Li Yang-r58472
Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org;
linuxppc-dev@ozlabs.org; Kalra Ashish-B00888; Li Yang-r58472
Subject: Re: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps
SATA Controller

> +	cd =3D pp->cmdentry + tag;
> +
> +	memcpy(fis, &cd->sfis, 6 * 4);	/* should we use
memcpy_from_io() */

If cd->sfis points at memory over the PCI bus (eg mmio or memory on the
controller card) then you need to use ioread/_io type functions. If
cd->sfis points into host memory where the FIS is delivered by DMA from
the card you will be fine if it was allocated with an _coherent
allocator


Alan
