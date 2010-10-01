Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 85419B70E3
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Oct 2010 21:22:18 +1000 (EST)
Received: by ewy2 with SMTP id 2so1631050ewy.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Oct 2010 04:22:16 -0700 (PDT)
Date: Fri, 1 Oct 2010 15:22:12 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: Re: [PATCH v3 2/7] spi/mpc8xxx: refactor the common code for
	SPI/eSPI controller
Message-ID: <20101001112212.GA17505@oksana.dev.rtsoft.ru>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 30, 2010 at 04:00:41PM +0800, Mingkai Hu wrote:
[...]
> -static void mpc8xxx_spi_change_mode(struct spi_device *spi)
> +static void fsl_spi_change_mode(struct spi_device *spi)
>  {
>  	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
>  	struct spi_mpc8xxx_cs *cs = spi->controller_state;
> -	__be32 __iomem *mode = &mspi->base->mode;
> +	struct fsl_spi_reg *reg_base = (struct fsl_spi_reg *)mspi->reg_base;

No need for these type casts (the same is for the whole patch).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
