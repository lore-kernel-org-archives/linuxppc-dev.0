Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C16F3DDE3D
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 17:42:49 +1100 (EST)
Date: Thu, 4 Jan 2007 07:42:54 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add delay around sl82c105_reset_engine calls
Message-ID: <20070104064254.GA31986@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061204124026.GB28159@aepfle.de>
	<20061204130254.424c7979@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061204130254.424c7979@localhost.localdomain>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 04, Alan wrote:

> On Mon, 4 Dec 2006 13:40:26 +0100 (MET)
> Olaf Hering <olaf@aepfle.de> wrote:
> 
> > 
> > 
> > the hald media changed polling does really confuse things.
> > noone knows why the delays are needed, but they give us access to
> > the CD.
> 
> Can you tell me what happens if you completely pull the reset out of the
> dma_end function. Do you still need delays then.

An udelay(50) will give reliable access to the drive, but there is still
one (or more) EH reset. The drive works without EH resets with udelay(100).

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/ata/pata_sl82c105.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -187,7 +187,9 @@ static void sl82c105_bmdma_start(struct 
 {
 	struct ata_port *ap = qc->ap;
 
+	udelay(100);
 	sl82c105_reset_engine(ap);
+	udelay(100);
 
 	/* Set the clocks for DMA */
 	sl82c105_configure_dmamode(ap, qc->dev);
@@ -216,6 +218,7 @@ static void sl82c105_bmdma_stop(struct a
 
 	ata_bmdma_stop(qc);
 	sl82c105_reset_engine(ap);
+	udelay(100);
 
 	/* This will redo the initial setup of the DMA device to matching
 	   PIO timings */
