Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id 512CF10479B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 06:15:30 +1000 (EST)
Received: by pzk5 with SMTP id 5so653317pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 13:15:28 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 16 Sep 2010 14:15:26 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] spi_mpc8xxx: fix buffer overrun when sending
	only/receiving only more than PAGE_SIZE bytes
Message-ID: <20100916201526.GB11972@angua.secretlab.ca>
References: <20100916070525.4882CC7391@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100916070525.4882CC7391@messagerie.si.c-s.fr>
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 16, 2010 at 09:05:25AM +0200, christophe leroy wrote:
> This patch applies to 2.6.34.7 and 2.6.35.4
> It fixes an issue when sending only or receiving only more than PAGE_SIZE bytes
> 
> Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

applied to merge-spi branch, thanks.

g.

> 
> diff -urN c/drivers/spi/spi_mpc8xxx.c d/drivers/spi/spi_mpc8xxx.c
> --- c/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:44:03.000000000 +0200
> +++ d/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:44:14.000000000 +0200
> @@ -393,11 +393,17 @@
>  
>  	xfer_ofs = mspi->xfer_in_progress->len - mspi->count;
>  
> -	out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma + xfer_ofs);
> +	if (mspi->rx_dma == mspi->dma_dummy_rx)
> +		out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma);
> +	else
> +		out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma + xfer_ofs);
>  	out_be16(&rx_bd->cbd_datlen, 0);
>  	out_be16(&rx_bd->cbd_sc, BD_SC_EMPTY | BD_SC_INTRPT | BD_SC_WRAP);
>  
> -	out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma + xfer_ofs);
> +	if (mspi->tx_dma == mspi->dma_dummy_tx)
> +		out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma);
> +	else
> +		out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma + xfer_ofs);
>  	out_be16(&tx_bd->cbd_datlen, xfer_len);
>  	out_be16(&tx_bd->cbd_sc, BD_SC_READY | BD_SC_INTRPT | BD_SC_WRAP |
>  				 BD_SC_LAST);
