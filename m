Return-Path: <JOFT@gmx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B6F5EB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 03:26:11 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7869BDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 03:26:09 +1000 (EST)
Subject: Re: SD card over (xilinx_)SPI, timeout error while CID
From: Joachim Foerster <JOFT@gmx.de>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1244216069.21470.12.camel@localhost>
References: <1244216069.21470.12.camel@localhost>
Content-Type: text/plain
Date: Tue, 09 Jun 2009 19:26:01 +0200
Message-Id: <1244568361.25223.16.camel@localhost>
Mime-Version: 1.0
Cc: lorenz@missinglinkelectronics.com, dbrownell@users.sourceforge.net,
	john.linn@xilinx.com, joachim@missinglinkelectronics.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, 2009-06-05 at 17:34 +0200, Joachim Foerster wrote:
> we have a very strange problem with SD-card-over-SPI support using
> 2.6.29.4 on our custom PowerPC 405 (Virtex-4 FX FPGA) based board. To
> summarize the problem in one sentence: mmc_spi gets a timeout (error
> -110) after sending MMC command "CMD10" (CID, card identification?).

The problem seems to be these DMA transfers/methods (?), which are used
by mmc_spi, if spi->master->dev.parent->dma_mask is non-NULL in
mmc_spi_probe() .
We detected the problem in form of kind of "data loss/corruption" in
mmc_spi_readbytes() after spi_sync() is called. Data is received
correctly by xilinx_spi (and thus by spi_sync())!

Background: The CMD10 is the first "bigger" ;-) (16 bytes) block
transfer, where mmc_spi waits for the token 0xfe by calling
mmc_spi_skip() in the end and later on receives these 16 bytes. But the
token seems to be "lost/corrupted" and thus a timeout occurs.

For now our dirty workaround is, to remove DMA support by commenting out
the "if (spi->master->dev.parent->dma_mask)" block in mmc_spi_probe().

Note, that in the old 2.6.26+arch/ppc this dma_mask is NULL - so DMA
code is never activated in mmc_spi_probe()!

Conclusion: Either DMA code in mmc_spi has a bug OR dma_*() functions
have a bug OR the device tree setup code should not assign a dma_mask to
xilinx_spi devices?

Any hints? Where do we have to look in case there is something wrong in
device tree setup?

 Joachim
