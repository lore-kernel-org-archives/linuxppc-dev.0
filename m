Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 17C0FB6EEA
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 21:57:30 +1100 (EST)
Date: Mon, 11 Jan 2010 13:57:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCHv2] spi_mpc8xxx: fix WARN_ON on remove after 4c1fba44296
Message-ID: <20100111105729.GA1259@oksana.dev.rtsoft.ru>
References: <1262859837-11311-1-git-send-email-jacmet@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1262859837-11311-1-git-send-email-jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 07, 2010 at 11:23:57AM +0100, Peter Korsgaard wrote:
> Commit 4c1fba44296 (Add support for QE DMA mode and CPM1/CPM2 chips)
> added unconditional calls to _cpm_init() / _cpm_free() from
> probe()/remove(), but only checked if we're actually using CPM mode
> in _init(), causing the WARN_ON in mpc8xxx_spi_free_dummy_rx() for !CPM.
> 
> Fix it by adding the same check in _cpm_free() as well.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Grant, can you please push it for 2.6.33?

Thanks!

> ---
>  drivers/spi/spi_mpc8xxx.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> Changes since v1:
> Fix return statement, mpc8xxx_spi_cpm_free() has void return type.
> diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
> index 1fb2a6e..674e7a2 100644
> --- a/drivers/spi/spi_mpc8xxx.c
> +++ b/drivers/spi/spi_mpc8xxx.c
> @@ -946,6 +946,9 @@ static void mpc8xxx_spi_cpm_free(struct mpc8xxx_spi *mspi)
>  {
>  	struct device *dev = mspi->dev;
>  
> +	if (!(mspi->flags & SPI_CPM_MODE))
> +		return;
> +
>  	dma_unmap_single(dev, mspi->dma_dummy_rx, SPI_MRBLR, DMA_FROM_DEVICE);
>  	dma_unmap_single(dev, mspi->dma_dummy_tx, PAGE_SIZE, DMA_TO_DEVICE);
>  	cpm_muram_free(cpm_muram_offset(mspi->tx_bd));
> -- 
> 1.6.5
> 

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
