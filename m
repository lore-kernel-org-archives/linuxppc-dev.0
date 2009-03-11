Return-Path: <Malcolm.Crossley2@gefanuc.com>
Received: from exprod5og114.obsmtp.com (exprod5og114.obsmtp.com [64.18.0.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B716CDE24D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:58:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: fsldma driver questions
Date: Wed, 11 Mar 2009 15:52:41 -0000
Message-ID: <FF6D174B07759740B0259F914CE6D7D305B1A61D@LONMLVEM04.e2k.ad.ge.com>
From: "Crossley, Malcolm (GE EntSol,
	Intelligent Platforms)" <Malcolm.Crossley2@gefanuc.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi there,

I've been examining the fsl dma driver (drivers/dma/fsldma.c) to work
out how a typical dma engine driver works so I can port an Intel dma
engine driver to the new dmaengine interface.=20

I have noticed that append_ld_queue() changes the next link descriptor
address field in the last link descriptor of the chain. The
append_ld_queue function is called from the fsl_dma_tx_submit() which
can called at any time by a kernel module using that channel. This could
result in the link descriptor being changed whilst the DMA engine is
running. Could this issue cause unexpected behavior of the DMA engine or
the driver?

A second question I have is to do with the dma_halt() routine setting
the channel abort flag. The dma_halt() routine is called from
fsl_chan_xfer_ld_queue() after the dma engine has been detected as idle.
The dma_halt() routine sets the channel stop flag and the channel abort
flag. Whilst the dma engine could be idle, it may not have completed a
transfer AFAICT. Or if the engine is has no more transactions then a
channel abort does not need to be issued anyway?

I have access to a GE Fanuc SBC310 which has an 8641D containing a dma
engine this driver was written for. So I can test any patches.=20

Thanks for your time. Malcolm

--=20

Malcolm Crossley, Software Engineer,=20
GE Fanuc Intelligent Platforms
GE Fanuc Intelligent Platforms Ltd, registered in England and Wales
(3828642) at 100 Barbirolli Square, Manchester, M2 3AB, VAT GB729849476
