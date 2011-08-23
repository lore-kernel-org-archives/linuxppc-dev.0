Return-Path: <jirislaby@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00E4CB6F99
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 18:49:48 +1000 (EST)
Received: by bkar19 with SMTP id r19so4408639bka.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 01:49:43 -0700 (PDT)
Message-ID: <4E5369A0.4080701@gmail.com>
Date: Tue, 23 Aug 2011 10:49:36 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] SPI: fix build with CONFIG_SPI_FSL_ESPI=m
References: <1314086345-2818-1-git-send-email-jslaby@suse.cz>
In-Reply-To: <1314086345-2818-1-git-send-email-jslaby@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2011 09:59 AM, Jiri Slaby wrote:
> When spi_fsl_espi is chosen to be built as a module, there is a build
> error because we test only CONFIG_SPI_FSL_ESPI in declaration of
> struct mpc8xxx_spi in drivers/spi/spi_fsl_lib.h.
> 
> We need to add a test for CONFIG_SPI_FSL_ESPI_MODULE too.
> 
> The error looks like:
> drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_bufs':
> drivers/spi/spi_fsl_espi.c:232: error: 'struct mpc8xxx_spi' has no member named 'len'
> ...
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/spi/spi-fsl-lib.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
> index cbe881b..97968de 100644
> --- a/drivers/spi/spi-fsl-lib.h
> +++ b/drivers/spi/spi-fsl-lib.h
> @@ -28,7 +28,7 @@ struct mpc8xxx_spi {
>  	/* rx & tx bufs from the spi_transfer */
>  	const void *tx;
>  	void *rx;
> -#ifdef CONFIG_SPI_FSL_ESPI
> +#if defined(CONFIG_SPI_FSL_ESPI) || defined(CONFIG_SPI_FSL_ESPI_MODULE)
>  	int len;
>  #endif

Oh, and there are still link errors:
ERROR: "mpc8xxx_spi_tx_buf_u32" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "mpc8xxx_spi_rx_buf_u32" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "mpc8xxx_spi_tx_buf_u16" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "mpc8xxx_spi_rx_buf_u16" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "mpc8xxx_spi_tx_buf_u8" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "mpc8xxx_spi_rx_buf_u8" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "of_mpc8xxx_spi_probe" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "mpc8xxx_spi_strmode" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "mpc8xxx_spi_probe" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "mpc8xxx_spi_remove" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "to_of_pinfo" [drivers/spi/spi_fsl_spi.ko] undefined!
ERROR: "mpc8xxx_spi_tx_buf_u32" [drivers/spi/spi_fsl_espi.ko] undefined!
ERROR: "mpc8xxx_spi_rx_buf_u32" [drivers/spi/spi_fsl_espi.ko] undefined!
ERROR: "of_mpc8xxx_spi_probe" [drivers/spi/spi_fsl_espi.ko] undefined!
ERROR: "mpc8xxx_spi_probe" [drivers/spi/spi_fsl_espi.ko] undefined!
ERROR: "mpc8xxx_spi_remove" [drivers/spi/spi_fsl_espi.ko] undefined!

The functions are not exported...

Should I export all those or deny CONFIG_SPI_FSL_ESPI=m?

thanks,
-- 
js
