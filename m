Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 6C1EC679E9
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 20:21:31 +1100 (EST)
Date: Mon, 4 Dec 2006 10:21:28 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061204092127.GA27140@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061203171216.GB21947@aepfle.de> <20061203222450.GA23765@aepfle.de>
	<20061203232349.72be01e7@localhost.localdomain>
	<20061204003048.GA24585@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061204003048.GA24585@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 04, Olaf Hering wrote:

> On Sun, Dec 03, Alan wrote:
> 
> > On Sun, 3 Dec 2006 23:24:49 +0100 (MET)
> > Olaf Hering <olaf@aepfle.de> wrote:
> > 
> > > This change seems to fix it, only a single reset occurs. I think that
> > > one is normal when a CD is in the drive during bootup, maybe it leaves
> > > the drive in a confused state.
> > > 
> > > @@ -167,9 +175,13 @@ static void sl82c105_reset_engine(struct
> > >         struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> > >         u16 val;
> > > 
> > > +       udelay(42);
> > >         pci_read_config_word(pdev, 0x7E, &val);
> > > +       udelay(10);
> > >         pci_write_config_word(pdev, 0x7E, val | 4);
> > > +       udelay(10);
> > >         pci_write_config_word(pdev, 0x7E, val & ~4);
> > > +       udelay(42);
> > >  }
> > 
> > Where do you get the delays from ? There is nothing in the documentation
> > or errata sheets I have here on that subject. Is this guesswork, divine
> > inspiration or an errata note I don't posess ?
> 
> Just guessing.
> The udelay(10) calls can go, then it still works.
> I moved the delays to the callers, which should have been equivalent,
> but it failed again.

This patch gives still two resets during the first access, but the
access works ok afterwards:



Index: linux-2.6.19/drivers/ata/pata_sl82c105.c
===================================================================
--- linux-2.6.19.orig/drivers/ata/pata_sl82c105.c
+++ linux-2.6.19/drivers/ata/pata_sl82c105.c
@@ -187,7 +187,9 @@ static void sl82c105_bmdma_start(struct 
 {
 	struct ata_port *ap = qc->ap;
 
+	udelay(50);
 	sl82c105_reset_engine(ap);
+	udelay(50);
 
 	/* Set the clocks for DMA */
 	sl82c105_configure_dmamode(ap, qc->dev);
@@ -216,6 +218,7 @@ static void sl82c105_bmdma_stop(struct a
 
 	ata_bmdma_stop(qc);
 	sl82c105_reset_engine(ap);
+	udelay(50);
 
 	/* This will redo the initial setup of the DMA device to matching
 	   PIO timings */
