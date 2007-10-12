Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 261BADDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 23:50:58 +1000 (EST)
Date: Fri, 12 Oct 2007 14:55:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA
	Controller
Message-ID: <20071012145522.29dd7413@the-village.bc.nu>
In-Reply-To: <1192196849-24758-1-git-send-email-leoli@freescale.com>
References: <1192196849-24758-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, Li Yang <leoli@freescale.com>, jgarzik@pobox.com,
	Ashish Kalra <ashish.kalra@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	cd = pp->cmdentry + tag;
> +
> +	memcpy(fis, &cd->sfis, 6 * 4);	/* should we use memcpy_from_io() */

If cd->sfis points at memory over the PCI bus (eg mmio or memory on the
controller card) then you need to use ioread/_io type functions. If
cd->sfis points into host memory where the FIS is delivered by DMA from
the card you will be fine if it was allocated with an _coherent allocator


Alan
